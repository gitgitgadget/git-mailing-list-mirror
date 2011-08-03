From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v15 7/7] bisect: add documentation for --no-checkout option.
Date: Thu, 4 Aug 2011 07:37:20 +1000
Message-ID: <CAH3Anrq_xAUDN5UW6XB+VvGbCB3OrM0WdKRUKTAufVx5xCa+MA@mail.gmail.com>
References: <1312383811-7130-1-git-send-email-jon.seymour@gmail.com>
	<1312383811-7130-8-git-send-email-jon.seymour@gmail.com>
	<7v62meb4a3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 23:37:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoj83-00068L-IE
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 23:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197Ab1HCVhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 17:37:23 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37589 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab1HCVhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 17:37:21 -0400
Received: by vws1 with SMTP id 1so663233vws.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 14:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8zMtHXQQiCocSqGqse+nNndQe5uhSRI7WvRMft6P/gc=;
        b=j8F7XU9Ij+xFaJnPIkJcK6UNmFHkWgEbYS9kLO/tV0HEANCLSb8MrO/9f9LRajIi1g
         +gChATeSX4Xn3oqgjXrGos9La8B3f7TtIm8+Z8DUtenu3tJB97QXwvMkRQHacuA9iWzt
         88Opf+xhtWctu+jVS1RwRlZHmo+dk2dEGYIus=
Received: by 10.52.110.68 with SMTP id hy4mr59509vdb.97.1312407440859; Wed, 03
 Aug 2011 14:37:20 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Wed, 3 Aug 2011 14:37:20 -0700 (PDT)
In-Reply-To: <7v62meb4a3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178623>

On Thu, Aug 4, 2011 at 6:59 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> +This option is useful in circumstances in which checkout is either =
not
>> +possible (because the repository is damaged) or is otherwise not re=
quired.
>
> I do not think "because the repository is damaged" is a particularly =
good
> example to single out here. For one thing, you may not be able to bis=
ect
> the history in a damaged repository due to unreadable commits. There =
are
> other valid and more plausible reasons that the users do not want to
> update the working tree while bisecting, e.g. they have local changes=
,
> they do not want to rebuild everything after bisection is done, etc.
>
> Also the above description muddies what is prerequisite and what is u=
ser's
> wish.
>
> =C2=A0- "is otherwise not required" is the prerequisite: "if and only=
 if the
> =C2=A0 test you would perform during bisection does not need a checko=
ut of the
> =C2=A0 version being tested, you can use this option";
>
> =C2=A0- Even if the user wishes to use this option for various reason=
s (e.g. so
> =C2=A0 that the next "make" wouldn't have to rebuild everything unnec=
essarily;
> =C2=A0 or the repository has corrupt blobs and checkout of some versi=
ons may
> =C2=A0 fail), if the test _needs_ a checkout, it is not an option to =
use this
> =C2=A0 feature.
>
> So I would suggest toning it down perhaps like this:
>
> =C2=A0 =C2=A0This option may be useful when the test you would perfor=
m in each step
> =C2=A0 =C2=A0does not require a checked out tree.
>

Sounds good.

>> +$ git bisect run eval '
>> +rc=3D1;
>> +if git rev-list --objects BISECT_HEAD >tmp.$$; then
>> + =C2=A0 git pack-objects --stdout >/dev/null < tmp.$$ && rc=3D0;
>> +fi;
>> +rm tmp.$$;
>> +test $rc -eq 0;'
>
> Hmm, "eval"?
>
> More importantly, aren't these excessive and unnecessary semicolons
> unsightly?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git bisect run sh -c '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git rev-list -=
-objects BISECT_HEAD >tmp.$$ &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git pack-objec=
ts --stdout >/dev/null <tmp.$$
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc=3D$?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tmp.$$
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test $rc =3D 0=
'
>
>> +In this case, when 'git bisect run' finishes, bisect/bad will refer=
 to a commit that
>> +has at least one parent whose reachable graph is fully traversable =
in the sense
>> +required by 'git pack objects'.
>
> Also "everything reachable from BISECT_HEAD" feels unnecessarily
> wasteful. By the time you invoke "bisect run", you already know one g=
ood
> commit, everything reachable from which are known to be good.
>

How about?

git bisect run sh -c '
        GOOD=3D$(git for-each-ref "--format=3D%(objectname)" refs/bisec=
t/good-*) &&
        git rev-list --objects BISECT_HEAD --not $GOOD >tmp.$$ &&
        git pack-objects --stdout >/dev/null <tmp.$$
        rc=3D$?
        rm -f tmp.$$
        test $rc =3D 0'
