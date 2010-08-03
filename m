From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 03 Aug 2010 10:55:51 +0200
Message-ID: <4C57D997.5010003@drmicha.warpmail.net>
References: <i372v0$3np$1@dough.gmane.org> <m3hbjcptyr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 10:55:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgDHk-0003GO-Fx
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 10:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab0HCIzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 04:55:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34503 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754723Ab0HCIzk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 04:55:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E12C8181958;
	Tue,  3 Aug 2010 04:55:39 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 03 Aug 2010 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=CvKeMulc1DVfPmoqPSMecAGPFoI=; b=d43fiT7Vn7BUGJbgk4OYXIeLTNeh7WsmQjjAYsuIlgWm8xvDwdi50GifAErTKORUMwFg1lnG9Tnz7Bdmu5Twa5WSubr0rjTtJWneQfMYEqa5rim3+smMDxGhoJtNxr5ICg8/ZSCRihAODLO1L95ybFW1gaH+H/DPNmJRwtfUuzk=
X-Sasl-enc: GhGljbQLAy+u+IkT3gTfJ8W8s2OPwGmt1tB2lAlp9wTX 1280825739
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1B2982C2B7;
	Tue,  3 Aug 2010 04:55:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100714 Lightning/1.0b2pre Lanikai/3.1.2pre
In-Reply-To: <m3hbjcptyr.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152493>

Jakub Narebski venit, vidit, dixit 02.08.2010 23:48:
> "Joel C. Salomon" <joelcsalomon@gmail.com> writes:
>=20
>> I'd figured to play with Git in an unusual way: to create a reposito=
ry
>> for the U.S. Constitution where amendments are presented as patches.
>> E.g., instead of the First Amendment being placed at the end (as is
>> usual) I'm putting it in Article 1, Section 9 (Limitations of Congre=
ss).
>>  Proposed amendments get branches, which get merged in later.
>>
>> But I'm trying to get the dates right, and I'm missing something.  F=
or
>> example, I made the initial commit with the line
>>
>> 	$ git commit --author=3D"The Philadelphia Convention <>" \
>> 	 --date=3D"Mon, 17 Sep 1787 12:00:00 EST"
>>
>> but that's not actually setting the commit date to 1787.
>>
>> Am I doing something wrong, or is Git (quite reasonably) unable to
>> accept commit dates that far in the past?
>=20
> Git encodes author and commit (and tagger) time using Unix epoch
> (POSIX epoch) plus timezone.  As Shawn and =C6var wrote on 32-bit
> systems time_t can cover a range of about 136 years in total around
> January 1, 1970, which means that the maximum representable time on
> 32-bit system is 2038-01-19 (the year 2038 problem), but what is more
> important to you is that minimum representable time is 1901-12-13.
> 1787 is too old for 32-bit time_t.
>=20
> The headers inside commit (and tag) objects are stored in text form,
> so they are not limited to 32-bit value.  You would have to use syste=
m
> that has 64-bit time_t, or patch git.

Hmm, sizeof(time_t) =3D=3D 8 for my x86_64 Fedora, but committing ancie=
nt
times fails.

My ctime() happily converts negative numbers into dates before the epoc=
h.

>=20
> 64-bit time_t would be enough for everyone (sic!).
>=20
> References:
> -----------
> http://en.wikipedia.org/wiki/Unix_epoch

Junio replied:
>I thought the internal representation of our time was "unsigned long",=
 >no?
>How can you represent anything before Unix epoch?

We have a mix of time_t and unsigned long (not signed, not long long!),
and we have our own tm_to_time_t() in date.c which explicitly forbids
years before 1970. It seems we don't use standard ctime() and friends
because the standards is not so standard and want to be independent of
that, but sizeof(long) is still system dependent.

Removing the check in tm_to_time_t() by brute force let's me commit
ancient times, but the parser gets them wrong (either on input or on
output, I haven't checked), 1787 ends up output as 1899.

time_t is signed on most systems. Using unsigned long buys us a few
years as long as we don't go through any system routine nor conversion
to time_t. So maybe we should:

- check to make sure we use time_t and system routines only when gettin=
g
the current time
- use signed long long as our git_time_t (I think long is less system
dependent then long but I could be wrong)
- make our own algorithms work for the extended format

Michael
