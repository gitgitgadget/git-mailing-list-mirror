Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8CEC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE8220707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUy6Z7yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgFOK5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgFOK5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1265C05BD1E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id q19so16918207eja.7
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fl55+w0m7vzo2xduM/elUX34+DvIdqum/I5CP31l3Gw=;
        b=IUy6Z7yjAsQd63zzqllC5OWG+rOn0cf3l/3wFVH4yWILSQMEy2hjRDaKr41462Rokh
         WNecCENo4/gWS6tCQO3StdEHYUdX3rnawETD2uoJsOfbw8Quckk5CKYFQi+rdiv0DKHM
         ZfrAYopy0JFvxO2DztP35RgAVxRQkjZmyt/fQL699EPyCv8xaZcDqARUJvUe/gj11Dn4
         YR2Rzaa3lS/xsGJYFBj/OLErnIX1bAqo6aZUe2EPy1oYuE2zf7AiuDKBv/ZWicikymcI
         MFcFqe27pLvP+pLYZpd8fGRqNnEFD/ufW8fmdstdbM9uu9GZIIMmT9CvlwQFf9lJyEnN
         ap4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fl55+w0m7vzo2xduM/elUX34+DvIdqum/I5CP31l3Gw=;
        b=EDf7Nx1zgQawKU2tjU5qDOYudXpOD/TrkmNHid0U372DRcVqqHIRReCm/wVBMkCQOE
         rOBwQqQ8OfwB1Y4R9H/Mm9xTpHoEwsA4WODaQHvOzTdxZlGh5Zk5LmXH1u4JLDyDZOWM
         pT09MgS8wIqk3wxnO/vX7k4hlOPV/sPBR0cWWYaGqwNNBuoEZswiTLkjHZo6DGuJgTeM
         OuGfiPydyfvFix23kL+A+/WipLEFfxpTqElsy33SEshYqF2mOw3ZPPUJshq3NxCRB+Aw
         7GwDnOchT3H1qdP2oKFF+cfKH4qPnMGgexnaJ4aJrgqJ59VDMcFeHUvrt6KgHarT0e4/
         AIWg==
X-Gm-Message-State: AOAM5334G1OJ2sfxu9BFclYk0DvLU1K7Vn7+quVKKyMgCKLrSFGgwfgK
        iqN6YFsTjYOcNlvIJYmFEnGOBGa2
X-Google-Smtp-Source: ABdhPJwA67HY/gzZhphQHrD+kcU9zvXQ7BRi7+n3ng1sGta3/lWPJLZMCSdustN3Z13J0Bnj5q25ww==
X-Received: by 2002:a17:906:328a:: with SMTP id 10mr5912778ejw.265.1592218664519;
        Mon, 15 Jun 2020 03:57:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bt11sm1374807edb.48.2020.06.15.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:44 -0700 (PDT)
Message-Id: <a5ce1235a03a49ad394da8d227f5abf52ef3179a.1592218662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.658.git.1592218662.gitgitgadget@gmail.com>
References: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:38 +0000
Subject: [PATCH 1/5] builtin/log: new config log.useRefFilter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Add a new boolean config variable "log.useRefFilter"
for `log` command, allowing log to switch to use ref-filters
logic.

*experimental*

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/config/log.txt | 4 ++++
 builtin/log.c                | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 208d5fdcaa6..603f635df86 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -48,3 +48,7 @@ log.mailmap::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
 	assume `--no-use-mailmap`. True by default.
+
+log.useRefFilter::
+	[EXPERIMENTAL] If true, forces `git log` to use ref-filter's logic.
+	Is `false` by default.
diff --git a/builtin/log.c b/builtin/log.c
index d104d5c6889..4eb13d1ef88 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -39,6 +39,9 @@
 #define MAIL_DEFAULT_WRAP 72
 #define COVER_FROM_AUTO_MAX_SUBJECT_LEN 100
 
+/* Set true to use ref-filter's logic in git log */
+static int log_use_ref_filter;
+
 /* Set a default date-time format for git log ("log.date" config variable) */
 static const char *default_date_mode = NULL;
 
@@ -489,6 +492,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_signature = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.usereffilter")) {
+		log_use_ref_filter = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
-- 
gitgitgadget

