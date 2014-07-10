From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Thu, 10 Jul 2014 13:52:37 -0700
Message-ID: <xmqqsim96ine.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BCDDE2.1080301@web.de> <53BD87B3.8050901@web.de>
	<xmqqmwci9vn1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5LKj-0004N3-SF
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbaGJUwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:52:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51645 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbaGJUwp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:52:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F24DE2756D;
	Thu, 10 Jul 2014 16:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dmDvyWwC7xyBQ4par704jUMFSqc=; b=IJpNoi
	jbHCM5Gw/irj6/p1q15K/zxeSMCuDYJwDbMAmC/365822riKyvnAxIHoBdC+LgIs
	54/C07SyI61Df9CoIKo/XF0W/az2wLcp5QBFy9FwVVslJ6BjINf8ollza1dXFssq
	+wDlKLPnyIB3G0NnyJDKMlBf4P4gle9BdoM5A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MRpUJIWmn+nfai4Robb0rN+07GkZE3gJ
	ABFEkzG30/0N0vcQaCoBP8V1yyCLHY28r3bVQcLoaxVIqiHn8+pPmUZIuPzEE+8c
	PEaaBSW3YvQqc/MRUe6jnhiLGPUx5SLXYjFHd7oroS7+Jao8TJF4nu5DfyFJ/Vkj
	rmuneNTDDE8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E41792756C;
	Thu, 10 Jul 2014 16:52:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60B2D27564;
	Thu, 10 Jul 2014 16:52:24 -0400 (EDT)
In-Reply-To: <xmqqmwci9vn1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 09 Jul 2014 12:31:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1840A158-0874-11E4-9041-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253217>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> I agree, but this case is special. The test asserts that nobody
>> added, modified or removed *anything* inside the .git directory.
>> The reason for problem we are seeing here is that I have to
>> remove the core.worktree setting when moving the git directory
>> from .git/modules into the submodule work tree.
>
> Hmph.  Comparing the files with core.worktree removed sounds like a
> workaround that knows too much about the implementation detail of
> what is being tested.  I am just wondering if core.worktree will
> stay forever be the only thing that is special, or there may come
> other things (perhaps as a fallout of integrating things like Duy's
> multiple-worktree stuff).
>
> But perhaps we cannot do better than this.

One thing we should be able to do (and must do) better is to
validate that core.worktree in the relocated config file actually
points at the right place.  Unsetting before comparing may let us
compare the relocated one in .git/modules/$1/config with the one
that is embedded in the working tree (hence no .git/config), but the
way your "how about this?" patch does, we wouldn't catch a possible
breakage to the relocation code to point core.worktree to a bogus
location, I'm afraid.

Perhaps squashing this to 7e8e5af9 instead?

 t/lib-submodule-update.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index e441b98..fc1da84 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -110,18 +110,23 @@ replace_gitfile_with_git_dir () {
 }
 
 # Test that the .git directory in the submodule is unchanged (except for the
-# core.worktree setting, which we temporarily restore). Call this function
-# before test_submodule_content as the latter might write the index file
-# leading to false positive index differences.
+# core.worktree setting, which appears only in $GIT_DIR/modules/$1/config).
+# Call this function before test_submodule_content as the latter might
+# write the index file leading to false positive index differences.
 test_git_directory_is_unchanged () {
 	(
-		cd "$1" &&
-		git config core.worktree "../../../$1"
+		cd ".git/modules/$1" &&
+		# does core.worktree point at the right place?
+		test "$(git config core.worktree)" = "../../../$1" &&
+		# remove it temporarily before comparing, as
+		# "$1/.git/config" lacks it...
+		git config --unset core.worktree
 	) &&
 	diff -r ".git/modules/$1" "$1/.git" &&
 	(
-		cd "$1" &&
-		GIT_WORK_TREE=. git config --unset core.worktree
+		# ... and then restore.
+		cd ".git/modules/$1" &&
+		git config core.worktree "../../../$1"
 	)
 }
 
