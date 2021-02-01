Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69399C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD6D64E30
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 06:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhBAG7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 01:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhBAG7c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 01:59:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ECCC06174A
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p15so15280175wrq.8
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 22:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bbJNvBd8SqTjp1bLQAT5B9ts20SlrwOtN5mJW+5EG1Y=;
        b=E7syTpSwIbDS1Oggv0pYzVaAcrwG71Zt2XPnV6nH/PO/gBfzsQyyQj8dN+7tWOjNpe
         wkELkRlUeXwOtB6W/0ggPHPbkPWpjMnXU5LjXLAtCub4LXw1b6kGEx/u9eKy3Pd/9vXd
         OJB8ODOQVK7QZ3cMfFsU7cYytmeReLZ6tjMGqcM6Kej2efDN0BpPAihWPjyvPPkW9qmq
         79mxZH+UDMMH1YcbyiHAAjXevX4cjsusGjC4W5dy23yX6yB6gqSb8thXLaqDqURYS+vd
         meSVFfl3fWpvTK3J64ARyG1fV5b4siKisr0V3lPYF/mOUsQbVJHTumtfHqkLOUQjTTnN
         vhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bbJNvBd8SqTjp1bLQAT5B9ts20SlrwOtN5mJW+5EG1Y=;
        b=qGG90U6QCDrmAhKAZSysRPA4bA7BFBl0dH3gZ8mqE/707lkPnFV2RMHAT6XszAIX5P
         Hq66DrG8g0TNyhbBKUyRMoTatIsrG16WMwRE3dIDrgXBATMC3Y4LDLdbDsgom5hiRhca
         r6jPZVRfLz5kUWQnWC7x4jaSh3Dk8PNnLi3lCMhxEc5SbPhbh56odH0mKn/fyXKuxMDo
         2CF2xsdmRol+zD0JocxoDJqclak6+gcJXmnSwbGpwmTZq9iZiGCWfvkfp5Mf7hxvvGDO
         KoXpdkjWhqzr87Cb6HQ4B7xQDdURE5azSVIyHX35/T4b6Ns+yi+Trrhh0ebagb4iRlV+
         g1EA==
X-Gm-Message-State: AOAM532XbRCbObZo+07EYV9h11UqyDGLM2wBZwEq80Qn0LUVPCqzhAyv
        oyiQA71thaOuXJdX8khfm7XbGWQDswg=
X-Google-Smtp-Source: ABdhPJxMaMOs0MB+y8BLnNxorYDv0WirVgUqQyqp2EpDdi+AOFnoQ9yq5AWEeF5Nte2I7Q72WjgrhQ==
X-Received: by 2002:a05:6000:234:: with SMTP id l20mr16363440wrz.212.1612162730488;
        Sun, 31 Jan 2021 22:58:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm26051978wrw.38.2021.01.31.22.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 22:58:49 -0800 (PST)
Message-Id: <90ca0a1fd697b91180a01d82eeaed54511c9719f.1612162726.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
References: <pull.676.v6.git.1610820679.gitgitgadget@gmail.com>
        <pull.676.v7.git.1612162726.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Feb 2021 06:58:36 +0000
Subject: [PATCH v7 02/11] revision: parse parent in indegree_walk_step()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhishek Kumar <abhishekkumar8222@gmail.com>

In indegree_walk_step(), we add unvisited parents to the indegree queue.
However, parents are not guaranteed to be parsed. As the indegree queue
sorts by generation number, let's parse parents before inserting them to
ensure the correct priority order.

Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
---
 revision.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/revision.c b/revision.c
index 0b5c7231401..5474001331a 100644
--- a/revision.c
+++ b/revision.c
@@ -3399,6 +3399,9 @@ static void indegree_walk_step(struct rev_info *revs)
 		struct commit *parent = p->item;
 		int *pi = indegree_slab_at(&info->indegree, parent);
 
+		if (repo_parse_commit_gently(revs->repo, parent, 1) < 0)
+			return;
+
 		if (*pi)
 			(*pi)++;
 		else
-- 
gitgitgadget

