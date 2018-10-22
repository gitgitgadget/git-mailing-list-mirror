Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754E01F453
	for <e@80x24.org>; Mon, 22 Oct 2018 01:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeJVKL5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 06:11:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38806 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbeJVKL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 06:11:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id p3-v6so4030255qkb.5
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gtEXh2zLU436jwZDFQRNZqAn32+igeNWlQjhqmNfBk0=;
        b=FDqzQDIiZTMx+X6AnfSwX3mAu1MJ9sblihMbYX3oV6mfaQ1NRmSgFdtEiIg+oLtits
         UeHin17jC21aArOzHoioc7yMmHxLWeKHhCE2lK0YOUcdoWy+qwsbLl7FoB+ZPV++m6nB
         BPvZnDpSPNvCk0FrEfPpb2Pn1KLWUndgHoWb6vXIxyO7aK8XgJpmjX7OcM/kJjwvvVtP
         U3KZasPdIF/t2HnOBTG9bt0GUnSzwvshO71kwVa8Yuk0I1tS1L4oFX9z7SRGwSP0OLzz
         hDER2oLBThTPEOGKLIMlJ9X51lmboV8+1UOeU9NJWRsS9FfDQ8agBPGm7nW3rukJzcJM
         86fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gtEXh2zLU436jwZDFQRNZqAn32+igeNWlQjhqmNfBk0=;
        b=eEWK6QfDnezIcmM0lO4/w8VdCbZIh86yUFd+7tQxdfhnhTAOQY0IWhT9KofbdCCTny
         l11hepj4rWA1KY5Y1ur/WRvGNFfBVhiE7Vu/6kSHnnbzAYbjtVdWUDHoA54GYqGmG+Ut
         5Vxdn6XuCNVSIzhLaeARdSqK/aowAbKxvbDfmvn8gKK7fQ9iRaARZuB9Pzdp44lFykdX
         leeede76mIKQulIciKoLv0dFwctWfcb7Bg+ymX4TU2249/1/tsdR7zhZMuUXK5M/lvTn
         e92ByLNjOEX4Nprg6LWqyvryuBhf9978BiWFMI60gw9GvJrZeZrDEt6a+duVmDOd8PDp
         rlcg==
X-Gm-Message-State: ABuFfogwWbNmT1uFM1cjjvhVRJjw/16wghs6OuVTcOfjdgXN/TB/LnpC
        Dw0S+sjlerkEXZbDCbxRM5ey1Cb4
X-Google-Smtp-Source: ACcGV609bc9g0dCumq2nQirktqfG1LsMkDVI2GpeFOAlfY/0C9T7Oq7Zvz7U5j2PQU8gMxCbrraRFw==
X-Received: by 2002:a37:9941:: with SMTP id b62-v6mr39368373qke.53.1540173332211;
        Sun, 21 Oct 2018 18:55:32 -0700 (PDT)
Received: from linux.mshome.net ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id b21-v6sm3234768qkj.9.2018.10.21.18.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 18:55:31 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, jnareb@gmail.com, gitster@pobox.com
Subject: [RFC PATCH] revision.c: use new algorithm in A..B case
Date:   Mon, 22 Oct 2018 01:55:28 +0000
Message-Id: <20181022015528.141238-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com>
References: <bb91d5bb-4220-97b9-dd78-5aed39033e58@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---

I just wanted to mention that in order to use the new logic for 'git log
--topo-order A..B', we just need the following patch. It is an extra
time that sets 'revs->limited' to 1, triggering the old logic.

You can use this for comparison purposes, but I'm not ready to do this
until more performance testing is ready in this case. Since these
comparison commands are already pretty fast when the diff is small,
there is less urgency to improve performance here.

Thanks,
-Stolee

 revision.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index 472f3994e3..8e5656f7b4 100644
--- a/revision.c
+++ b/revision.c
@@ -278,10 +278,8 @@ static struct commit *handle_commit(struct rev_info *revs,
 
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
-		if (flags & UNINTERESTING) {
+		if (flags & UNINTERESTING)
 			mark_parents_uninteresting(commit);
-			revs->limited = 1;
-		}
 		if (revs->sources) {
 			char **slot = revision_sources_at(revs->sources, commit);
 
-- 
2.19.1

