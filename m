Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3758CC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D1120724
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ZlapkSEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgDWVlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:41:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD648C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so3051947pju.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 14:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RTvKG1i9iSpQkXtkhMv9n7bFb2DzUwpr0ka+2ZBOaMc=;
        b=ZlapkSEGTQ1ogkjfrsD8ZM2RJBjU+DOEhSBipC84CC/u1STwnreY8//qqJJoLiFMnG
         wF1ZDzpJMW/1RncpCnEDtR1BtR3OQMul05bQdB2+rT+GA2v0M5Es4cw4rLcyL4F7MSdY
         EMb0AZwJp3H7wRYkmUX0zkOaOdU4ZhcHzKfoNbSeSAGgcfh0c18GjEg28NcRQx97o4+u
         xElNbtqbRzTxi4nnxmO30RGzjHh98kzKDJIa52Vpsjr3Byr9dBhRI5JMDavuMmPJkjHE
         pzyn482RVGEaYFQfYvFcHeGhJFm4gYl9hf+3n0KbLUwXGKERlVDTeTuty6HCvX48H4a/
         mWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RTvKG1i9iSpQkXtkhMv9n7bFb2DzUwpr0ka+2ZBOaMc=;
        b=RtkWc9zNqRX4vxZ6cv0VetiyiO3enobWfIhAdJ/YrKPDYpHZEpOBNzR6Ewd3fkrUZS
         L4n9RnpfnqD8ICX0YrA1qQpet+Nf6IHcgkr8KuLPzWF9dHQeMquMizfLJkACF7xAyAZG
         JUFyQMpRsDpKxIPmqZD8Moguvmr9FgUHnAcfKCRcFV0dd71Uk32cUKTCFfg0Zw/o51pi
         5OZMGGUxIULaSZ0NisNLfNr39po5K/yctw4j6ux9YApY8Z32F8IFrH0uSYXZsLifF1DY
         vEF7Uyej/S7owtuJ53U1s+0Vpn6Ck4/DuhM2mBgWD3Nesfjd6hgcYfzXiDLTO29vGFUL
         6Xjg==
X-Gm-Message-State: AGi0PuarjBA/qEQzq4JgY++vHCiZUFm0XCeAWg01pzZ/YCHM15bn0TBt
        j9oNHoXJo5jFkpKuoo0NhP27a7xtzYhS0Q==
X-Google-Smtp-Source: APiQypIWj1VdGx/4rCyg1HOTAbUYBZwirMtTH4Vnjmv1J7rx/2dlW6XRqLkoOSVzsvqHRnUBRwM74Q==
X-Received: by 2002:a17:902:fe03:: with SMTP id g3mr5727758plj.28.1587678063880;
        Thu, 23 Apr 2020 14:41:03 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id k1sm2887763pgh.72.2020.04.23.14.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 14:41:03 -0700 (PDT)
Date:   Thu, 23 Apr 2020 15:41:02 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, szeder.dev@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH 1/4] commit-graph.c: don't use discarded graph_name in error
Message-ID: <17dff6142e62d202794986f0bd51e4a8604f8e49.1587677671.git.me@ttaylorr.com>
References: <cover.1587677671.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587677671.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a commit-graph layer, we do so in a temporary file which is
renamed into place. If we fail to create a temporary file, for e.g.,
because we have too many open files, then 'git_mkstemp_mode' sets the
pattern to the empty string, in which case we get an error something
along the lines of:

  error: unable to create ''

It's not useful to show the pattern here at all, since we (1) know the
pattern is well-formed, and (2) would have already shown the dirname
when trying to create the leading directories. So, replace this error
with something friendlier.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index b8737f0ce9..afde075962 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1397,7 +1397,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		fd = git_mkstemp_mode(ctx->graph_name, 0444);
 		if (fd < 0) {
-			error(_("unable to create '%s'"), ctx->graph_name);
+			error(_("unable to create temporary graph layer"));
 			return -1;
 		}
 
-- 
2.26.0.113.ge9739cdccc

