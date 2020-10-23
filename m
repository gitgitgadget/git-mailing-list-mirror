Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694AC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EA7208C3
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqX5fgtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750234AbgJWOAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750228AbgJWOAK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:00:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B54C0613CE
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d3so1691515wma.4
        for <git@vger.kernel.org>; Fri, 23 Oct 2020 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aD3hSWme35bH5GSXz3sWxrYQFZCbTQubuUpDM8tkeS8=;
        b=WqX5fgtnSVJSZbGjXlaBuc8xlukmPunrUAtw2TcDlhNWsrukf7XCHELjkGR6+CZAQZ
         lOJ61ggPm/Lib0afY8nhfaJQLlMzusW80X8r9ct0ArqoXuEMjV1aiJKVJecTndiqjnoh
         +20xelXZLNWFP9AOQnCYZ/DSsKPJlSp3XlJRPxKbAK9Lfgc9TxCmBzJ/Bf1SrGlG8ZG9
         ca6YD51x+1Ft1tn8qXlkWgBfg+Qup7YQR31ZuHm100rb5D1I9+2ZDRZHF9hlb6WSYC2D
         svOwck4JZ0HkJF8BL5OYGdeICfLtqAM0uEX7yG75m58aJ42yT5TNXodBcjhCWjglk+xW
         vZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aD3hSWme35bH5GSXz3sWxrYQFZCbTQubuUpDM8tkeS8=;
        b=Z3vtx2FkB3SIdgwxoygST/2Y/G3dgVB1zyDIDH85h9+6/p9sMeDFuHCRo24j7g+DXS
         FqPXfoW3MX3NL9srlRmoZUiHb3Vub90QTpKmAc3a4x4liBsd9H+S5dk8qvLnvvPocHYI
         771zkLX29HypTDmGjKqlosMS8rxzA9ylnFr1uvFJIyPyXsfoYBuXSJ33/bO6P9tOdfSk
         mGsjaPVg/Vww2O+yDi9dKg/vFVVDEJZnhiDtGn3c4fbl1vfCi33P61LMfqYIhUtADKNi
         74CLkVqDUesOJaa/PpKGYR4VIpLESkIKNn9SIDF8D0MzH09x3oweWLMaIeQcEcxTH/jG
         JOYQ==
X-Gm-Message-State: AOAM533+5boDgVEQemxR+8+XFWgFMRpYbXtrMqzuRrVA5+yLk5wi0J2g
        ++uj7hUoZ01Hj0kWGSaitnOb63LaxD8=
X-Google-Smtp-Source: ABdhPJwV9cMXmJosiM2Q1TDha2j2ikeVoKnXtyDVJUIa24S/gWpDhWUGdjS0Wq6CBlwtTDQDSMkxBg==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr2396674wme.18.1603461608855;
        Fri, 23 Oct 2020 07:00:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d129sm3441895wmf.19.2020.10.23.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 07:00:08 -0700 (PDT)
Message-Id: <bd2c72a348881bd1e5c5b73545fa0afc866c4ff3.1603461606.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <pull.758.v2.git.1603461606.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Oct 2020 13:59:58 +0000
Subject: [PATCH v2 1/9] fmt-merge-msg: also suppress "into main" by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In preparation for changing the default branch name to `main`, let's
skip the suffix "into main" in merge commit messages, the same way that
"into master" has been skipped by default.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fmt-merge-msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index bd22e1ea88..9a664a4a58 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -626,8 +626,10 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 	void *current_branch_to_free;
 	struct merge_parents merge_parents;
 
-	if (!suppress_dest_pattern_seen)
+	if (!suppress_dest_pattern_seen) {
+		string_list_append(&suppress_dest_patterns, "main");
 		string_list_append(&suppress_dest_patterns, "master");
+	}
 
 	memset(&merge_parents, 0, sizeof(merge_parents));
 
-- 
gitgitgadget

