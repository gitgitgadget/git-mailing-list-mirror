Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8DEC433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2774E64DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 19:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhA2TQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 14:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhA2TOe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 14:14:34 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A43C061574
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 11:13:54 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id k193so9804250qke.6
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1pdTgOs/kOa+9FedvtO9hScL5ZwVUNAUKyw0djcdZg=;
        b=DLfJCCOHoj7Crhqa75DNBGvBBcNjJKZrv6kDcY9+it0oRXm3b94vRb9xmwUatgC2vE
         jc5+84TIQQS95r9pQ8KR+6EfV4Fk+BJlChxFPmWbb8ZFkJYxSiJde0Q2jbq18Edxs589
         CB45OSXB89wuFXGzOYrZ316NOVPQ/S6cPPgNL0LGYWEyrc2956bqO3ecwvwRJomie7qr
         Tr82w6LDRmGMKrt4gKU8wHiNOsqsPYLhSERM/CIyQ58/86MyTvw93OrRepcTfKciJXDq
         TpoHNpammtJii+oq8zUm485/PwJ4MeyDfwsrkBd1jQhmkWrA7L/wkFbkvxhTf/bG5tj2
         vETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1pdTgOs/kOa+9FedvtO9hScL5ZwVUNAUKyw0djcdZg=;
        b=ZZuotyuAMWmAD1s2SaY30xDTp4PGgkF93N7O+eK8s+6Nt9dd5rBy4595QW14w6Y2v5
         1F1HJ+yv8HMg4yAGjExZJk2l3Bqg62RJEOoxf85i9y1uJK75TR9mCApIxiP+r0tbcsE4
         sRhK4EkP/jdaBQdXmk1+P568pXUD+lRbzuIUgqjsmWvnyopeF4SrXwpbzfQnlnfX98ft
         9nKCmQAR+eblA92rxVIvlmxA5N5E+nbr7j3JvVDitvXMuH8GV6+IFmoUEuxlat9jntEL
         FNDCkhh3ZexFXwBXWfOpVCVjRIInvpJh8BVplkmo1OQynPj/miVgeOfDwU+mltWDAaW/
         Ftyw==
X-Gm-Message-State: AOAM532NbbCqtVZjdMfX4T+izsKNOcIx6/sw0KijhP4c62tUWMV7THw0
        38/btD4Spk3jaQEFZvA5+nc5QQ==
X-Google-Smtp-Source: ABdhPJzZ4yqWTsxPHKvUdDB/AITVN2fFQkt1pVHhjRzCiwaLQX3yoyAAvcR/t+1yf+lq4wmhwNJgZA==
X-Received: by 2002:a37:a58d:: with SMTP id o135mr5384283qke.204.1611947633055;
        Fri, 29 Jan 2021 11:13:53 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f05a:e493:9aaa:4c8c])
        by smtp.gmail.com with ESMTPSA id 196sm6893715qkl.4.2021.01.29.11.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 11:13:52 -0800 (PST)
Date:   Fri, 29 Jan 2021 14:13:43 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 02/10] revision: learn '--no-kept-objects'
Message-ID: <YBReZxK3WbEAn5PV@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <4184529648abe7451b5c7b772493df8c067cec82.1611098616.git.me@ttaylorr.com>
 <xmqqo8h8tp4j.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo8h8tp4j.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 07:10:04PM -0800, Junio C Hamano wrote:
> We know that the enumerated objects do not appear in any of the kept
> pack, but it does not mean all objects that are reachable/in-use that
> are not in any kept packs are enumerated.

You raise a very valid point. FWIW, I originally wrote these patches as
just "enumerate the objects in these small packs, make a new pack out of
those, and then (optionally) delete the small ones. I abandoned that
idea because it needs special handling for loose objects, and it has no
idea which objects are unreachable, etc.

But maybe it is time to go back to the drawing board there. Perhaps a
`--geometric` repack implies that we keep unreachable objects in effect,
and that a full repack (i.e., one that does reachability analysis) is
required to drop them.

Other ideas are welcome.

Thanks,
Taylor
