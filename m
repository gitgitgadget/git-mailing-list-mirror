Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9FC2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668EE24656
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcGStxoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLMIIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42075 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMIIO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so5566481wro.9
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YLnhQQvkpK6MEhWrppIdMIuQxCGIvIQUSBjOiJFLlNc=;
        b=fcGStxoOU2rHo9TNIVfJm6vTv7kIxCHqD7u4w4pMoQGqyStMfUKknD1Tss8J5EzSvF
         C3y58IgIKTj4JZIcsW+PC+F9J6rWPKTntjqGFdn4sDz6Trem6BdmWp3E/LSoEYl1WlGD
         ldIPYMiwda4nAXcXpuROXAghrqlLLWwjDDYCm3MVQTbIz5vbMPtYEIj6mIpHkrcrqI3c
         T2SdOte6fVZfBBuFOJ23SrG4SJYRyTya31fVkGSO2IJ2ZgDQcDXY4hMNxAUn+nbnCgvz
         S572sIngxzBnwuLQ4MdE672XX1BLzF24BHxEZ+hg3uwPymMCWn9Ar0qkOqgoXZ656T3b
         B34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YLnhQQvkpK6MEhWrppIdMIuQxCGIvIQUSBjOiJFLlNc=;
        b=YgumMPYBenhmvdodZZFZYggNiuORfpa9BNAYvGBtfaojiAgwdz7u5cmWX9h7cq707e
         X8SRH62azlp4jUK09a+9JD8u6t3UZCL0NK+Dykf3R2r0rlQtbNIHbNp/DzcM+1PIEVEV
         y2cae9xT8JTBjsqDDzd214bR591neqemLlqPzLh0zirhvn8xUyFKn8aEBGt8C+7McxJY
         LYxzjLoPUaXlMWa1iI8xuXXu59GK0wMV6XMn4w5/joJH6/fd5vcMPLzwjnYd17hbCEA8
         DYCU0p6bCgasfGjxFoBlPC1YKXg0jtgRM/fMgzoiXqN9yKo3OM4Q9bNMcEHESz1g6E5/
         ZmQw==
X-Gm-Message-State: APjAAAUT4R6oxecdU7Wk7OsJxt35h/3hpmHBsLR7HwATb2RmeQoH+F+7
        VkU+7lbUzyFpzonP9pzv/VRYb76a
X-Google-Smtp-Source: APXvYqwI7q4HARtDOCcwk1U7cmvz+r+dAmuXcPYy18lWsK0Nx4WFy1p4o3/NNrlZGp69z7E1xhoP+Q==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr10945077wru.398.1576224492122;
        Fri, 13 Dec 2019 00:08:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm9128949wrr.75.2019.12.13.00.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:11 -0800 (PST)
Message-Id: <7d3a59dd117a670734e8420093e7ccbe28d1650c.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:52 +0000
Subject: [PATCH 05/19] built-in add -p: color the prompt and the help text
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

... just like the Perl version ;-)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index e266a96ca7..dab2ff2381 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -334,9 +334,12 @@ static int patch_update_file(struct add_p_state *s)
 			strbuf_addstr(&s->buf, ",j");
 		if (hunk_index + 1 < s->hunk_nr)
 			strbuf_addstr(&s->buf, ",J");
-		printf("(%"PRIuMAX"/%"PRIuMAX") ",
-		       (uintmax_t)hunk_index + 1, (uintmax_t)s->hunk_nr);
-		printf(_("Stage this hunk [y,n,a,d%s,?]? "), s->buf.buf);
+		color_fprintf(stdout, s->s.prompt_color,
+			      "(%"PRIuMAX"/%"PRIuMAX") ",
+			      (uintmax_t)hunk_index + 1, (uintmax_t)s->hunk_nr);
+		color_fprintf(stdout, s->s.prompt_color,
+			      _("Stage this hunk [y,n,a,d%s,?]? "),
+			      s->buf.buf);
 		fflush(stdout);
 		if (strbuf_getline(&s->answer, stdin) == EOF)
 			break;
@@ -376,7 +379,8 @@ static int patch_update_file(struct add_p_state *s)
 		else if (undecided_next >= 0 && s->answer.buf[0] == 'j')
 			hunk_index = undecided_next;
 		else
-			puts(_(help_patch_text));
+			color_fprintf(stdout, s->s.help_color,
+				      _(help_patch_text));
 	}
 
 	/* Any hunk to be used? */
-- 
gitgitgadget

