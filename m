Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183CB1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeJDCmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:42:42 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:55212 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbeJDCml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:42:41 -0400
Received: by mail-io1-f74.google.com with SMTP id l24-v6so6547331iok.21
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PQw5VNRqY67VEQ0o3B/Q/ISsDEZKysHNiMYTvo+2YUI=;
        b=Df2HlqngtWvkNC/UoySDVyGsQmmM0/GkEvW+U99QzifwsWzst5C6fkCxBKeyBSwGdz
         cDd8BwddI3eDFcodaeHDvGqA1FHNdKt9KQVxYrz/7rmEEVhI6Apq+51ssUTzbjmGuZj8
         ufriDXLefoL8qkMpgXOAz1Z0E3PEbZ2oPeecpbhqjX5IXohw2LJpqgwXv2QyAejwkwi/
         RpcZC/qX1ozKeoiaTY6pukH7CFajQ1n2jgI+nioh4E6khErjeVtPOFdTnSPNs3TKXVS9
         yanueRuFg3PrCc9N+IwMQkiahk1fpiuUAq2Kit0JRpPR6DUpKIe8sj6KXzVbohBiLErU
         i9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PQw5VNRqY67VEQ0o3B/Q/ISsDEZKysHNiMYTvo+2YUI=;
        b=KKCYV5Ws8DDyHdHon8CVxDInl3vsvguQzfZVGg2KuaUBL0YxksFPji8OdxE+GYa+wb
         eGaytDTI0uXBxS386SohRE5PvRb8oAqQ+AgEzVs9xTSVBapXQ7DHyA6son+bYfuGx/5Y
         1b5I3dCifeDciMfWNAXqw5+wBY4rrVYtTdQ5gE+INh+4qZ6+dsNIIMEiKTdYk86NZFE9
         DzEWGcX3Wwt/kKuPYRR22iiU/qtbRICHZ8zirditZju6qe5eidthjSK/00LRcob9+7Q8
         IiV01hE+EqvKkPstTS0dZnb2iYL4gGMTxpKZm51K8lAFayZ/oG8dzPg+XZ/6FhybY3SX
         ZHdw==
X-Gm-Message-State: ABuFfohBbMykb4o6QeMIxUfur+y2GZM4AtYHMq+4qOJsoQ9/+xVhLBhT
        foIZWT3tppJ6Fp/MHNlFMrJsW8gMTaRLEmOnDFzfggPoLF/AMzMm5XP60p3QQYG0kueNxVknBj6
        k7KyUpnwCM9p0laisofk9OUvtk2ehLu1FU7hjOwQFIi1Jn00aQ44vZT27vsw=
X-Google-Smtp-Source: ACcGV63MV/JJAz2l4Fwd2NpX91/Tib6o1s5FN3ZUI7HCuSumFmks1EuZPBRzBkd5sP0xy1CMx/T2MBMllOFs
X-Received: by 2002:a05:660c:b0c:: with SMTP id f12mr2367615itk.22.1538596372291;
 Wed, 03 Oct 2018 12:52:52 -0700 (PDT)
Date:   Wed,  3 Oct 2018 12:52:18 -0700
In-Reply-To: <cover.1538592829.git.matvore@google.com>
Message-Id: <4d9bbf5c8af670a969a5b11876a65f0505b1a1b8.1538592829.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538592829.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v10 7/8] list-objects-filter-options: do not over-strbuf_init
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function gently_parse_list_objects_filter is either called with
errbuf=STRBUF_INIT or errbuf=NULL, but that function calls strbuf_init
when errbuf is not NULL. strbuf_init is only necessary if errbuf
contains garbage, and risks a memory leak if errbuf already has a
non-STRBUF_INIT state. It should be the caller's responsibility to make
sure errbuf is not garbage, since garbage content is easily avoidable
with STRBUF_INIT.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 list-objects-filter-options.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index c0e2bd6a0..d259bdb2c 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -30,7 +30,6 @@ static int gently_parse_list_objects_filter(
 
 	if (filter_options->choice) {
 		if (errbuf) {
-			strbuf_init(errbuf, 0);
 			strbuf_addstr(
 				errbuf,
 				_("multiple filter-specs cannot be combined"));
@@ -71,10 +70,9 @@ static int gently_parse_list_objects_filter(
 		return 0;
 	}
 
-	if (errbuf) {
-		strbuf_init(errbuf, 0);
+	if (errbuf)
 		strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
-	}
+
 	memset(filter_options, 0, sizeof(*filter_options));
 	return 1;
 }
-- 
2.19.0.605.g01d371f741-goog

