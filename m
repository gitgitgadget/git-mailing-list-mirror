Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AFDC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 17:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjHJRo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjHJRoz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 13:44:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126582702
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 10:44:52 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-589addee1c1so11062417b3.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691689491; x=1692294291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SdKpvrCdrG++OYxPvy6ZplBH8apr9MyVYSPQdomqng=;
        b=GrC1j0keGEDNkEDn6BB+OQPgfqxsH56D5ykUAqvGIxbVJ8ky1G7qysZsIZj1bgTqsU
         X6yN/GdNHj51Of5cmudpKqfpGg/mAZWeuyOnglmmC2oQyWnCnwVM3HDPb3U2CS+T7Rnn
         fZ1Afh2Wqu5W8FgsDhgLFoduQmvfYdEZc1K4nEWgeZfUF9tz7PTCb8prAo61zfWpluzd
         F0HG8upOwsxic0j3hFvjtTSLv2Nfd0WiW7eu92hunKBTnVjHNlyn55VYHUtAaXZEjeBs
         5A3WleGRN3lcFabwkFGAQAzZ/aXGddglS+IVXlhfyHetP8REB37qI+uPuTThsLLvc+ch
         I3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691689491; x=1692294291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SdKpvrCdrG++OYxPvy6ZplBH8apr9MyVYSPQdomqng=;
        b=S4W/c+t6dF3sGmIkcnB65/PXOGE0Cy/PIz720e8yXRlrxsR0pA2sTpdvsG0s05go6B
         zTMYt3jC4SmOkTonvL2naj6iNUJnIY6/gF7ghxDZ9pUVhIMlN2OgVKwu6O/oTL7+r/su
         emFa5dFI7BMqpbQx8SWs0XogiWXY/LOUyFJqzzg4hbUnIMZt6ejjT+lam7pnScBIaTv1
         Mxuhrpp/HfDLAVOYihuYh30XTN4W2Yro8V+0b3HMyf4/ojbn9q9jaEjeGXR+xEvlUPti
         iStxusiEKTvMQrOraStYvUHKzbpA+os3GP4/mEwrRhPsO/KySdXrhxUQE33h478ihnvo
         ORuA==
X-Gm-Message-State: AOJu0YzF2Z4tUTNTru9a5KRx2KJ/0RE5+frn3bCl4FSN6NgXBmmURbi1
        71EWZvkqAfDGkKCZRG8j1akuzQ==
X-Google-Smtp-Source: AGHT+IHbmWa3LTHt+xpBsi0QLQdQT79OVnuRW0iyqprd1yqXN4bdO0MsJxb/jZ6nP32KXrxgBTZmOg==
X-Received: by 2002:a0d:ee81:0:b0:57a:2250:f5c0 with SMTP id x123-20020a0dee81000000b0057a2250f5c0mr3843028ywe.19.1691689491181;
        Thu, 10 Aug 2023 10:44:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x1-20020a818701000000b005707d7686ddsm471580ywf.76.2023.08.10.10.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:44:50 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:44:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [RFC/PATCH] commit-graph: verify swapped zero/non-zero
 generation cases
Message-ID: <ZNUiEXF5CP6WMk9A@nand.local>
References: <20230808191536.GA4033224@coredump.intra.peff.net>
 <ZNUJq2nFEDHwrF0U@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNUJq2nFEDHwrF0U@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 12:00:43PM -0400, Taylor Blau wrote:
> > There's a matching GENERATION_NUMBER_EXISTS value, which in theory would
> > be used to find the case that we see the entries in the opposite order:
> >
> >   1. When we see an entry with a non-zero generation, we set the
> >      generation_zero flag to GENERATION_NUMBER_EXISTS.
> >
> >   2. When we later see an entry with a zero generation, we complain if
> >      the flag is GENERATION_NUMBER_EXISTS.
> >
> > But that doesn't work; step 2 is implemented, but there is no step 1. We
> > never use NUMBER_EXISTS at all, and Coverity rightly complains that step
> > 2 is dead code.
>
> So I think the missing part is setting GENERATION_NUMBER_EXISTS when we
> have a non-zero generation number from the commit-graph, but have
> generation_zero set to GENERATION_ZERO_EXISTS (IOW, we have seen at
> least one commit with generation number 0).
>
> --- 8< ---
> diff --git a/commit-graph.c b/commit-graph.c
> index 0aa1640d15..935bc15440 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2676,9 +2676,11 @@ static int verify_one_commit_graph(struct repository *r,
>  				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
>  					     oid_to_hex(&cur_oid));
>  			generation_zero = GENERATION_ZERO_EXISTS;
> -		} else if (generation_zero == GENERATION_ZERO_EXISTS)
> +		} else if (generation_zero == GENERATION_ZERO_EXISTS) {
>  			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
>  				     oid_to_hex(&cur_oid));
> +			generation_zero = GENERATION_NUMBER_EXISTS;
> +		}
>
>  		if (generation_zero == GENERATION_ZERO_EXISTS)
>  			continue;
> --- >8 ---

OK, I investigated this a little bit more and now I think I understand
fully what's going on here.

There are a couple of things wrong with the diff that I posted above.
First, it has a logic error that we should set GENERATION_NUMBER_EXISTS
when we have a non-zero generation number from the graph, regardless of
whether or not GENERATION_ZERO_EXISTS is set (like how it is done in
your patch).

But more importantly, we'll never end up in the first arm of that
conditional as-is (the one that fires for when we see a generation
number of zero) as a consequence of 2ee11f7261 (commit-graph: return
generation from memory, 2023-03-20), which only returns non-zero
generation numbers (or GENERATION_NUMBER_INFINITY, which is also
non-zero).

I think you want something like `commit_graph_generation()` that returns
whatever is in `data->generation` regardless of whether or not it is
zero valued. You'd then want to use that function instead of calling
commit_graph_generation() directly.

> > So I kind of wonder if there's something I'm not getting here. Coverity
> > is definitely right that our "step 2" is dead code (because we never set
> > NUMBER_EXISTS). But I'm not sure if we should be deleting it, or trying
> > to fix an underlying bug.
>
> I think that above is correct in that we should be fixing an underlying
> bug. But the fact that this isn't caught by our existing tests indicates
> that there is a gap in coverage. Let me see if I can find a test case
> that highlights this bug...

Doing the above allows me to write these two tests on top of your patch,
which both pass:

--- &< ---
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4df76173a8..8e96471b34 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -450,14 +450,15 @@ GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
+GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
 GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
+GRAPH_BYTE_COMMIT_GENERATION_LAST=$(($GRAPH_BYTE_COMMIT_GENERATION + $(($NUM_COMMITS - 1)) * $GRAPH_COMMIT_DATA_WIDTH))
 GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
-GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
@@ -596,11 +597,6 @@ test_expect_success 'detect incorrect generation number' '
 		"generation for commit"
 '

-test_expect_success 'detect incorrect generation number' '
-	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"commit-graph generation for commit"
-'
-
 test_expect_success 'detect incorrect commit date' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
 		"commit date"
@@ -622,6 +618,16 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '

+test_expect_success 'detect mixed generation numbers (non-zero to zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION_LAST "\0\0\0\0" \
+		"but non-zero elsewhere"
+'
+
+test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\0\0\0\0" \
+		"but zero elsewhere"
+'
+
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
--- >8 ---

Note that we remove the duplicate "detect incorrect generation number"
test, which was originally introduced in 1373e547f7 (commit-graph:
verify generation number, 2018-06-27), but was modified in 2ee11f7261.

That test is replaced by the latter "non-zero to zero" variant.

Thanks,
Taylor
