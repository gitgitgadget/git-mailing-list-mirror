Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995C81FC96
	for <e@80x24.org>; Sat,  3 Dec 2016 00:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757037AbcLCAa7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 19:30:59 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36349 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756116AbcLCAat (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 19:30:49 -0500
Received: by mail-pf0-f173.google.com with SMTP id 189so55137129pfz.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 16:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ImOKWSzmlS7ihQ8MlVImVIMg46Mz2zNGDVf4CuLzSM4=;
        b=hSMOWjYlFFVrytOQsEHDxHNKddKatvdIqjjMTp2pmGb92g/J7au9u84TmNi7lFc/nO
         Y1TvZScAwMre37ZQnqh6mukk2x9F5ztRNVXIZ1pQ2EL3bGYxDhqDKn13RqFgucriDNei
         CV1XFwkaYW3ZvgOTcrVoh+OxCnHVb9mVR7LCIMIVGN8tIv8hTzbcaqee4PTm62N1JfPl
         Pu7mA9RN/csfBO3e82B6gIpadN4gYGPtDdnK8qKYGR0/cDTqyiv0xtksX3UH1UVeVtHm
         GkplL7cSwU51Uel3X8b1E/fL2w2LOZMF5K6AjRgVdMDHTwVQAALpdIDKT73BNl1N1Ei9
         +SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ImOKWSzmlS7ihQ8MlVImVIMg46Mz2zNGDVf4CuLzSM4=;
        b=L34Cmu3bTOl8gqgyc/b9GDg4m1DjyzzLGwH6K0yiZiQND9NM25kohSLFe3zl4BloS8
         5B6kGEpCK384f49v5Fukt2zh/XoHro4+uwi3TdsNXw1ApBDegA0AgRGvine7OE0uF4+c
         HehEmSg/6tXkm7sY3q48HnbgkS8h/reta2jUvGvjYrinHY13xO9tDoWd3l6vDcpRvK39
         NfnUsR3Z7I1oYTbA8fA1pNDAKO1vIoXtutqkf09PBLNXt1oTj/EGoWkzVSCDvLJqr55U
         /21XTK01ZMNvzizkyCNTWZyX0WvcrYVLrG5EX+KClwIrBP3N+ISarCyOTzKQnffpI7VX
         bSSQ==
X-Gm-Message-State: AKaTC03RGCrQFPqFLkpnrJY/2PCiI9io+WrsN7DlxxMJ1kzwH5KNVEvDStQTx5rtrpnbkrGw
X-Received: by 10.84.164.162 with SMTP id w31mr102185797pla.9.1480725048627;
        Fri, 02 Dec 2016 16:30:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:99ac:e2be:c532:3e35])
        by smtp.gmail.com with ESMTPSA id m66sm10324229pfm.3.2016.12.02.16.30.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 16:30:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com, David.Turner@twosigma.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        hvoigt@hvoigt.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC PATCHv2 13/17] entry: write_entry to write populate submodules
Date:   Fri,  2 Dec 2016 16:30:18 -0800
Message-Id: <20161203003022.29797-14-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.28.g2673dad
In-Reply-To: <20161203003022.29797-1-sbeller@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/entry.c b/entry.c
index 02c4ac9f22..a668025b8e 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -208,6 +209,7 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		schedule_submodule_for_update(ce, 1);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
-- 
2.11.0.rc2.28.g2673dad

