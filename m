Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4CC433EF
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346269AbiEaQ7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346252AbiEaQ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5353E68986
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k16so15185644wrg.7
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+RZqbq+i7II6esB5ZqK/d9mkhvnCJXis5bAL2W8hZg=;
        b=Mwab7PnNVWv3KncEwmar79w4SzBekx4h+JyXPd/n6WJUFPqhAekWSHKq4KdyhZfAwJ
         1eDbAzbMbHr0cOV7hM4+m3Om2qCxnFZas9KAJTFmTFSRxllVZZGNOJvTiNRCTy/k5LL3
         cQYcHxPdOL+Y9UkuiqgtvKRbk2HFVcOkml0JPBJsvd+wvkcO/L0ECSNm5J8XwcAR47xX
         rztT+1JhXu06NZUnmBB1aqQJT0a6O+9RU5GD1Xp39sbd1r3f4tC+DC8eHb9Lu60sEE0R
         ckqz/AmFXZyb7icV97U5NrlaL0kS8wK+AZY4kA/2jzrviJ0DiscZ/7IKtvi+F8TMaJUV
         fb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+RZqbq+i7II6esB5ZqK/d9mkhvnCJXis5bAL2W8hZg=;
        b=Jzb+x5XsAkLUqLCZYrBgt6FohiV9awNBhtsKFvQTCfF17jc+MeS6ZR6lC7vPmM9AkY
         jv2qTnikQdVZdUeBn0RtOkKmzDS3tcROBlS9/pLuyhNJTbDbmQ1SOuHPJZJMmKmGNuUG
         zailsA2aMYNhka77OP6EuIdHKUumqcv7lw4WvqsB7yO9gPu4+A5Oia3jmXfrjX/UkHbm
         dmbziBK6f1J3W3MdPW6TUZTIAcBL5klOLCVf91v/77IBUzqhOIykdDw22MALHHIHcWhz
         Ypf+P7EWS1Fo1qdOATNb/dBQ+AP+fR3tAEJzizJcjT8zxY1H+zUGyVGGHp+i1JF7Jn4x
         O9yQ==
X-Gm-Message-State: AOAM532+BmgCmr347OXJxJBqkWLoPqKerzaz1qpdnNU/Z+CZpDNy2h8D
        MYPTxI3sBaM+CtffN0O9cZ2vOdrl3p55Xg==
X-Google-Smtp-Source: ABdhPJzTXHMiXk+9pXp77Xz7Hak5oQtgXNgU6CdhHRGJgiIAdHgzAhEqLRrriOZtydSm4+rQivCZ1Q==
X-Received: by 2002:a05:6000:2c7:b0:210:d2e:6af3 with SMTP id o7-20020a05600002c700b002100d2e6af3mr21684320wry.242.1654016347590;
        Tue, 31 May 2022 09:59:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] parse-options.c: use optbug() instead of BUG() "opts" check
Date:   Tue, 31 May 2022 18:58:46 +0200
Message-Id: <patch-v2-4.6-47d384d0ae5-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the assertions added in bf3ff338a25 (parse-options: stop
abusing 'callback' for lowlevel callbacks, 2019-01-27) to use optbug()
instead of BUG(). At this point we're looping over individual options,
so if we encounter any issues we'd like to report the offending option.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 78b46ae9698..243016ae30f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -473,21 +473,30 @@ static void parse_options_check(const struct option *opts)
 				optbug(opts, "should not accept an argument");
 			break;
 		case OPTION_CALLBACK:
-			if (!opts->callback && !opts->ll_callback)
-				BUG("OPTION_CALLBACK needs one callback");
-			if (opts->callback && opts->ll_callback)
-				BUG("OPTION_CALLBACK can't have two callbacks");
+			if (!opts->callback && !opts->ll_callback) {
+				optbug(opts, "OPTION_CALLBACK needs one callback");
+				break;
+			}
+			if (opts->callback && opts->ll_callback) {
+				optbug(opts, "OPTION_CALLBACK can't have two callbacks");
+				break;
+			}
 			break;
 		case OPTION_LOWLEVEL_CALLBACK:
-			if (!opts->ll_callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs a callback");
-			if (opts->callback)
-				BUG("OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+			if (!opts->ll_callback) {
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs a callback");
+				break;
+			}
+			if (opts->callback) {
+				optbug(opts, "OPTION_LOWLEVEL_CALLBACK needs no high level callback");
+				break;
+			}
 			break;
 		case OPTION_ALIAS:
-			BUG("OPT_ALIAS() should not remain at this point. "
-			    "Are you using parse_options_step() directly?\n"
-			    "That case is not supported yet.");
+			optbug(opts, "OPT_ALIAS() should not remain at this point. "
+			       "Are you using parse_options_step() directly?\n"
+			       "That case is not supported yet.");
+			break;
 		default:
 			; /* ok. (usually accepts an argument) */
 		}
-- 
2.36.1.1100.g16130010d07

