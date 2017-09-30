Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B9720281
	for <e@80x24.org>; Sat, 30 Sep 2017 06:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbdI3GWx (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 02:22:53 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:51139 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbdI3GWw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 02:22:52 -0400
Received: by mail-pg0-f48.google.com with SMTP id p5so819349pgn.7
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 23:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iIbRYp9MDIHe1NroyzqEr6r0epEyyUaSwBtCBHjmPPo=;
        b=AKuk2viws/zSjQZfGzsQE26l1N6mVnYFZR6sjlNQn8ex0VeQbkjBo/XA5QZksghXTa
         tljDxk8O33XmqovRopEQfKYufsw6hqnz4/dL+32L++46lKPPpk3+CS4iaT/rCaG3volQ
         mgO7RWtryQkeSLBQTRUOuqSqYi6fvzZ9W7qslFSrFlTQZgGvWS/GT6Dwb5AhHjAsODmd
         6uZm9L80cMksWNSaIeDcHpviKR8Xx94/4wewwMuQ6v6TioizvjQ1w3LMn2QlsbMbvAn+
         hGX2t7t9fdiZQYeST/Jpl64297Ul5CiEUXY/8p5PGc58SKV9DijeieQhM0Gqjrb8sPQp
         JCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iIbRYp9MDIHe1NroyzqEr6r0epEyyUaSwBtCBHjmPPo=;
        b=H7e4RclyhYqd38UhH2Bfmo4uo8xGa7Kx8S74vw0nvSlmeY3NPeytMYNpUXBscCqFE4
         EDR0ZH4V78lP5pzHfklawevu7m6ege/IrTQhY1ZU+BFEBk/RaWeO5LWTe/fNHR8HKCiv
         XI3yRP78XAeD8XvdLK/Y61BkF8oM/+wvAtj0c5QLKV01nAZ951Md2LkCVkMI5zYUJknN
         0NwhSATZdJnKfYkSq276fU/hBAN8Dl6L2e9p+naZQYe05I8MmxDMchVeHW1GsZNgGKgb
         uph+1HcleZUsNi01q6jC6LXxyweLra+c/bd5cX3ax5cqn9Ice9uZ6eN6smvO4ZDXMFHT
         +How==
X-Gm-Message-State: AHPjjUiXWyF1StloNFgdrfV81oBSoNyFBE/drESQ0zORPurBZRcD39ep
        iM6zEJDdhsV6bWY6WEnsZSeyVfasDN0=
X-Google-Smtp-Source: AOwi7QBnyPz3s1n/eMF9CN0qic4/P7ec+5NzJ2v/41Oxr0MttY2NmiEzRWmp6Y+FentfdLqJk4qNEw==
X-Received: by 10.99.121.141 with SMTP id u135mr7496347pgc.86.1506752570987;
        Fri, 29 Sep 2017 23:22:50 -0700 (PDT)
Received: from localhost ([205.175.97.239])
        by smtp.gmail.com with ESMTPSA id v14sm8649772pgq.72.2017.09.29.23.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 23:22:49 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/5] t6300: refactor %(trailers) tests
Date:   Fri, 29 Sep 2017 23:22:35 -0700
Message-Id: <20170930062238.87077-3-me@ttaylorr.com>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee
In-Reply-To: <20170930062238.87077-1-me@ttaylorr.com>
References: <20170930062238.87077-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently have one test for %(trailers) in `git-for-each-ref(1)`, through
"%(contents:trailers)". In preparation for more, let's add a few things:

  - Move the commit creation step to its own test so that it can be re-used.

  - Add a non-trailer to the commit's trailers to test that non-trailers aren't
    shown using "%(trailers:only)".

  - Add a multi-line trailer to ensure that trailers are unfolded correctly
    using "%(trailers:unfold)".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6300-for-each-ref.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 834a9ed16..2a9fcf713 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -592,18 +592,25 @@ test_expect_success 'do not dereference NULL upon %(HEAD) on unborn branch' '
 cat >trailers <<EOF
 Reviewed-by: A U Thor <author@example.com>
 Signed-off-by: A U Thor <author@example.com>
+[ v2 updated patch description ]
+Acked-by: A U Thor
+  <author@example.com>
 EOF
 
-test_expect_success 'basic atom: head contents:trailers' '
+
+test_expect_success 'set up trailers for next test' '
 	echo "Some contents" > two &&
 	git add two &&
-	git commit -F - <<-EOF &&
+	git commit -F - <<-EOF
 	trailers: this commit message has trailers
 
 	Some message contents
 
 	$(cat trailers)
 	EOF
+'
+
+test_expect_success 'basic atom: head contents:trailers' '
 	git for-each-ref --format="%(contents:trailers)" refs/heads/master >actual &&
 	sanitize_pgp <actual >actual.clean &&
 	# git for-each-ref ends with a blank line
-- 
2.14.1.145.gb3622a4ee

