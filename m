From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/2] Remove noreturn function pointers in usage.c
Date: Thu, 9 Jun 2011 23:13:56 +0200
Message-ID: <BANLkTimxA9yRHFt8jX2kEM8JvNoO5AOcYA@mail.gmail.com>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
 <7v4o3z264s.fsf@alter.siamese.dyndns.org> <20110609045915.GA15448@one.firstfloor.org>
 <20110609055224.GA27780@sigill.intra.peff.net> <20110609063145.GC15448@one.firstfloor.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:14:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUmYu-00041V-9G
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 23:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab1FIVOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 17:14:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48101 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab1FIVOi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 17:14:38 -0400
Received: by pwi15 with SMTP id 15so932024pwi.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 14:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SaS1auB8Yz8c6F3qcCQeAJSUqoWonXeenHSJ2d0bqnE=;
        b=tg0+7Vm58NDbfvAisYnvxEUhm+J9S4WSmo1CK4i74DMdWt55PYAWhCR9NVb0LfNyGl
         971W3XwrcEa0i0dEhIsQ+sO5u/N6rKoXVFY0qKDclQDL//vQ+i/Lw+lvKr9ftX2W87Z4
         fVuee/FszSZc6QV/U+qAo0DsPwk/xUWcHyqbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=bscccjR+8cRf+1lODBuhVe0jQUsnsdO4n+zyJxC7N3ZQAz+TUG7Ljp0OjRwh3igjT7
         UkybH9Z3nDJNQgbQS+vQ1a7r0S5mWVYyQp2i61aRq7Ja2XiyxYNjdwKxKdUfiNF9OP4Y
         xEVB02IyTeN1EdRDBoqrTvpO73tQ980T4yk40=
Received: by 10.68.68.106 with SMTP id v10mr608447pbt.115.1307654077192; Thu,
 09 Jun 2011 14:14:37 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Thu, 9 Jun 2011 14:13:56 -0700 (PDT)
In-Reply-To: <20110609063145.GC15448@one.firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175577>

On Thu, Jun 9, 2011 at 8:31 AM, Andi Kleen <andi@firstfloor.org> wrote:
> On Thu, Jun 09, 2011 at 01:52:24AM -0400, Jeff King wrote:
>> On Thu, Jun 09, 2011 at 06:59:15AM +0200, Andi Kleen wrote:
>>
>> > > =A0- Potential impact to people who do not use Gcc 4.6 with prof=
ile feedback
>> > > =A0 =A0is not explained away well, except for "Doesn't seem to m=
ake any
>> > > =A0 =A0difference."
>> >
>> > I merely went by "there are no new warnings" (I assume that's the =
main
>> > motivation)
>>
>> On your compiler and settings, perhaps. With your patch I get:
>>
>> =A0 usage.c: In function =91die=92:
>> =A0 usage.c:70:1: error: =91noreturn=92 function does return [-Werro=
r]
>
> Ok. =A0Hmm, all I can say it compiled here.
>
> Ok then we have to remove it. I didn't really like Junio's approach
> to only do it for a single file because that would break with LTO / l=
ink
> time optimization which requires declarations to match between
> translation units.

Junio's approach didn't do it for a single file, it disabled the
NORETURN mechanism all together, by having a Makefile-switch.

> BTW 4.6.2 or so will have the problem fixed.

If it's only in 4.6 through 4.6.2, then we probably don't even need a
Makefile-switch for junio's approach at all; just checking the GCC
version should be reliable enough, no?
