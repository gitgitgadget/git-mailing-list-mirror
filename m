Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A86C43332
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EA02070A
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cE/nXRha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgCUJWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:22:38 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34588 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgCUJWh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 05:22:37 -0400
Received: by mail-qv1-f65.google.com with SMTP id o18so4459105qvf.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 02:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NumuQO/ly6xOJmPf1n0dPzmvz7xqlc5+KcTK5eRjVA=;
        b=cE/nXRhazS/qL2ktsSfvAW0iTsyO6OJPDZB4F9cjJgcQ/FzuOgwT8m54wFS91lfPDL
         l7wfhZdGT/7kWePICUCHMIs9nRLuuAlH6uQAFwpKfpyITjKvTYHro6g25zwu0WSpRLqh
         3+Ffv1+lWRuNxGd6zfm3ieFcsmBmPLcqsgAn2IqqDBYb7Txa+KuM16bf6tlow7u3uI8m
         CSN9gYMwa2OmPktqHqYCqPX1fdQe4m/7DC6lsdS+EPD5srEZf8GrmWirMmW60ZkCJrCc
         JhSU9DaGk5Tzd6PPiryo5C32ujWdENBqg7TgC5eX5PmcJw6XpyRhqFn+rBjA6ir7hUzS
         m/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NumuQO/ly6xOJmPf1n0dPzmvz7xqlc5+KcTK5eRjVA=;
        b=IVHJYsbmeakmWKWq0rlrTiqgDhhwp9C6TNBivy8UrPnODPMCQnnkUVSCjvftoCCfGm
         jgwL5bEite8zsQ5lRJ3mJclJO1R2/wphwwe2pvokHQsSVfDsMasT3HxeZVvZOIQEhTQs
         wolwCclEFt4pVcs2CPU3V1qaOGlR94vo1IwFmaS1lA8+JM0iwAzQvWTo/W59nJuYKACD
         mMIKd59SIcf45nztBIFfOjfo9i7D5LkpPNEojoWBKNoeXg9ZZkcWLOvMY11wr413NMoJ
         Kz19Zj4JagaGSROSV7BXzaGyNYfUPNfJMismqy43+30YTF+q1Kr1kcN3D4sHMyrP/ok6
         ZQDg==
X-Gm-Message-State: ANhLgQ3rIAb9YSrK5HhfFYCAWg/9L+xIRIi8JpgYGnS1er3uXN3bSZub
        65y4TwNO8OYKU3XWF8RuTgU6s5y1
X-Google-Smtp-Source: ADFU+vs1WS16pdkBdop/zHmipZ6Ctoo/u7Ohlgvr9ZqfQFFaENrrknYgvp/j4MPO0r36wCznLHMUgg==
X-Received: by 2002:a05:6214:7e8:: with SMTP id bp8mr12052762qvb.243.1584782556287;
        Sat, 21 Mar 2020 02:22:36 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id z23sm6579890qkg.21.2020.03.21.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:22:35 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 15/19] sequencer: unlink autostash in apply_autostash()
Date:   Sat, 21 Mar 2020 05:21:34 -0400
Message-Id: <d5af261eb813cc5bb4dd8ad69d63cd322303179c.1584782450.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1584782450.git.liu.denton@gmail.com>
References: <cover.1577185374.git.liu.denton@gmail.com> <cover.1584782450.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explicitly remove autostash file in apply_autostash() once it has been
applied successfully.

This is currently a no-op because the only users of this function will unlink
the state (including the autostash file) after this function runs.
However, in the future, we will introduce a user of the function that
does not explicitly remove the state so we do it here.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index b2951843a1..81b6c700d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3746,6 +3746,7 @@ int apply_autostash(const char *path)
 				  " \"git stash drop\" at any time.\n"));
 	}
 
+	unlink(path);
 	strbuf_release(&stash_sha1);
 	return ret;
 }
-- 
2.25.0.114.g5b0ca878e0

