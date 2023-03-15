Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC345C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 23:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbjCOXNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOXNE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 19:13:04 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D7B11E84
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:13:02 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i5so21795561pla.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678921982;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NnM+dzOojfbd6oAWwHUWg/Xt2mRU9OQHuTfJbEqNvc=;
        b=EyWGu+sGkKx+gAmh/kOTGu0sHOI/22s77ACsgBF2GiC9dFC45WuiJBpofMpYUum89C
         kUMfKnbnyIWVTsIVfbR5eiRAiraCpMtaI3GEDHhi+HFb4VLZq+HH3Q8HK8ou0mHnzx5Y
         RFlDhLr63IFIJkO9dpgNiNOa4Y9e4ZxxI9b2Q5XD900E9eZcnYvUAwciXdvRYp2yguzb
         NcPmxeH93EVfsVJlJuIUe0vJ1V30bENVYVj8bIsRz5vFYaCwuBY+9PqBVbdazFdLdXxh
         e9H1L4kzbxGhzXupVsZcvH4HaAUp+jzAOYCnPb1Jxb4b9uHLLn6SoOkbvk6NRVfAKd9b
         IaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678921982;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4NnM+dzOojfbd6oAWwHUWg/Xt2mRU9OQHuTfJbEqNvc=;
        b=Xnyv0FtZDVHU3bbqsQ2LaFnydq5g7ji7/WFTNgCR4VQqIEbtC59+sScvXlb2PAbGAc
         kKiKRPhXgruX58/UGrzCVqufh1XZR/soXxXvEzeYN+Tc8uBh7iEhei1pVr94HGexfhZ6
         GYezOO6jAEDJ3IZvUVeWhMMRtiDoLBtP3PoXlbydIXIpLDVyd46t9EqhvIWiKYIO5fCP
         O0Fg9Vo+mKMx12sEd5F08UWXTIjUp/nyJBE5nGo12GUSJkL3tNieadO9loZ1UJzUYYnj
         YvxdlmjUmauHQGW9WBsX03oyf9i12J1MxgzIvIKGJbtN8gB4QKehWF5rNSOeY0uqPfTq
         JhRA==
X-Gm-Message-State: AO0yUKVKzwRWlf8eTiR+uqDaxVMeNbboJEiUSh7gmCqCL/1XFQa7h3nn
        pi9gY/XYLEXNdcfFD9+kQvA=
X-Google-Smtp-Source: AK7set8s65/PY07csQSj26FPWugHjh+Q3ergGkAv81pSYtenJF/UyNAYMj/K87g0wWm+DX+cCec93w==
X-Received: by 2002:a17:902:f24c:b0:1a1:8d4e:a70d with SMTP id j12-20020a170902f24c00b001a18d4ea70dmr728344plc.38.1678921982398;
        Wed, 15 Mar 2023 16:13:02 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b00199023c688esm4187632plv.26.2023.03.15.16.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 16:13:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/8] fetch: fix inconsistent summary width for pruned
 and updated refs
References: <cover.1678878623.git.ps@pks.im>
        <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
Date:   Wed, 15 Mar 2023 16:12:59 -0700
In-Reply-To: <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 15 Mar 2023 12:21:32 +0100")
Message-ID: <xmqqttylmww4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> As the abbreviated hashes may have different lengths in order to be
> unique we thus need to precompute the width of the summary's column by
> iterating through all the objects. This is done in two locations: once
> to compute the width for references that are to be pruned, and once for
> all the other references. Consequentially, it can happen that the width
> as calculated for these sets of references is different.

Hmph.  Use of ref_map vs stale_refs as the parameter to call
transport_summary_width() is to come up with an appropriate width
for showing the list of stored refs vs the list of pruned refs, so
from that point of view, an appropriate width for each list is
calculated to a different number may even be a feature, no?

I do not mind either way all that much, but a change like this to
update the presentation may want to be protected with a test from
future breakages.

Thanks.
