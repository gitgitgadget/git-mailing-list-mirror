Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09FDC0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 22:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjGYWpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjGYWo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 18:44:56 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5763469B
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:40:23 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-583b47809beso43627907b3.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 15:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690324710; x=1690929510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJkfo2TKxXrDq8kUu7ZaN0Z7FSg9uWirTUp3iiXPyCU=;
        b=KRgzvhKVA20XXo5MrVv1PV26qLbYjPuUtg84pkEOd1cGA8gim7lfM/HtF5+RRpCmyV
         itZnas9jEmbLanH0lGdzWi6DnUnE4tBZSR6CQclvv6gRNhaBj4l+aTXMPM60ssYMK4d7
         JqqOT42oMQoV7TcB6u3Uv/LDnUDv03T9Mw5rvQBjjlF2NnNbb8ivz+xhSVW2h5fY1iAS
         LHT1018gdHRIU0huRNJNKm8d0WsRvhRSNX5iDSCGJug2H45TVYIO7SbcbLOL0lvTnHFR
         UZrFTEyvr1fiUoIP8bQ/S3q2LHwcpJcuCvAB9BjrIW+x0ac1N3mdIYMFqhfP9BaQNOTg
         vCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324710; x=1690929510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJkfo2TKxXrDq8kUu7ZaN0Z7FSg9uWirTUp3iiXPyCU=;
        b=Lp/Jf8RwM/DHvfG+RrFGTVdM22F2fhLaj7i7ByA5ZY5EdqnR7pUJmKVH+Nd7lFpReu
         HL9cV9YC2JnBFBESnYAOMPPUh8iafFTRi6ByRLUwhCJoVmU9HmDLyfGJ7PHpeALhgVXk
         cKNWgi7wfFLQlPOdLK+mGPWHHVHQ/FvNaJYl1S2S1R4k/y64xC70ROkvTyy1gx3bdxuR
         53QbaqP7MXCNVySJY1wBDOUeiAin3dpXQooq3PzHrUu4vvtwCkJMZek6FWDsE7V1bxQM
         jss73bNCUjY1Xj8DV5HtpCXJ1NsRR+wuzp5yuLy06xEvU38UM+SvC28X+ygKCrNZgLZX
         eBMg==
X-Gm-Message-State: ABy/qLbsTDan+XbexqxOqlbxRKPJXmTV431xeQcN7wPOSfzucYmNYSlO
        hUnEq7V9YmIwvButtXmuzjwmCw==
X-Google-Smtp-Source: APBJJlHavsNP/Gt0+aAsq0CcTOcAfG1jrH9pSrVBaCbVwWtQiqCNtxKxRP84zD2OhINZP2xZF4fPVw==
X-Received: by 2002:a0d:d955:0:b0:573:455e:2a61 with SMTP id b82-20020a0dd955000000b00573455e2a61mr494643ywe.23.1690324709807;
        Tue, 25 Jul 2023 15:38:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h184-20020a0dc5c1000000b0057736c436f1sm3791874ywd.141.2023.07.25.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:38:29 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:38:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/8] pack-objects: allow `--filter` without `--stdout`
Message-ID: <ZMBO5A0WxWystYyv@nand.local>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com>
 <20230724085909.3831831-2-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230724085909.3831831-2-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 10:59:02AM +0200, Christian Couder wrote:
> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects-filter-objects.sh
> index b26d476c64..2ff3eef9a3 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -53,6 +53,14 @@ test_expect_success 'verify blob:none packfile has no blobs' '
>  	! grep blob verify_result
>  '
>
> +test_expect_success 'verify blob:none packfile without --stdout' '
> +	git -C r1 pack-objects --revs --filter=blob:none mypackname >packhash <<-EOF &&
> +	HEAD
> +	EOF
> +	git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
> +	! grep blob verify_result
> +'

Just a couple of style nits here. It's a little strange (for me, at
least) to see the heredoc into a git process. I wonder if it might be
clearer to write something like:

    echo HEAD >in &&
    git -C r1 pack-objects --revs --filter=blob:none $packdir/pack <in

, but I could certainly go either way on that one. I am less certain
about redirecting the output into a file "packhash", only to cat it back
out.

Do later tests depend on the existence of this file? If so, then what
you have makes sense. If not, I would recommend storing the output in a
variable, which avoids both the I/O operation, and the unnecessary "cat"
sub-process.

Thanks,
Taylor
