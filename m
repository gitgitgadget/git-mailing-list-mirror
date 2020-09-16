Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9017C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9B220838
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="NiI5YiAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgIPSHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgIPSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:07:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141D6C06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p65so6883269qtd.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRMElt2uq9/5C4eKkJRsIRdQBvymmD1QqYtUGgVACEY=;
        b=NiI5YiApI1hr3W2iJRZJTxObXJreTTiYpARfbK8gX3smmxGL2buV1nXm2/VDHzQ993
         g4xwrgQsHAGi9IcQh6aA6N/nwuRQzrims20+qtSed0nTrAigvNc3X3QgRL3hBR5o+a1c
         dUE4ZQG1zyjudasLiepoCMQL2gMxL1k3q43uOaHs7edswv5JJqno3X/+kLf6Pe8dv28R
         D1Yi0UtVEPiNx0g8ubX/keyDFSgISkTAuMCBYTOJVYWfvkTdH0hqmkho7pGpF7JwAW41
         UO5cTZQMJNOhsa1MufXoR3sbbcgvoEy3mocyf5PjERoSLpIJvQEKV1lMauKbvga6CF+c
         oZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRMElt2uq9/5C4eKkJRsIRdQBvymmD1QqYtUGgVACEY=;
        b=WC1iXaxoVgbQP20P6Df0QXtIlP8RkceOyNaVDKVkjedBoS8xwJwE9GxxDo1G2pW63U
         cemF0r+UaWInPewmaDrwrNAfdFmUD3tWQAWs8hBlpcix6ewTo3z3eChHMkUxiyON3esX
         MRjKXMsAk5A4FEeNoLAjdGrT3Ek8u479ivDPZoR/X5JPU7+roJoKyzZdZnofCNYOnlQL
         tZViPfAP84SLp/q8StIlqb0owSPBvSN7ATFPkClzXzGkJdgmdAdrvW0Chrijz1xxKFX/
         9cUkYCwNPkYRtxO36YhjMwZ11OrOC1drWb4JDIcGh+fkUiyAODsHpmF6UGVJajb5y5Go
         v31A==
X-Gm-Message-State: AOAM53099ppx1rGkuSRxGJfOttGjLjIlQ8QRqro9E+iLbpRjumQmVstm
        zztXQAUziPgJr2VxvT/tNCHisTc6+ZdQBPFF
X-Google-Smtp-Source: ABdhPJxgHbCghgx8++62/2j31ERr+XDxLXoPV0HTPVvISAAXOXhDQ/bcMEiKWWSpHuYhVAnQlwiuVA==
X-Received: by 2002:ac8:c4e:: with SMTP id l14mr24686189qti.149.1600279635919;
        Wed, 16 Sep 2020 11:07:15 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id w59sm19281059qtd.1.2020.09.16.11.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:07:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:07:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 04/13] t/helper/test-read-graph.c: prepare repo settings
Message-ID: <9416c467394e46e0a04c2c32737229a88998dcf7.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1600279373.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The read-graph test-tool is used by a number of the commit-graph test to
assert various properties about a commit-graph. Previously, this program
never ran 'prepare_repo_settings()'. There was no need to do so, since
none of the commit-graph machinery is affected by the repo settings.

In the next patch, the commit-graph machinery's behavior will become
dependent on the repo settings, and so loading them before running the
rest of the test tool is critical.

As such, teach the test tool to call 'prepare_repo_settings()'.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/helper/test-read-graph.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6d0c962438..5f585a1725 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
 	setup_git_directory();
 	odb = the_repository->objects->odb;
 
+	prepare_repo_settings(the_repository);
+
 	graph = read_commit_graph_one(the_repository, odb);
 	if (!graph)
 		return 1;
 
-
 	printf("header: %08x %d %d %d %d\n",
 		ntohl(*(uint32_t*)graph->data),
 		*(unsigned char*)(graph->data + 4),
-- 
2.28.0.510.g86fdc5f89a

