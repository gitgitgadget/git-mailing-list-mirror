Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99248C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 17:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbjELRdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 13:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjELRde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 13:33:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F23D055
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:33:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-560f6723651so48356597b3.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 10:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683912812; x=1686504812;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovNXajCSewwDaPWskIaZcNFVsOWrsQTKYxCtlrsB608=;
        b=2Ez4T88Ki7bAKz+5EiqNpEaw+gp0H1fQs7+v6UJ5qP2LsG+y8yppv0qZ6clsZADff2
         dmYEV9uANzT2PD2y1C8gKug3Lr0rjVSUGl/PSpIwJxVFs+O2wAB8EZtyluA9YJgwAESo
         K8Eo00blj+o9ipQsvSxBg2nc9aBezY9e6gmNDXLm+vFbnBwiFALsZ0Wp0wxFIvLsbKx+
         eC9azuXrpvjH14+8Dei0VpF/SYa9YlP6Z3nqC0ClSZQ2ZEECslkHi4yjEZEPa5YXCm83
         DjKtP/iS/LTSmZXu5UhbaFwsedvIju0spesXWUbEEdEeVSaL6/mOPC7z6Sb9joLKdSTN
         itpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683912812; x=1686504812;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovNXajCSewwDaPWskIaZcNFVsOWrsQTKYxCtlrsB608=;
        b=RTnotb0J4u4uUf68y+PcaXySxZutZfj/MqHRJ8JK6Cud/1OTZs2SgcQWuwtyFzJo0p
         6ZwCb7l7CaNJv16/zPvPkBHdGMMu63Qwxxz82cknGjBYKvIBd06RUqrvXMEh8nvi4uJs
         dk6eiWVA8h4HhyHgzmeLLWWEj5uEUWyfsOvCv94d6EUSmNQuioXjWK+xCVRs2tcGfaex
         f0s1+eGT1LQk03vpZiWEJokRFV1E95ShnOKzlnMUIbwEPcSo98w7AqKMTN6mdCDMkXFi
         7kV95J0icNIxKI76XEmVPP7NM6KtELFev9db01jliY6VDxdDqaPN/naFldRdS9st67gC
         ML+g==
X-Gm-Message-State: AC+VfDzOTRD5oMERG3sEhuw14CdU1bzHYxoyEYOYmS2IseZnoWog8JPn
        MEsJZiYE4Sx1tONCVxfdzDBQ1ROK3gobEEKS1kXO
X-Google-Smtp-Source: ACHHUZ6iFy1GjyjVvn1ip3ZkaQ2A45VMM+XmaK+oNmoa67CqBaKvb3iUiItVzpuJw8u0FbakaFR7BOVtSvrje7EmYO9y
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:aa27:e943:1ce4:723f])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ae17:0:b0:561:2d82:7f07 with
 SMTP id m23-20020a81ae17000000b005612d827f07mr791470ywh.0.1683912812448; Fri,
 12 May 2023 10:33:32 -0700 (PDT)
Date:   Fri, 12 May 2023 10:33:29 -0700
In-Reply-To: <ZF116EDcmAy7XEbC@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512173330.1072880-1-jonathantanmy@google.com>
Subject: Re: Changed path filter hash differs from murmur3 if char is signed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        derrickstolee@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, May 11, 2023 at 03:51:16PM -0700, Junio C Hamano wrote:
> > If path filter hashing were merely advisory, in the sense that if a
> > matching data is found, great, the processing goes faster, but if
> > not, we would get correct results albeit not so quickly, a third
> > option would be to just update the implementation without updating
> > the version number.  But we may not be so lucky---you must have seen
> > a wrong result returned quickly, which is not what we want to see.
> 
> Right; from my understanding of Jonathan's message, I believe that we
> would get the wrong results if the implementation of not-quite-murmur3
> were corrected without updating the on-disk Bloom filters.

Yes - if the bloom filter contained junk data (in our example, created
using a different hash function on filenames that have characters that
exceed 0x7f), the bloom filter would report "no, this commit does not
contain a change in such-and-such path" and then we would skip the
commit, even if the commit did have a change in that path.

> We already have the bloom_filter_settings struct, which could also
> encode whether or not the data was computed with sign extension or not.
> If we are consistent in computing the hashes when we write Bloom filters
> and when we re-compute hashes to query them, I'd think we would be able
> to reuse the existing filters.
> 
> That would be nice to do if we could. Unfortunately, I don't think there
> is an easy way to determine the signed-ness of an existing set of Bloom
> filters, nor a guarantee that they all have the same signed-ness (IOW,
> the Bloom filters could have been built up across multiple copies of
> Git, each with different compiler settings).
> 
> So I'm not sure that that is a productive direction for us to take.

Agreed.

> > But if I recall correctly we made the file format in such a way that
> > bumping the version number is cheap in that transition can appear
> > seamless.  An updated implementation can just be told to _ignore_
> > old and possibly incorrect Bloom filters until it gets told to
> > recompute, at which time it can write a correct one with a new
> > version number.  So I would prefer your "Bump the version number and
> > ignore the old and possibly wrong data".
> 
> Version numbers are easy to increment, as is the case when adding new
> chunks to the chunked file format used by commit-graph,
> multi-pack-index, etc.
> 
> However, computing Bloom filters en-masse from scratch is fairly
> expensive. At GitHub when we were rolling out Bloom filters to all
> repositories a few years ago, I wrote 809e0327f5
> (builtin/commit-graph.c: introduce '--max-new-filters=<n>', 2020-09-18)
> to avoid spending too much time computing new filters from scratch.

Thanks for this pointer.

> If we do have to re-compute all of the filters from scratch, it may be
> worth considering enumerating all of the repository's paths first and
> seeing if any of them are >0xff. If none are, we can propagate the
> existing filters forward without having to compute new ones.

One way server operators can do this is by:
 - patching their Git to ignore the bloom filter version number
 - in a batch job, enumerate all trees and see their filenames
 - for the repos that have <=0x7f filenames, bump version number
 - update Git to the latest version (that uses the new hash)

Enumerating all trees saves on revision walking, which hopefully will
speed things up.

I don't have statistics on this, but if the majority of repos have
only <=0x7f filenames (which seems reasonable to me), this might save
sufficient work that we can proceed with bumping the version number and
ignoring old data.

> Better yet, we should be able to reuse existing Bloom filter data for
> paths that have all characters <=0xff, and only recompute them where
> necessary. That makes much more sense than the previous paragraph.

I would think that at the point that we know the paths that have been
changed for a commit, the cost of computation of the bloom filter (all
in the CPU) is negligible compared to the I/O it took for us to retrieve
all the paths (so the solution of just ignoring old data seems better
to me). But perhaps at large scales, we do want to save the computation
time anyway.
