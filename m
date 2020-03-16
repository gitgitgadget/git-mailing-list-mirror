Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70445C0044D
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4351920409
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 03:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="VeSVoqpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgCPDr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:47:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46655 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729387AbgCPDr6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 23:47:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id t13so12989616qtn.13
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 20:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UguOCU7m/Cd9jOpvZD/QE+LtXnPFHqxGwiVU2viIxoY=;
        b=VeSVoqpZOmDjLxq0aksoYc6hNgbvEJH39dDxUOOm8/Q3yOawStI0J/JrgLGI2XrnqP
         KFExjqi46mFN3AaaxvPxRdXpiql+8FZMC6QNsCeh4tDvkgmFb1OqisnfAY/ts3/8n/Bm
         DZEIUOtDVEzg0/6K68PDRMjyujgEWALUoMQ5Csjr1kcGHj78rs13TMzX+mvw9Ni/w2Pi
         jAXcbVX9RZnS6Loyeuw5hqx0Pk0p7s+HroEX5/01iQnE5omAFA9yn10GrhGdRYF/Ohvo
         tPkg5FwhQoywFJwYPIGqRS3yGinNdInYhy9KivOaz7z2BxmFf9ZwxjHCaKRBp2M5U2J8
         1pXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UguOCU7m/Cd9jOpvZD/QE+LtXnPFHqxGwiVU2viIxoY=;
        b=HqDC0NGGliw4nbJ+pG7f5NPOKoa9Y7yMnU9liBEc02mQZ/ShvYixmrp5nqexK/zNnL
         gj39qf1Icq42jfxsWLhIwtwbR5o0EuDOuZUcDOz8Wgvygsugvrq+qDYap4AgsWYCA1TU
         yz2wUl/qrOMKiJntbG6jIzh/hCVca0PlcWKt8FWoe6Zy8gifgLQoPk+JdE8JsR83KjCI
         VTqlrAd4TthCOx6ypfRn1ainoSi0XsikoSZ13sEeLNl5mpLIbdqUmLgfeyGbSVdemY6m
         keYv23YzFdJQREyphXAirI+BvIMRtOJSAfcglS/53+oRVTVjklS3MOxcaVNe08oubq5s
         F+DA==
X-Gm-Message-State: ANhLgQ3cerp5Er9s5a/L6c4s2kadooCFLLFeN0bV7N4G/Pm1r4K4IvIm
        7LjdVF/vIV16LuGgPhDdayvgRuYXG3E=
X-Google-Smtp-Source: ADFU+vuy4gFZ2TmFfUvrIbTlq2Ey3KOtBNFi7ovu5wAYy+IjmsDa8GCmfnD6qpFOtgBg3CI1K6SCWw==
X-Received: by 2002:ac8:111a:: with SMTP id c26mr3461584qtj.249.1584330476711;
        Sun, 15 Mar 2020 20:47:56 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id r3sm3705930qkd.3.2020.03.15.20.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 20:47:56 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/2] dir: fix outdated comment on add_patterns()
Date:   Mon, 16 Mar 2020 00:47:26 -0300
Message-Id: <9de4c8cdee441be7d9bbef2a961a8ed7d423f448.1584329834.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1584329834.git.matheus.bernardino@usp.br>
References: <cover.1584329834.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4b33e60 ("dir: convert struct sha1_stat to use object_id",
2018-01-28), the struct sha1_stat was converted to oid_stat. In this
process, add_patterns() also learned to use the new struct definition.
However, the comments in this function still refer to "ss" (i.e. the old
sha1_stat). Update that.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 0ffb1b3302..ab2e5b8717 100644
--- a/dir.c
+++ b/dir.c
@@ -1015,9 +1015,10 @@ static int add_patterns_from_buffer(char *buf, size_t size,
  * an index if 'istate' is non-null), parse it and store the
  * exclude rules in "pl".
  *
- * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
+ * If oid_stat is not NULL, compute OID of the exclude file and fill
  * stat data from disk (only valid if add_patterns returns zero). If
- * ss_valid is non-zero, "ss" must contain good value as input.
+ * oid_stat->valid is non-zero, oid_stat must contain good value as
+ * input.
  */
 static int add_patterns(const char *fname, const char *base, int baselen,
 			struct pattern_list *pl, struct index_state *istate,
@@ -1065,7 +1066,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 			int pos;
 			if (oid_stat->valid &&
 			    !match_stat_data_racy(istate, &oid_stat->stat, &st))
-				; /* no content change, ss->sha1 still good */
+				; /* no content change, oid_stat->oid still good */
 			else if (istate &&
 				 (pos = index_name_pos(istate, fname, strlen(fname))) >= 0 &&
 				 !ce_stage(istate->cache[pos]) &&
-- 
2.25.0

