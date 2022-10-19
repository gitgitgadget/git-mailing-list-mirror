Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853CCC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 20:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJSUoJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 16:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJSUoH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 16:44:07 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF1E197F97
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 13:44:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35A3C1C28D8;
        Wed, 19 Oct 2022 16:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hjnCk+oQkvTctjAR9ZK5Hw+8HEdXjWf0OoGMDa
        voJus=; b=pt3xxEH6OsTnPIHmV7PZY+CJBaK7i5Blesl/NDAo2kmdAGfx9NnaUo
        ASYJtlvYFv4b/2kgTOKTGBPcaxQaapFQ4ZPmUaWY/dl9bxWjkrcyWbwgzSK6dPrW
        hTmYuaLh/nCyb4Vl9p8+eruxf2lpzr39xJu6EA0GCB/OV1NB6ezsw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E4211C28D7;
        Wed, 19 Oct 2022 16:44:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6051F1C28D5;
        Wed, 19 Oct 2022 16:44:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heather Lapointe <alpha@alphaservcomputing.solutions>
Cc:     Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive
 command
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <xmqqo7u9t1zf.fsf@gitster.g>
        <CAFwvh9BwV=NEtF_gsh9Tr8gHz02=78m4MCBQbuXk5SzKCAm4RA@mail.gmail.com>
        <xmqqy1tbssa8.fsf@gitster.g>
Date:   Wed, 19 Oct 2022 13:44:00 -0700
In-Reply-To: <xmqqy1tbssa8.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        19 Oct 2022 09:16:15 -0700")
Message-ID: <xmqqwn8vpmr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C333B0E4-4FEE-11ED-9EF4-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Mimic what Taylor did to adjust to the new world order that was
> introduced in the 2.38.1 update.
>
> Look at 9c32cfb4 (Sync with v2.38.1, 2022-10-17), which merges
> 2.38.1 and updates the tests to adjust to the new world order, by
> comparing the t/ directory of its first parent and the result of the
> merge.  It shows what Taylor did to adjust the tests to adjust.
>
>     $ git diff 9c32cfb4^ 9c32cfb4 t/
>
> I personally doubt it is generally a good idea, as it sets a bad
> pattern that tempts unsuspecting users to blindly copy and paste it
> to their $HOME/.gitconfig without realizing what its ramifications
> are, but the easiest workaround may be to mimic what was done in
> t/lib-submodule-update.sh that sets protocol.file.allow
> configuration knob globally.

I'll queue this at the tip of your topic when I rebuild 'seen' for
today's integration run.

 t/t1023-tree-read-tree-at.sh  | 4 +++-
 t/t5005-archive-submodules.sh | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t1023-tree-read-tree-at.sh b/t/t1023-tree-read-tree-at.sh
index 9e5ce3abb4..cfe6c867e3 100755
--- a/t/t1023-tree-read-tree-at.sh
+++ b/t/t1023-tree-read-tree-at.sh
@@ -32,7 +32,8 @@ test_expect_success 'read_tree basic' '
 '
 
 test_expect_success 'read_tree submodules' '
-	rm -rf walk_tree_submodules &&
+	git config --global protocol.file.allow always &&
+	rm -rf submodule1 &&
 	git init submodule1 &&
 	(
 		cd submodule1 &&
@@ -42,6 +43,7 @@ test_expect_success 'read_tree submodules' '
 		git add file1.txt dir1/dirA/file1.txt &&
 		git commit -m "initial commit"
 	) &&
+	rm -rf walk_tree_submodules &&
 	git init walk_tree_submodules &&
 	(
 		cd walk_tree_submodules &&
diff --git a/t/t5005-archive-submodules.sh b/t/t5005-archive-submodules.sh
index aad6cfd108..e1413e08a2 100755
--- a/t/t5005-archive-submodules.sh
+++ b/t/t5005-archive-submodules.sh
@@ -4,7 +4,7 @@ test_description='git archive --recurse-submodules test'
 
 . ./test-lib.sh
 
-check_tar() {
+check_tar () {
 	tarfile=$1.tar
 	listfile=$1.lst
 	dir=$1
@@ -15,7 +15,7 @@ check_tar() {
 	'
 }
 
-check_added() {
+check_added () {
 	dir=$1
 	path_in_fs=$2
 	path_in_archive=$3
@@ -26,7 +26,7 @@ check_added() {
 	'
 }
 
-check_not_added() {
+check_not_added () {
 	dir=$1
 	path_in_archive=$2
 
@@ -37,6 +37,7 @@ check_not_added() {
 }
 
 test_expect_success 'setup' '
+	git config --global protocol.file.allow always &&
 	rm -rf repo_with_submodules submodule1 uninited_repo_with_submodules &&
 	git init repo_with_submodules &&
 	git init submodule1 &&
-- 
2.38.1-236-gf47955814b

