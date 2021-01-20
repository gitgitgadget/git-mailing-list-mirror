Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1550C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717062339E
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbhATQG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391213AbhATQFO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:14 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCDCC061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:34 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c1so16596610qtc.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MpxTWFrdLIdnySvmhgmX+h6wa8U+flAOeYqhfYxuTmI=;
        b=fwaRncwtZJ+523kABcxJbUQTR4YuKp/c4nZSKi2heBbk32TwyLuTqd6O8DDvFlRpy7
         1raSRVHmERfOBh18GrUhnTHpux4C7OSCM7X80P1QZEKOCUkLTn9vQrzetLIY9bVNny8X
         wTpOK4Qm/PelUIwBaqQCa8Wbnjkr5RDNH0d0Oa2Ffgh1A15UZEeon8P/v7DsoCUiAHEa
         LxyHlZooGVJ/B1sXDweFJtV9PgLGm1oyZuSlnsPvyOzzVI3ifVXHwTWZ32SnKutTk6al
         aIjU+3nvqMVTs7V5JvbFNYJc4XTWZXd37lORWXhJZGGnRpJVtZ0pQjBb+orForvP/hOa
         uRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MpxTWFrdLIdnySvmhgmX+h6wa8U+flAOeYqhfYxuTmI=;
        b=QIV3aMd6RBpVgoehACodhQLHnsPWYHQ9AS27kP6L3yP/cFoBaZhnYrwgqVBaXCoSSw
         EJOdGI/j10g81Mb/Z22lHpA8ssXqRN7JnhhFRWziBF8m21n5G8QPaJVHsCYyR1r+pAio
         60rB+9qFEGcICapFMTIdbWMuxdrLlu4xX/G2/e1S1QZ+YomSvgrfbqROTB6vgXqyU5b7
         UVfix0emCFAAGp8Keg3op0T9T2RqcfT38gbMvqB7R5hL95sifNfIeDg38wr4zCta/rdP
         +wu3FTXsQ/qu+FTOfmcSLXw3getDzeWqf/8VLv1Q8rWzYUU9V1rmX+n9LB4nqk89HkjO
         +COQ==
X-Gm-Message-State: AOAM532kN/pZgDKxUDQixccfUojFXoMg7oLhp2NJfDMymNTTqY3+rAWm
        woPQjR1emnUgmCImnCSUgpa9y0qtgPrgfQ==
X-Google-Smtp-Source: ABdhPJwu/sR9OJ722C29teYohOaXK2T+u2tphkigp9rLQKA+85lSonusydzVu7OQTgJBxJifLtagVQ==
X-Received: by 2002:ac8:1094:: with SMTP id a20mr1960876qtj.248.1611158672872;
        Wed, 20 Jan 2021 08:04:32 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id m13sm1386959qtu.93.2021.01.20.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:04:32 -0800 (PST)
Date:   Wed, 20 Jan 2021 11:04:30 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     jacob@gitlab.com, peff@peff.net
Subject: [PATCH v2 3/3] ls-refs.c: traverse prefixes of disjoint "ref-prefix"
 sets
Message-ID: <b97dfb706fe7a94381a978fa9678dde0738106c2.1611158549.git.me@ttaylorr.com>
References: <cover.1611080326.git.me@ttaylorr.com>
 <cover.1611158549.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611158549.git.me@ttaylorr.com>
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

The callback 'send_ref' is resilient to ignore extra patterns by
discarding any arguments which do not begin with at least one of the
specified prefixes.

Similarly, the code introduced in b31e2680c4 is resilient to stop early
at metacharacters, but we only pass strict prefixes here. At worst we
would return too many results, but the double checking done by send_ref
will throw away anything that doesn't start with something in the prefix
list.

Finally, if no prefixes were provided, then implicitly add the empty
string (which will match all references) since this matches the existing
behavior (see the "no restrictions" comment in "ls-refs.c:ref_match()").

Original-patch-by: Jacob Vosmaer <jacob@gitlab.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ls-refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ls-refs.c b/ls-refs.c
index 367597d447..eaaa36d0df 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -110,7 +110,10 @@ int ls_refs(struct repository *r, struct strvec *keys,
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
