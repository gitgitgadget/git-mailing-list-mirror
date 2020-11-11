Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6A8C56201
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135E5205ED
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NctBd7yQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKLBcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgKKWxq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 17:53:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3456C061A47
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 14:53:25 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f18so2455238pgi.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/V1q+/Zsx66fYfZ1R2P3xJ4D8SiWoUeOaqu3EuKFuyY=;
        b=NctBd7yQZTjbwmP3dz2W7BQsPtNF+QcgnnMTFmEyZN4yRJAq+jwOaflj0VDiMzoZng
         eHJUi4t4o1pOIlfdrWrr9xWCBVExlZWuo/cP5j/xD+fGfVLAh+RFAMETevMye/SFH/Ud
         xvXRW3pHKMSD3ZQ4N+54gEpHmpineWjh3UfmcIj5EcfE0og/An7heP+yezF+TS+g7oxN
         M4b+7tqQheXd9HVBDXYD2Hlfe8JKc8Iwh6zERMwE5c0owG7P4TqDnPVbahDuxI/4deIt
         BDrbKawf3wZbrr5d0lOrqJ/YEEI9rXUxyfWC5D5H6U6wifGLtCw/Wr3W3gDjA8INgtJx
         rPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/V1q+/Zsx66fYfZ1R2P3xJ4D8SiWoUeOaqu3EuKFuyY=;
        b=Q/9EQ7RNRCmDQrz4CIYVAjfz39ugW0iq8c3NMvXb8CX4tYzDPb+XndXtx7MWDNxbkn
         kGdgTABHeDBbwA/QoCq9OARGzUkI156ASSo00W8zUUw+ws52+HGvPP9Fyu1Mi20MeEBd
         AGMWi+I3RPin8qt0uxLoLMafwfCNt1l6PqbC4WiyGCv5jaw+tCALtNlmL5ghlCeaZ47H
         YwNOdD+r+L/a5dk1lW18uDJSwDDpsPUZnkbRz1k6Ms0cKCkPJBc3SkPhftAeOxdXBOn0
         V4/x4bfSB0uQDECynTnJYeoP5kl2RHOCIdO9EpjbGPB9zK8cHT35PqOdHQrqRA7Kw2Uz
         yorw==
X-Gm-Message-State: AOAM532bIbQXgvGp/6guwkENr2+x5ZcauI1UnsLANtargzGQsiSKbRlx
        uHUJt3ujNuwilEz0xSnxSx2raCo5YKyjag==
X-Google-Smtp-Source: ABdhPJykl3baG3blKl4LZtVDMM/q6DjiZ1Nu9CpcYqcDftGlarKjTzfCSrHBUx5efDFWG44Y0xzmwg==
X-Received: by 2002:a17:90a:4497:: with SMTP id t23mr5958530pjg.39.1605135205278;
        Wed, 11 Nov 2020 14:53:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id f16sm3633143pgk.48.2020.11.11.14.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:53:24 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:53:18 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH v2 07/11] transport: log received server trace2 SID
Message-ID: <20201111225318.GG36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git@jeffhostetler.com
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <21bdbf23f39c800b1722c54b666df7a91b5879b5.1604355792.git.steadmon@google.com>
 <xmqqpn4slt8o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn4slt8o.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.04 13:14, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > When a client receives a trace2-sid capability from a protocol v0, v1,
> > or v2 server, log the received session ID via a trace2 data event.
> 
> Would this pose a new security threat surface?  Just wondering if we
> want to ignore the capability if it is not enabled on our end with
> the configuration.
> 
> Thanks.

As Jeff pointed out, the json-writer handles string escapes, so I don't
think we could cause any trouble with the trace2 "event" target. The
"normal" target ignores data events, so this would not show up in a
normal trace2 log. The "perf" target doesn't seem to do any escaping,
but it's intended to be human readable rather than parseable, so I'm not
sure if we need to worry there. Jeff, any thoughts?
