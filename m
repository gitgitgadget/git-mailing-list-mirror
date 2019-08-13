Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872F51F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfHMM1O (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:27:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56294 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfHMM1L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 08:27:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so1320431wmf.5
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 05:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qEEc/uPwXOZ/C7M3KgAp6PY7nx3k9Bx5aSlvMLcRh8o=;
        b=Junvw+256qA7JtaiPNLz8qmIYV9BdIa93YdrCqJL+9oCuSHKNbRdPON/oKff9698qk
         rEj3KBkTnfJG1M5XhLv/HrUJ6N447LH2mp6IMD8m+q146nXGVybr6P8WqmMHnCXFqSMU
         NxSijySb1+LWoQnaHplQXWN7fE9aClXIThJNk5qtgViQ58xUyZRuzSIQROMl6nLqkgBn
         7NgoYLHpK6OZVgoVBfa/kJXo4QMMo6T+gc2kpLI9U/JB6hp49jz2TXCpUNDemnvfWOi3
         Hdc40SJoq6nmmO52z9RR0Ve49V3Bf3Fm51dk+au4FpBnkdsWGPm7WhY2iePnZomC0Ne2
         gKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qEEc/uPwXOZ/C7M3KgAp6PY7nx3k9Bx5aSlvMLcRh8o=;
        b=WDfCN09kLpDetOp1av8jwnirF/kqIGNEAUPHlHz8OwKzz9FVXgMRl/3UvJiMv+ZCFD
         MpDVmSSbBScV064wFDf+ZeQpv3hJMHMUqB7sCeQ/R8sLXg9NPddcd8ocp+FvGCA3i8js
         pWeakFUyus3VWG3LyD3WSNm9m7RBFCGARwyuv6LLOWxXep8WjlVeIYvtS1e4f0cS+5eT
         6fR3HJLuqOFemRo+mvr7YRlrxSZSu5+62eDZtExE5yEemQoyvl7SPe79SICdMqhhdmi+
         laPO2tEb0YqZDP0f+rKmdenlf7IM/CdXBzg9I8NTADjrLgmb/PSzyqaEbnkdOdCfPWEQ
         wHEA==
X-Gm-Message-State: APjAAAVQj2yYDB6IYd6xMoTNs47LGNbtamnptdf9mdL+HBY6/pCKw0Gc
        XUhr8iNIAazurGP5kafKDBXTGBuV
X-Google-Smtp-Source: APXvYqwUJSBnFlVhKHyNbDXpBD5gv+wuUsmOGuep7P4BOLw8NafVcUAD2GL1vneyy8LujoiQFiHb4w==
X-Received: by 2002:a1c:1bd7:: with SMTP id b206mr2797481wmb.85.1565699229534;
        Tue, 13 Aug 2019 05:27:09 -0700 (PDT)
Received: from localhost.localdomain (x4db44abf.dyn.telefonica.de. [77.180.74.191])
        by smtp.gmail.com with ESMTPSA id r5sm1978069wmh.35.2019.08.13.05.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:27:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 05/11] completion: use 'sort -u' to deduplicate config variable names
Date:   Tue, 13 Aug 2019 14:26:46 +0200
Message-Id: <20190813122652.16468-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.350.gf4fdc32db7
In-Reply-To: <20190813122652.16468-1-szeder.dev@gmail.com>
References: <20190813122652.16468-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The completion script runs the classic '| sort | uniq' pipeline to
deduplicate the output of 'git help --config-for-completion'.  'sort
-u' does the same, but uses one less external process and pipeline
stage.  Not a bit win, as it's only run once as the list of supported
configuration variables is initialized, but at least it sets a better
example for others to follow.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f89324d84f..b51cb31ea1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2225,7 +2225,7 @@ __git_config_vars=
 __git_compute_config_vars ()
 {
 	test -n "$__git_config_vars" ||
-	__git_config_vars="$(git help --config-for-completion | sort | uniq)"
+	__git_config_vars="$(git help --config-for-completion | sort -u)"
 }
 
 _git_config ()
-- 
2.23.0.rc2.350.gf4fdc32db7

