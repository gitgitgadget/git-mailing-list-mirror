Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D81C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 14:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiA0ON7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 09:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiA0ON6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 09:13:58 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8FCC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:13:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so2644285ota.10
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SHwrFO5pIyfn4lE9fFtig8hU4n+3Pv5kDf39vL9aIAo=;
        b=S7I8soE74/YqkcoN5WgheLM6U+nsbW9jc3URFrtxxIDAqmmW+C9XQM2O/rt2ClXpdQ
         9YhkLjKfvQcrhMtudawpSE1OtltzHUZBW2ZAHY8Ia2sWLnn10rVn/0EgI47bDar0Qg6n
         gDFbDxAC9raGxDG6L4hZv2PX27VRygaENp3keGnsAiVf7u07U6sK+yMnvY+cchsjA0rN
         oWBpuW6McMdY7uxD2wBc0d3/zu+L0VpxzW8gkCKWk9adijYmgDKc4DwwwVybOOe0Kq6i
         Ees3u2NZzi/TgZgFyILIUHpcHyPR5LmefO245lZTQ+dLy3lb8hVnNrmZ4gwmCzpRRFg1
         mxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SHwrFO5pIyfn4lE9fFtig8hU4n+3Pv5kDf39vL9aIAo=;
        b=t2T0KD9OstotTL1v1tBaCj/MRoFCNw1A1UHsaxpNHtP1UiCznEdyekF8EDAJ3Q/mUN
         6CyAk1MoChFxigx+30upNAW2cvVjBNqIMxTr0MhUQZEEA9BhaQCjPB648KaDlVuCnj+x
         RSYgPR1ux/AHYMNdofTiKBD4fSzjWsuN/rqioqCrv3avXLeIjrsneD4FHTXHyCyMQX8R
         tDH/69pyTKCgTPV5/aMntYC3HVjxwITmd+bDgrUjEZgCdZpc1bZq9s4ey8eRqk4rAEfh
         ZWXkZ/P0ryB/XX2vV9S+Ak71+7bg2JUt3cFkTPrpuZgashm3Y5MyFq58XfxxYInwDnmZ
         4wZA==
X-Gm-Message-State: AOAM530t0T9aENvfUhdNxD0JYcFhVbG6fbkjBSMV5Wj/hCH/j2EcmO4N
        lZYMFEmiwGZvBI8gdEmEMTP5HahOsxw=
X-Google-Smtp-Source: ABdhPJw3kQ+h7ufwcVS/4QK82ibLJKOK2nzB6ARE+zXV5ZxdTQE7i3EnokrF0ZZhAxDLCdFyPUiI4A==
X-Received: by 2002:a05:6830:439e:: with SMTP id s30mr2224688otv.96.1643292837720;
        Thu, 27 Jan 2022 06:13:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d9cb:250e:9ea6:f8? ([2600:1700:e72:80a0:d9cb:250e:9ea6:f8])
        by smtp.gmail.com with ESMTPSA id u25sm10457030oth.56.2022.01.27.06.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 06:13:57 -0800 (PST)
Message-ID: <8842fdd9-438d-43dc-b7b5-0d6bb456e313@gmail.com>
Date:   Thu, 27 Jan 2022 09:13:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 0/9] midx: prevent bitmap corruption when permuting
 pack order
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, jonathantanmy@google.com
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1643150456.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1643150456.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2022 5:40 PM, Taylor Blau wrote:
> Here is a(n even) small(er) reroll of my series which fixes a serious problem
> with MIDX bitmaps by which they can become corrupt when permuting their pack
> order.
> 
> The only change is to revert back to using finalize_object_file(), since it
> behaves consistently with other parts of the code that touch $GIT_DIR/objects.
> This is safe to do given the other change described in that patch. The
> description has been updated slightly to reflect.
> 
> A minor tweak to the tests is done towards the end of the series. But otherwise
> this is unchanged from v3.

It's been a while since I've looked at this topic, so I re-read the
patches and the discussion on this version. I found the patches to
be ready to go and the comments that exist to be interesting style
points, but not valuable enough to hold up the series.

If you _do_ decide to re-roll, then please add

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
