Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B248EC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B5D23603
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 13:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgLGNoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 08:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgLGNoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 08:44:06 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729F8C0613D2
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 05:43:26 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id k4so9334670qtj.10
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XR+LdUP5zyGOdMTqAXUwZ31aKJrHXLIToZMjP+R4/Us=;
        b=Ze79Ay0ESJO6ous5tkVkT+FEEKGX0KtJfAgDyQAgtvQvpnzIt2uc8Rtvd2gnE+fwfN
         vwbqRZbaUx/bWs4/ZuhFtvmD3iYAKpNAkEjjwhcMtjJBD+Tz8sNrO1NnPId0pPH9o/5j
         eiZ8qIrHfemzUpicVumzGj3ifcQ5Y3vnxfr2lIjgOltiA9UEgEOrEdXDMMomcpbAG86X
         bTaQbIeLV0PpwHeKSW1mFyLysKxJzsynA0oDEmnmlEdpRjuBpLvapWwRnQa5NExdw/1l
         oCj05lgz8Y6C8sVTtPauSg3C/NA9cvYrPrkTFbHCos5uhL59ZGG69fULM6fk+xcAraCe
         r3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XR+LdUP5zyGOdMTqAXUwZ31aKJrHXLIToZMjP+R4/Us=;
        b=hHd6mapUi14LfY+HLaDikxml+xykDjgZ5He7WaFfI/prRc8I9NjqyKbkZwQ9/QKGye
         l7kUn75+YN0UYy+qbgAdQqZFjwBmBj+1PlH40ca7gVV2ed9JuLEvKYq1EU6Qg7M/55av
         N8x5MqETqYQUGlc0QoIFIHDy67A/kO+btpF7UfecUw2yFoRJDjxZt7I2xKqbUxTJwex9
         jSCntCuQ5BZzcHAW7k32epngih9Q7kVeNATYxDV3OHlJW45tH4iAjQY23WiQ48y2E7V2
         4QIbVWFnQkjN8ZePA910UkZLNfoW0ElZx40nd5VV6RlLY01rFocY2yKySDuTkuvOYwsA
         HDxA==
X-Gm-Message-State: AOAM532Uc08sPYON3feQYque+PiPfC7t0fUtzNL0RVrlIYz3RBGijwNZ
        UYg4A3IArAvAAFx9oAvPYB8=
X-Google-Smtp-Source: ABdhPJy1X6Kn2zTA3AYynI/VKv+oHBt4W1f/dsCk4i05QlUpoeHvenDObQVhIxRRsCLyAtZguV5OUg==
X-Received: by 2002:ac8:590f:: with SMTP id 15mr24209929qty.249.1607348605618;
        Mon, 07 Dec 2020 05:43:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02? ([2600:1700:e72:80a0:8ddc:62f4:9dcc:ce02])
        by smtp.gmail.com with UTF8SMTPSA id j17sm11368577qtn.2.2020.12.07.05.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 05:43:24 -0800 (PST)
Subject: Re: [PATCH 14/15] commit-graph: restore duplicate chunk checks
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
 <106dd51f75699fbf4fc1e46687124995f5ef0278.1607012215.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <86e1d647-2242-8a3b-d5a3-832e37e79ff8@gmail.com>
Date:   Mon, 7 Dec 2020 08:43:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <106dd51f75699fbf4fc1e46687124995f5ef0278.1607012215.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 11:16 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The previous change introduced read_table_of_contents() in the
> chunk-format API, but dropped the duplicate chunk check from the
> commit-graph parsing logic. This was done to keep flexibility in the
> chunk-format API.

"keep flexibility" is bogus. This is the biggest YAGNI of this
series. Instead, consider the patch below instead which restores
duplicate checks for the commit-graph file AND adds them to the
multi-pack-index file due to the shared API.

This is also roughly half of the added lines from the previous
patch.

Thanks,
-Stolee

-- >8 --

From 0df4959d59d7f9df3e9f6326bb0acb7b84f84980 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 7 Dec 2020 08:36:42 -0500
Subject: [PATCH] chunk-format: restore duplicate chunk checks

Before refactoring into the chunk-format API, the commit-graph parsing
logic included checks for duplicate chunks. It is unlikely that we would
desire a chunk-based file format that allows duplicate chunk IDs in the
table of contents, so add duplicate checks into
read_table_of_contents().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 15 ++++++++++++++-
 chunk-format.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/chunk-format.c b/chunk-format.c
index d888ef6ec73..a4891bbd28a 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -57,9 +57,13 @@ int read_table_of_contents(const unsigned char *mfile,
 			   int nr,
 			   void *data)
 {
+	int i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
+	for (i = 0; i < nr; i++)
+		chunks[i].found = 0;
+
 	while (toc_length--) {
 		int i;
 		uint64_t chunk_offset, next_chunk_offset;
@@ -83,7 +87,16 @@ int read_table_of_contents(const unsigned char *mfile,
 		}
 		for (i = 0; i < nr; i++) {
 			if (chunks[i].id == chunk_id) {
-				int result = chunks[i].read_fn(
+				int result;
+
+				if (chunks[i].found) {
+					error(_("duplicate chunk ID %"PRIx32" found"),
+					      chunk_id);
+					return 1;
+				}
+
+				chunks[i].found = 1;
+				result = chunks[i].read_fn(
 						mfile + chunk_offset,
 						next_chunk_offset - chunk_offset,
 						data);
diff --git a/chunk-format.h b/chunk-format.h
index 7049800f734..de45797223a 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -56,6 +56,9 @@ typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
 struct read_chunk_info {
 	uint32_t id;
 	chunk_read_fn read_fn;
+
+	/* used internally */
+	unsigned found:1;
 };
 
 int read_table_of_contents(const unsigned char *mfile,
-- 
2.29.0.vfs.0.0



