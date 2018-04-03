Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4141F404
	for <e@80x24.org>; Tue,  3 Apr 2018 19:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeDCTBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 15:01:39 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:39808 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDCTBh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 15:01:37 -0400
Received: by mail-pl0-f48.google.com with SMTP id s24-v6so10146238plq.6
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQ7OqHsHN5dMTICyKWWX41HOxlcKw+ktbX/pm9LpevI=;
        b=bGYy6F2+G7k+xh8IXU0hSh8y647mJRw3TXz2dIUPXHSguqF3yNtwgMowvcH5OdiC5J
         r/YlrnR1/fjGa/nDDACIY6171974VZNu4l5vrtg6sKUuwveBiQvYz7NU1tZeih8vmtlx
         OhCPrPYIKDVAVRxaRQETjd65gzf2sf/zOT9QzaKR2/5N0ExM/afb85d7k4ugC743gkiX
         9kOzKGKCCWgDbZ4WMzxTJRnknIfdkNffQUs/O+35ePdYXG62Z5z5kD1g4mDxjwO2X1gG
         ZR6i7IpKZW7xEbit/kg0PUVcm1Yl+bllh6ttb9Fm0/90sMmsMUn5f/s5FifdQfD97JZh
         wsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQ7OqHsHN5dMTICyKWWX41HOxlcKw+ktbX/pm9LpevI=;
        b=jVKziH/rnGGTMb8sZMMURRIzxgswvYYdAYYsc/VRyTdWpM7/mGqGTs89+Wx1/dSHqk
         h3SjqsrJ/KmtGORxXZ48fUruR16yeCIBNkrOm8EK4v+LsqETQ8CKqfWdKTZ3Y2ZaNhjR
         m1DuFe3nVIAK+7bNgEHYpJAcrfMLehN9+l+Cl73Xpv9AXze/dxSlyjzvJVsTYCg+3V09
         7230vWbeXbC0xMRvZ2qVDvdSVm0RJB5RKGI1i3aaAP2jvddx5ljSxBtaLsY+JRkmuQgj
         /5D23rnwc4lWi8fBkrFmww2QV86kWuidD+2nKSgj7kJF+xLxCCE4Zdkj0ms5X6suK05m
         PIxQ==
X-Gm-Message-State: ALQs6tAab1mBDxek79DDptbT9xKYYgU5QT/1MXFEb8YdNBMA440NmIv1
        cykqxgJHxcmaJw9Bg4BgK73tug==
X-Google-Smtp-Source: AIpwx491HWxgdPB08kRbPu2F2Gwn+zHEYhIozUy4peK+A+PK3O2RgPZtJM5ej2JJaEq0uj7ZXeupBA==
X-Received: by 10.101.66.139 with SMTP id j11mr3534935pgp.370.1522782095547;
        Tue, 03 Apr 2018 12:01:35 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id j3sm6711078pfj.60.2018.04.03.12.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 12:01:34 -0700 (PDT)
Date:   Tue, 3 Apr 2018 12:01:33 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 5/6] commit.c: use generation to halt paint walk
Message-Id: <20180403120133.a1327fae0475a6ad1467e364@google.com>
In-Reply-To: <20180403165143.80661-6-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-6-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:42 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> -static int queue_has_nonstale(struct prio_queue *queue)
> +static int queue_has_nonstale(struct prio_queue *queue, uint32_t min_gen)
>  {
> -	int i;
> -	for (i = 0; i < queue->nr; i++) {
> -		struct commit *commit = queue->array[i].data;
> -		if (!(commit->object.flags & STALE))
> -			return 1;
> +	if (min_gen != GENERATION_NUMBER_UNDEF) {
> +		if (queue->nr > 0) {
> +			struct commit *commit = queue->array[0].data;
> +			return commit->generation >= min_gen;
> +		}

This only works if the prio_queue has
compare_commits_by_gen_then_commit_date. Also, I don't think that the
min_gen != GENERATION_NUMBER_UNDEF check is necessary. So I would write
this as:

  if (queue->compare == compare_commits_by_gen_then_commit_date &&
      queue->nr) {
    struct commit *commit = queue->array[0].data;
    return commit->generation >= min_gen;
  }
  for (i = 0 ...

If you'd rather not perform the comparison to
compare_commits_by_gen_then_commit_date every time you invoke
queue_has_nonstale(), that's fine with me too, but document somewhere
that queue_has_nonstale() only works if this comparison function is
used.

> +		if (commit->generation > last_gen)
> +			BUG("bad generation skip");
> +
> +		last_gen = commit->generation;

last_gen seems to only be used to ensure that the priority queue returns
elements in the correct order - I think we can generally trust the
queue, and if we need to test it, we can do it elsewhere.
