Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633B1C433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DBF20747
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW0LCgza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgFKMjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgFKMjE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 08:39:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612DC08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so5985731wrw.8
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9FZcy0kvOKkAf040rcyHHZkIhwa8WXzai6Li+gKu0+0=;
        b=ZW0LCgza8ZqMY/KD9DOYFaYuS7a5zDZV9eDBP5RSDl7C/9lIEzGqrVKkSt4trq+JfB
         d0rVL7YYc78lE0XRwTHQ+Do2DnK+s7c/J+5QpT1/srUWbFLifW3wvp3qcra7SGbe6ANX
         R0oQ6kdreMbN8axUbVhgvhxVTXm0ZSt9nJ/0Ks1zlyu4lizzEdcyf/UkDaPykS/YY9cS
         OmdsN/WDpuTn91iul3hAS6gHo19SO8ZRtUHdgpP35jDh+yYY2MhWs5xekGm8t7CG+/PR
         cp4DdOeMUYwDFs0YgWy1M3MYF43zikIEmLpRTkMxTf/gQtoQozCYAOEc36O5NslECnI+
         rbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9FZcy0kvOKkAf040rcyHHZkIhwa8WXzai6Li+gKu0+0=;
        b=Rh48p1w5LVJ8cFolroKwVeYQKjIPfXX66DbNDvBQ9D3SMgluhWuhASioOB6oGtroM3
         Iyl4OO9wfDR+5lRK6BPFvKttJh7TKSwBa0VUYowqtSQyHaZWPmh6PRiGae2Kk0Vm4KWM
         lakbwQYrp2gS2/Nt3GxwXuO6rI0svXLrR8DJn/55YejgoS+JhA9PWvOKxxGwtZ1i2gCi
         vhNSf1BWWhoUoangq2qzDmZIGEdc55pKMnbDOCV471V7V4qW6ey1a+87i8GiKdvw5eCa
         zDn3Wqs6R5OuWyDxbDwMg7YUDwA3jdf4LTZLimOPoiw5PXVXwWI2Oa9wvrOkLupUY9PL
         WuBg==
X-Gm-Message-State: AOAM533G/kj8aWXWyNAcUBYP8ueCSZWSRzYskUx+QuzhKVIEoX7+kz+f
        iCX1BpK1+8NY19lBPcHrbmK/sjcu
X-Google-Smtp-Source: ABdhPJwggMZTZxV4E+UbTVojopj2tyXT7QdwKN2fzcw7dRBME2cbqBc0ZKGtFmg2mLYD0t+y/xUMxg==
X-Received: by 2002:adf:82cf:: with SMTP id 73mr8908360wrc.382.1591879141874;
        Thu, 11 Jun 2020 05:39:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm4347640wme.46.2020.06.11.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:39:01 -0700 (PDT)
Message-Id: <9c96c43f3d744a0f4f312bb466eaf54d372a56fb.1591879139.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.git.1591879139.gitgitgadget@gmail.com>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Jun 2020 12:38:57 +0000
Subject: [PATCH 1/3] diff-files: fix incorrect usage of an empty tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
2017-05-30), the OID to use for intent-to-add files was inadvertently
changed from the empty blob to the empty tree. Let's revert that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff-lib.c b/diff-lib.c
index 61812f48c27..15bb45776e4 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -220,7 +220,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			} else if (revs->diffopt.ita_invisible_in_index &&
 				   ce_intent_to_add(ce)) {
 				diff_addremove(&revs->diffopt, '+', ce->ce_mode,
-					       the_hash_algo->empty_tree, 0,
+					       the_hash_algo->empty_blob, 0,
 					       ce->name, 0);
 				continue;
 			}
-- 
gitgitgadget

