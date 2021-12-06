Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D095C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385672AbhLFQOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388756AbhLFQNn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:43 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99EC00FDFD
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o29so8538772wms.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gH3g4kfU8Y2PYneljW76tLyHpoW5kOXX5YMI78kGvl8=;
        b=lNX8P0W8EH6326aMCKDC6VWnMpMCbPI3DsiFIbgiDBRJlVBZ2X/0SCnYMFD4EmdnAV
         y7BhrbIyr6VAFOMkVdh8yt3S43GJQ0sHbpDwqSUcj+zsyVRypQvTs8bLF1enB5/RIwxZ
         Ks+7xqaxwfd5c7cIXK3l1goDFnWRbJiWjhpvHwhMD9j0vLV4AywwMGAgAqwS8VZ450qb
         9i8TLus/yyzbtaZIOq0Kg7zGPKkZ+bvtvmtSeFel41v2hZJdn1bEP8VUNNexoMnmJ6Tl
         R3oEvNFOSfmrSrT9MMOZEj/kRbh439L6qfOIku+0C9d3Tp2Ex9EOkV7EGtpg6z0UXCvN
         +JwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gH3g4kfU8Y2PYneljW76tLyHpoW5kOXX5YMI78kGvl8=;
        b=DODNx6jvsecKQrcOnykgMUkttWGwPAGK5AW2v/sjM3gB393z751PXdlcsWGwRzenJq
         n/MYzaiu5QQ9XfBEaDnPXvAvNB4xjvBpGgYgbQKL5XL6S3xGvNpnfRt8jjH77FzKyaW8
         v7JSG1401eek104Nvqc84+zfHJzaa2CepsiymyPmAOVpPkt40I/bdynfPNAu/QGY+kwi
         p35lFZvSu7sdtoYjxmHLxUAvVsbMOZqUONRRG2QlFt4Y4+YjlR2odm+W95gGdmMrdh0t
         PPljto1vxMfQxQ915/UueaXj7Joix2+JyCRoWccdOvj0+DXq2O8NHferqBRUhJ9OZHot
         U7Iw==
X-Gm-Message-State: AOAM531zirDS7Proy4qT694GCyDoWgjHCUEbMES1/2N3ItGgpsG8v3/n
        8W2t+YtTsya5vhqrCJ94UV8ReHICtOk=
X-Google-Smtp-Source: ABdhPJx/o81ryeM9gdyMvWjnAXcx0mkNLcZyPFxtU6zhFGwA579pMEjPAyI+QL6Yh0IBt5COI8ZS9g==
X-Received: by 2002:a05:600c:4ed2:: with SMTP id g18mr39357973wmq.18.1638806165897;
        Mon, 06 Dec 2021 07:56:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u23sm12478162wru.21.2021.12.06.07.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:05 -0800 (PST)
Message-Id: <fd28be71ca47a71b224a5b08cb81f903ada6a2bd.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:58 +0000
Subject: [PATCH v6 4/7] repo-settings: prepare_repo_settings only in git repos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Check whether git directory exists before adding any repo settings. If it
does not exist, BUG with the message that one cannot add settings for an
uninitialized repository. If it does exist, proceed with adding repo
settings.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 repo-settings.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/repo-settings.c b/repo-settings.c
index b93e91a212e..00ca5571a1a 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -17,6 +17,9 @@ void prepare_repo_settings(struct repository *r)
 	char *strval;
 	int manyfiles;
 
+	if (!r->gitdir)
+		BUG("Cannot add settings for uninitialized repository");
+
 	if (r->settings.initialized++)
 		return;
 
-- 
gitgitgadget

