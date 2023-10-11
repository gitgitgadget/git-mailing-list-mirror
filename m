Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F24CDB475
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjJKSl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjJKSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:41:26 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22890
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:41:25 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41983b83e53so1121641cf.2
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697049684; x=1697654484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPhmtKWrn9FYr+85kkbrgHWnCjiBFLOW8+jtPp9oyPE=;
        b=TYA8Wz77TVXaRjkuvtauyz7spIpxntYgwY86b/3boakco7f6/XXHJaYYD6Vbq85Yu8
         YvKCZyOBoXjtxvNKnHFGgR5s3tmyBqIhu6DUa+JDO58Rv/SnQbCRwcfBnhXPxxNGhDY/
         GYC7OwQo+ia3Li+f8Gr49yL1r5QUePCjCAyAo3ilQrDXwMhvNKivGQrAIjMfmAjXmx+9
         4cGktJ2z5g1PxrpxSaY/F+nQuh7T1gWaKve4WUt7i/+BZFY/y8YPd7NwQfNlEJc1ZGX1
         y29uUatyV90DnUu5Ko+yEMviTxNUN91c4iJVHqqv9T3jAV813HoeJ0dm3+00LGjDrekB
         hO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049684; x=1697654484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPhmtKWrn9FYr+85kkbrgHWnCjiBFLOW8+jtPp9oyPE=;
        b=jsMrTuDq36vInAbR/eVgnbe2AfusAx9CPYAnGsH2XI4FPvh/HmLdobpOe+iSVca2/S
         6lKKDJn8663THBo2OJF6TPoXHjdsCacW1hII6Vrp9ffJGv3J3TVseNvGL7iExGwY+n2X
         tsr7qvvcHgV2Zp3jNt6x1v3pJMhr0Lsg4mgVRHMkW/55zfxzP6Kic/0LLXnQDn0wvJx1
         eDemv+IrWKX0D2EhQV7fYu/wSh3zcICboPDliq7IczVNV4gwnuArYqBxbylkqQN8Ezpq
         JmvKLSh9gWwgtHWhEI0Zquap9KsAHICDo8cJSaN1UwF31aumn8TP9CdXdpuTsPzMSIHG
         xdqw==
X-Gm-Message-State: AOJu0YzRuSVMTt5ZhJ22M0VUGhLU76aDFtoAWV3ISON1EWTmHRQUUeSa
        jKQIfBoDkpM4pknSC2iVdfQl/v3Fv1Ot+i3ck1Ag1g==
X-Google-Smtp-Source: AGHT+IEjGIN5db+MlImQXEoUXyM0zK3iO3aG6/q53XlEwd16/1v0iCwhDb0rh9yJx88Yj217cjQ1tw==
X-Received: by 2002:ac8:5f90:0:b0:412:395c:e794 with SMTP id j16-20020ac85f90000000b00412395ce794mr26677227qta.50.1697049684341;
        Wed, 11 Oct 2023 11:41:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x6-20020ac85386000000b004198ae7f841sm5523325qtp.90.2023.10.11.11.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:41:23 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:41:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/20] midx: check size of revindex chunk
Message-ID: <ZSbsUQyA71AGMkhl@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210533.GK3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210533.GK3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:33PM -0400, Jeff King wrote:
> +static int can_use_midx_ridx_chunk(struct multi_pack_index *m)
> +{
> +	if (!m->chunk_revindex)
> +		return 0;
> +	if (m->chunk_revindex_len != st_mult(sizeof(uint32_t), m->num_objects)) {
> +		error(_("multi-pack-index reverse-index chunk is the wrong size"));
> +		return 0;
> +	}
> +	return 1;
> +}

This all looks good to me. I was going to suggest that it might be worth
just NULL-ing out the chunk_revindex field here altogether. I think that
we have some prior art for doing that in the commit-graph code (though
I'd have to look to be sure...), but that's all within the same
compilation unit.

Having the pack-revindex machinery NULL out a field of the MIDX
structure feels icky to me, so I think that having a "can we use this
function?" instead makes much more sense.

Thanks,
Taylor
