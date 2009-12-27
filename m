From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix core.worktree being used when GIT_DIR is not set
Date: Sun, 27 Dec 2009 12:58:20 -0800
Message-ID: <7viqbsw2vn.fsf@alter.siamese.dyndns.org>
References: <200912071115.48085.robin.rosenberg.lists@dewire.com>
 <1261920513-25189-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 27 21:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP0CL-0001qP-JC
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 21:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbZL0U6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Dec 2009 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbZL0U6e
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 15:58:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZL0U6d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Dec 2009 15:58:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 977C0AACA8;
	Sun, 27 Dec 2009 15:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=E5nZ66YCApu1uwUPrO9gfqOIl
	s0=; b=J3fnlxDYRE7sZ7DX2upvpPDKbtjrSwGfHOdQde/WPzPAgR0dLkkirq7YS
	N1MBOor7z50JKtWC9eWxDYlWEbaui2ffIWYstG2iabOo8edptDjdoIlh8XfOBcpV
	1lnTaJJR3M2NYUl1L5CkEfNJ8GfeG1Vad8K4XsVn2RpJvL2xlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=eYPwFvJr3lqb5l94LF8
	QLVcHsnAFPMU5pzuhumfABys2zSkT9XZGaOy+j/zhQ6JFPe1AKAWN9JGZJbJu/WD
	m8MPNzysvdpukwO4zSOnURsYRW2lOvhTQB5Vjbbcs/rIRXrZPFAtokQDSp6+0fLO
	nseQTI8/DQ0Fy+g15dfKsbgw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56E8EAACA7;
	Sun, 27 Dec 2009 15:58:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE817AACA5; Sun, 27 Dec 2009
 15:58:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 95158432-F32A-11DE-B25C-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135712>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> According to config.txt:
>> core.worktree::
>>         Set the path to the working tree.  The value will not be
>>         used in combination with repositories found automatically in
>>         a .git directory (i.e. $GIT_DIR is not set).
>
> This behavior was changed after e90fdc3 (Clean up work-tree handling =
-
> 2007-08-01) and 9459aa7 (Do check_repository_format() early (re-fix) =
-
> 2007-12-05). If core.worktree is set, even if git_dir automatically
> found (and git_work_tree_cfg set), git_work_tree_cfg will be reset to
> core.worktree. This makes core.worktree effective even if GIT_DIR is
> not set, in contrast to config.txt.
>
> This patch makes sure it only checks for core.worktree if GIT_DIR is =
set.

The work-tree area got too complicated over time for a small Panda brai=
n
to grasp, so let me think aloud here.

The command line option --git-dir=3D has the same impact on the semanti=
cs as
the $GIT_DIR environment variable has.  The only difference is that the
option has higher precedence over environment.  Therefore, I won't talk
about the command line options in the following description.

In the beginning, there was GIT_DIR environment variable.  We had a ver=
y
simple semantics:

 - When there is no GIT_DIR environment variable:

   - if "." is a "git directory", i.e. it has the set of git things lik=
e
     refs/, objects/ and HEAD, then you are working in a bare repositor=
y.

   - if ./.git exists and it is a "git directory", then "." is the top =
of
     the work tree;

   - otherwise, try the parent directory of "." for the second rule
     repeatedly to find the git directory and the top of the work tree.

 - When there is GIT_DIR environment variable:

   - $GIT_DIR is (and must be) the "git directory" and "." is the top o=
f
     the work tree.

People wanted to have a work tree that is at a location totally unrelat=
ed
to where the "git directory" and setting $GIT_DIR at runtime was the on=
ly
way to do so, but that restricted them to work only at the top of the w=
ork
tree.  $GIT_WORK_TREE was invented as a way to say "this is the top of =
the
work tree".  So that people can do something like:

    $ GIT_DIR=3D/srv/git/proj.git GIT_WORK_TREE=3D/scratch/proj
    $ export GIT_DIR GIT_WORK_TREE
    $ cd $GIT_WORK_TREE/Documentation
    $ edit; git diff; git commit -a; ...

Because the facility was meant to allow separation of "git directory" a=
nd
its associated work tree, and not meant to allow more than one work tre=
es
sharing the same "git directory" (which does not make any sense, as the=
re
is only one index in "git directory" that describes the state of the wo=
rk
tree), it was an unnecessary nuisanse that you had to set two environme=
nt
variables.  core.worktree was invented---by recording the location of t=
he
work tree in the config file in the "git directory", the above can be m=
ade
into this:

    $ GIT_DIR=3D/srv/git/proj.git
    $ cd /scratch/proj/Documentation
    $ edit; git diff; git commit -a; ...

Given these background, I am not sure the "fix" is addressing the right
issue.  What does it mean to have "core.worktree" in a configuration fi=
le,
but that configuration file was found in a "git directory" that was fou=
nd
thorough the repository discovery process due to lack of $GIT_DIR?  The=
re
are only two cases I can see:

 - The user is in the "git directory" itself, which is bare (iow,
   /srv/git/proj.git in the above example).  This is not the case the
   documentation snippet you quoted is about, and I don't think your pa=
tch
   changes (nor should change) the behaviour for;

 - The "git directory" is a ".git/" subdirectory of some work tree, and
   the value of core.worktree may or may not match that work tree.  Thi=
s
   is the case the documentation talks about, and your patch addresses.

=46or the former case, while I don't see much point, we do seem to supp=
ort
this use case (continuing the example scenario):

    $ unset GIT_DIR GIT_WORK_TREE
    $ cd /srv/git/proj.git
    $ git checkout -b newbranch master

We find that "." is our "git directory", and through its config file, w=
e
know core.worktree points at /scratch/proj/, and the checkout updates
files over there, not in /srv/git/proj.git/.  While it is not obvious w=
hy
anybody finds this useful to me, I think the behaviour makes _some_ sen=
se,
and I don't think your patch breaks it by changing the behaviour for th=
is
case [*1*].

The latter, unless core.worktree matches the parent directory of the "g=
it
directory" in question, seems to me a misconfiguration and nothing else=
=2E
Shouldn't it be diagnosed as an error, instead of matching the
documentation to the letter?

[Footnote]

*1* I said "makes _some_ sense" for a reason.  While operations like
switching branches that is inherently whole-tree makes sense, it is
totally unclear what operations that work relative to the work tree,
i.e. "git add", in such a set-up.
