Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEBBD1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 23:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFZXv3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 19:51:29 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:55223 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfFZXv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 19:51:28 -0400
Received: by mail-pg1-f202.google.com with SMTP id t2so185478pgs.21
        for <git@vger.kernel.org>; Wed, 26 Jun 2019 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CzbVNOD2j5bMf9GFKvZflE6/nywHKbyh3joXpDHdDOM=;
        b=Tfb8G06f7SIh5omUaMKVSQTTBrr651oHxDzD9i9mkQIPwuMSkPKINggGEDdW6HluRD
         8Lbrphnx8Eg/BRMHybJujxM9+q10CCIZikNdRPEHlnY6hWPZWISbjOVMa56HzvZvFGGe
         Sk+JUbxssABRC0dPAUqhdU83jMVnB2vL3RR8BzEed/FjE/yP9KZooTrnQ65dKD6W3Fir
         wfaENOES6n3rZK2ZbAne1dMs2RFiHDwtMYjZYVkYZRrgTL/4Gst7rSb148Rpm0x89189
         aXzp4mE3URrpUsX3892lBV+nmfTkyKS2VH1EhOeuGy29Xcy+ey+PuVre3YvbGkRXsb2e
         V/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CzbVNOD2j5bMf9GFKvZflE6/nywHKbyh3joXpDHdDOM=;
        b=k71KsPXSv198pt5Vti0qnj5LKRX4Ovm5mDUubjUlJ2gSbgYigJ0tk+3dqzL/B6iTeJ
         tuzY4pIIJvI+/2YrS/EPbEusvAZLCFXiy4I3dG1SaAShZ9F7c1AyWjabizBVVjioJ0nN
         jYA53A9YNvTs/yyR15EZaUnQ4qr8QALmPb8TUucntXs3SanhlCweg8DWaQB8JKbaS9eT
         l7/8OER+fqYq+lPAcQ9dlAI0+hCqa4CzpFPoYOBS4DPzfzy6uGgc2zddJtIO/COSFyHb
         bjqH3ITEJ8GlTpafRnG8OuSN41oBbw0YgAO8iPI4TPjTTMLZZzQEiIuOglicIL0IXJDD
         tsNQ==
X-Gm-Message-State: APjAAAXsf2vRUSk5rcyOW9rIaZ9g+OapHNNUUtbHI413bk99Ri4LUtRY
        Fmq7d+Xv+PfQsy3tnTTTSKKUyCFsxoAjhQ9qLOC7mBL6HiQWdcXq52kjMhx8jSIFjfNmpmUJEE+
        bF8dWem8ZYdT+WvOLMNwJOwww0q6Qk+fVVN/Nqw+80H3KwTK8Vd6znWlGm2UkdNYaV5XYr5TLgA
        ==
X-Google-Smtp-Source: APXvYqy7FFnZ4QtqW8oz+JlUZUHvvAvgPfVrMdKGhjLZywod1OTLIevWBE/L906pzaYUKS6dtlQb0JjsoT10LDOm6zo=
X-Received: by 2002:a65:5347:: with SMTP id w7mr587077pgr.375.1561593087792;
 Wed, 26 Jun 2019 16:51:27 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:50:32 -0700
In-Reply-To: <20190626235032.177551-1-emilyshaffer@google.com>
Message-Id: <20190626235032.177551-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190626235032.177551-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v2 13/13] walken: reverse the object walk order
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Demonstrate that just like commit walks, object walks can have their
order reversed. Additionally, add verbose logging of objects encountered
in order to let contributors prove to themselves that the walk has
actually been reversed. With this commit, `git walken` becomes extremely
chatty - it's recommended to pipe the output through `head` or `tail` or
to redirect it into a file.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I91883b209a61ae4d87855878291e487fe36220c4
---
 builtin/walken.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/walken.c b/builtin/walken.c
index dc59ff5009..37b02887a5 100644
--- a/builtin/walken.c
+++ b/builtin/walken.c
@@ -112,11 +112,13 @@ static int git_walken_config(const char *var, const char *value, void *cb)
 
 static void walken_show_commit(struct commit *cmt, void *buf)
 {
+	printf("commit: %s\n", oid_to_hex(&cmt->object.oid));
 	commit_count++;
 }
 
 static void walken_show_object(struct object *obj, const char *str, void *buf)
 {
+	printf("%s: %s\n", type_name(obj->type), oid_to_hex(&obj->oid));
 	switch (obj->type) {
 	case OBJ_TREE:
 		tree_count++;
@@ -158,6 +160,7 @@ static void walken_object_walk(struct rev_info *rev)
 	rev->tag_objects = 1;
 	rev->tree_blobs_in_commit_order = 1;
 	rev->exclude_promisor_objects = 1;
+	rev->reverse = 1;
 
 	if (prepare_revision_walk(rev))
 		die(_("revision walk setup failed"));
-- 
2.22.0.410.gd8fdbe21b5-goog

