Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73EF1F954
	for <e@80x24.org>; Fri, 17 Aug 2018 22:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeHRCCr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 22:02:47 -0400
Received: from mail-yw1-f49.google.com ([209.85.161.49]:33351 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeHRCCq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 22:02:46 -0400
Received: by mail-yw1-f49.google.com with SMTP id w200-v6so1454559ywd.0
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCVHUSUuy8AlZKF4YuXFOn4fT2vUeG6TT/ecROhcP8E=;
        b=Xa30kR2jqhphHkHfv6vjASMdk+03m3gonuaoB54fBxMeg8P1cagV5rdCH1z2AYduNa
         v57SPH6m3DV8Py7oJMwwNoEiSp1Dcp0NOERGh3eQBHC0Fj4ZgKfBiKwhnZiPVgZb5so1
         xbSqYsTpFdhlxxgHEqEzI7NEizR+FmImwRsy+XZPAC2HctH6ELuxs6iahlHYZUMWa2Rf
         QgSFnU2Unk8HPCqzrhRDP1g7IzG7g/YGZPohN25/0Bgad/6QREPKWphSfIdu2eUKvdPX
         2bzbP6eWmAw2ReEMLhqkg058alDOk4ElotdunnhsfJWEmP840pUFfu83MFgVZNfMz7nN
         oG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCVHUSUuy8AlZKF4YuXFOn4fT2vUeG6TT/ecROhcP8E=;
        b=C5Gxgyd6nXGH7MLSqLFzoWxH/Q91K6V7uIjkUfxtIam+uRQeM5aLyqQFp3bsyrN0W+
         AyFbT3l8WXVMbUExdL5qBCJ7b4/swuHuVCRK+p/iBoGx0BAKKbcvtQERSNhB4iT1mEcQ
         I17yMhREGM432hGvoJhFsn4uAIqBgH5hWVsn55TvBTD86RlhsvVR6Obd6+A+lgWSN8Nv
         FSTeAzDLa+7LouUtmGaC8ksKACPsdJiAKKGyJPDhmqcmnL+lAXQOX8k0GF+Z5EXzPPBK
         guoE0YJPHooQHqeZEO9pIWxVIoBup+VBDLtUUQ/AiU8WQBayIccg9PJPCZ2AN7UiwEfD
         tG5Q==
X-Gm-Message-State: AOUpUlER4PWutdIDvdzxwUBv70+X88Kv1wNCJpaEa1cA2CMs4N4c5ksQ
        20SJzWOfQeDQAiijvWbapsjvtP/lgbxNjfGHn51Ptc9h
X-Google-Smtp-Source: AA+uWPxIcB5O4Vy0nGxZOP2JbvL66RuefiCH94x8obAIHj3w7krn+TEEvx72Kjd/zbEi/PZ7V4PsIe1DVjmOh20kbpc=
X-Received: by 2002:a81:9a17:: with SMTP id r23-v6mr21242728ywg.119.1534546649392;
 Fri, 17 Aug 2018 15:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180817205427.GA19580@sigill.intra.peff.net> <20180817210604.GF20088@sigill.intra.peff.net>
In-Reply-To: <20180817210604.GF20088@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Aug 2018 15:57:18 -0700
Message-ID: <CAGZ79kY9o_38WRX2TXC1JMA+9Y_ihf_jK8-f2pcYA+cYPF6B4A@mail.gmail.com>
Subject: Re: [PATCH 6/6] pack-objects: reuse on-disk deltas for thin "have" objects
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 2:06 PM Jeff King <peff@peff.net> wrote:
>
> When we serve a fetch, we pass the "wants" and "haves" from
> the fetch negotiation to pack-objects. That tells us not
> only which objects we need to send, but we also use the
> boundary commits as "preferred bases": their trees and blobs
> are candidates for delta bases, both for reusing on-disk
> deltas and for finding new ones.
>
> However, this misses some opportunities. Modulo some special
> cases like shallow or partial clones, we know that every
> object reachable from the "haves" could be a preferred base.
> We don't use them all for two reasons:

s/all/at all/ ?

> The first is that check_object() needs access to the
> relevant information (the thin flag and bitmap result). We
> can do this by pushing these into program-lifetime globals.

I discussed internally if extending the fetch protocol to include
submodule packs would be a good idea, as then you can get all
the superproject+submodule updates via one connection. This
gives some benefits, such as a more consistent view from the
superproject as well as already knowing the have/wants for
the submodule.

With this background story, moving things into globals
makes me sad, but I guess we can flip this decision once
we actually move towards "submodule packs in the
main connection".

>
> The second is that the rest of the code assumes that any
> reused delta will point to another "struct object_entry" as
> its base. But by definition, we don't have such an entry!

I got lost here by the definition (which def?).

  The delta that we look up from the bitmap, doesn't may
  not be in the pack, but it could be based off of an object
  the client already has in its object store and for that
  there is no struct object_entry in memory.

Is that correct?

> So taking all of those options into account, what I ended up
> with is a separate list of "external bases" that are not
> part of the main packing list. Each delta entry that points
> to an external base has a single-bit flag to do so; we have a
> little breathing room in the bitfield section of
> object_entry.
>
> This lets us limit the change primarily to the oe_delta()
> and oe_set_delta_ext() functions. And as a bonus, most of
> the rest of the code does not consider these dummy entries
> at all, saving both runtime CPU and code complexity.

Thanks,
Stefan
