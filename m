Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4DA2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbdHGSVd (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33120 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdHGSVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id y43so862690wrd.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhdgBFMAitNCZ9/mMqwZPCVEPuuWyAqSjj6nLT4TA3Y=;
        b=kNal6ILD9OEVAq+PProiVOr9g0zOwIRZakALKGwyrkdttCUizRQBimrWKxOWzPVaR2
         n8qV5qxfN82S+iNHFuDG06+nMRFu4JWwFMhoD0r+1BKY+l9Fa/wuSltkQC3h6U5j9nrT
         mah9m3K7IcLFkoaSd4Vk5djo3NegEqW0JLnYOdmQ9G40Q8iGtrO67xXRPDAuZigiJGcb
         L2FIrcajd97gGTs3e6kG3ww4wvBlL2GDBopDc/CWqULhs+T0Oq3AMTcK+zno2GDmT8Dc
         tp7wYkjHjJh6RvVS3wYiU+WIEGalMYCfq41CyGzQbi8pTNRkT2uz+ZJuHPTFeo/J4+lq
         BzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZhdgBFMAitNCZ9/mMqwZPCVEPuuWyAqSjj6nLT4TA3Y=;
        b=JxodXEpKtSrRF9+wQf7QWxpP/RrFKo1SdsDElwGR/DaZnEPgN5TfZpb134yLFsnYPH
         eQmu3EI+I1NEqPHfLYWNPpb++49Lhlwm+csddFVM9SM0H+2YXK/gn3EFK+9gCICwUhqJ
         BTyyh6OeSKRHAxI99IRsLDeOjCY9nUF2NUZ+3T4SQMFRXChU/H9bJkoZ51LAO1dfJlIj
         kPtYehhzm2tgBFTpF1D3Vx1PiGEkb4TSRWAQhL14nPvDePGIdsEZEb1LzEa8xK/XlC0s
         WA8Cld+G4U0Pr6ogfS4eZR8jqK7WCkGh+YpYi5IeFxlTpg3fphylU3dr3Uoihjer6WU9
         Q+JA==
X-Gm-Message-State: AHYfb5hEBO0h6hVaFfMuAa5QLR8VPk2D0tvncVbQy7/erBIJVz88QOvS
        XBr3AsmIK+R9wQ1S
X-Received: by 10.223.184.50 with SMTP id h47mr990106wrf.163.1502130084123;
        Mon, 07 Aug 2017 11:21:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:23 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] config: make git_{config,parse}_maybe_bool equivalent
Date:   Mon,  7 Aug 2017 20:20:48 +0200
Message-Id: <74e20299473958b2279ee62d311cbf906b709952.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both of these act on a string `value` which they parse as a boolean. The
"parse"-variant was introduced as a replacement for the "config"-variant
which for historical reasons takes an unused argument `name`. That it
was intended as a replacement is not obvious from commit 9a549d43
("config.c: rename git_config_maybe_bool_text and export it as
git_parse_maybe_bool", 2015-08-19), but that is what the background on
the mailing list suggests [1].

However, these two functions do not parse `value` in exactly the same
way. In particular, git_config_maybe_bool accepts integers (0 for false,
non-0 for true). This means there are two slightly different definitions
of "maybe_bool" in the code-base, and that every time a call to
git_config_maybe_bool is changed to use git_parse_maybe_bool, it risks
breaking someone's workflow.

Move the implementation of "config" into "parse" and make the latter a
trivial wrapper.

This also fixes the only user of git_parse_maybe_bool, `git push
--signed=..`.

[1] https://public-inbox.org/git/xmqq7fotd71o.fsf@gitster.dls.corp.google.com/

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t5534-push-signed.sh |  2 +-
 config.c               | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 5dce55e1d..1cea758f7 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -71,7 +71,7 @@ test_expect_success 'push --signed fails with a receiver without push certificat
 	test_i18ngrep "the receiving end does not support" err
 '
 
-test_expect_failure 'push --signed=1 is accepted' '
+test_expect_success 'push --signed=1 is accepted' '
 	prepare_dst &&
 	mkdir -p dst/.git/hooks &&
 	test_must_fail git push --signed=1 dst noop ff +noff 2>err &&
diff --git a/config.c b/config.c
index 7df57cec0..d87376a5d 100644
--- a/config.c
+++ b/config.c
@@ -946,11 +946,6 @@ static int git_parse_maybe_bool_text(const char *value)
 }
 
 int git_parse_maybe_bool(const char *value)
-{
-	return git_parse_maybe_bool_text(value);
-}
-
-int git_config_maybe_bool(const char *name, const char *value)
 {
 	int v = git_parse_maybe_bool_text(value);
 	if (0 <= v)
@@ -960,6 +955,11 @@ int git_config_maybe_bool(const char *name, const char *value)
 	return -1;
 }
 
+int git_config_maybe_bool(const char *name, const char *value)
+{
+	return git_parse_maybe_bool(value);
+}
+
 int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int v = git_parse_maybe_bool_text(value);
-- 
2.14.0.5.g0f7b1ed27

