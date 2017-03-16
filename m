Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD9920953
	for <e@80x24.org>; Thu, 16 Mar 2017 22:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbdCPWix (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 18:38:53 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34701 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754487AbdCPWiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 18:38:51 -0400
Received: by mail-pf0-f169.google.com with SMTP id p189so7532130pfp.1
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pq8fNm5/QQLjzAdPPKdICvGBdKS//eq2jCLj6F/iCGQ=;
        b=qC+nVe9rdg8jvKdYri/+VfbMAgDq8e+kCpvBY4mjLyjf/n5kO+VUUtxGxAk3SC7Ozu
         sdK/lnI3sF3027+DN4nBHpn2geVVbehzzURUUHw7yUtLB4k4XiP2w8nqjD+QAJ+4jtES
         uKXdj75KzpFb0zVwM4ee+8aC7TuirJm3yL/mC33ee7q5se/COSOeBs71L9kN1jgD/FxK
         a71Wy0RXAFQVWXgrjpGtoB5TrdR/RqW494VzEjqyBPKE4ObykL9qEGjj0KkjFFPykFe2
         U7rdQV8xdifKuDS6tghUt4NMOMLOOsS880iUn/8nE7PcYBKvLqttd3BigUP2mobukr6t
         jxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pq8fNm5/QQLjzAdPPKdICvGBdKS//eq2jCLj6F/iCGQ=;
        b=qsfFtsW0Uz4edv0u578pXDlfQHYlm+i7Z649B5fa9nUVE+WydgPbqiUK9FVU6kETL5
         KIlmrD0elGuaBYM7vwGqJhbh5yVgm947KlV7LIRqjSHPMXVQzLD8v0VfVIvwOCNmmx4Z
         UNgx4rVc/d7aKAl+JE1sUKV8lTUn/CwwompO75ZH889fr7sBcIeC4eBtNFRSksNeTfuW
         +4Kdo7plYCr87GHfxlMIFkTfkBFfYvfEkwUut5vhJ8mnabVOPNubI0YDETXfY/hycQUm
         gLqti6e/A7VRrJYue9DJSK74AtuiBzvFlgmGeE4tPJkNsyYAzLMoPfb9ZVbc8v6RTNgp
         kw+Q==
X-Gm-Message-State: AFeK/H3dIYr9WAipKNUi/MblIeYSqA8Gm/sy7HBxk3DZHW/SOggl/2tTwrud2g5MF9mzsw1v
X-Received: by 10.84.218.130 with SMTP id r2mr9161316pli.79.1489703412230;
        Thu, 16 Mar 2017 15:30:12 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id t5sm12520946pgb.36.2017.03.16.15.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Mar 2017 15:30:11 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v4 09/10] submodule--helper init: set submodule.<name>.active
Date:   Thu, 16 Mar 2017 15:29:51 -0700
Message-Id: <20170316222952.53801-10-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170316222952.53801-1-bmwill@google.com>
References: <20170313214341.172676-1-bmwill@google.com>
 <20170316222952.53801-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When initializing a submodule set the submodule.<name>.active config to
true if the module hasn't already been configured to be active by some
other means (e.g. a pathspec set in submodule.active).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c |  7 +++++++
 t/t7400-submodule-basic.sh  | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e95738b42..a574596cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -361,6 +361,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 		die(_("No url found for submodule path '%s' in .gitmodules"),
 			displaypath);
 
+	/* Set active flag for the submodule being initialized */
+	if (!is_submodule_initialized(path)) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.active", sub->name);
+		git_config_set_gently(sb.buf, "true");
+	}
+
 	/*
 	 * Copy url setting when it is not set yet.
 	 * To look up the url in .git/config, we must not fall back to
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 3af1c00ff..cf77a3a35 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1256,4 +1256,15 @@ test_expect_success 'clone and subsequent updates correctly auto-initialize subm
 	test_cmp expect2 actual
 '
 
+test_expect_success 'init properly sets the config' '
+	test_when_finished "rm -rf multisuper_clone" &&
+	git clone --recurse-submodules="." \
+		  --recurse-submodules=":(exclude)sub0" \
+		  multisuper multisuper_clone &&
+
+	git -C multisuper_clone submodule init -- sub0 sub1 &&
+	git -C multisuper_clone config --get submodule.sub0.active &&
+	test_must_fail git -C multisuper_clone config --get submodule.sub1.active
+'
+
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

