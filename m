From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Fri, 27 Jan 2012 10:11:06 +0100
Message-ID: <CAH6sp9O7P8bmYA66fY754mn=ogp8OP1i3KQuE_hnrTY46nNAxw@mail.gmail.com>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
	<1327444346-6243-6-git-send-email-fransklaver@gmail.com>
	<20120124232421.GH8222@burratino>
	<op.v8moybu10aolir@keputer>
	<4F205028.4060606@kdbg.org>
	<7vr4ym2rad.fsf@alter.siamese.dyndns.org>
	<CAH6sp9NEnkDY-BCccW9VM3waxg8sG8zV5-rVAuMUfZ9rji4-Qw@mail.gmail.com>
	<20120127084845.GC806@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 10:11:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqhq2-000172-7i
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 10:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2A0JLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 04:11:12 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49483 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab2A0JLI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 04:11:08 -0500
Received: by qcsg15 with SMTP id g15so808926qcs.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 01:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nUUfp0c9/8qVnVV3gBTAL75Z2+LUtqpCIsy0j84K5mM=;
        b=Ns5PtphSafcDrG68UfGHCgolynj6Db9R3TaaKOwUpQbEgE+zITntMLaIq51vCHQHv3
         +gzaD1JkJSFB4T2IMcxDEhdy5j7RmNKxN4lNXQ8By+Fla4erJu3RMh/g3aISI9v6MS7z
         yrRe1SZMAp2C2HKEg1s4pCMkoqeUDGL3XNYsQ=
Received: by 10.229.77.31 with SMTP id e31mr2056865qck.63.1327655466864; Fri,
 27 Jan 2012 01:11:06 -0800 (PST)
Received: by 10.224.105.143 with HTTP; Fri, 27 Jan 2012 01:11:06 -0800 (PST)
In-Reply-To: <20120127084845.GC806@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189206>

On Fri, Jan 27, 2012 at 9:48 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0If this was pretty much
>> going to be /dev/null'ed from the beginning, I'd rather have heard i=
t
>> after my first patches.
>
> Almost always when a developer has an itch, it is _possible_ to
> massage a patch that scratches it into something acceptable to others=
=2E
> And whether it is worth the trouble in terms of time is something tha=
t
> only that developer can decide.

Hannes' reaction and Junio's to his didn't give me the impression they
even saw a possibility.


> So no, I would not say these patches were not doomed from the
> beginning. =C2=A0However, I certainly agree that in their current for=
m they
> are more complicated than the use case justifies.

Good. That's something we can work on.


> There is a tension between requirements that leaves me oddly
> uncomfortable with the series:
>
> a. on one hand, it would be nice to preserve all the current features
> =C2=A0 of execvp(), which makes the approach of only doing post-morte=
m
> =C2=A0 analysis after a failed execvp appealing;
>
> b. on the other hand, it would be nice [*] to avoid launching a pager
> =C2=A0 only in order to call execvp for a command that does not exist=
 when
> =C2=A0 the fallback might be to an alias to a command that does not w=
ant a
> =C2=A0 pager. =C2=A0That would require figuring out in advance that e=
xecvp
> =C2=A0 would fail with ENOENT and missing out on possible system exte=
nsions
> =C2=A0 that allow execvp to run shell built-in commands not existing =
on
> =C2=A0 the filesystem.

Just for my understanding: before a command is executed, a pager
(less/more or so) is started? We want to avoid starting the pager if
we won't be able to execute the command?


> I want to like (b), but the downside seems unacceptable.

The downside being: having to figure out what execvp is going to do?
That would be tantamount to writing your own execvp.

> I honestly
> don't know if something like (a) would be a good idea if well
> executed, so I was happy to have the opportunity to try to help
> massage these patches into a form that would make the answer more
> obvious.

Given the above information, I'm happy to work on this to see if we
can mould it into something usable. Since the impact seems to go
beyond figuring out why execvp failed, I'm probably going to need some
help.

=46or now, I'll go through your suggestions and see what it produces.
We'll go from there.

Thanks for the heads-up.
