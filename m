Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760CEC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB4321D56
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 19:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Px/suT94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJTIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:08:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgCJTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 15:08:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EED67B3E0E;
        Tue, 10 Mar 2020 15:08:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Won8B6uw1WJzUIenpkN6UiJdTE=; b=Px/suT
        94iImuxa2v/DxZQHh2ULBiyTbjJS44Oj/0kxPdSqS+OHw3UUeigOFalJEOPktukt
        lriW7EMlOnyQNQ+c5IyjoOcDuc0g3o22mDuFNzps71WFgsCB0tAtmI6p+p9MMEG/
        QoJHNM3oiMpKB8Lv9iYkJsHlK3/OjBhoVnkLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SPhX1iaWimxWiIZ7vKFuoyQ6bJYkxfjQ
        YVRkWxMdQnkpfats7iilN+LB+UZmOWCCy+LhoSnrJzxfxa6vGOAlMc7KifOo8Y4I
        uX682GIdTO8yjDGnH2KwMyq+MUiG4h8SdkJYpvdLs5eSOgAzmCh5vlU6C8tdQ//e
        L8782T/KG24=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5D6BB3E0D;
        Tue, 10 Mar 2020 15:08:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 360D9B3E0C;
        Tue, 10 Mar 2020 15:08:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.26.0-rc1
References: <xmqqo8t4z29k.fsf@gitster-ct.c.googlers.com>
        <20200310174017.GA549010@coredump.intra.peff.net>
Date:   Tue, 10 Mar 2020 12:08:41 -0700
In-Reply-To: <20200310174017.GA549010@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 10 Mar 2020 13:40:17 -0400")
Message-ID: <xmqqwo7shvt2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FD41E36-6302-11EA-8F60-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Mar 10, 2020 at 07:57:11AM -0700, Junio C Hamano wrote:
>
>>  * "git rebase" has learned to use the merge backend (i.e. the
>>    machinery that drives "rebase -i") by default, while allowing
>>    "--apply" option to use the "apply" backend (e.g. the moral
>>    equivalent of "format-patch piped to am").  The rebase.backend
>>    configuration variable can be set to customize.
>
> I noticed a few behavior changes that I think are related to this
> switch.
> ...
> Oops. If I "git rebase --continue" from there, I get "No rebase in
> progress?". Doing "git cherry-pick --skip" clears it. I guess the issue
> is the continued presence of .git/CHERRY_PICK_HEAD.
>
> As you can see from the output above (and the earlier snippet, if you
> run it), there are also a bunch of minor stderr output changes. I think
> these probably aren't worth caring about.

Hmph.  It might have been way premature to switch the default, then.

Introducing rebase.backend to allow adventurous to opt in early,
while keeping the default backend same, may not be a bad way to
avoid the regression in the upcoming release and to give us enough
time deal with it after the release, perhaps?

-- >8 --
Subject: rebase: do not switch the default to 'merge' just yet

Reverts 2ac0d627 (rebase: change the default backend from "am" to
"merge", 2020-02-15) to postpone the switch of default backend of
"git rebase" to the merge backend, as there seem to be a few
remaining bugs (we saw two reported on the day after 2.26-rc1---we
do not know how many remaining bugs there are) that regresses the
end user experience.

 * When a rebase stops with a merge conflict, "rebase --continue"
   after resolving the conflict opens an editor with the merge
   backend;

 * When a rebase sees a change that is already applied, the end user
   gets thrown into "cherry-picking" mode, causing "git status" to
   say "nothing to commit, working tree clean". At that point, "git
   rebase --continue" does not let the user get out of this state.

Let's keep the default for the upcoming release, without removing
the configuration variable so that those adventurous can opt into
using the 'merge' backend to help polishing it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt           | 6 +++---
 builtin/rebase.c                       | 4 ++--
 t/t5520-pull.sh                        | 7 +++----
 t/t9106-git-svn-commit-diff-clobber.sh | 3 +--
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8c1f4b8268..58bc556142 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -260,8 +260,7 @@ See also INCOMPATIBLE OPTIONS below.
 
 --apply:
 	Use applying strategies to rebase (calling `git-am`
-	internally).  This option may become a no-op in the future
-	once the merge backend handles everything the apply one does.
+	internally).  This is the default.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -315,7 +314,8 @@ See also INCOMPATIBLE OPTIONS below.
 --merge::
 	Use merging strategies to rebase.  When the recursive (default) merge
 	strategy is used, this allows rebase to be aware of renames on the
-	upstream side.  This is the default.
+	upstream side.  This may become the default in the future
+	once known bugs are shaken out of this backend.
 +
 Note that a rebase merge works by replaying each commit from the working
 branch on top of the <upstream> branch.  Because of this, when a merge
diff --git a/builtin/rebase.c b/builtin/rebase.c
index f3036f40c6..37d2920620 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -100,7 +100,7 @@ struct rebase_options {
 #define REBASE_OPTIONS_INIT {			  	\
 		.type = REBASE_UNSPECIFIED,	  	\
 		.empty = EMPTY_UNSPECIFIED,	  	\
-		.default_backend = "merge",	  	\
+		.default_backend = "apply",	  	\
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = ARGV_ARRAY_INIT,		\
 		.git_format_patch_opt = STRBUF_INIT	\
@@ -1913,7 +1913,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			imply_merge(&options, "--merge");
+			options.type = REBASE_MERGE;
 		else if (!strcmp(options.default_backend, "apply"))
 			options.type = REBASE_APPLY;
 		else
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2f86fca042..e8d28e5e36 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -340,7 +340,7 @@ test_expect_success '--rebase with conflicts shows advice' '
 	test_tick &&
 	git commit -m "Create conflict" seq.txt &&
 	test_must_fail git pull --rebase . seq 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" err
+	test_i18ngrep "Resolve all conflicts manually" out
 '
 
 test_expect_success 'failed --rebase shows advice' '
@@ -354,7 +354,7 @@ test_expect_success 'failed --rebase shows advice' '
 	git checkout -f -b fails-to-rebase HEAD^ &&
 	test_commit v2-without-cr file "2" file2-lf &&
 	test_must_fail git pull --rebase . diverging 2>err >out &&
-	test_i18ngrep "Resolve all conflicts manually" err
+	test_i18ngrep "Resolve all conflicts manually" out
 '
 
 test_expect_success '--rebase fails with multiple branches' '
@@ -774,8 +774,7 @@ test_expect_success 'git pull --rebase does not reapply old patches' '
 	(
 		cd dst &&
 		test_must_fail git pull --rebase &&
-		cat .git/rebase-merge/done .git/rebase-merge/git-rebase-todo >work &&
-		grep -v -e \# -e ^$ work >patches &&
+		find .git/rebase-apply -name "000*" >patches &&
 		test_line_count = 1 patches &&
 		rm -f work
 	)
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index aec45bca3b..dbe8deac0d 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -92,8 +92,7 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 
 test_expect_success 'check that rebase really failed' '
-	git status >output &&
-	grep currently.rebasing output
+	test -d .git/rebase-apply
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
