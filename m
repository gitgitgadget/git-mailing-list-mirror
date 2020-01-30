Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1130DC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D602F20708
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="t+ZggL5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgA3Udj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:39 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:38627 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3Udi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:38 -0500
Received: by mail-qv1-f66.google.com with SMTP id g6so2175806qvy.5
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mXc0JGAnpaTT7WkDztXaipWGC+d+Uw0pUQB9NwsZaM=;
        b=t+ZggL5BiqEJROnMzl7XGA12J0JHzibLA7+G2hPhD5jBWOnYIdr7WOTTGxVxa3glQj
         9pWjEtXI8W87scp6cGnAmPBv9OCt3O/hBHv6VlzCkZkU/FQSqKYZED1NmOXgg2+T0X2h
         Hcf0xfxu643v5uHqwk/vE0sZZV4SxLfCVV1kowMFEDNLQdtmJ2rPC2oSLcj22AI/CNQs
         a4g8oVkczMatGXv01Py9Pc5buduRRYlIheIu2qfzERHCnyiWNt9NpiODiwM6UokVXzrN
         S/zf4AaC1uireQwM8jSiFB3Bl7e+Wq/pMzc57VX0M62QsItEq0u+t8bolltkuouwrlZj
         G+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mXc0JGAnpaTT7WkDztXaipWGC+d+Uw0pUQB9NwsZaM=;
        b=f0XhBgh1f+gzHPA6Ouo9xYOg3WTaZZzIue0AYfENgyZYhvJbbLHXLHklr7FAuiH3K2
         ATD0H33K+rTx0omjOZ2VjNCw0REuzsOuIyKb/contDHDVb0jFnHY9CU9jsPfLprH6CnT
         upkbIBc01nNlKNZHZ49zdXb77moYjOKZDVzLUOdpPnSiMDGzmF6DaxWPatTrAME7Z+FA
         RryUlQfcR/F+PM9BssUig3TWbCd6nVIEFglpBnYC9CUrnQuGNFf6NwhiO/4XyMWF5rov
         /JYtS/wjMp92w7nV845PQxnILBKQBf1eCW+VrmCs7sarBisUhPSn/R6HS1UAHml1SNzL
         6Ymg==
X-Gm-Message-State: APjAAAUpBuwBcOGZWsMqPwH9NTeMUnFf2SqfrBluyDVLcepwxbxJkOKD
        N2YXCfx1VGB+LvXuAdL+9LlZk+ms+HQ=
X-Google-Smtp-Source: APXvYqzLM/3g2qJO2RTuSHhwMonhUQKnaW3ozT8Nlq7EVXf9yV1tjKnm8LBpHXqxNE82Jr6egvkQ4Q==
X-Received: by 2002:ad4:46af:: with SMTP id br15mr6714995qvb.216.1580416417366;
        Thu, 30 Jan 2020 12:33:37 -0800 (PST)
Received: from mango.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o12sm3436514qke.79.2020.01.30.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:36 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/7] cache-tree: use given repo's hash_algo at verify_one()
Date:   Thu, 30 Jan 2020 17:32:18 -0300
Message-Id: <8bab40cb3357d64b8d365b8848ded99122056689.1580413221.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

verify_one() takes a struct repository argument but uses the_hash_algo
internally. Replace it with the provided repo's git_hash_algo, for
consistency. For now, this is mainly a cosmetic change, as all callers
of this function currently only pass the_repository to it.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 cache-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cache-tree.c b/cache-tree.c
index 1bd1b23d38..8c51a15751 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -826,7 +826,7 @@ static void verify_one(struct repository *r,
 			i++;
 		}
 		strbuf_addf(&tree_buf, "%o %.*s%c", mode, entlen, name, '\0');
-		strbuf_add(&tree_buf, oid->hash, the_hash_algo->rawsz);
+		strbuf_add(&tree_buf, oid->hash, r->hash_algo->rawsz);
 	}
 	hash_object_file(tree_buf.buf, tree_buf.len, tree_type, &new_oid);
 	if (!oideq(&new_oid, &it->oid))
-- 
2.25.0

