Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D4BC001B0
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGSR1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjGSR1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 13:27:16 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B61FE2
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:27:04 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-577412111f0so77216537b3.0
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 10:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689787624; x=1692379624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q0Z8PYcbvvSTEBNFppNMp5aKFvrYj1UhtfkV6WoDMmA=;
        b=v9V7lWSRhyX4Eu39nkU544/g7iG75EECPTjekCJhLqiaOC2RnrBvHLytiCfuTJdxX+
         KnpQma9SMQ8+Np5FkJKvpseiF+ffrOsfZMsXV0500tGdGUopBEiC75OIoa9hFmxqilNO
         RA6dEHdq0a87MJ4u0DLFJmkhLmeWLrMzDp+7D+oTcvHc4Y46J4pDVPdRnrajeNa/EMR7
         dz2OyeP4cVusPtnWoT8dFSdI9SfAsZfp0I7gwMCI6JrHGIbntwBDhEvC7IQf0SH2ubiY
         Yw2Rty0yMFvCeD+hKBszRySHb7pmu8uWBOmhJVnm/dzKQoybctd84AgYtMoqijzT9co8
         sJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689787624; x=1692379624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0Z8PYcbvvSTEBNFppNMp5aKFvrYj1UhtfkV6WoDMmA=;
        b=DZKnCQLVOR6598ZmhnlWf+MInIe5UISAbLI32lqgcfJCHl9XM9Kb48BPwFiRLMFM5u
         f6119C79kr1w6qb0WBl7cPt0dpdo74JQf6ka5xU/zu099CcAq4X5UOqmfDKKc3W25FNd
         dzhJw6WySTKP4tqOhTH5I7mgFUTwlZvzMrSsfnvw6nx0qEE9jZu8Cs9rGM/OyHWCAZ85
         DlNPknA5jo1c6JkST44zVCe9nHTblIunwCE93N/7n1fttFWM+WDFufQOoSaS3Gu7WkLy
         /hqmkqMxiIApXh4tLa7WmbvDgrGZ+PgV7J20ojhUuW/muA/DMdRESR85ui5C3D+pUpXC
         LKQg==
X-Gm-Message-State: ABy/qLY9IvZcWZcPHKRrhisrEhV811PxsvMUaDPegqtun7yxbN8B9T0R
        bn4iaOfMEiSrEeIhBBIhHnrZEDD0D5FGevEOYAaXzQ==
X-Google-Smtp-Source: APBJJlFhMdVtrClpApbf4RD+v3nYgWSfNrN7e9xFDyWw9APBMuLV1pYk5C4HTBmZPLH74BGGfhC0yA==
X-Received: by 2002:a0d:eb49:0:b0:57a:69eb:7a06 with SMTP id u70-20020a0deb49000000b0057a69eb7a06mr5861314ywe.25.1689787624119;
        Wed, 19 Jul 2023 10:27:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m132-20020a0dca8a000000b00545a08184cesm1127773ywd.94.2023.07.19.10.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 10:27:03 -0700 (PDT)
Date:   Wed, 19 Jul 2023 13:27:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 2/4] t4216: test changed path filters with high bit
 paths
Message-ID: <ZLgc5q0FrL1s7j0j@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689283789.git.jonathantanmy@google.com>
 <94a4c7af38525d04f3effc035084e661fe382dcd.1689283789.git.jonathantanmy@google.com>
 <xmqq4jm7l92q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jm7l92q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 03:50:53PM -0700, Junio C Hamano wrote:
> > @@ -404,4 +404,51 @@ test_expect_success 'Bloom generation backfills empty commits' '
> >  	)
> >  '
> >
> > +get_bdat_offset () {
> > +	perl -0777 -ne \
> > +		'print unpack("N", "$1") if /BDAT\0\0\0\0(....)/ or exit 1' \
> > +		.git/objects/info/commit-graph
> > +}
>
> Hopefully the 8-byte anchoring pattern is unique enough at least for
> the purpose of this test script.

I had the same thought myself. I wonder if this would be more
straightforward to implement in a test-helper.

Thanks,
Taylor
