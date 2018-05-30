Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F011F42D
	for <e@80x24.org>; Wed, 30 May 2018 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932065AbeE3RDO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 13:03:14 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35800 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbeE3RDM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 13:03:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id 15-v6so8095665pge.2
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqDzxT4T8jmi+yLgSWi6da42psFi324TRFy5clzJuI8=;
        b=A0XDe/1hh5Kve9FSsXpBvIXP45zJEhacj0M/B3UZE5tJbTWpYVHsJTNJG3aQo9kCgG
         UhQ0APlEO2A5Mnl0a8tvspoCKSQKT+e/FKHGsAKxACzNV4adZDD7xJwpRJSIYgVQzoPo
         8eQkhFawzH9iRLAhk6qHO//qW0poBvMDvKM3xwTEYf4cf6EyrpkSa8s0r+fXbDfwS4CI
         13hj61bXCBMEN9CIvaZM6j55cMgIYFdJ7v6r2s3sxcBrxfyQS2CFBy3Dm72aYdl1/UcF
         vdaGWQYL5YlJVKa+vnp5THEhXi+uOWzeUAkgnSixsbliiaKB6DgogJDqqWHNnjal1FVz
         DZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqDzxT4T8jmi+yLgSWi6da42psFi324TRFy5clzJuI8=;
        b=AH8P56c4XSt0H+IjMUo5HvyR1yPg4OorYCp3jJfVFvbNPd6MNq6NJRUSHyQRYwI86u
         cVnZPC1WmluthFaYnntaxGRnwl+d4Q0XPGUuZjWds+S/UBIb4YaLsGQshfdxd1VOfBSc
         8N5OzNqg+e8JUF4JSF2omG1LJh6ALqqEk4SwtBmgua7AuiP5dw5LywkXL3rJukoZDZyp
         qwxarSxBsotXC+vrzX6eCBLyXulJKLJZlXlDY7lrTwEaUjvBt8YqdUGFjjvV6lf6fjdi
         QBQZWRg/828/nmkcmmOrucu/HnVnggpoBDkLC/hNPQlGyKCKEEGLuTV6YWvinOSRQS4h
         m0Wg==
X-Gm-Message-State: ALKqPweeOD4C85YOOaYOZkAJXy5DHNc9tOE1dXiyIh+/srj1yXJrYQF+
        AdRHSHEXSULAJoExWggqPD14Wy3oYv8=
X-Google-Smtp-Source: ADUXVKKGXCGxGRxtVta7cO53Ur/CmbIF20eDHB0LVyc2fBQEakmgk6Zw65Qiy8s1g+FZwo+zDmB+eQ==
X-Received: by 2002:a65:64c7:: with SMTP id t7-v6mr2888829pgv.274.1527699790084;
        Wed, 30 May 2018 10:03:10 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id t68-v6sm26084876pfe.91.2018.05.30.10.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 10:03:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] submodule--helper: plug mem leak in print_default_remote
Date:   Wed, 30 May 2018 10:03:02 -0700
Message-Id: <20180530170302.191176-3-sbeller@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180530170302.191176-1-sbeller@google.com>
References: <20180530170302.191176-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7c3cd9dbeba..96024fee1b1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -63,6 +63,7 @@ static int print_default_remote(int argc, const char **argv, const char *prefix)
 	if (remote)
 		printf("%s\n", remote);
 
+	free(remote);
 	return 0;
 }
 
-- 
2.17.1.1185.g55be947832-goog

