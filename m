From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in submodules
Date: Sun, 12 Sep 2010 14:10:00 -0500
Message-ID: <AANLkTinMf-_vk2-gRazf-8FNykZoNbVwmu_+c+5ht8rY@mail.gmail.com>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil>
	<7vy6bajvnd.fsf@alter.siamese.dyndns.org>
	<1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 12 21:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OurwK-0008EG-MZ
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab0ILTKD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Sep 2010 15:10:03 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36360 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab0ILTKB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Sep 2010 15:10:01 -0400
Received: by eyb6 with SMTP id 6so2453394eyb.19
        for <git@vger.kernel.org>; Sun, 12 Sep 2010 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EjfBOZi+O/VQYp8aKdWMY705mamiaWYgKHZ0KSBEmwA=;
        b=GSZb92v1vwv8wqAU1tVam7hm5s1LcmE7KpMhPgO/zWHgF0G3Xf51ZtBezxhKZH/mKv
         FqiY/q/mQUwPDru8WzUQInfcPPVS2JPCgqL8bcbJKkjyIojX0pMwQSWCxSbsPpu+jbcx
         UG/kgsZrR1oUZ7xleQRp73rFcRrnYPNtisIyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t0vyq3I3Zmsa5p86EuV/wtQUv3+jg9Jxm0qfEV46wuUhG25LpgzSufoQVthtX3TAPi
         wLEnEQ62wgoP3Beo31dBhcVkRA6P4QVJvgjpkNCRfxe1NT+xyNyk3IHAOoD6I3CSoyFS
         mm7EIJINFjt0FPiZ0HKpio8YesE22ewH443Uo=
Received: by 10.213.106.7 with SMTP id v7mr2232135ebo.31.1284318600542; Sun,
 12 Sep 2010 12:10:00 -0700 (PDT)
Received: by 10.213.108.78 with HTTP; Sun, 12 Sep 2010 12:10:00 -0700 (PDT)
In-Reply-To: <1094265482.7527324.1284144028114.JavaMail.fmail@mwmweb047>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156043>

On Fri, Sep 10, 2010 at 1:40 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
>>Brandon Casey <casey@nrlssc.navy.mil> writes:
>>
>>> From: Brandon Casey <drafnel@gmail.com>
>>>
>>> Since 'git describe' does not append -dirty to the version string i=
t
>>> produces when untracked files exist in the working directory of the=
 main
>>> repository, it should not do so for submodules either.
>>>
>>> Add --ignore-submodules=3Duntracked to the call to diff-index which=
 is used
>>> to decide whether or not the '-dirty' string is necessary.
>>>
>>> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>>> ---
>>
>>Hmm, this changes the behaviour in a big way but it probably is for t=
he
>>better. =C2=A0At least it is consistent with the recent fixes to the
>>interaction between diff and submodules.
>
> Hmm, by default the diff family considers submodules with untracked f=
iles as
> dirty unless configured otherwise (and AFAICS the recent fixes to the=
 interaction
> between diff and submodule were options to configure your own default=
).
>
> So when git status tells you the subodule is modified, e.g. because o=
f an untracked
> file, I would expect git describe to add '-dirty' to its output when =
requested.

Triple hmm.  Perhaps a deeper level change is necessary than what I ori=
ginally
thought.

It appears to me now, that the behavior of the entire diff family is
inconsistent
with respect to how untracked content is handled at the super-project l=
evel and
at the submodule level.

At the super-project level, git only considers as 'modified', changes t=
o
_tracked_ content.  Any untracked content is ignored by git-describe, g=
it-diff,
and friends, and git-status places it in its own 'Untracked files' sect=
ion.

At the submodule level, all files, tracked and untracked, are considere=
d.

> To get rid
> of that I would expect you either fix the .gitignore of the submodule=
 or configure that
> you don't care about untracked files in submodules at all (either onl=
y for this
> submodule or in the config).
>
> So if I didn't misunderstand something here I would rather vote again=
st this change,
> git describe should append a '-dirty' when git status would show modi=
fications, no?

Do you agree that there is an inconsistency between how untracked conte=
nt is
treated at the super-project level and at the submodule level?  Any tho=
ughts
about how the behavior should be made to be consistent?

Perhaps the default setting of submodule.<name>.ignore should be 'untra=
cked'?

-Brandon
