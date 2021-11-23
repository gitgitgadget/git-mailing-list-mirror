Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44602C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhKWBdE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhKWBdD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:33:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BFCC061748
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:29:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id t5so85251606edd.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6EJCH/VJb85grHpqtR2bsUx/l8YP7RHsS7oHvkfa1wE=;
        b=F+CogKoxllRTAFspB0YOnXCsMg7NvJgc2AH0qKRL5m2mvSXcGvuCsstW7o4GztQe2i
         1IpfjLGWAq0uhC2IAGxaBcD0LZOes4K6dGFMaPwE2Y9IkygP96ITmRHcLPSwDduZNuHc
         g28WY9kqkXZHzR3qDMmKMwmU4AgdS3x4Wci9DV5EPvvFgrbtmkN0ky+/RkcbVPrYK1Df
         2H2uiTYgV8htglklRXTbjESksbwsv5Wl9O8hYfC7Pymxe3Pr8cxFgcITq19w8C9/8d6B
         MZw2xZ7kpF6hdGjSN1P4dtmzNO/DECCIr+XxEOklnExzRdRHLqoY7F81EUwKPxo5sVfh
         LXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6EJCH/VJb85grHpqtR2bsUx/l8YP7RHsS7oHvkfa1wE=;
        b=A9Z65xE240LyhZcm/Ma6I4lvEgPyCz5ICUYxsdCH/VG52/Eb2RQLm8ngXgxBI4MvAr
         ZEmUfoQTsSn5fpjctZzgP0zOMii0VpviAN/pKX/br4KfD+HY/XQq/UziL1i4iiWJ6huE
         91B1tT9J215MYn/nMXnYb/GNN+Qk0gzsZfRAHiPNHHeXUNsV6B2DMfj1yQLYYcRbZeO/
         FfuFkLR2rdEauPV/AnFas2rq5KpX+naE1muyJXhx7s587+jrkbCw1COR8DKnfZhfspF6
         jWgmao46eF+HI87bS46ucmQ5zC+fYf7Jmbpoy24Ishmnrln25esXkCkCA4SeAPFvgFAv
         f3VA==
X-Gm-Message-State: AOAM5326DnCokYBIT6ylNwJQhlKgXNu4X4DTjIZ+fpOxr2+fF3Hf2i0j
        eLzvt6GAfHXkQ+dkIZC4veKk/VdyZ5rS0g==
X-Google-Smtp-Source: ABdhPJxy0g5eyvUM6c8BEIDm/yq6kMqd76CB086CLNuwwwvCo3P4oBeroX9hgTrhVWPly1WbYMMzXg==
X-Received: by 2002:a17:906:fca3:: with SMTP id qw3mr2527892ejb.285.1637630994437;
        Mon, 22 Nov 2021 17:29:54 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm4888945edj.1.2021.11.22.17.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 17:29:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpKd7-001GFX-LF;
        Tue, 23 Nov 2021 02:29:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, peff@peff.net,
        gitster@pobox.com
Subject: Re: [PATCH v3 2/2] config: include file if remote URL matches a glob
Date:   Tue, 23 Nov 2021 02:27:33 +0100
References: <cover.1634077795.git.jonathantanmy@google.com>
 <cover.1637020610.git.jonathantanmy@google.com>
 <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <1c1a07a0b65d4bbbb0f2628a3ddf1980e37d5065.1637020610.git.jonathantanmy@google.com>
Message-ID: <211123.86pmqrwtf2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 15 2021, Jonathan Tan wrote:

> +`hasremoteurl`::
> +	The data that follows the keyword `hasremoteurl:` is taken to

Both here..

> +		die(_("remote URLs cannot be configured in file directly or indirectly included by includeIf.hasremoteurl"));

..and here...

> +		if (skip_prefix_mem(cond, cond_len, "hasremoteurl:", &url,

...but not here (C code)..

> +	 * For internal use. Include all includeif.hasremoteurl paths without

..but here..

> +test_expect_success 'includeIf.hasremoteurl' '

..and also here etc., let's consistently camelCase config keys whenever
we're not using them for lookups in the C
code.

I.e. "includeIf.hasRemoteUrl" (possibly "includeIf.hasRemoteURL"?). It
makes them a lot easier to read, and makes the end-user documentation &
messaging more consistent.
