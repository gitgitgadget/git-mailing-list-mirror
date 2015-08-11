From: Martin von Gagern <Martin.vGagern@gmx.net>
Subject: Merging after directory got turned into submodule
Date: Tue, 11 Aug 2015 15:02:41 +0200
Message-ID: <55C9F271.30008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZP9Ce-0001tj-OJ
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 15:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbbHKNCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2015 09:02:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:65307 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934075AbbHKNCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 09:02:46 -0400
Received: from [192.168.71.20] ([188.195.143.204]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M6AbC-1YasrQ3Sxu-00y695 for <git@vger.kernel.org>;
 Tue, 11 Aug 2015 15:02:42 +0200
X-Enigmail-Draft-Status: N1010
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
X-Provags-ID: V03:K0:NxbAfAvzh4NzD39FGMHJoXbfkHqt+CzA+abDbguKh/E5H7pueYU
 oqvdXv5LDqNejpXcceOmZZuqzZc9gSfnoD2wUDWomBvRXiDWzZ/RgbwbgOFVX7bzuuwzSmE
 CZfWusDN1Tzg9FBJJy3g7iuxvyO0+S2Kno6tH9eA/9xE0JJXTEvN6jLWB/htZ0Ezdi0w0cC
 SeCBwYkhYQNW7XGlwG31g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gaZkPu+qb4g=:q32TB4Eqc3NpODPxAhS19y
 pXO27EqB1al3fxDCuq9qNBGwA3wUD4IF61bvx6/lFsQ5kUc4n0Id10mcgPWh12wY4HXsKI6jA
 92fJnoAbKvLUYgj7YBHLEoKU2vuR/dC7HWdrjGZEyK81c+t8iiUtUhtvnowmfKokrzVP2Q6ud
 uL5/ZgmtHy8nV7X0+TZCPbc46zhTnaQPFbx6NpAgL8uMDTAuCe33zmixJigiEb9UwHggF5+zO
 PBQqLaHZQDEbPmdvyaH0ZLGGpHPuqQpMLqsozwgX9FxU+UcF1VSLJEvbIpvW+4FIzUwzmpdKA
 +Ves3QzO3k1449FKd+VUkwoiWihyTtQgEVvZkMQYj8B+gfa3v8dUWnR6gXB/3mmHxwuK3/mo8
 QwHXmplHBn3OQvoX8fos6Z/q/QQyGRxKzB235Sd7r/MNPosdjEJQnMEMkhmmH7mW/Sf5casgG
 T7faSrBbEFh3uadL2t9jDTgi7jEeN3mLNEODjso+Lhj1xqZakvSmSBIfn9nhSLPRNwd67v0Kq
 fwpyGWRm3reGvc5R3fThWpDIxUef9xzTZlujrwcpaG0T3l4tG8XlU12rAi5CnKw02ygw7S07I
 hwZKFyv/l9d2jXdJYyIJQMx6qgcAKc5X8ZQRg6sXNZKYoxKQq8zr35K/VB33YbJN1svF041yc
 2WnhEwVmgflv3wPIiIpKfW/KR42sPYiIvBBhclbo0gi3y6ohNsWePos2ztq/lf73p2mN/ttQv
 ggkJHEGTIaiMqbJUsa94/aDtZrnGEJvOCbuLNQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275686>

Hi!

I've noticed that if I turn a subdirectory into a submodule, I'm having
severe trouble merging branches from before that change, even if they
don't modify that subdirectory at all.

I've posted this problem on Stack Overflow and started a bounty for it.
See http://stackoverflow.com/q/31821219/1468366. So far I haven't
received an answer, so I decided to ask here as well.

Here is an example.

# Create one project, to be used as a subproject later on
git init a
cd a
echo aaa > aa
git add -A
git commit -m a1
cd ..

# Create a second project, containing a as a normal directory initially
git init b
cd b
mkdir a b
echo aaa > a/aa
echo bbb > b/bb
git add -A
git commit -m b1

# Replace directory with submodule
git rm -r a
git submodule add ../a a
git commit -m b2

# Create feature brach starting at version without submodule
git submodule deinit .  # will error if I don't do this
git checkout -b branch HEAD^
echo abc > b/bb
git commit -a -m b3

# Try to merge the feature branch
git checkout master
git merge branch

This prints an error message:

> CONFLICT (file/directory): There is a directory with name a in branch=
=2E
> Adding a as a~HEAD
> Automatic merge failed; fix conflicts and then commit the result.

I get the same error if I do a git submodule update --init before the
git merge branch. I don't see any a~HEAD anywhere, neither in my
directory tree nor in the output from git status, which reads like this=
:

> On branch master
> You have unmerged paths.
>   (fix conflicts and run "git commit")
>
> Changes to be committed:
>
>     modified:   b/bb
>
> Unmerged paths:
>   (use "git add <file>..." to mark resolution)
>
>     added by us:     a

If I do git add a as suggested, I get another error:

> error: unable to index file a
> fatal: updating files failed

If I do git submodules update --init just before the merge, then I can
do git add a successfully. But if I forget to do so, and then try doing
that after the merge, I receive this error message:

> Submodule 'a' (=E2=80=A6/a) registered for path 'a'
> Skipping unmerged submodule a

How do I recover from this situation? Something other than git merge
--abort, since I'd like to use it for things like git rebase as well,
and since in some scenarios (don't know how to reproduce) I couldn't
even abort the merge cleanly, and had to do a hard reset instead.

How can I avoid it in the first place? Is there some magic setting whic=
h
makes git do the right thing with submodules vs. directories during
merges, so that I don't have to manually post-process a merge which onl=
y
modifies files unrelated to the submodules?

If there is no easy way to avoid this, do you think I should file a bug
report for this? After all, replacing a subdirectory by a submodule
shouldn't be that rare, and neither should be merges across such a
change. So in my opinion, git should be able to cope with this.

Greetings,
 Martin von Gagern
