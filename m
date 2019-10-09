Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35011F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 23:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfJIXon (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 19:44:43 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42785 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732453AbfJIXom (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 19:44:42 -0400
Received: by mail-pf1-f202.google.com with SMTP id w16so3139431pfj.9
        for <git@vger.kernel.org>; Wed, 09 Oct 2019 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oawioSwaAUmu2ZZkSqQzGwRKasmcRDzuAeebAfPR2dI=;
        b=Rqtdr2wCwtU5P7RNpqHG8UeHzn8+6FecGDtq6+TM4Je/tHxlZQ9WmGpZbS/7EGai8I
         AJXEHOAhN9rnDDYKZnlmRbnlgvfcF0GlQTzMQ8fWnuP3ig5wH0RAn4Rgg0Ii9lYkB8mF
         /5a3uMwBXt1YL/f38oVOkY5C8zbKNHpBalMmRn/+U7W38CFpA5ACJRO2O4oTpQCAMa4Q
         EyE6fBkZf3gu/hgwhPJn5H87P8dlp+hsTp9nXX9mrHb6Gh0Le4qSk65HJfOk4pCg70GQ
         jdtOQZjBP5Umop3xXFFLoTOwkU7hMvkplEQ6aKlBldUpqK+dWgLjHwZxcWU5nC1+YtA4
         KKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oawioSwaAUmu2ZZkSqQzGwRKasmcRDzuAeebAfPR2dI=;
        b=Z+udgg0bYXj85v3jAuaSJHDdQksGFhFcleBWcrn9gqFW5rQl6PAWn0BjBNf79Jnp3F
         Ri3E4ywLQir/eEffBXz3Bwj0sSEoR+KUs8G4Po8V2qtzEqAUJhSOdDXvBD3kZfygr914
         6tGl+QrQFsCTQyherCo0eomjM4lReBsmoh7NF5nexrfFNwy3Ao3LWXFyIeOqU3OOVfV2
         JDcca7RHuN7n2xd6FZoioOBDhPpOzbwBUGdzly1MyAzJlbiKznzhERrTDJ7lYz/oKXUg
         3chgi79KP64ORUFlT3VoflpamF0uRQytq59REQmCE7lB5jvpbEPFznDPaMOImUUIjk/T
         RVLw==
X-Gm-Message-State: APjAAAUFFvRFPwFV8yv/UKmQvqeHYj+B4agqyIJudAs8j3t1u9mw7GKE
        ojnGt0IsXswYgRVHIkYMnkPy7ntHB6BsUFlilF+pQhgwT1M+TrZXEzRTB533dAJ1gSBWGX3zMNp
        gPSLIP4BXTGDObwRVpW/CcxZysm9J2J1wHTnKJDQ4phO/e2u6j6+phm9xpdu2QivY3iaqSaCP1G
        Ae
X-Google-Smtp-Source: APXvYqwwuJuDAQ8SfV2THRpnsDbSwF2hliv6Gl4yuUM3i1IrcWMtrzrstkryXqATZrVHTthtjIi30Z0tfkxudtjrgp5y
X-Received: by 2002:a63:c045:: with SMTP id z5mr7089447pgi.69.1570664680291;
 Wed, 09 Oct 2019 16:44:40 -0700 (PDT)
Date:   Wed,  9 Oct 2019 16:44:21 -0700
In-Reply-To: <cover.1570663470.git.jonathantanmy@google.com>
Message-Id: <6fcda102acd550818536c69c41c270a8058050a7.1570663470.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 5/6] index-pack: make resolve_delta() assume base data
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent commit will make the quantum of work smaller, necessitating
more locking. This commit allows resolve_delta() to be called outside
the lock.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 17997834ec..3908cd3115 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -926,7 +926,7 @@ static struct base_data *make_base(struct object_entry *obj,
 static struct base_data *resolve_delta(struct object_entry *delta_obj,
 				       struct base_data *base)
 {
-	void *base_data, *delta_data, *result_data;
+	void *delta_data, *result_data;
 	struct base_data *result;
 	unsigned long result_size;
 
@@ -941,8 +941,8 @@ static struct base_data *resolve_delta(struct object_entry *delta_obj,
 		obj_stat[i].base_object_no = j;
 	}
 	delta_data = get_data_from_pack(delta_obj);
-	base_data = get_base_data(base);
-	result_data = patch_delta(base_data, base->size,
+	assert(base->data);
+	result_data = patch_delta(base->data, base->size,
 				  delta_data, delta_obj->size, &result_size);
 	free(delta_data);
 	if (!result_data)
@@ -1000,6 +1000,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 					   base->obj->real_type))
 			BUG("child->real_type != OBJ_REF_DELTA");
 
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ref_first == base->ref_last && base->ofs_last == -1)
 			free_base_data(base);
@@ -1014,6 +1015,7 @@ static struct base_data *find_unresolved_deltas_1(struct base_data *base,
 
 		assert(child->real_type == OBJ_OFS_DELTA);
 		child->real_type = base->obj->real_type;
+		get_base_data(base);
 		result = resolve_delta(child, base);
 		if (base->ofs_first == base->ofs_last)
 			free_base_data(base);
-- 
2.23.0.581.g78d2f28ef7-goog

