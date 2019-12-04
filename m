Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F479C432C0
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 03:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A01206DB
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 03:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rllZunSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLDDzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 22:55:25 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:45776 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDDzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 22:55:25 -0500
Received: by mail-pf1-f170.google.com with SMTP id 2so2893423pfg.12
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=16f8KGM62EqDw9XIRd4GXwK3bilTQb5gxZ61LLZRLNE=;
        b=rllZunSLhtLUF2sl1KRmepuERhpw9nngvAOg3iba2XgZBuew+X5oZfb/mU2pD3OVjh
         dDYadY7yWAfQWWZwCy7eeIGrNMVtuXkBLusXkWbd7x451wl7vNRU9yM1ZR5Oml2ylqqt
         QtMclEmBts21liEpMeNhAeUY2tBYLRWcZi7IOm7lBv6oW5PhpUSYiOhq0b/ix+3Tocso
         V6h2kSgMdkf2lImSa1MAAerZRXfnjq1jQFSU+L0ebXYAripVIzWw8Nf8jnWbsDeRgvtn
         R+6TOqjN8yn02u6CDNHYpOXL+cazWRPOnUk6U/jJv6qJrlnxXKnQrRysjs/ckREoqv6/
         cObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=16f8KGM62EqDw9XIRd4GXwK3bilTQb5gxZ61LLZRLNE=;
        b=Cs7RV7jRgoFbmJoJQLneSvaZ6imrWaNKHRWHXjpePPoL1GnkpRtQbvOu4DvUjocoGR
         QsuMT9vTg4sNeoyjGX/NiUXNmwJsgPQPM8qJ9ABG2fsodJPuPK/ouX6Ly4FFChJjpLuP
         pui5E6lPYUozmW8bK9oG7PSPIxIPEbbVYdwe2EDCs0w4F3a5M4My27pIBrWg0yueUu0a
         ptKh/tBgMvX/I5e4Xm6Ub61ZoYBI0yUHD4SQ89hZsFXoYzPzioqyju/6b3RIxbliXLHn
         aVdc5HW2sPtY39wk0bnCnbjUb4iQTjIOp0SzYO6kr50VINbQ0qLQS8zLuXrj6c6/MuFP
         Pjmg==
X-Gm-Message-State: APjAAAXcVuunk4qeJRSd2KBHfXTqwvZ1zSydYmW+Tcjkx/xlJszSVGl/
        ixb+8z2edtCPMfcIk2z+g4Q=
X-Google-Smtp-Source: APXvYqypEArfzptmceOGCINXHHvT3yfrgRDVbIbPGyE/ZsR2LrpCAHWMsAKaE2o4CU76V3GYf9ZDWA==
X-Received: by 2002:a63:e94d:: with SMTP id q13mr1352610pgj.160.1575431724607;
        Tue, 03 Dec 2019 19:55:24 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i4sm5083809pgc.51.2019.12.03.19.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 19:55:23 -0800 (PST)
Date:   Tue, 3 Dec 2019 19:55:22 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     "Patrick Marlier (pamarlie)" <pamarlie@cisco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative
 objects
Message-ID: <20191204035522.GC214771@google.com>
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
 <20191127123211.GG22221@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127123211.GG22221@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

> Subject: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
>
> When pushing, we feed pack-objects a list of both positive and negative
> objects. The positive objects are what we want to send, and the negative
> objects are what the other side told us they have, which we can use to
> limit the size of the push.
>
> Before passing along a negative object, send_pack() will make sure we
> actually have it (since we only know about it because the remote
> mentioned it, not because it's one of our refs). So it's expected that
> some of these objects will be missing on the local side. But looking for
> a missing object is more expensive than one that we have: it triggers
> reprepare_packed_git() to handle a racy repack, plus it has to explore
> every alternate's loose object tree (which can be slow if you have a lot
> of them, or have a high-latency filesystem).

Nice analysis.

> This isn't usually a big problem, since repositories you're pushing to
> don't generally have a large number of refs that are unrelated to what
> the client has. But there's no reason such a setup is wrong, and it
> currently performs poorly.
>
> We can fix this by using OBJECT_INFO_QUICK, which tells the lookup
> code that we expect objects to be missing. Notably, it will not re-scan
> the packs, and it will use the loose cache from 61c7711cfe (sha1-file:
> use loose object cache for quick existence check, 2018-11-12).

On first reading, I wondered how this would interact with alternates,
since you had mentioned that checking alternates can be expensive.  Does
this go too far in that direction by treating an object as missing
whenever it's not in the local object store, even if it's available from
an alternate?

But I believe that was a misreading.  With this patch, we still do pay
the cost of checking alternates for the missing object.  The savings
is instead about having to *double* check.

Am I understanding correctly?

[...]
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> ---
> Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
> getting oids from the other side. But I think it could possibly benefit
> in the same way. Nobody seems to have noticed. Perhaps it simply comes
> up less, as servers would tend to have more objects than their clients?

I like to imagine that servers are also more likely to keep a tidy set
of packs and to avoid alternates.  But using INFO_QUICK when checking
the fetcher's "have"s does sound like a sensible change to me.

Thanks,
Jonathan
