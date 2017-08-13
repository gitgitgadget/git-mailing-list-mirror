Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEA31F667
	for <e@80x24.org>; Sun, 13 Aug 2017 19:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdHMTg0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 15:36:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33728 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdHMTgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 15:36:24 -0400
Received: by mail-it0-f67.google.com with SMTP id m34so6835508iti.0
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 12:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BkjJfi6rHYD/KYDz589MHC5v5iFKfMFrEDapMX9/7jA=;
        b=vM00FEsSV/lcmr+M+qE8NmuQ9sZe6Nig+kIOTyhTsHiJafOYh/JqhPrXuLCnd+Aie4
         cyqV4dfvC0gPOiWyBFCm8/ekyQdlDB0a812RhhbQVGELsEVhqs7YBSz3LEPdt13qUWlO
         lsMh+Gye95/wKguD1D4W+8a+tEFajPwYyhPKVZ3LMm6nrbsHFiZewjmMFt1dkhIaSdAm
         GUXlVPbn7K/Tdcr9mDOB6wxZ1oZfVMADZj3Isejia2ukAFP9I2St0gm//dM7qDb+kWGQ
         Ms/u4pUgPEpUP72aQQNMvM5MCNF5Vq5jgh8Q896NN8uxqWsBA23xw8SbTaxoveUt8+Zn
         gc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BkjJfi6rHYD/KYDz589MHC5v5iFKfMFrEDapMX9/7jA=;
        b=IH293D/r4d2+U9KnLWZZZQdFn/6dlh3Th0JEdXuznc4kJnnOJK8q0sHe61DAtYj+pp
         o/iGNSrpRE47Ih2ANdIuDNRLoyw3fsc8Kltp6/67mZ7LB+z1Tw1eqHXepMvV29BsuRfp
         TQP9pZLCDnQM5Hwa/Kf2DSV8ixW2ET7UQXEZJe6+LnhagDXhtrsrhueioWHMIqfvYnW/
         RvQQ5K0tZUVfefmVOJ33rEr4JYpquXAj9VkXUz2dXZzt5bZCrMA1wmONtTxSTjWHIUR8
         9RA0lEkDE9FTllWQmyp/sGQHHCkVfVN/zkmPgAeN5+MyP6vpbS7vUofS2ncpCttnFYqC
         aN3A==
X-Gm-Message-State: AHYfb5iNfnmJ7scs3d+d7i3uGM/TSR5WL3VHufYAmaVLbuOe/pgrCtVT
        6WPHUoQosC3o3ZTlgq4=
X-Received: by 10.36.65.223 with SMTP id b92mr4239013itd.57.1502652983695;
        Sun, 13 Aug 2017 12:36:23 -0700 (PDT)
Received: from localhost.localdomain ([192.252.136.182])
        by smtp.gmail.com with ESMTPSA id s66sm2045678ita.9.2017.08.13.12.36.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 12:36:23 -0700 (PDT)
From:   Richard Maw <richard.maw@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/7] Expose expand_namespace API
Date:   Sun, 13 Aug 2017 20:36:05 +0100
Message-Id: <20170813193611.4233-2-richard.maw@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170813193611.4233-1-richard.maw@gmail.com>
References: <20170813193611.4233-1-richard.maw@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Namespaces will not only be settable with GIT_NAMESPACE,
so this previously internal helper needs to be made available to other code.
---
 cache.h       | 1 +
 environment.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 71fe092..e01b8a2 100644
--- a/cache.h
+++ b/cache.h
@@ -485,6 +485,7 @@ extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
 extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 extern int get_common_dir(struct strbuf *sb, const char *gitdir);
+extern char *expand_namespace(const char *raw_namespace);
 extern const char *get_git_namespace(void);
 extern const char *strip_namespace(const char *namespaced_ref);
 extern const char *get_super_prefix(void);
diff --git a/environment.c b/environment.c
index 3fd4b10..97dfa8c 100644
--- a/environment.c
+++ b/environment.c
@@ -123,7 +123,7 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
-static char *expand_namespace(const char *raw_namespace)
+char *expand_namespace(const char *raw_namespace)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf **components, **c;
-- 
2.9.0

