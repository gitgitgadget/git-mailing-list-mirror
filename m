From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Thu, 27 Oct 2011 19:06:34 +1100
Message-ID: <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com> <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com> <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 10:07:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJKzb-000266-M0
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 10:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab1J0IHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 04:07:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41178 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab1J0IHG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 04:07:06 -0400
Received: by faan17 with SMTP id n17so2350675faa.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SEysptOkstDXa2fRdRiNx3SIfySbHRDpyYlm+XcK1T4=;
        b=WBlK+7lj5c1S9QPhDBY8DyrQp0g0kn0Lu0nNV+huoX06pglXQc+9axwQXej0DhJn/n
         p3e6rp59c9zUOsBgnm5ZxNnI+ZmTcgtSYoNpCJKmof+0cryJNvkdKEfDQwxwR29yQpQD
         0SFTVgsh/iDV1PRNhx9T62O/bd97lMHauS3Cc=
Received: by 10.223.77.66 with SMTP id f2mr11181573fak.24.1319702824210; Thu,
 27 Oct 2011 01:07:04 -0700 (PDT)
Received: by 10.223.113.143 with HTTP; Thu, 27 Oct 2011 01:06:34 -0700 (PDT)
In-Reply-To: <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184289>

On Thu, Oct 27, 2011 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C2=A0- reads content of current directory, it sees "clone2" as a di=
rectory
>> =C2=A0- it descends in and see ".git" so "clone2" must be a git link
>> =C2=A0- because clone2 is a separate repository (again $GIT_DIR is n=
ot
>> consulted), "b" should be managed by "clone2"
>> =C2=A0- so it stops.
>>
>> This is the only place I see a submodule (from the first glance) is
>> actually top level repository. Yes I guess we can support this, but
>> it's just too weird to be widely used in pratice..
>
> Where did you get this idea that submodule is somehow involved in thi=
s test?

Because "clone2" looks like a submodule (it has ".git" inside with vali=
d HEAD)

> I do not see there is any submodules involved; the test uses two
> repositories 1 and 2 that appear in the working tree of the main
> repository test infrastructure created, but otherwise there is no
> sub/super relation among these three, and there are many other tests =
with
> "clone" or "mkdir+init" or "init <newdir>" in the main test repositor=
y.

If I tweak the test a bit

git clone ./. clone2 &&
GIT_DIR=3Dclone2/.git git add clone2 &&
GIT_DIR=3Dclone2/.git git add clone2/b

then the last command fails with "Path 'clone2/b' is in submodule
'clone2'". So clone2 could be a submodule from that perspective. Doing
the the other way around

git clone ./. clone2 &&
GIT_DIR=3Dclone2/.git git add clone2/b &&
GIT_DIR=3Dclone2/.git git add clone2

"clone2" is not just a normal path. Should we stick with one way only?
--=20
Duy
