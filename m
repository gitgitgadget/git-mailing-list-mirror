Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C073C63777
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D3420809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 00:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="TiFEv5+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgLAAav (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 19:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgLAAav (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 19:30:51 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B66C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:30:10 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id s2so87698plr.9
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 16:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hS4rQuex5xNvPzyLLbT4gOUQFiKAvZIRe2Nq37lvUCk=;
        b=TiFEv5+3F2uuhS3+iqT0NnamrrMFH4mvTx5KHJCRqce82oQrFo1V3rexTON+OQcPnB
         Td+TI0taQdnR/QsUNgTbUH0tdX77SP5sZBms4vlPaLO/tURuvAkZnWqOoC8hm53MbXRP
         A8P8KgJ9/wodASIJaN7A6TRemrHBayIO2pjKgQwkyAnL/EzI1tuD/EzUzS5nnsgKP2/z
         gLDqpVyd6m3cCjKMA206DTaHxFVreV1Or7SQFNzQyKE10NRMLItwUGfNktCtpQF6yIOK
         Xzg5DMjcKtQ1hAUzqlfwZ4BiItRIN8R8jbx4fjYw1TrOpS/F0cZjjCnNRyuEkfpP/70i
         hRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hS4rQuex5xNvPzyLLbT4gOUQFiKAvZIRe2Nq37lvUCk=;
        b=CswF3dGPoBj6LOaI+ct3F2PZz0MIh7ddqw8BMZtIf6x/jmptjCokExy0fUMyBqE7MF
         +SGZD8ANdn2OL+tF1ZZe7BEOB+FyGNo2s3Epah5Hb8G/+nzaHhOUVpZtHfCIt3OzXgj/
         bzP+tnNno9v0W5j8ykF+OkQLNlKBZfTwatkCstP48TX9r+jFWm9E+wjmUIwFgGxnzz0W
         BQTilqqf4vtzTM9uByLyetSBC8EATGvBt4+BUbLxCLNfx+2d4X6yY3I0iyCN1eYLT+di
         //g40zipJocbnqZLKA+H1ML8b3P5X9kirSuO8g6+j2vfdZPe/Sj4odEHHxSltM17YTCZ
         m8lw==
X-Gm-Message-State: AOAM533nBTAxKnmKy6yL59ozj1NEXeJdTmHYOAiDXUwU7xFas64dpcZs
        hDbllWRGDLZ9LAoBkpQCioVLz675RcJTdOQV
X-Google-Smtp-Source: ABdhPJxIqKboEklitM69EnH01ajY+Loq4DnP2UeUGgSwgrhAqgQPrpfliUBiAYhp4+I13DWneLMKNw==
X-Received: by 2002:a17:902:bd41:b029:d8:f07f:4815 with SMTP id b1-20020a170902bd41b02900d8f07f4815mr230483plx.70.1606782610041;
        Mon, 30 Nov 2020 16:30:10 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m14sm202920pgu.0.2020.11.30.16.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:30:09 -0800 (PST)
Date:   Mon, 30 Nov 2020 19:30:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     emilyshaffer@google.com
Subject: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
Message-ID: <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To generate its filename, the 'git bugreport' builtin asks the system
for the current time with 'localtime()'. Since this uses a shared
buffer, it is not thread-safe.

Even though 'git bugreport' is not multi-threaded, using localtime() can
trigger some static analysis tools to complain, and a quick

    $ git grep -oh 'localtime\(_.\)\?' -- **/*.c | sort | uniq -c

shows that the only usage of the thread-unsafe 'localtime' is in a piece
of documentation.

So, convert this instance to use the thread-safe version for
consistency, and to appease some analysis tools.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
How embarrassing: I forgot my sign-off on the previous message. The
contents in this version are unchanged, but this one includes my
sign-off.

 builtin/bugreport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3ad4b9b62e..ad3cc9c02f 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -125,6 +125,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	struct strbuf report_path = STRBUF_INIT;
 	int report = -1;
 	time_t now = time(NULL);
+	struct tm tm;
 	char *option_output = NULL;
 	char *option_suffix = "%Y-%m-%d-%H%M";
 	const char *user_relative_path = NULL;
@@ -147,7 +148,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');

 	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
+	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
 	strbuf_addstr(&report_path, ".txt");

 	switch (safe_create_leading_directories(report_path.buf)) {
--
2.29.2.533.g07db1f5344
