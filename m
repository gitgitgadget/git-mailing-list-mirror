Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B1F207D6
	for <e@80x24.org>; Wed,  3 May 2017 10:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbdECKS7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 06:18:59 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36376 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbdECKS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 06:18:56 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so3655005pfd.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtL57SZf9CrnU/07M7sb64Iby+TgArCFciHNgS6FW+I=;
        b=tH2LElv/D9myIJhfPfYynrwRLSsOySmlO6yD5hYHQdIoTodungwgDKG29iV2w5onge
         cTlhK5/OAK7lMZeBRvDCRr9dxdPjXTIkt9cA8u6f7Zkj604TbY+c5dIL9fRxuepfzHNF
         sgm9ocSxFS0eLxYbYPrp8vXUNLPckODkiAqWIU7nePJ5Xyffwtf4SvHJWhFZwba7NMTH
         Na1SMdxIT+IrmjMHL6SR35eicYh9GntTotn1icjOScaiH1D/IAaykLPH3cFK6ECSFq8u
         kWCMzuJnwpQ6gUwH1cF35QlhUozoMXRNwQACBYQlu/FyMWVUgBQ0pun43wdfbM72B/ai
         AYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtL57SZf9CrnU/07M7sb64Iby+TgArCFciHNgS6FW+I=;
        b=GmpAuHBt3DpUVK2NupuFruHDt6SfmtM8wRWjaZm/JkH7xUgKjcIwdsjUeI/LHvZl0M
         gT445iq6MZMVVNdPYiRLDXJYu74/zc0Fig/0FWfVJYaLg+DexbH/mEaIjMGKEmmy6As3
         tzDMyEUC8R3q9al2RwQPLD0WfBSj4vRKGsj8UQym/CJgA4TQ09Lq9Wi8p1bHr3526xMc
         zVOHrKr/Fv912MhlREy++Mjqh5wHL5j9621s4AFCytQPArrJ5oYAbRqZ19DXVJiPCLka
         daT+bTaZGXodEwtcp8igWhTcV+X9+HLNzNgkhQJU3jIRzkAM2I6yLLM75gTtcbyVZlcH
         wGoA==
X-Gm-Message-State: AN3rC/79sS94doJ3jellHGr56V/mj+KGK1iP3XV+Emy1ue64Vcr9kvhz
        UCttsTmh6re7rA==
X-Received: by 10.99.127.80 with SMTP id p16mr10617248pgn.180.1493806736121;
        Wed, 03 May 2017 03:18:56 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id u78sm3613468pfa.47.2017.05.03.03.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 May 2017 03:18:55 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 May 2017 17:18:51 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 10/21] log: report errno on failure to fopen() a file
Date:   Wed,  3 May 2017 17:16:55 +0700
Message-Id: <20170503101706.9223-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170503101706.9223-1-pclouds@gmail.com>
References: <20170420112609.26089-1-pclouds@gmail.com>
 <20170503101706.9223-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index b3b10cc1ed..26d6a3cf14 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -858,7 +858,8 @@ static int open_next_file(struct commit *commit, const char *subject,
 		printf("%s\n", filename.buf + outdir_offset);
 
 	if ((rev->diffopt.file = fopen(filename.buf, "w")) == NULL)
-		return error(_("Cannot open patch file %s"), filename.buf);
+		return error_errno(_("Cannot open patch file %s"),
+				   filename.buf);
 
 	strbuf_release(&filename);
 	return 0;
-- 
2.11.0.157.gd943d85

