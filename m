Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC0C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF8F61166
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFWQ6z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFWQ6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 12:58:55 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FBAC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 09:56:37 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r12so4324094ioa.7
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w3W3q/MPC18YL9uhlGjGT718ibrPrYdv/vMVMqF+3tE=;
        b=pkT7LQDHM0XNsqk4bUm7oqDFgOez/ZZFElXhSpZOmW6gJlyUBxVu/0RF8bEmnixV3h
         QJWiXaS+BnoCPJ+hiTlFrcv2axuDithm6xOLUOf2RM3HuxL4aWl+5SDAXP/wEl+AfYoq
         kbkuGTw6Dr0ChnkMz6t2QZtxwOsMUe5d7GfE/4/bonpozEdHaQEyLEtqDjSVNj6Kgwh5
         EgDbcjAG7feklGuVApYbcVwQKusndZPJ3MQjezB5zcqDoofoA3NLhSB4blv88skqCmu2
         kgonRO5SBnlI7DHpssw2yT2bEcWMfP2V/ekdlYDzBOr3DCqC5UbooKNd60cAA7AG0kOa
         5mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w3W3q/MPC18YL9uhlGjGT718ibrPrYdv/vMVMqF+3tE=;
        b=eN0sFFxmaKH/eOBSyepVMrAviHB8xEhH+YjpJbJt6uro5pyhLQNk4txHYs6p5qQnT2
         PtVFG/PP/nLmWpFXi37edjOtw4FSBwGFVwcPJ8rzhwQ17GnbbGsypDzdwPpPzAgybQ95
         dJWmIZholrCMZZoqw0COHvzoY9E+0WUD3codNhudtM0VAV8tukI9t4KSB5NUkGXhr3MC
         9ESrRDJZpAw3YH36nfOXWJpNo9PSKaJCkZgKiFm4KV4IgtNdtXBWHMTRX+shSETSarKl
         UNSXNkaZ6gO+tpE+/H3Pl6UR2RvZux6Dd8+AIRhj4uWRjy6ZbxGHNN2edIyvtBXqAwTP
         YdZA==
X-Gm-Message-State: AOAM533T/6FDAPARVIo+Wk2lPemH/A3PHO27auXSmIeYtxTntgmL9K2S
        ZXsxlJUOktKJBkG/DsF1XIckHfyruRHl5HmJ
X-Google-Smtp-Source: ABdhPJxvd85BP60bch80cJIY4DCwh7hPpcVw+kyi8GxKpn9SGBhDCrO9k7aiLZIHJP8TGsI7t5aDLw==
X-Received: by 2002:a5e:940a:: with SMTP id q10mr412394ioj.19.1624467396053;
        Wed, 23 Jun 2021 09:56:36 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:827b:778a:e73b:3ade])
        by smtp.gmail.com with ESMTPSA id a9sm267150ilp.42.2021.06.23.09.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:56:35 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:56:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Mike Moreton <mmoreton@lifesize.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: git-fetch man page does not document --filter
Message-ID: <YNNnwm3xxstHMn1M@nand.local>
References: <DM6PR15MB359467B7277CDA31029A6630BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
 <DM6PR15MB35943E5232F67765D4FAFFD1BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR15MB35943E5232F67765D4FAFFD1BB089@DM6PR15MB3594.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 09:36:53AM +0000, Mike Moreton wrote:
> See subject.  Looking at https://git-scm.com/docs/git-fetch

Thanks for noticing. It seems like an oversight to me, so I added a
little bit of text in the patch below.

--- >8 ---

Subject: [PATCH] Documentation/git-fetch.txt: add documentation on '--filter'

`git fetch` accepts a `--filter=<spec>` option, but does not document
it. Make sure that git-fetch(1) mentions that --filter is accepted.

The documentation itself is just the first and last sentence of what is
mentioned in git-clone(1), with an additional detail about interacting
with non-promisor remotes.

Reported-by: Mike Moreton <mmoreton@lifesize.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/fetch-options.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 9e7b4e189c..52755572a9 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -11,6 +11,16 @@
 	Use an atomic transaction to update local refs. Either all refs are
 	updated, or on error, no refs are updated.

+ifndef::git-pull[]
+--filter=<filter-spec>::
+	Use the partial clone feature and request that the server sends
+	a subset of reachable objects according to a given object
+	filter. When using a `--filter` while fetching from a
+	non-promisor remote, that remote is registered as a promisor.
+	For more details on filter specifications, see the `--filter`
+	option in linkgit:git-rev-list[1].
+endif::git-pull[]
+
 --depth=<depth>::
 	Limit fetching to the specified number of commits from the tip of
 	each remote branch history. If fetching to a 'shallow' repository
--
2.31.1.163.ga65ce7f831

