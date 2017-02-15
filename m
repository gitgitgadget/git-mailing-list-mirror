Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828422013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdBOAfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:39 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35009 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdBOAfT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:19 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so56276956ith.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ob6jcjJcjRPKY2qwV8hp8lDo88IiTF4QqmK5QmoPBU4=;
        b=awnR2Nlh8X3yt7R4hvisAlStXoz54+SxSipEcgCbMqynJqQplsDzTB475vcY5r1Nyy
         BjMd2XAGCHoebi3C4tRYFwm+1PBbnpRuPfdfW+CA31d4vjEx4r0ldL/xjwrPcWXTtgXP
         cUUux/93x6jsSiHv8MEXZdSmlIBzkiJeZPjjpSyWL7smzJEG9oz0/9LJI/QUR4jK0zOa
         o59qnqON2dtznniVFm82NLLdEFTQJDy+aZxmEEiH1zAVcproWUPW/38vYXRT06EDbFSn
         LEEXkeTtyJGvzcKiCDxlXB04xc7/qySXwmrkGwy0IwBlx3LQS/ttTSDJ3w6AODqnIOqH
         bW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ob6jcjJcjRPKY2qwV8hp8lDo88IiTF4QqmK5QmoPBU4=;
        b=TJYB12O4ZaLFxENj1hDrY++y6Z/a+q2bjCUXvSy26vqWMx3BgsGbN2ez0prJMydbiX
         ABka/qqoCM2tGMEHXcV8utBzkEjcoB/MY+01xOa9YXvwy0OZ4RcMW8ELKZKjFsGio1cP
         u6cPgldb6axXx+HhGaccrY9VjSvTDvurQrNcP50PtWuu+dgl/NhSlnepoQb6zSQXelVm
         CAzMQDBf8ya+ub1wUDnOfHNfEy6FK+ZIqvSosdy2CTDMlUGVkTkM70iViZ/UZVn6Pg8p
         YeyZkPIWWHBNy5L3D29VzXOU60axNsDDsY5+ElBYhut1D7WIMDHPvv4v6/0R4K5SWBA5
         4J/Q==
X-Gm-Message-State: AMke39m6j0fuAP8KoZ9lzkdOh8qn7999QIlQ21/GoW/lWIoSfl8wADrBVQ6JVlfFCV9pSL3u
X-Received: by 10.99.102.134 with SMTP id a128mr35075616pgc.215.1487118918453;
        Tue, 14 Feb 2017 16:35:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id v186sm3305808pgv.44.2017.02.14.16.35.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:17 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 12/14] read-cache: remove_marked_cache_entries to wipe selected submodules.
Date:   Tue, 14 Feb 2017 16:34:21 -0800
Message-Id: <20170215003423.20245-13-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 read-cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 9054369dd0..c0776b93b0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "submodule.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -532,6 +533,8 @@ void remove_marked_cache_entries(struct index_state *istate)
 
 	for (i = j = 0; i < istate->cache_nr; i++) {
 		if (ce_array[i]->ce_flags & CE_REMOVE) {
+			if (is_interesting_submodule(ce_array[i]))
+				submodule_go_from_to(ce_array[i]->name, "HEAD", NULL, 0, 1);
 			remove_name_hash(istate, ce_array[i]);
 			save_or_free_index_entry(istate, ce_array[i]);
 		}
-- 
2.12.0.rc0.16.gd1691994b4.dirty

