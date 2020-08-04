Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840E121744
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 14:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIx7Tfzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHDOvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbgHDOvs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 10:51:48 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A4C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 07:51:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id df16so13742929edb.9
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yP/jw/tif3dliGO50+Bi/LjuZXFDaFNSBizqVQQUMQU=;
        b=iIx7Tfzpu7wSbS3v4NmH7dbyvXNcVht4ObUe5ymBt5ZoDiowuWm6DpXulGIapyBmVq
         xOPi0iTNLYorfs5LbbL5h6nISMp76fKzFVWFiDjcweMouKAXlHiLmw9jdY/k64c93NQK
         k6B1sKjfGE77zR7ioShO+6EHvEEG+EP2hXjJ52sLm/zPdnj8r87yLQDr3SG7E3XCsNoi
         iCDYkRHMRnK2fZT0Fmv+07fHR3vPDXSsGr8bR+BBDXZkpY9AlR1My+QRGF+0x1Ejozqe
         O/W58NKEY3NPpjBhfdxCWP3LsnN7g8Nr986ak3HvIDB2laBgPNIkLVwVIIF8it7BJVjL
         G7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yP/jw/tif3dliGO50+Bi/LjuZXFDaFNSBizqVQQUMQU=;
        b=fTnDZC6RvR3t/h2btY6aorTd1sGsLlELIWcS1pM2hskw/feIUEm4k0CbCv7H2sXFTd
         XpbU+HL7iNZzQBgPacTFA5FsJwtNHs+HrJY7hjGF4+Tam34phM2HSJ8eya+6SBjy4do4
         wskYw/PzVIaQO2nlJnnX+YNgFKsb8YUjXbbKkUKpqKnr/XNsC20D2KtvNtCWZTpSIuVK
         Z35jurbVQGZ/RNvjzMnXXyQUt8FewFnxoMbU+qNEpdR7GsIIAZerzm/sozV2dTrTKerY
         CKJRojOuxMOg6Vw+ue0sGyixxiv5aa38NyYwhjnprcPBH8KdhTEZSSmdDXFYE2juOc3E
         prFg==
X-Gm-Message-State: AOAM531y6tJbvXJJPfUYO5w8LYbq0IITIuQc1QoLW8TsI5XRakus1IHx
        mo0wKNVHNNrSn+F1l/Qw0go=
X-Google-Smtp-Source: ABdhPJwsdCsChV+mJTVghBowBxnikYjdUptY8pE8oCwp2Y8hMWgije+fKln1zmJVvadULoNciNbWHg==
X-Received: by 2002:a50:d51e:: with SMTP id u30mr18456144edi.296.1596552707044;
        Tue, 04 Aug 2020 07:51:47 -0700 (PDT)
Received: from szeder.dev (94-21-29-171.pool.digikabel.hu. [94.21.29.171])
        by smtp.gmail.com with ESMTPSA id a101sm19617075edf.76.2020.08.04.07.51.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 07:51:46 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:51:44 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        garimasigit@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 06/12] bloom: use num_changes not nr for limit
 detection
Message-ID: <20200804145144.GQ2898@szeder.dev>
References: <pull.622.git.1588347029.gitgitgadget@gmail.com>
 <pull.622.v2.git.1589198180.gitgitgadget@gmail.com>
 <8278b5c0918c6b357e1f1ab3ee65ed2091ec3f61.1589198180.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8278b5c0918c6b357e1f1ab3ee65ed2091ec3f61.1589198180.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 11:56:13AM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> As diff_tree_oid() computes a diff, it will terminate early if the
> total number of changed paths is strictly larger than max_changes.
> This includes the directories that changed, not just the file paths.
> However, only the file paths are reflected in the resulting diff
> queue's "nr" value.
> 
> Use the "num_changes" from diffopt to check if the diff terminated
> early. This is incredibly important, as it can result in incorrect
> filters! For example, the first commit in the Linux kernel repo
> reports only 471 changes, but since these are nested inside several
> directories they expand to 513 "real" changes, and in fact the
> total list of changes is not reported. Thus, the computed filter
> for this commit is incorrect.
> 
> Demonstrate the subtle difference by using one fewer file change
> in the 'get bloom filter for commit with 513 changes' test. Before,
> this edited 513 files inside "bigDir" which hit this inequality.
> However, dropping the file count by one demonstrates how the
> previous inequality was incorrect but the new one is correct.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  bloom.c          | 2 +-
>  t/t0095-bloom.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bloom.c b/bloom.c
> index 196cda0a1bd..e2ede44126c 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -215,7 +215,7 @@ struct bloom_filter *get_bloom_filter(struct repository *r,
>  		diff_tree_oid(NULL, &c->object.oid, "", &diffopt);
>  	diffcore_std(&diffopt);
>  
> -	if (diff_queued_diff.nr <= max_changes) {
> +	if (diffopt.num_changes <= max_changes) {

The field 'diffopt.num_changes' is marked with:

  /* For internal use only. */

>  		struct hashmap pathmap;
>  		struct pathmap_hash_entry *e;
>  		struct hashmap_iter iter;
> diff --git a/t/t0095-bloom.sh b/t/t0095-bloom.sh
> index 6defeb544f1..48a90625596 100755
> --- a/t/t0095-bloom.sh
> +++ b/t/t0095-bloom.sh
> @@ -100,7 +100,7 @@ test_expect_success EXPENSIVE 'get bloom filter for commit with 513 changes' '
>  	rm actual &&
>  	rm expect &&
>  	mkdir bigDir &&
> -	for i in $(test_seq 0 512)
> +	for i in $(test_seq 0 511)
>  	do
>  		echo $i >bigDir/$i
>  	done &&
> -- 
> gitgitgadget
> 
