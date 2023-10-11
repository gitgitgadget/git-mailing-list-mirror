Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90CBCDB47F
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 19:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjJKTQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKTQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 15:16:28 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEA90
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:16:26 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77063481352so114137485a.1
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 12:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697051786; x=1697656586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BfHQ8LwXoVYICN/O79+J7d4FFpv5+8du/kzMNIVkis0=;
        b=tWqSvdE4H8Xu2pm7wZXwY5lZHC05z/9CyeRUN8kG/N12rCdn9v1NuFg8d8z4XPgmv7
         qqed4zELB+MbUC+KVRe9fqejZipjzBmCkTf0QUmU32IkXR2ES+xrWSR1/lsw+GZP9DRi
         FICL6YMCSgi4wA37IncIQPM09SbSktxTC9CCEx8r5JOl2fi/SFfok3RTTxeWnfnCPxUS
         MoMzKrn2lgEy1Gqs9ltD3trhPjjFEiM/UWtkRMF/wVe9UIYCMk6c3f9L6mbjvWVD6GZ/
         8uieJamfbuPgBwnGOXgTnxIyDGEQ+tvl1PRbwctiC1sTXLEHX63StW5wKhhp5LMfAt5v
         DFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697051786; x=1697656586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfHQ8LwXoVYICN/O79+J7d4FFpv5+8du/kzMNIVkis0=;
        b=RDYQ1r6qiDFYWu9mwTGlEA8B+Bqc1cFTIBbKRFtLl2jYvI8KwWX9dwWTN/GGfv6waN
         X7ceMw87yZKC2skp+4KEtnLrSWgsXSHhAszSN7psUZsoKYgZfi8NPo13RejH4oA+geUU
         rcVxmF076DSIsBiw51gl4A+hxXBhjVjd+Ku95wcbkf+AX/wUxa2KZ4ujAdBnZ3ECAIbX
         IgIcCYhzAJnhyiu/AWeDMHJo+pfRXgKgsZQ0jp7Bivlrv3guCwoYsvuiPde+zZGlcdWm
         0bZ42pOzr+Od4c8e1fAIxjhXKrC19N7JbxcGRHzu89OJKmxdxDZqECyzhFS78KN8Ct/Q
         1Chw==
X-Gm-Message-State: AOJu0Yzen/XsuwAXU7mp+CdAsh0Gj5aOu8DcToGdMP+aWynQ3IyRqbcE
        EkQLt6BIV/WR/xo8Gnq9iQLZG7/uyFeE6TuyfSIzjQ==
X-Google-Smtp-Source: AGHT+IFgRRMDv9rBE+2wf1rWfL/Bsbf37zoHO8RN5PJsCzhMhdaLaCCtIQsrT/CIas9uCU/z2HAkrg==
X-Received: by 2002:a05:620a:2802:b0:774:364c:4e36 with SMTP id f2-20020a05620a280200b00774364c4e36mr25959793qkp.37.1697051786000;
        Wed, 11 Oct 2023 12:16:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p10-20020ac8408a000000b004181f542bcbsm5553390qtl.11.2023.10.11.12.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 12:16:25 -0700 (PDT)
Date:   Wed, 11 Oct 2023 15:16:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 19/20] commit-graph: detect out-of-order BIDX offsets
Message-ID: <ZSb0iCFxYL3nymvJ@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210556.GS3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210556.GS3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:56PM -0400, Jeff King wrote:
> diff --git a/bloom.c b/bloom.c
> index 61abad7f8c..1474aa19fa 100644
> --- a/bloom.c
> +++ b/bloom.c
> @@ -75,6 +75,16 @@ static int load_bloom_filter_from_graph(struct commit_graph *g,
>  	    check_bloom_offset(g, lex_pos - 1, start_index) < 0)
>  		return 0;
>
> +	if (end_index < start_index) {
> +		warning("ignoring decreasing changed-path index offsets"
> +			" (%"PRIuMAX" > %"PRIuMAX") for positions"
> +			" %"PRIuMAX" and %"PRIuMAX" of %s",

Should this be marked for translation?

Otherwise this LGTM.

Thanks,
Taylor
