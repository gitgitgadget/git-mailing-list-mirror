Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494C8EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGUPtc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGUPtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:49:31 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2510C3
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:49:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 831D22E21C;
        Fri, 21 Jul 2023 11:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B9RJuBBbuv7TX59Tmk1XjIuwIP+dair4nqIl4x
        P3QE8=; b=U0K2yCziXnUjEn/LqM/z1H/XVxTrCGha2bJM7ElG54uSP8W8Xh4nkq
        SoGs8L/eX9VXlJFMDbHaLxUpdtsla7nbfrWDHegbGlpsmvntzCdeINwwZj2WqCoi
        FK5+KnRBjGaFjlaL/oQ0R9je6xXMFw8bFobkprwkO2d78pp8JKsmk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B6B22E21B;
        Fri, 21 Jul 2023 11:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 552A92E218;
        Fri, 21 Jul 2023 11:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] t2400: rewrite regex to avoid unintentional PCRE
References: <20230715025512.7574-1-jacobabel@nullpo.dev>
        <20230716033743.18200-1-jacobabel@nullpo.dev>
        <20230721044012.24360-1-jacobabel@nullpo.dev>
        <20230721044012.24360-4-jacobabel@nullpo.dev>
        <xmqqv8edwb0k.fsf@gitster.g>
Date:   Fri, 21 Jul 2023 08:49:24 -0700
In-Reply-To: <xmqqv8edwb0k.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        21 Jul 2023 08:16:11 -0700")
Message-ID: <xmqqiladw9h7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B0E7132-27DE-11EE-9F64-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just for reference, here is a summary, as a squashable commit, of
the message I am responding to.

---- >8 ----
Subject: [PATCH] SQUASH???

(remove this part of the message while squashing)
Use ` `, not `[ ]`, as the proposed log message described.

(append to the proposed log message of the previous)
Also, do not write `\+` in BRE and expect it to mean 1 or more;
it is a GNU extension that may not work everywhere.

Remove '.*' at the end of a pattern that is not right-anchored.

Helped-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2400-worktree-add.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index eafecdf7ce..aee5eba980 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -417,9 +417,9 @@ test_wt_add_orphan_hint () {
 		grep "hint: If you meant to create a worktree containing a new orphan branch" actual &&
 		if [ $use_branch -eq 1 ]
 		then
-			grep -E "^hint:[ ]+git worktree add --orphan -b [^ ]+ [^ ]+$" actual
+			grep -E "^hint: +git worktree add --orphan -b [^ ]+ [^ ]+$" actual
 		else
-			grep -E "^hint:[ ]+git worktree add --orphan [^ ]+$" actual
+			grep -E "^hint: +git worktree add --orphan [^ ]+$" actual
 		fi
 
 	'
@@ -709,8 +709,8 @@ test_dwim_orphan () {
 	local info_text="No possible source branch, inferring '--orphan'" &&
 	local fetch_error_text="fatal: No local or remote refs exist despite at least one remote" &&
 	local orphan_hint="hint: If you meant to create a worktree containing a new orphan branch" &&
-	local invalid_ref_regex="^fatal: invalid reference: .*" &&
-	local bad_combo_regex="^fatal: '[a-z-]\+' and '[a-z-]\+' cannot be used together" &&
+	local invalid_ref_regex="^fatal: invalid reference: " &&
+	local bad_combo_regex="^fatal: '[-a-z]*' and '[-a-z-]*' cannot be used together" &&
 
 	local git_ns="repo" &&
 	local dashc_args="-C $git_ns" &&
-- 
2.41.0-376-gcba07a324d

