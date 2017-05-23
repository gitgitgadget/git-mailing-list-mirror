Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 515E11FF30
	for <e@80x24.org>; Tue, 23 May 2017 09:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935239AbdEWJSm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 05:18:42 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34738 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760211AbdEWJSi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 05:18:38 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so22099591qka.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=L/95Vpy1SJaopNxp6UQUuP4f2DvsVl6HCzq/k6sks3dB7zIYKTn/EBCyII8bqVWWc+
         R3VYYWPcZEV9yIpCJybcusFNL7xLwJYJGGq32iwOmA3FfBMVLA4Qdx2dwjp/eH1xVLwf
         eEQM/y/mPKUGKbHkbvzV0h7gx/YPf+1UWgL30fNogvlZmcBdQKXJ8A/lyuk5fk91tpVY
         KovAHYE0gAlCzUwRARlEvBTaaaet9pFqS0YJWoJbYnujmlGKKMB5JemPeSMSdKBBe1ZG
         jDZAfARe9GpSnhMYCFHri2Dzha4/mOltHTi1KCbDV8XDoB7sNZZ8KKlyQJa/Vj2qmhx7
         Mbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=tmgZXXQ3Cepl47Uj0oMGXXMKiCjscpQGcpNdRdsmyaNFDuHQTo5NH/EsCVm6Jt08Bs
         9MQ6fXifGtveePNbwdOPd47OYCYRRaTw/AvKvjhA3+aXMlhnTHOx1T/MARi921ZPbPfZ
         MaBaHqpoy9ulbreE2C5aYX6nuEcGkktPfiPVJchpGfQCtQDWKPcyS10LHRmwzUqBoZov
         h2uTMwrtwZuoQR7rpgKQjUY+ovEngMar0tS6liBpfZtwHWl1VnCcNfJJuoboaCHiZeo+
         VxWyfCW0QkkPa23uMFoFxVp6BdxdZpP+8aEjoZ22mojxcg8lm9SZ/83vFxbkZpU5b/SR
         yFPA==
X-Gm-Message-State: AODbwcDEUNba9X85s2zXldsZvJYOgXZXQgQxAX9uaFLYrhAixvSTuO0W
        KsgB6Va5Q1FKMA==
X-Received: by 10.55.157.198 with SMTP id g189mr22337945qke.111.1495531117347;
        Tue, 23 May 2017 02:18:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id a45sm83105qta.39.2017.05.23.02.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 02:18:36 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v5 1/6] t7300: clean -d should skip dirs with ignored files
Date:   Tue, 23 May 2017 05:18:24 -0400
Message-Id: <20170523091829.1746-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
In-Reply-To: <20170518082154.28643-1-sxlijin@gmail.com>
References: <20170518082154.28643-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git sees a directory which contains only untracked and ignored
files, clean -d should not remove that directory. It was recently
discovered that this is *not* true of git clean -d, and it's possible
that this has never worked correctly; this test and its accompanying
patch series aims to fix that.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..3a2d709c2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,20 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	echo ignoreme >>.gitignore &&
+	rm -rf foo &&
+	mkdir -p foo/a/aa/aaa foo/b/bb/bbb &&
+	touch foo/bar foo/baz foo/a/aa/ignoreme foo/b/ignoreme foo/b/bb/1 foo/b/bb/2 &&
+	git clean -df &&
+	test_path_is_dir foo &&
+	test_path_is_file foo/bar &&
+	test_path_is_missing foo/baz &&
+	test_path_is_file foo/a/aa/ignoreme &&
+	test_path_is_missing foo/a/aa/aaa &&
+	test_path_is_file foo/b/ignoreme &&
+	test_path_is_missing foo/b/bb
+'
+
 test_done
-- 
2.13.0

