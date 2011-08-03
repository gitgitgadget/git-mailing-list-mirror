From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 23:16:15 +1000
Message-ID: <CAH3AnrrtfhU1r1DWO8ski5Jd=cLXcj3Wq-MowB8QKv+r1-BT_A@mail.gmail.com>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
	<1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
	<7voc07ct9z.fsf@alter.siamese.dyndns.org>
	<7vk4avcsk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 15:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QobJ7-0004sJ-NB
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 15:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab1HCNQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 09:16:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33121 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab1HCNQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 09:16:16 -0400
Received: by vws1 with SMTP id 1so287667vws.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MfmbS3YaePlw9atPHmYYTrVSdTyH6Vsvgd3edEakYOk=;
        b=d4zD7CIDQP+N9flARDalpT9AoeYEwfJLupkAePHxNJNOBZg4lpp0TMqpIQXTcYxNYO
         ylkyAkQp78Sir3OnGK+jUXM1QWUPf+UOq/W23qZFhJR1Fc2FfeevNZldYS5rDAWQUyYq
         69qifijOMMqwhXjeC/2lcq8f5wVo48XtwNPZ8=
Received: by 10.52.22.19 with SMTP id z19mr1071741vde.499.1312377375174; Wed,
 03 Aug 2011 06:16:15 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 06:16:15 -0700 (PDT)
In-Reply-To: <7vk4avcsk9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178566>

On Wed, Aug 3, 2011 at 9:16 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jon Seymour <jon.seymour@gmail.com> writes:
>> ...
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test "$BISECT_MODE" =3D=
 "--no-checkout"; then
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git update=
-ref --no-deref HEAD "$start_head"
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checko=
ut "$start_head" --
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>
>> Just a minor worry but I would not be surprised if somebody's "test"
>> implementation barfs upon:
>>
>> =C2=A0 =C2=A0 =C2=A0 test "--no-checkout" =3D "--no-checkout"
>>
>> mistaking the string with a dash at the beginning as an option unkno=
wn to
>> it. That is why we often have "z$variable" in our comparison, like s=
o:
>>
>> =C2=A0 =C2=A0 =C2=A0 if test "z$BISECT_MODE" =3D "z--no-checkout"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git update-ref --no=
-deref BISECT_HEAD "$start_head"
>> =C2=A0 =C2=A0 =C2=A0 else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git checkout "$star=
t_head" --
>> =C2=A0 =C2=A0 =C2=A0 fi
>>
>>> - =C2=A0 =C2=A0git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAME=
S" &&
>>> + =C2=A0 =C2=A0git rev-parse --sq-quote "$@" >"$GIT_DIR/BISECT_NAME=
S"
>>> + =C2=A0 =C2=A0echo "$BISECT_MODE" > "$GIT_DIR/BISECT_MODE" &&
>>
>> &&?
>
> Having said that, other than these minor nits, I think this round is
> almost ready. I didn't check how it behaves upon "bisect reset",
> though. It shouldn't touch the index, HEAD nor the working tree (it
> probably is just the matter of "update-ref -d BISECT_HEAD" and nothin=
g
> else, but I haven't thought things through thoroughly).

That seems reasonable. In fact, none of these series properly cleaned
up the reset state properly, so I'll fix that and a test for it.

>
> Further polishing we may want to do while it is still in pu/next I ca=
n
> think of off the top of my head are:
>
> =C2=A0- In this mode, I can bisect the history even inside a bare rep=
ository,
> =C2=A0 as the whole point of --no-checkout is that the mode does not =
require a
> =C2=A0 working tree. I however suspect "git bisect" requires working =
tree. Is
> =C2=A0 this something we want to fix?
>

I agree, that would be useful. Haven't tried it yet but I'll see what
happens.I may issue changes for this as separate commit that can be
squashed later, if required,  once it has been reviewed.

BTW: I'll squash v14 8/8 into the other commits, per Christian's sugges=
tion.

> =C2=A0- Further, perhaps should we default to this mode inside a bare
> =C2=A0 repository?

Seems reasonable.

jon.
