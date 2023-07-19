Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA19C0015E
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGSRZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSRZW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:25:22 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DD31BB
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:25:20 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5728df0a7d9so73291807b3.1
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689787520; x=1692379520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uFpaLYvMB6GQc/5AsLZ+iMIPKff/ndwf7HoVvWQ/STM=;
        b=qg2HAqRJdgzrhF4NRdkZucKCeKEfWS+l98r0ufEVt2KcINVgBZyrzLgf9z7wK5DeW6
         rSd4mqyHtbZXEGAxXdjs8cTUVpXjUgvriJmcHMZTIrrEjeKeT0/VHzrrzzws9XxDw7BB
         w8y4flzusAWzyH6/E8Ul4XrxFRX19lOMmvkonin4w+gQHW2Gy1laTEzLNvb4REEqhVCy
         fQB116AM7LmeC0GiinZbnNgyOmU8eJ+yIQFjwWpLN9vEaIppH1w1LqI9r+J2dFIc9yJX
         0dWLU6Be5Qf9whVTCmB94ZZwOy0eXdL0amd84BZnBIur0Jx09RabwzosvdD/wNfoUKKZ
         37rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787520; x=1692379520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFpaLYvMB6GQc/5AsLZ+iMIPKff/ndwf7HoVvWQ/STM=;
        b=YMCJ3sRB3Gy39BBlc7dtxcctCK5z2ArsXFFyp0HnTrf0AGQax+4LNIQOGi1ygncCOE
         nA+5KKXFXtXOX2EfZjsVjxFyN9Pb/tjsj4U0Wve+SWLLK+1RtMP8NcoRa8CIHMeCoGj+
         WFHrzeU3srQf32BujVN5r9Lxoyx5GnIrJ7ubBoC3zSnQLykIAdlUMjj+nR//zF8Xnhcl
         YxbfOJJX6Aly6lPmS8p14m28SK2zgQfgN4ndVwEDwNchjC2Voi1TXuPZFCF41PlKnYX1
         qKNd1cfHjSJrmlO5m7h1bgVS9dJoAxj8s+G4KsX6jrunOZSDUarLPPO7IxTbB0F+RjC/
         Ihgw==
X-Gm-Message-State: ABy/qLb87sUm11KXpIoWq2WVeeoM7nHtKXbJlDlMUvwMpEkV0uTIZNU8
        Zef85XRMu02b4dDdKsMD2xh3Pg==
X-Google-Smtp-Source: APBJJlHKoPLK0W6Lnj45SBU8WYIywNaFRHaSUVTRwoDTul+cZ0FYNDCxQFXzbL5fVElup/Yq3yy6iA==
X-Received: by 2002:a81:5485:0:b0:56d:824e:d93f with SMTP id i127-20020a815485000000b0056d824ed93fmr3586828ywb.38.1689787520003;
        Wed, 19 Jul 2023 10:25:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w78-20020a0dd451000000b005832268b729sm1123259ywd.99.2023.07.19.10.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:25:19 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:25:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/4] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <ZLgcfvIrV3TapMAp@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689283789.git.jonathantanmy@google.com>
 <52e281eef0e857de93e5bdc6e0ef50065adaab2c.1689283789.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52e281eef0e857de93e5bdc6e0ef50065adaab2c.1689283789.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 02:42:08PM -0700, Jonathan Tan wrote:
> The code change to Git to support version 2 will be done in subsequent
> commits.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/gitformat-commit-graph.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
> index 31cad585e2..3e906e8030 100644
> --- a/Documentation/gitformat-commit-graph.txt
> +++ b/Documentation/gitformat-commit-graph.txt
> @@ -142,13 +142,16 @@ All multi-byte numbers are in network byte order.
>
>  ==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]

This is a little beyond the scope of your series, but since we're
changing the on-disk format here a little bit, I think that it might be
worth it to consider whether there are any other changes that we'd like
to perform at the same time.

One that comes to mind is serializing the `max_changed_paths` value of
the Bloom filter settings, which is currently hard-coded as a constant,
c.f. 97ffa4fab50 (commit-graph.c: store maximum changed paths,
2020-09-17).

We always assume that the value there is 512, or the environment
variable GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS, if it is set. But it
might be nice to write it to disk, since it would allow us to do
something like:

--- 8< ---
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index fa9d32facfb..a42b0b03cfb 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -178,11 +178,12 @@ test_expect_success 'persist filter settings' '
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		GIT_TEST_BLOOM_SETTINGS_NUM_HASHES=9 \
 		GIT_TEST_BLOOM_SETTINGS_BITS_PER_ENTRY=15 \
+		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=513 \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2.txt &&
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":513" trace2.txt &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2-auto.txt" \
 		git commit-graph write --reachable --changed-paths &&
-	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":512" trace2-auto.txt
+	grep "{\"hash_version\":1,\"num_hashes\":9,\"bits_per_entry\":15,\"max_changed_paths\":513" trace2-auto.txt
 '

 test_max_changed_paths () {
--- >8 ---

Which is currently not possible (the second grep assertion will fail,
since Git has no way to remember what the value of max_changed_paths is
from the existing commit-graph).

> +	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
> +	when char is signed and the repository has path names that have characters >=
> +	0x80; Git supports reading and writing them, but this ability will be removed
> +	in a future version of Git.

Makes sense.

Thanks,
Taylor
