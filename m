Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4DDC433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD00A233EE
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbhATQI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391183AbhATQFA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:00 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B469C0613D6
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h22so1159537qkk.4
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gPf45UX+u3kdlPI0JKzBORjRIslsSGGCmhXixGdvy04=;
        b=mZ7TF55WgTInHaFJQuYqYXozgeQ9SFVO9OpgxdpG2SHNiUcYeZwqf10L89Q7l6Wnzu
         j82LYVqZIEMOmHKdcDl8QpL53NMolq0Do9dCLXsb/MWjF20s9NpH0KP5PkvbHx4dbyXR
         r6FKW7A0cvC3rKTTpfDqBLAvAtQ2+Uai3BybkKos57StvKh2i0p5eUaV/wVmdWJgpnM4
         pNJbA83Mrhsx8OAEW/BorB99NsfW/OYDNU9/KERmaN6aQreyAxmTiOuRY+E4dBaLf9/0
         wn5ETt2hdv56GY3YZhDAtI2NTn7B+bllNKHYYQ740JJY008LW96OpiRC52wIx5vp7B3F
         4NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gPf45UX+u3kdlPI0JKzBORjRIslsSGGCmhXixGdvy04=;
        b=mbBg3/h7QUWJnUNgc80bL0OrTU+aG/uHTIgaSwrfkTyqLDz6Hk/PN/2DpAwUVRyPVq
         +Tq/HaSw0clQBOUi6yey8kT1VJDYWO3+l6mfM1aCN/uuTHkhHyFUfdDJqIVUNpnrmHUz
         r5mxtc2Sx0zAmBRAVCBWXXS51ZMHGhxi7gBlAyMd31umpWKikfKrxee1cZWm3ABU8zU/
         biKJRXwUfdfsYbz2yOQmkyO8TEsdXAGvNS/UoeiQ2CNS//ULpUrLzmvKKAX1SmLrkSAi
         kClwFz2UHv+0rOw9ck2SuuG8/H2vZ8YsFJ+jJGDRy1mDjGYMew/XboQGKsZ20U7lj44t
         Xasg==
X-Gm-Message-State: AOAM531PQIQTqJpY3XrND07q3Xi/5HDdR54dX/RmzXF3pih2MEoyVv/2
        OBh+wONRbhynwUv5EltXB/IFiS56OoScrg==
X-Google-Smtp-Source: ABdhPJzELJGffNkGTjsHDFK3igEaA4Gqo67Kdv2iCQifDtzw7JYZvnJbtoRKHUZz+LBernESE4X6nA==
X-Received: by 2002:a37:9205:: with SMTP id u5mr10293720qkd.345.1611158658954;
        Wed, 20 Jan 2021 08:04:18 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id b12sm1429908qtj.12.2021.01.20.08.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:04:18 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:04:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH v2 0/3] ls-refs: traverse prefixes of disjoint "ref-prefix"
 sets
Message-ID: <cover.1611158549.git.me@ttaylorr.com>
References: <cover.1611080326.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611080326.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of the series I sent yesterday to traverse the
longest-common prefixes of disjoint sets containing the ref-prefix
arguments to ls-refs.

Not much has changed last time, except some clarification about what
'for_each_fullref_in_prefixes()' can yield, and splitting out the last
patch into one from Jacob and one from me. I've forged his sign-off
since it contains his original code, but it includes a new patch
description from me.

Jacob Vosmaer (1):
  ls-refs.c: initialize 'prefixes' before using it

Taylor Blau (2):
  refs: expose 'for_each_fullref_in_prefixes'
  ls-refs.c: traverse prefixes of disjoint "ref-prefix" sets

 ls-refs.c    |  6 +++-
 ref-filter.c | 74 ++------------------------------------------
 refs.c       | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 refs.h       |  9 ++++++
 4 files changed, 103 insertions(+), 73 deletions(-)

