Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF27C636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBGVE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGVEO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 16:04:14 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291D71BDE
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 13:04:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id a10so866740iod.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 13:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RriZ8kNKSic+f7XKd/T0tc7dgAUkQXekvLDm5MlCcE=;
        b=iXoSh8KSz8pYAt9QNJD5AGjywybZq5UjBVZYuCG8P7gJGB6QICnmIuidK8FU51eWe6
         qChDhEJtbJNyTkmtDYMySlQx8s20NpvdpomPLuln+tM9dzOhsSL7v2krb4Vw6QkPb/q/
         qQ7UnbGEhkmUW076xLnai3vZNr9004aoTDHB1cs0SfkAtI0Szrf6GD58M2v0FXdyq9vn
         y6kMa4MQsokinkdvC+1C4z34I0QmHZUOQTcDQrIjmEW6Cp0b2DabvaB6utREbR+ztff+
         0bMo0m0lSOMqCHn7SJMvwz6emfUmxvwS/ANPKtIj73RkKVYdWO3Vd+OLdkqTtzT4+EEH
         B7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RriZ8kNKSic+f7XKd/T0tc7dgAUkQXekvLDm5MlCcE=;
        b=xR3/DLvBTiRELMlVhpoVG4aURdPLbUUcDt0b4AByMZ0gHo3OyVvHRwjkGyRkzUtQXW
         egjhgzl9Xh+nQJARqAG6lexmeiINB3aucqbIIm4QBFKs2yIMD1JWRmqjLiExc3v42Cyz
         fWLkPPV8v9evNNJrqlhq1T0/FHGzgB2CddDUd7hHmzkyQptk9sUBX7VAVSeHFLikQ3nl
         Rgh8rPHHsQ5RFTHwQtjm1KPwHGZnxAJow+iBp0G1JPlCb10cuirMoh1ZfynWvlsDj5CF
         ByZxUgWIGBLz5hnvoqJK572ef6zc/LTcHuh4jQ6dj/FhjbHyOqLkDznwkZmTP5hQ+K3L
         313Q==
X-Gm-Message-State: AO0yUKVTMmjRAyjxayBkbQRLwpuW9TCOg/ZDG9PVDK2nQrT6kIEyxsbC
        2eCbhX9TH9ULZf2XJapOKDjDhA==
X-Google-Smtp-Source: AK7set8i/vKbpwnV8hexwgtMRqnErrolslgd8RYezhCFE0JihR5DBAOWlXHnQaP9Zuulq0/dzBEOkw==
X-Received: by 2002:a05:6602:3c4:b0:71c:9462:fdde with SMTP id g4-20020a05660203c400b0071c9462fddemr6436391iov.17.1675803852538;
        Tue, 07 Feb 2023 13:04:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a6b4104000000b006e2f2369d3csm4180640ioa.50.2023.02.07.13.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:04:11 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:04:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Victoria Dye <vdye@github.com>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: GSoC 2023
Message-ID: <Y+K8yvrv+k83/IJ9@nand.local>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
 <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
 <b8f90d73-8c49-554c-1109-92d8713d1c29@github.com>
 <38932e46-e00a-ec79-a1ff-72b7f257af98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38932e46-e00a-ec79-a1ff-72b7f257af98@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2023 at 11:18:18PM +0530, Kaartic Sivaraam wrote:
> Taylor,
> Since you expressed interest to be a co-mentor, would you be willing to
> co-mentor the project with Victoria ?

Thanks for thinking of me. I think that Victoria's got this area more
than covered herself, so I'd rather see here solo this one, if that's
OK.

Thanks,
Taylor
