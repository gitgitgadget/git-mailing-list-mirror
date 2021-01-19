Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C7C43331
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59AE922AAA
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733193AbhASSWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 13:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392531AbhASSUC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 13:20:02 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F6C061757
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 10:19:20 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v5so14381421qtv.7
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 10:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hi4N2WNwddO33w2ira543eAG0bSqGyiGjl0UrnoQOCU=;
        b=riaju/HPvsymt20f+bdw+Bl8g/VQH/DD3Q455q7EWI8YzRs2ZR0Gq2Xb5I2Mkm057c
         3eaa880jit/CIZ/IOpjtncGGMK5pEftp1GmOiCXX2xKJDOyF7825XofJc8SO0+JFNySb
         q3yFcI91JoDwj9v82hFEgEs9iSPb4UB3oCmMPRKFwbQgFY6ElXgVELtG8oLnmdRyKIRL
         N1aWo+DFMwZdfW72JLwnG7YnJ01Zl0+tBkHDqB9rD5IVGTgJVUyJyLn9VldxfG/eBoPK
         0F617rAKyFeqnBqvYUEpC0I7XzaOkmZidoEiTqhkLesDL5XHNSo1Sdt2un9EAXzauUiF
         GF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hi4N2WNwddO33w2ira543eAG0bSqGyiGjl0UrnoQOCU=;
        b=qLfKRym99/1HWaFRkkLYD8QKvoa0j8C+DdSCpj4tHwmFevG9G2Sv651ZCffjnlLiGI
         IPJ3YLJFWDL0/TSuYkMKc5O6FnarLdzMbtKn8ktPz9vaCf6SK0YBJu0khhnfYvCpp8h7
         QtuVQnGrSD7Q8nPhSvhJK3ym29+eheu87XD+6U4sp7yPpCgaiHeRJiHWFxjdWxhxZqe6
         iQohUVmIs8NAv1Ix4X5zFfBE0kOfOG1YPq+X901PMzhYL7VboQnjkmNTTqEjccrbyxJw
         jv4aG1tS+loyQXCCOFkUhdGtzuA3xDjj5DUWLoergQo3rASsfuWTV0QDuiZ85//P7KjQ
         zj6A==
X-Gm-Message-State: AOAM531YnMT6Yh1oTB0LSjDB/pCFe+k1fND0CPHv5NuQPkdMY3fPy21A
        9CRFZOc1X2/Ek2MDizehNTKF09BhD31P0g==
X-Google-Smtp-Source: ABdhPJyERZgMvqZGDcTWRfaY7bWtY3Tetip3RJUqzUMjnpz2YnVW97qV79by/AADlC/sc6Bwvk3gmA==
X-Received: by 2002:ac8:6d05:: with SMTP id o5mr5571018qtt.6.1611080359648;
        Tue, 19 Jan 2021 10:19:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id k64sm13623723qkc.110.2021.01.19.10.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 10:19:19 -0800 (PST)
Date:   Tue, 19 Jan 2021 13:19:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH 2/2] ls-refs.c: traverse longest common ref prefix
Message-ID: <fb8681d12864d724108c524834f9498d91e270e6.1611080326.git.me@ttaylorr.com>
References: <CADMWQoPREhirr+RJPkJJV2U+8VG=DFotvTBCDSXFhn-3pn2X-A@mail.gmail.com>
 <cover.1611080326.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611080326.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ls-refs performs a single revision walk over the whole ref namespace,
and sends ones that match with one of the given ref prefixes down to the
user.

This can be expensive if there are many refs overall, but the portion of
them covered by the given prefixes is small by comparison.

To attempt to reduce the difference between the number of refs
traversed, and the number of refs sent, only traverse references which
are in the longest common prefix of the given prefixes. This is very
reminiscent of the approach taken in b31e2680c4 (ref-filter.c: find
disjoint pattern prefixes, 2019-06-26) which does an analogous thing for
multi-patterned 'git for-each-ref' invocations.

The only difference here is that we are operating on ref prefixes, which
do not necessarily point to a single reference. That is just fine, since
all we care about is finding the longest common prefix among prefixes
which can be thought of as refspecs for our purposes here.

Similarly, for_each_fullref_in_prefixes may return more results than the
caller asked for (since the longest common prefix might match something
that a longer prefix in the same set wouldn't match) but
ls-refs.c:send_ref() discards such results.

The code introduced in b31e2680c4 is resilient to stop early (and
return a shorter prefix) when it encounters a metacharacter (as
mentioned in that patch, there is some opportunity to improve this, but
nobody has done it).

There are two remaining small items in this patch:

  - If no prefixes were provided, then implicitly add the empty string
    (which will match all references).

  - Since we are manually munging the prefixes, make sure that we
    initialize it ourselves (previously this wasn't necessary since the
    first strvec_push would do so).

Original-patch-by: Jacob Vosmaer <jacob@gitlab.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ls-refs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index a1e0b473e4..eaaa36d0df 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -90,6 +90,7 @@ int ls_refs(struct repository *r, struct strvec *keys,
 	struct ls_refs_data data;
 
 	memset(&data, 0, sizeof(data));
+	strvec_init(&data.prefixes);
 
 	git_config(ls_refs_config, NULL);
 
@@ -109,7 +110,10 @@ int ls_refs(struct repository *r, struct strvec *keys,
 		die(_("expected flush after ls-refs arguments"));
 
 	head_ref_namespaced(send_ref, &data);
-	for_each_namespaced_ref(send_ref, &data);
+	if (!data.prefixes.nr)
+		strvec_push(&data.prefixes, "");
+	for_each_fullref_in_prefixes(get_git_namespace(), data.prefixes.v,
+				     send_ref, &data, 0);
 	packet_flush(1);
 	strvec_clear(&data.prefixes);
 	return 0;
-- 
2.30.0.138.g6d7191ea01
