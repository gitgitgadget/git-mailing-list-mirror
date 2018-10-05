Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C97621F97F
	for <e@80x24.org>; Fri,  5 Oct 2018 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbeJFEc1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Oct 2018 00:32:27 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:43661 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJFEc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Oct 2018 00:32:27 -0400
Received: by mail-it1-f201.google.com with SMTP id w137-v6so3679513itc.8
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PQw5VNRqY67VEQ0o3B/Q/ISsDEZKysHNiMYTvo+2YUI=;
        b=fMvmXWTZeAfRL0So3JRopHarqNmc6wZVtfbxUY/mj/O2N+NyhXXSsI210HJUh8rdta
         mFDz493GCRKG8XxOD+2VMDX9JiTPjtOPuMuHpoLaGR2bJkaboxlG3vXa5oza2scy7w4b
         +IeVAS2KBNPTwNBNVz8r3QMzQ5Dlyq+14+O3ufD2uO8+FMa0jCB5adwiq7bKS4kKXU9m
         6zDMmmxGz6p5DMQTSsgGo1JGpn+77gmSCRR8hSoF+EMTza6gc2ko1nIF4DpMezKIS39D
         2kRjvzzckYOXCza4KhF/Xmu66zwB6E+NrOBgcN5e+bT33BwHnyzQs84SJy82x082yDxB
         YtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PQw5VNRqY67VEQ0o3B/Q/ISsDEZKysHNiMYTvo+2YUI=;
        b=aQB5YR/WGXVGkLXVMYqh78sqBdgRBciZn5lg5m4Ase1VvBuPzSdSrdR+2f/ZQyNShG
         cyMiXFdFh4fhrt2253qJfPewpzDq8BkAjI1/aiA2EN6Wu+Nur+/l0pEro7wzMBWjNMTL
         R+u5OCYlhyi/v+Pz7dki+zwROoEdK6rb3tPVar3rh428hgYZZctu9bK+NNXhivmeUEp2
         8XbAndOFyGz95RtyGuAfar12l0X6PCbr7tQDQE0mTU6nUfR8je3A1PJiu1N5rI1X5Oyi
         v339kE1TtDFxYIlwAL+PG//jc/mGFfGS63nPF/J05OsqvPJusCyTgLaptXtKKhsYI5OE
         kyiA==
X-Gm-Message-State: ABuFfoiiEXDN+W3i3olIBGFX/UB1WOoSrMPfFCsIOVepGXhg22iC53rW
        znLxAm6R79UWVLR4Mv4F2Cc/kybMqeG22Oc+gyIrOaK9cb6RkQye66EjlJbtoGQNB4mbiYHNYdX
        VcTd/BD5+haWVZWH6WI83g2ksdBllQPB9F1OerO822vmLWzbqRaDxvgR+sAI=
X-Google-Smtp-Source: ACcGV61c8oDEmnR/eBsTRKkmRAHH/b/aCuflb+uvFVoY/OzMrDbp2fhczvxrj61KTU8LAW7Cv/tkgdqQuo0I
X-Received: by 2002:a24:d49:: with SMTP id 70-v6mr9712668itx.5.1538775112526;
 Fri, 05 Oct 2018 14:31:52 -0700 (PDT)
Date:   Fri,  5 Oct 2018 14:31:26 -0700
In-Reply-To: <cover.1538774738.git.matvore@google.com>
Message-Id: <1a055a109adadaca6eff89514089fbde739d600c.1538774738.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1538774738.git.matvore@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v11 7/8] list-objects-filter-options: do not over-strbuf_init
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

