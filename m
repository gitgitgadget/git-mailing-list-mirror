Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB2C433FE
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 01:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377694AbiBEBB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 20:01:27 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:41959 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbiBEBBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 20:01:25 -0500
Received: by mail-pj1-f47.google.com with SMTP id t12-20020a17090a3e4c00b001b87b6fd18aso734156pjm.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 17:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjTDKKpOL2rcy8EsJI5MyglEm0NGzELxrdErAu5DuRE=;
        b=e16wxXJzZ94kQ7rvrhG0zmKv5yLOGOSFuo1RGnKR4CGbg1pPOggOgmZDNtBWsLrtBT
         DrCAm0ieZ0WEprLzIMISt/nltuHpFPHmZ9DwF6+0zxIJulLcOxJE8kRw2rFHLFeNL+QK
         G7t+8hbPrE7yfsyZKDTiU3WgryX39rGWqujsaC7noBQkeHZ75L+wWi6jqDnPHEoMxX4j
         BURXZjHR58rY1N/T/Afol4MBa7dyDUa6g26demF+q6ZJJJNPwNPF5OvojwR0Q+C/+FRM
         Kr1tx0gTYe2mXNmQ6qwjrgsbiL73rHYr1hkIuUKV7zn2H9vn17wgBNpeHZ29KgWeTKun
         eSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=cjTDKKpOL2rcy8EsJI5MyglEm0NGzELxrdErAu5DuRE=;
        b=5Mdv12BJcbnOnO3q7y6ScSOtdyoMrB2QROMVFZdQSZessbzhBtTACmxZ8DFnMCtmZi
         SdeOakC0CMobXGxQg0Rs8ffUx+EaD2K8Bgy5/bwGZpw1w97ibeiMWxqc700GaOw38CJA
         lzWxMj/YhUBhfc+TgAuHnKbGYxVkdAyQQrLgYSUdhiOc0MT1nPt5M6OS8yUR9H9IqO6I
         WikxvrFOYnBxBVBctTCZ8a0O3L/J0xNzyweFa2c9s55C2ukDnP+/RTyE3LfIzpZ630Nd
         qsngWRjgMq93UbNAUyQALdt7bxOKDLfAXqZszM22T/TMxdkez605rBzMEylUe3zBJ29Y
         fTUw==
X-Gm-Message-State: AOAM5329aKL7O7mcTutkILhfdUNc5bmd+b80LXA2j4Fq9IJkZXu9hJms
        MRBBD8/d839HGX68h0OAAqu6S5uYc6iYsg==
X-Google-Smtp-Source: ABdhPJzNFxtKIaSTMpdRorBXNsIC5OjppkodJulBttT8rJqQymGHMrHB8+1b8ZAuzD/g/VvcY/gSeg==
X-Received: by 2002:a17:90a:c08d:: with SMTP id o13mr1782874pjs.187.1644022852442;
        Fri, 04 Feb 2022 17:00:52 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:8562:eb15:bb84:ce64])
        by smtp.gmail.com with ESMTPSA id 17sm3940577pfl.175.2022.02.04.17.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 17:00:51 -0800 (PST)
Date:   Fri, 4 Feb 2022 17:00:45 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH v2] clone, submodule: pass partial clone filters to
 submodules
Message-ID: <Yf3MPWFgThx7wG6L@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, newren@gmail.com
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
 <8678e721c2ddd785e866df972af734e422b95039.1644021221.git.steadmon@google.com>
 <Yf3KztxONWk+R3K6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf3KztxONWk+R3K6@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.02.04 16:54, Josh Steadmon wrote:
> Hmm, t5617 fails with GIT_TEST_DEFAULT_HASH=sha256. Not sure why yet,
> but I'll investigate and send a V3 with a fix.

Ah, checking `core.repositoryformatversion` == 0 is not a good way to
verify that a repo is not a partial clone. I'll figure out an alternate
method for V3.
