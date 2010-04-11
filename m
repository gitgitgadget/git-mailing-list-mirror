From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Mon, 12 Apr 2010 08:22:41 +1000
Message-ID: <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk>
	 <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com>
	 <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234>
	 <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com>
	 <d0869259b375a26df46ef92a2b973615@212.159.54.234>
	 <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org,
	Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 00:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O15eb-0002v3-PN
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 00:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0DKW3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Apr 2010 18:29:16 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:8362 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab0DKW3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 18:29:15 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1811797qwh.37
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 15:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q7AG92bX7b4zN+Dc4SVV3RjmUQqIz6UALAQ5MApQB6k=;
        b=aW/RTyIFx0oUA0XVLEW+1osIbZYQgkRKKJ3oWTTc5/PSPoIomhoj3GPzXcwcqRuQKC
         Nua9auuWYap3i0oTD+GD/5lH7w8kH5Y9JTCjINvusojgkPBlNr5eWiMFNre0hvVvAyyQ
         L34kqMpj5wIP1AdB9nzubp4ki0Ws9j7hiAAE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bnzjipcozwScvPnu6FI0kECl6aP87UQBRQB2IjFvUB6jV/jmvL/owkqBouJxF3qnno
         wu/OpCt2sm2ZS5YVdkVA4lnwruMT6IXN+OQL6ekypzDxUlRUyORaO5V/i7IP+92uMoLt
         UOYUCVbCkyO0RGC+SjzmIBJr9W5j4ZYg5uU2w=
Received: by 10.229.185.136 with HTTP; Sun, 11 Apr 2010 15:22:41 -0700 (PDT)
In-Reply-To: <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com>
Received: by 10.229.227.83 with SMTP id iz19mr4780584qcb.44.1271024561708; 
	Sun, 11 Apr 2010 15:22:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144690>

I can see that retrofitting this more widely would add quite a lot of
conditional logic to a lot of places.

If one was designing for both line-oriented and structured outputs
from the start, I imagine one would build a map for each record, and
then hand that to the output context when it is complete, allowing the
considerations of both line orientation and structured output to be
encapsulated within the backend. Self-describing output formats can
use a simple map without needing to know the record type, but line
oriented outputs, of course, would need to know the type of record in
order to select the correct line formatter.

So, would it be worth providing a hint as to record type in the
output_start_object call so that if it was later desired to subsume
line-oriented formats under the same framework, there is enough
information available to the backend to do that?

[ And, yes, I understand that to making line-oriented formats a
backend would be a reasonably invasive change to existing code that
would involve a level of indirection and abstraction that may not be
to everyone's taste. ]

jon.

On Mon, Apr 12, 2010 at 3:50 AM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> Heya,
>
> On Sun, Apr 11, 2010 at 19:45, Julian Phillips <julian@quantumfyre.co=
=2Euk> wrote:
>> I think that there probably are commands where it will be more work =
to
>> integrate the output - but I think that is probably more to do with =
the
>> structure of the current code than the API of the new. =C2=A0Does it=
 make a
>> difference what the API of the new output code is if there isn't cur=
rently
>> a sensible hook-in point?
>
> No you are right, the existance of such hard-to-change commands does
> not really affect the API design in this case, although I think it
> might be a good idea to try out at least one such command before
> committing to using this API. For example, it might turn out that
> there's an elegant way to hook in, or that adding all those if
> (output_style !=3D OUTPUT_NORMAL) =C2=A0statements gets cluttery and =
there
> should be a different way to do things instead.
>
>> If code has been written without the expectation that the output for=
mat
>> could be changed then the effort to add a new output format could be
>> considerably more than for status or ls-tree. =C2=A0However, with th=
e
>> frontend/backend design hopefully we only have to endure the effort =
once to
>> get multiple output formats.
>
> I'm curious to see where this will lead us :).
>
> --
> Cheers,
>
> Sverre Rabbelier
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
