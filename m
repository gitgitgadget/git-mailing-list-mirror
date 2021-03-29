Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC0FC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAEE6198A
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhC2VWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2VWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:22:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260BC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:22:22 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u2so12470275ilk.1
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b+Xoa1IoYOdUfX4j/jHv6KSKs4kYr2ZJDGRsBptRnYQ=;
        b=nSjgFXcyTJbWhYI4qli/oQTKlOVJjfTqWjpP1xQE/ZZgbS3qt36ibkj3uSQo1vG32g
         uQdrwKr+V2AvYJzRv9xqw9ZwcCwKJlN6mdCd4pfPUL11to1G3H6bXYdqcm17quK7z5TB
         j5bwHY9CRmVV+UaKo1YUfIofgf2JkNM/h0cIgKdNjedntl0PHuaY5Z4VIJmg2RGVkEiz
         36jCPNiXTXAXGqqpDvvrL+V1CYwxIMydCbbWFJtzilNBFnX60PZ+h3Nx3qGs7COCqXI+
         rhLdwy4IdxBVumihED6VaVW7fsY9pGsdz4SnSCbxMKIHp3pa3MbG5hgEylsLnKBOVkwa
         ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b+Xoa1IoYOdUfX4j/jHv6KSKs4kYr2ZJDGRsBptRnYQ=;
        b=WXyBQb8DrH6QskTXs+W+BlHlMTi3CuB43oT9P085uRp+QkbTRQp7lg3UNUSSTt39W8
         GaefwBX09v4VeyEuarIBNf133WN/9puL6OW9nK55x4I9tAcMhlDKATZ1JzOctLQ5GTGu
         eohpx6NdH78TsTQIchmTa8oM2ZPxnMXIRt3xyAp19cmO4QK+4oQKrhEz5pMbEZF3vh3D
         DNtG+bNkHIs/SiZOntFRUM8eJDnzZdQl2Yev5TATqVqDSWYJljJQQN9gE6wPRODCeu7q
         VwpfIJk+H+ENpf0SFzzPVWLICaZxuquBKroZ8EmwE0mmSHwW5Zg7WPu6n/UQHFrS2R81
         QUeQ==
X-Gm-Message-State: AOAM53037i3eo+egOuTOHNopewsVSvi9ZoPnh/J/RFj4x5t4VfPx3DWq
        ECGWePjqZFUObp69kTMgnAN9AA==
X-Google-Smtp-Source: ABdhPJwuUwqCv1zaemQ0jOaCDJTXemv89CJh8k97B3fyklqKWgLVh/D1s8743gwPOcBt+Ida7y1BKA==
X-Received: by 2002:a05:6e02:e44:: with SMTP id l4mr12567251ilk.185.1617052941839;
        Mon, 29 Mar 2021 14:22:21 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id i3sm10135291ilu.67.2021.03.29.14.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:22:21 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:22:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 12/16] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <YGJFDBds3imLWike@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <4745bb8590f5cdc24445618dd63ba6bd541227b4.1615482270.git.me@ttaylorr.com>
 <YGHEN6rcao2tJ006@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHEN6rcao2tJ006@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 08:12:39AM -0400, Jeff King wrote:
> On Thu, Mar 11, 2021 at 12:05:25PM -0500, Taylor Blau wrote:
>
> > As a prerequisite to implementing multi-pack bitmaps, motivate and
> > describe the format and ordering of the multi-pack reverse index.
>
> Nicely written overall. I found a few typos / formatting issues.

Thanks for the attention to detail. Everything you wrote makes sense to
me (including a quite-embarrassing mistake to switch "their" with
"there").

Thanks,
Taylor