Range-diff against v1:
1:  d4c8d059f6 ! 1:  bda314fe7a refs: expose 'for_each_fullref_in_prefixes'
    @@ Commit message
         common prefix of among a set of refspecs, and then to iterate all of the
         references that descend from that prefix.

    -    The subsequent patch will want to use that same code from ls-refs, so
    +    A future patch will want to use that same code from ls-refs.c, so
         prepare by exposing and moving it to refs.c. Since there is nothing
         specific to the ref-filter code here (other than that it was previously
         the only caller of this function), this really belongs in the more
         generic refs.h header.

    +    The code moved in this patch is identical before and after, with the one
    +    exception of renaming some arguments to be consistent with other
    +    functions exposed in refs.h.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## ref-filter.c ##
    @@ refs.h: int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
      			unsigned int broken);

     +/**
    -+ * iterate all refs which are descendent from the longest common prefix among
    -+ * the list "patterns".
    ++ * iterate all refs in "patterns" by partitioning patterns into disjoint sets
    ++ * and iterating the longest-common prefix of each set.
    ++ *
    ++ * callers should be prepared to ignore references that they did not ask for.
     + */
     +int for_each_fullref_in_prefixes(const char *namespace, const char **patterns,
     +				 each_ref_fn fn, void *cb_data,
-:  ---------- > 2:  5fc081b2d5 ls-refs.c: initialize 'prefixes' before using it
2:  fb8681d128 ! 3:  b97dfb706f ls-refs.c: traverse longest common ref prefix
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    ls-refs.c: traverse longest common ref prefix
    +    ls-refs.c: traverse prefixes of disjoint "ref-prefix" sets

         ls-refs performs a single revision walk over the whole ref namespace,
         and sends ones that match with one of the given ref prefixes down to the
    @@ Commit message
         disjoint pattern prefixes, 2019-06-26) which does an analogous thing for
         multi-patterned 'git for-each-ref' invocations.

    -    The only difference here is that we are operating on ref prefixes, which
    -    do not necessarily point to a single reference. That is just fine, since
    -    all we care about is finding the longest common prefix among prefixes
    -    which can be thought of as refspecs for our purposes here.
    -
    -    Similarly, for_each_fullref_in_prefixes may return more results than the
    -    caller asked for (since the longest common prefix might match something
    -    that a longer prefix in the same set wouldn't match) but
    -    ls-refs.c:send_ref() discards such results.
    -
    -    The code introduced in b31e2680c4 is resilient to stop early (and
    -    return a shorter prefix) when it encounters a metacharacter (as
    -    mentioned in that patch, there is some opportunity to improve this, but
    -    nobody has done it).
    -
    -    There are two remaining small items in this patch:
    -
    -      - If no prefixes were provided, then implicitly add the empty string
    -        (which will match all references).
    -
    -      - Since we are manually munging the prefixes, make sure that we
    -        initialize it ourselves (previously this wasn't necessary since the
    -        first strvec_push would do so).
    +    The callback 'send_ref' is resilient to ignore extra patterns by
    +    discarding any arguments which do not begin with at least one of the
    +    specified prefixes.
    +
    +    Similarly, the code introduced in b31e2680c4 is resilient to stop early
    +    at metacharacters, but we only pass strict prefixes here. At worst we
    +    would return too many results, but the double checking done by send_ref
    +    will throw away anything that doesn't start with something in the prefix
    +    list.
    +
    +    Finally, if no prefixes were provided, then implicitly add the empty
    +    string (which will match all references) since this matches the existing
    +    behavior (see the "no restrictions" comment in "ls-refs.c:ref_match()").

         Original-patch-by: Jacob Vosmaer <jacob@gitlab.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## ls-refs.c ##
    -@@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
    - 	struct ls_refs_data data;
    -
    - 	memset(&data, 0, sizeof(data));
    -+	strvec_init(&data.prefixes);
    -
    - 	git_config(ls_refs_config, NULL);
    -
     @@ ls-refs.c: int ls_refs(struct repository *r, struct strvec *keys,
      		die(_("expected flush after ls-refs arguments"));

--
2.30.0.138.g6d7191ea01
