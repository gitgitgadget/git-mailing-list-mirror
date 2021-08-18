Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB73C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA5F608FE
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhHRUQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 16:16:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54632 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhHRUQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 16:16:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 730D21504D4;
        Wed, 18 Aug 2021 16:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9GgzjswsH9GVgHCadfkC8xUNRabDYvPcIHWOTc
        B6sP4=; b=m6yqK5Cj4lBdAQX27FwPFe08iCVq0vCJDTbnurKzisvjeWQHGr9o70
        dQo2lR1nNGDJ8O1YF/f483HH6EVkVVtJV7JO5lnnFdaeczFXkOAHbd0g/Ak80DgL
        +Kt2IsAoCG4KOMwYvWKJwvtIZR2OLlLLVY1ByoibsZcspJLTJDq/A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C7DE1504D3;
        Wed, 18 Aug 2021 16:16:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A52801504D1;
        Wed, 18 Aug 2021 16:15:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: [PATCH] fixup! clone: set submodule.recurse=true if
 submodule.stickyRecursiveClone enabled
References: <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <pull.1006.v6.git.1628903396783.gitgitgadget@gmail.com>
        <xmqqy293ucju.fsf@gitster.g> <YRw/8tThN7djNE+E@google.com>
        <xmqqk0ki5xwk.fsf@gitster.g>
Date:   Wed, 18 Aug 2021 13:15:56 -0700
In-Reply-To: <xmqqk0ki5xwk.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        18 Aug 2021 12:57:15 -0700")
Message-ID: <xmqqa6le5x1f.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D5E4AA-0061-11EC-98D3-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Narrow the scope of a temporary variable used only once and
immediately die, and rename it to a shorter, throw-away name.

Also lose a {} around a single statement block.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be squashed into mk/clone-recurse-submodules topic 1a0e8231
   (clone: set submodule.recurse=true if
   submodule.stickyRecursiveClone enabled, 2021-08-14)

 builtin/clone.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a08d901224..9c0c68a8ef 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -986,7 +986,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
-	int sticky_recursive_clone;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1115,6 +1114,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_recurse_submodules.nr > 0) {
 		struct string_list_item *item;
 		struct strbuf sb = STRBUF_INIT;
+		int val;
 
 		/* remove duplicates */
 		string_list_sort(&option_recurse_submodules);
@@ -1131,10 +1131,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					   strbuf_detach(&sb, NULL));
 		}
 
-		if (!git_config_get_bool("submodule.stickyRecursiveClone", &sticky_recursive_clone)
-		    && sticky_recursive_clone) {
-		    string_list_append(&option_config, "submodule.recurse=true");
-		}
+		if (!git_config_get_bool("submodule.stickyRecursiveClone", &val) &&
+		    val)
+			string_list_append(&option_config, "submodule.recurse=true");
 
 		if (option_required_reference.nr &&
 		    option_optional_reference.nr)
-- 
2.33.0-204-gff69670db4

