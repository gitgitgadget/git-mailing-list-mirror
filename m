Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EC5C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4041021D7D
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 13:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="Ua8rN2Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgIINTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgIINQr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 09:16:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C081C061786
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 06:16:19 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g72so2316481qke.8
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXCfTHyd3GlAbreZtkECTUsrfPVu2qY7EZ5tW/uJ8sA=;
        b=Ua8rN2Qwl0aHBnwDBiJ3jXpY70qnbi9YXXDkKWQUK6YbOh5YcS2GjEeE/vxWecbg0M
         1wV+DnJcXDcq0Wzi6mIPk254ELrdNft9DjHiHCkKJNoD4qT008Rng4QQTU/rOAZDP2MS
         4L/g0Pf/bZmAo7OQ82Gobk/Q6/SeQaPaLTqbW7n0MXxQBFhpKVMAXNZuocrZkQm+v5Oy
         o+vu16+K4jgLdcNjEARX5tr1C0doi8tC08hxcyTqvt5vT8XjHpltlTzyHjpDzeIjxtXF
         eb0VO9OVeNo/t5a2Bd31HcOQ2np626m/HzVPHVlhzMh6He7rom9FeWtntoc7/iDvS8De
         p04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xXCfTHyd3GlAbreZtkECTUsrfPVu2qY7EZ5tW/uJ8sA=;
        b=gIcrAOGnNlhGorNUquxPDDFUk+QmzssPmX4TsFm6QqcfHGGS0mxUWzOaYhowTw/Adg
         BcuztR0QwudeM8WypDjQpMRpdTBpu4gH6FnivbXbBYUuz2a4ShgfgONbaRufy6Rz92LV
         QQ3EAqatPqr9umvjqEy2ErcrO2Mi/cUrTFp8cEHGo3AMw3PbcA1+6tWlKbfVaqJujDdd
         BVDykF6aKHJvVIUayuJ9IC0vyt5ARU1UhtBdAv93tA2JJ+dtr0Xr2qfpjZyzfPvymm4+
         A6shrPYZVV++l0bdhu3a9bYxIy5yByz1ih/KujGWOOEXLK09rxb05NnJW/PnQOGHWptG
         Xibw==
X-Gm-Message-State: AOAM5330M9h4iBoXCAlz9hPGxTz7ICYLMzOfHOqvTvrn6CSsuz8eDEcj
        PqIE714AgDnsDNtXpBC7zr7b2AZEZO1t8Q==
X-Google-Smtp-Source: ABdhPJwPug/y+BpXbwjcKbiyR3h5A2zNxpiKiuMGBIb8evQ4QGMTgibyNrQBp4e+5jD4K8p5CS+4hw==
X-Received: by 2002:a37:644c:: with SMTP id y73mr3297865qkb.246.1599657377740;
        Wed, 09 Sep 2020 06:16:17 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:81:83eb::1001])
        by smtp.gmail.com with ESMTPSA id r21sm2942146qtj.80.2020.09.09.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:16:16 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH] config: complain about --worktree outside of a git repo
Date:   Wed,  9 Sep 2020 10:16:08 -0300
Message-Id: <3dfd33eda3f9cbd0d87ba7bb31f4501aa7b8b8a8.1599657308.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Running `git config --worktree` outside of a git repository hits a BUG()
when trying to enumerate the worktrees. Let's catch this error earlier
and die() with a friendlier message.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/config.c  | 12 ++++++++----
 t/t1300-config.sh | 13 ++++++++-----
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5e39f61885..53e411d68a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -628,11 +628,15 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
-	if (use_local_config && nongit)
-		die(_("--local can only be used inside a git repository"));
+	if (nongit) {
+		if (use_local_config)
+			die(_("--local can only be used inside a git repository"));
+		if (given_config_source.blob)
+			die(_("--blob can only be used inside a git repository"));
+		if (use_worktree_config)
+			die(_("--worktree can only be used inside a git repository"));
 
-	if (given_config_source.blob && nongit)
-		die(_("--blob can only be used inside a git repository"));
+	}
 
 	if (given_config_source.file &&
 			!strcmp(given_config_source.file, "-")) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 97ebfe1f9d..825d9a184f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1836,11 +1836,14 @@ test_expect_success '--show-scope with --show-origin' '
 	test_cmp expect output
 '
 
-test_expect_success '--local requires a repo' '
-	# we expect 128 to ensure that we do not simply
-	# fail to find anything and return code "1"
-	test_expect_code 128 nongit git config --local foo.bar
-'
+for opt in --local --worktree
+do
+	test_expect_success "$opt requires a repo" '
+		# we expect 128 to ensure that we do not simply
+		# fail to find anything and return code "1"
+		test_expect_code 128 nongit git config $opt foo.bar
+	'
+done
 
 cat >.git/config <<-\EOF &&
 [core]
-- 
2.28.0

