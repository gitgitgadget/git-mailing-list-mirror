From: Karl Wiberg <kha@treskal.com>
Subject: Re: making stgit handle being rebased by git rebase
Date: Thu, 11 Nov 2010 12:34:11 +0100
Message-ID: <AANLkTimfJZ5q+fg0qhr6o2y7SGWKKNP4-kVFiL8DS1Sd@mail.gmail.com>
References: <AANLkTik3MVNW0svJEo5gWq3+qGo6dKeqAUz9NPcJnYNN@mail.gmail.com>
	<AANLkTik_dFsaiDkugrpBp8T31zNWVMRNC=hQBj0RmV+o@mail.gmail.com>
	<AANLkTimjO0yMJvf_fF3g7qypAuhPyiHCeF-sUv5toM_S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 12:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGVQ4-00014Z-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 12:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296Ab0KKLeP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 06:34:15 -0500
Received: from mail1.space2u.com ([62.20.1.135]:64298 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab0KKLeO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 06:34:14 -0500
Received: from mail-qw0-f46.google.com (mail-qw0-f46.google.com [209.85.216.46])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.4/8.14.3) with ESMTP id oABBY8IU018767
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Thu, 11 Nov 2010 12:34:09 +0100
Received: by qwi4 with SMTP id 4so1589386qwi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 03:34:11 -0800 (PST)
Received: by 10.229.225.134 with SMTP id is6mr693427qcb.99.1289475251718; Thu,
 11 Nov 2010 03:34:11 -0800 (PST)
Received: by 10.220.124.193 with HTTP; Thu, 11 Nov 2010 03:34:11 -0800 (PST)
In-Reply-To: <AANLkTimjO0yMJvf_fF3g7qypAuhPyiHCeF-sUv5toM_S@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161226>

On Thu, Nov 11, 2010 at 11:41 AM, Catalin Marinas
<catalin.marinas@gmail.com> wrote:

> On 11 November 2010 10:29, Karl Wiberg <kha@treskal.com> wrote:
>
>> I've thought a bit about this in the past, and the best solution I
>> could come up with is of the first kind, and would change the
>> representation of applied patches to use just two refs: the branch
>> itself, and the stack base ref. I think git rebase wouldn't wreck
>> things for that representation.
>
> git rebase would most likely change the base of the stack so stgit
> can no longer track its patches.

I was thinking we could use another git branch as stack
base---specifically, use origin/master as stack base for master, etc.
The stack of applied patches would then be defined as
origin/master..master. That way, git rebase really wouldn't do any
harm.

Of course, if git rebase was used to rebase onto a different branch,
then StGit would have to be told about it; but git already stores
information of this sort, used by e.g. git pull with no arguments.
(No, I haven't researched this part properly. )

> Maybe a better option for stgit is to just remember the branch and
> the number of patches (probably including the patch names unless we
> always generate them automatically, not that bad but you lose the
> possibility of renaming patches).

Yes, that's another way to do it. I think I like my proposal better,
but as I said, I haven't worked it out in detail, and I'm not about to
do so any time soon.

> The above would work well if people use git commit on top of an
> stgit branch.

That goes for my proposal as well.

> The patch names maybe be wrongly associated or (if we automatically
> generate patch names) we may miss the first patch in the series
> because of the number of commits. The latter is not that bad since
> we can always use stg uncommit, though a stg rebase could override
> the committed patch.

Patch names are a problem in all these "minimal metadata for applied
patches" ideas. They could possibly be preserved by guessing the best
match if the stack is modified outside StGit.

--=20
Karl Wiberg, kha@treskal.com
=C2=A0=C2=A0 subrabbit.wordpress.com
=C2=A0=C2=A0 www.treskal.com/kalle
