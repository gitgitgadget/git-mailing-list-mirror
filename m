Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90FE31F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965058AbeFNWyi (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:38 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:35314 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964987AbeFNWyh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:37 -0400
Received: by mail-vk0-f74.google.com with SMTP id d134-v6so3001690vkf.2
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ZC8B36TbjzHxxnnggcDvHJc+BQe27pz4CVvnZHuXSB8=;
        b=AQ5bBzykZtFnwEYnGuwnhw9Pfy23LcddUsrht+gKhtVDNdNCk91wIjxjKw73R7+xHF
         5hooWTF4HISiKWRs+NXm1Dyp/mpAMerd/h8t2Nn5XopETjZcjt7E/PPLCj6cGv1WeoTX
         03set2Did2xYMdkAGa8zdPxAN/pNrVhpBoja0q6Us3f+QaNKqx72WqO0I2L0wJvUPGLX
         hrxAWk2f5W8hdB8VqscXcFX+GwS68IWVu8Qw9dDhf/M7n91rXFjlLmjdGI21zhhHDJy0
         spnzGxMqKj7GRhxsu3kUHdGTp4yGzVUa+U/sq/IJcgVAhFoYIopTYvc5gjS5+kqy891f
         Andg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ZC8B36TbjzHxxnnggcDvHJc+BQe27pz4CVvnZHuXSB8=;
        b=JCxvp1r5Y/Z6awUWCb/HmTTZ8qU3ER956g4V9W4+Yq2c+wI3WeO1ck4G6uM1XIlxoo
         OH3u+I6z/3BhGgC5bj4nF2EibgcbXl51Aw2aGegIcsRqGl6rvwEZkPF4DhOLUox/0vVm
         kJkvVMNsiq3/y6+DazvqF9B+khWp1B4qI2/QtSfzZ4G+0+WVgHEmCQ75Wp9davpyzLwb
         BxCk8WYWEMUOMfL0S88mSxK6/hh0WdkOTqmpU/J7nQUfN++cxyy0wpceIPP8LYqce+rW
         XopabBRS08x4CkOr4Je8c+dwqYgL/rMg4yQ5dY7aybSQQV7nXfGSeoDdeKAkHRs22ApG
         x4GA==
X-Gm-Message-State: APt69E2g/pFAf6SyvIggkt0kNJO47m6UBbod8BwGIngwOFe5Ud7beRnB
        9Hp1m23nglgSJW6oJsrFoYl9vj/2TgRDkkqCLdUO2MTtnDYX3cU4JMsESaMM/lUtoY+ZDgtUeRj
        DzleS2JWb7/I08Qd2W6Y6Q62I9PM1V5suCfgRryd6fdUMeDgDWCGOeFwWKpQ4GQHqIW9+3k+4Ks
        Rs
X-Google-Smtp-Source: ADUXVKIXcxSZmTestQ2bF4L4UaKMDRbQuVJoB4fN1X+P4rdSpKAS3zhzJeuWqDz7yl7/nMN8dUrPwzjQ7nlIY9/e2kSB
MIME-Version: 1.0
X-Received: by 2002:ab0:51b1:: with SMTP id g46-v6mr1971362uaa.101.1529016876677;
 Thu, 14 Jun 2018 15:54:36 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:23 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <dca6619c551b8259aef0476146184996657a80e9.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 2/7] fetch-pack: clear marks before re-marking
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If tag following is required when using a transport that does not
support tag following, fetch_pack() will be invoked twice in the same
process, necessitating a clearing of the object flags used by
fetch_pack() sometime during the second invocation. This is currently
done in find_common(), which means that the invocation of
mark_complete_and_common_ref() in do_fetch_pack() is useless.

(This cannot be reproduced with Git alone, because all transports that
come with Git support tag following.)

Therefore, move this clearing from find_common() to its
parent function do_fetch_pack(), right before it calls
mark_complete_and_common_ref().

This has been occurring since the commit that introduced the clearing of
marks, 420e9af498 ("Fix tag following", 2008-03-19).

The corresponding code for protocol v2 in do_fetch_pack_v2() does not
have this problem, as the clearing of flags is done before any marking
(whether by rev_list_insert_ref_oid() or
mark_complete_and_common_ref()).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 5c87bb8bb..2812499a5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -336,9 +336,6 @@ static int find_common(struct fetch_pack_args *args,
 
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
-	if (marked)
-		for_each_ref(clear_marks, NULL);
-	marked = 1;
 
 	for_each_ref(rev_list_insert_ref_oid, NULL);
 	for_each_cached_alternate(insert_one_alternate_object);
@@ -1070,6 +1067,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
 
+	if (marked)
+		for_each_ref(clear_marks, NULL);
+	marked = 1;
 	mark_complete_and_common_ref(args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
-- 
2.17.0.582.gccdcbd54c4

