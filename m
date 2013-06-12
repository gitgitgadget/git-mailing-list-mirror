From: =?UTF-8?B?Q8OpbGVzdGluIE1hdHRl?= <celestin.matte@ensimag.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 13:12:48 +0200
Message-ID: <51B857B0.5030603@ensimag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr> <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr> <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com> <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com> <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?TWF0aGlldSBMacOpbmFyZC0tTWF5b3I=?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 13:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmizF-0003Cx-ED
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 13:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302Ab3FLLMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 07:12:52 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40521 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab3FLLMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 07:12:52 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5CBClce010677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 13:12:47 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CBCnb7012061;
	Wed, 12 Jun 2013 13:12:49 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CBCmvo002124;
	Wed, 12 Jun 2013 13:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 12 Jun 2013 13:12:48 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227597>

Le 12/06/2013 12:17, Mathieu Li=C3=A9nard--Mayor a =C3=A9crit :
> Now, I'm not sure if we should always display the list of commits
> already applied and those left to apply. What I mean is that maybe it
> would be better to make status require a flag to display the two list=
s.
> Something like (not sure about the flag's name):
>=20
> $ git status --rebase-state
> # HEAD detached from ecb9f3e
> # Already applied 2 patches:
> #     b170635... my_commit_message
> #     b170635... my_commit_message
> # You are currently editing a832578... my_commit_message [3/5] while
> rebasing.
> # 2 patches left to apply:
> #    b170635... my_commit_message
> #    b170635... my_commit_message
> #   (use "git commit --amend" to amend the current commit)
> #   (use "git rebase --continue" once you are satisfied with your cha=
nges)
> # ......
> # ......
>=20
> What do you guys think ?

I agree. When you're in the process of rebasing a big list of commits,
it would produce a lot of not-so-useful output, when what you want to
see is, most of the time, which commit you are currently editing.
So, in my opinion, whole lists should not be displayed by default.

Now, if I could suggest an improvement over that list: when you rebase
some commits, I'm quite sure the history of what you already did is
stored somewhere since you can revert it which git rebase --abort. It
would be nice to improve that list by displaying these informations, li=
ke:

$ git status --rebase-state
# HEAD detached from ecb9f3e
# Already applied 4 patches:
#              b170635... my_commit_message
#              b170635... my_commit_message
# new:         b170635... my_commit_message
# modified:    b170635... my_commit_message
# reworded:    b170635... my_commit_message
# You are currently editing a832578... my_commit_message [5/8] while
rebasing.
# 2 patches left to apply:
#    b170635... my_commit_message
#    b170635... my_commit_message
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your chang=
es)
# ......
# ......

I have no idea how complicated it would be to do that, though.
What do you think?

--=20
C=C3=A9lestin Matte
