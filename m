Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B41FC001B0
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjF0TxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0TxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:13 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268010F5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:12 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b806d07935so12753085ad.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895592; x=1690487592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2T39xnHDYEY7hV4G88h6xY2GmEwlx6kKroIelOcchI=;
        b=hg2QRtNt/awVF/zRxQ9wIWnd3pI97pMCA4Uumr+nOOhk/ZoEE5CKZILsEoSs9dW/5Z
         +8kATu/BNSuhGyWd5DXlW8moxQz1oU+fyBBbUVOXKkB8Q8TLY78LMZ0YRlhI/Wu99OjH
         LWQYBouh5qfsqzqqQF7FW1PG0ukHuUTRue22eknW+7x0427EwQGmhVVy9S+qZrIBrAjb
         q4VCnWfXh6PAuxcuGdnf6pLzOZqX5lN/XWdCUxXRMOoiTVFwDDKMJhUpJPMIJmlapxN+
         X3quuJ92Qtzai9S4CDW/98qYW/e2kD7sRwSG+LoqH6nknykCG3VUu/bLZHp5pN1epiw+
         Y4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895592; x=1690487592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2T39xnHDYEY7hV4G88h6xY2GmEwlx6kKroIelOcchI=;
        b=i0s1ZbAGq4bjn0skbmw1DKcVCbzRAQNdM6CkU1JcUiHWWIof8NNMC7EgctwGc33NCO
         3/vulqoMK1XU7Hag5v/xb/y2aiqbCMchwPajzdJK+veFgBvaTqMURyg9udjxGBXQLR7B
         xD/+0IRJZiiawPoOzo+jO+uh8g3EnwovQpbo/HR5iODt2UqqVLAhKyxf4y4tvrw+HlUq
         uVMTVWSp5kw2dYFvk0FtLyfVvx7pezExSHc98DITw/BEzkOEzDDVO9GrbazrQ0zh64K2
         e23ApGWs6FS5dTTQFha9sZzLsYqfWX2d0wiPLy98m5Rxy6DZcVxCNzC+aU0ShoG24TXF
         Tv4w==
X-Gm-Message-State: AC+VfDzFX45XWZIYgqcnvrajIJ8Vk8y1Jyl6OGSMrIIAetY9g7j/gtjM
        HyTiLcg8vzwFWgF64/Q14lR9E3qN//Z7d0oijsXUhbNoB0IC+R40rdN8IvNXO6K8HvZpRCRvwDM
        KD5zckFoAyFfgN4CcVh19ZV47nhs+p7N1vkUxEOBcXVGi5cIA7NAydgB66thRiI0CzQ==
X-Google-Smtp-Source: ACHHUZ4QFoIvLBmzNiaoo/uj6tq0DoLhIAmwIK+qu9LbY0oPUQetj6OeTGAMMKGBKOUflMJEHL4ZfPh7ej0JV9I=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:c946:b0:1b5:a0c:fddf with SMTP
 id i6-20020a170902c94600b001b50a0cfddfmr802909pla.6.1687895591947; Tue, 27
 Jun 2023 12:53:11 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:47 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-5-calvinwan@google.com>
Subject: [RFC PATCH 4/8] config: correct bad boolean env value error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An incorrectly defined boolean environment value would result in the
following error message:

bad boolean config value '%s' for '%s'

This is a misnomer since environment value != config value. Instead of
calling git_config_bool() to parse the environment value, mimic the
functionality inside of git_config_bool() but with the correct error
message.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 config.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 09851a6909..5b71ef1624 100644
--- a/config.c
+++ b/config.c
@@ -2172,7 +2172,14 @@ void git_global_config(char **user_out, char **xdg_out)
 int git_env_bool(const char *k, int def)
 {
 	const char *v = getenv(k);
-	return v ? git_config_bool(k, v) : def;
+	int val;
+	if (!v)
+		return def;
+	val = git_parse_maybe_bool(v);
+	if (val < 0)
+		die(_("bad boolean environment value '%s' for '%s'"),
+		    v, k);
+	return val;
 }
 
 /*
-- 
2.41.0.162.gfafddb0af9-goog

