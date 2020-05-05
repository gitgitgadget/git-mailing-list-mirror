Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51673C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3010C20757
	for <git@archiver.kernel.org>; Tue,  5 May 2020 15:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ+yLSr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgEEPZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 11:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729261AbgEEPZa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 11:25:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E480CC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 08:25:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1293748pje.5
        for <git@vger.kernel.org>; Tue, 05 May 2020 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6G+8rx+nfy3xbWQWngXjYcwCCzfhyUPsB50o8+t8h5A=;
        b=UZ+yLSr8ozEF/oDYUpegpESHU+Nhlx4ZuXDLBDiyuWkt+w2glzitf8SpNeSaUztWaK
         K8GWTmG8j2gwRqYus0xNE4hyQn6evDMmIIszifEzkHflKqKx+YORNo80nw3jImrwnrjE
         IAw13hNfzXjCDcLab/xo8lUBDdRgmTFKqGQZiZTRv9chBRxcDfq2WM1XfZ9ZRYYbmNEL
         2usNEVs3KfLWjpoOfiArkOynpj/LNccxKo2VUPd/rRoDYnAVR2yXOvZ8T2tUs5Z1G5OK
         aieSpd7pFjm3en+b68L1GMxKQ+hM7MmGz4+JsJhhpjnEozKS5aN4UuCH1okc45BuIEKJ
         CdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6G+8rx+nfy3xbWQWngXjYcwCCzfhyUPsB50o8+t8h5A=;
        b=a5nl/LameTxRyfCa+eVRcdmm5kWihSeRKgS1QUN8l5X5gZ2SgV2AIhaaPI+MyNSdSz
         5kOSySdVjFz0F2iH8fFY+yOtFnix28qgl1XAoAgbx7PDDZgYyrHYKgTJRk/0ThLz4OE0
         0xk8uLxCQdIzpqh6a/SesVlNE/1tkf+0UpLsk8TGc95srPl9KgzUw+lbkfYXQoz/vLiF
         4gC/CEAePL1ggsDzI4CeNdPz84ESebTCKIQmijofs/pRwRBuv3VKvrg0IzFNd74KuYX3
         OspwuihkM2nIfmMN3KAsoUVpypLIK/aN0Z1M8dwd7FoTo+42CVt69mhpGdCsKoYe2TN1
         VZAA==
X-Gm-Message-State: AGi0PuYG4AM7XOVaL2eZxO4wq7cz0i0tJ+ekmfq1mU/6yP/EuWO8/QzI
        kk/SmKxf7k8JEp64/dHCUbG73KgZ
X-Google-Smtp-Source: APiQypLX+8rELhgoJAQIDVt/LeTXS68xCIPyRNA8K7gM+ff0UifB6qyd2QszM9rMXKn3kpiD9W4T3w==
X-Received: by 2002:a17:902:d30a:: with SMTP id b10mr3625795plc.3.1588692329430;
        Tue, 05 May 2020 08:25:29 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y29sm2352265pfq.162.2020.05.05.08.25.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 08:25:28 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v14 8/7] fixup! New capability "report-status-v2" for git-push
Date:   Tue,  5 May 2020 11:25:21 -0400
Message-Id: <20200505152521.30530-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200505144131.30048-4-worldhello.net@gmail.com>
References: <20200505144131.30048-4-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Fixup commit for patch v14 3/7.  Will queue this fix for reroll v15 with others.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/send-pack.c | 2 +-
 send-pack.c         | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 4faee72640..4fff1c62d3 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -109,7 +109,7 @@ static void print_helper_status(struct ref *ref)
 				strbuf_addf(&buf, "option new-oid %s\n",
 						  oid_to_hex(options->new_oid));
 			if (options->forced_update)
-				strbuf_addf(&buf, "option forced-update\n");
+				strbuf_addstr(&buf, "option forced-update\n");
 		}
 		write_or_die(1, buf.buf, buf.len);
 	}
diff --git a/send-pack.c b/send-pack.c
index 9a9285755c..82b9760340 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -253,8 +253,7 @@ static int receive_status(struct packet_reader *reader, struct ref *refs)
 				hint->report.error_message = "failed";
 		} else {
 			hint->status = REF_STATUS_OK;
-			if (p)
-				hint->report.message = xstrdup(p);
+			hint->report.message = xstrdup_or_null(p);
 		}
 		new_options = 1;
 	}
-- 
2.26.1.120.g98702cf3e9

