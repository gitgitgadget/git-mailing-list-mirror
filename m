Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F74C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765D2610C7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 07:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhEXHzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhEXHyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 03:54:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A26C06138D
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j14so25739477wrq.5
        for <git@vger.kernel.org>; Mon, 24 May 2021 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMO1tHD2ecEIx94xUNQOhjZxjAW7c/wY9QAU3b4fJv8=;
        b=g28XQoWtlIoZEorYJtXrWj8fpG9RGGjzXOF/+JeXN8y8iKYr6oWdnN478cf69YKAs6
         0AjSBr+z49n7f1SrvteNQoefX2e3WXV6ZlsxN4BOcZld2vPf1vzOKbEGNXzLdfUaRUz3
         3O9VkWpAb4oEpNXi4YN9jLJzlwJE7DGLPUeIDAv0qX3MPlii4I6fRA+sCkudCeoFFIug
         8hdy3MuDLRX8EOMgW+EB9PoAR68Ug4yYtucj31ZWurmF3YVidK9DM6B6GcTl22xT9DBn
         blYiCd9P2NTtsRTdLKu5Hpwsqn3ST+Ag4bAi8vpZH3WuLjONbZEnxyaI9SUlTQZfNUqd
         F6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMO1tHD2ecEIx94xUNQOhjZxjAW7c/wY9QAU3b4fJv8=;
        b=mh2OrEv78YvhlX18rYODsa/S2HDmPcHU/iKwb5IkeOHj+5NIUSrvpWac2jfP8875iv
         PIyscfaOJ68KwrC3ZdNU89zvoixKWMFFE/jc5XMyvkrxdxb5DeI67DvolF4vhGQfmNSH
         CDERwBOvQsVupRvjKfjRVP3K+rrMODEG1pbFBtntwG8BNs6awKj2KysCuQ4lBunbUkLm
         LJiUjB9vob+0VzPq6Pn+VvX8Q5mke0JXQlJFO3nmp7xtwZKP9CDyNXcF2zlXeKjGCwaB
         tSd1nwRPqIxOlDkNLvbv+NcArSAvcpgESebm2b+SMPbhjnUfW6x5wRHKqLMVQjlsl1g1
         tfrA==
X-Gm-Message-State: AOAM533Km3b3zPg00eLR+8zU/+Io/BM6yIoH3aSPcmxjT/0dRskLeq2O
        EK4UhVHJBo7YK6c6gEyEnFapZuHb8IE+l7u9
X-Google-Smtp-Source: ABdhPJzksQOjnlLgYdaMN6/mf144/PLJsgcyRr34sz9dTw9hvrFnZ4Vjz71eh+QlTs84cvrwrBVZLA==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr20419959wrr.47.1621842792394;
        Mon, 24 May 2021 00:53:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u126sm8540459wmb.9.2021.05.24.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 00:53:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/13] send-email: use function syntax instead of barewords
Date:   Mon, 24 May 2021 09:52:57 +0200
Message-Id: <patch-08.13-860156013f8-20210524T074932Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.385.g46e826f1e55
In-Reply-To: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
References: <cover-00.13-0000000000-20210523T085231Z-avarab@gmail.com> <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
doesn't have to guess that "__" is a function. This makes the code
more readable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-send-email.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 56bd5b0e50c..83f764a8bf9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -696,7 +696,7 @@ sub is_format_patch_arg {
 		if (defined($format_patch)) {
 			return $format_patch;
 		}
-		die sprintf(__ <<EOF, $f, $f);
+		die sprintf(__(<<EOF), $f, $f);
 File '%s' exists but it could also be the range of commits
 to produce patches for.  Please disambiguate by...
 
@@ -782,7 +782,7 @@ sub get_patch_subject {
 	my $tpl_in_reply_to = $initial_in_reply_to || '';
 	my $tpl_reply_to = $reply_to || '';
 
-	print $c <<EOT1, Git::prefix_lines("GIT: ", __ <<EOT2), <<EOT3;
+	print $c <<EOT1, Git::prefix_lines("GIT: ", __(<<EOT2)), <<EOT3;
 From $tpl_sender # This line is ignored.
 EOT1
 Lines beginning in "GIT:" will be removed.
-- 
2.32.0.rc1.385.g46e826f1e55

