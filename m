Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E82C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 01:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F261C610C8
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 01:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhILB6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 21:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILB6R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 21:58:17 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB012C061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 18:57:03 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z1so7408825ioh.7
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 18:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PXsqirs73ZoUDdjJSWeUM+GpfSEOIgH6FsD0hVBh5hg=;
        b=fjThcqUA/4GLZ2w4ijoli4ktMFB3S2L6BchzclJ/vNutKWw64LfYSv7i4u/xnLqc99
         FDiLBplKp+L2icqmAp4JR/9/QleHRw3F/R273P0gnhsbuWtPA/hPIvq1ajoy5yeaRsM3
         C25GFqqRRPT5GEssjaKxpbYzqT7nBsWa4BUlHjJmp5sAoRzIcq5W3fzj9vvflIvydZDL
         Nwbzd69iVHwr/uH+j0LDnUhvCxfEp87ygrSAc0N21TlXGYXPev+juhkpn5jw9OoqcTly
         9geW0KHv1X3x7iMEfxLiJyL32eGNl/CkHt65roUCAGCpRhDgXABJ/shMW5cp1W0zS35r
         6RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PXsqirs73ZoUDdjJSWeUM+GpfSEOIgH6FsD0hVBh5hg=;
        b=VRbnfGEon8nSS/T+x9SRUfdQVpxG7JdC8SfLbwA/NQXjt9rrTOr9xYri78eDgP4+vF
         PCeNPPPj2chII0IWzZ9Rsv679VozCZRREbX6tKUQMTTVn3Lhsc0I9Tj0czMga+uVW0aQ
         udxbcVhFGL1dHMP1PeooeaRZ1sztJY5S8UggRKSoS+wXhFkcye5tNVPhTO/nnJTiRYPQ
         JrMtvdB/A2qhM0phKfta91eoamAXhIsEoXgFOYc5hDOa2VJ2k6m4PdUkygZZjah3KQLU
         wFQARcxVLNMF1Ndsjmd8JjemBH7uBt4CuCChL4MWlDefVxsy09oJ5RfatoD0jg11Sguu
         lBQw==
X-Gm-Message-State: AOAM532cmRTX9v5DRqEsYujljjoy6GMbEF2csJGL5KmnwnSOw4IkSmdJ
        zp0tqL6r7jzEup+IKEBwtz074A==
X-Google-Smtp-Source: ABdhPJx3FAQVRa6lmWQKI8n4kFRpGrQZZHPym8tuPAGzQT4Xz0PKBucRMJjsZhcVboew9yQh/lf8eg==
X-Received: by 2002:a05:6638:1347:: with SMTP id u7mr3951358jad.34.1631411823210;
        Sat, 11 Sep 2021 18:57:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i20sm1901662ila.62.2021.09.11.18.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 18:57:02 -0700 (PDT)
Date:   Sat, 11 Sep 2021 21:57:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2021, #03; Fri, 10)
Message-ID: <YT1ebpnuRhtS7oQl@nand.local>
References: <xmqqsfycqdxi.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsfycqdxi.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 03:11:05PM -0700, Junio C Hamano wrote:
> * tb/multi-pack-bitmaps (2021-09-09) 29 commits
>
> [...]
>
>  Will merge to 'master'.

Hooray! I could not be more excited to see this get merged, since it has
been quite the effort in designing, implementing, testing, and
submitting these patches over the past year and a half.

Thanks very much to the many reviewers (Peff, Stolee, Ævar, Jonathan Tan
and you all come to mind; apologies if there were any that I missed
along the way!) who took a careful look not only through this monstrous
series, but also the many leading up to it.

(A small side-note, I think that my small series in [1] which builds on
top of this one was missed, but otherwise is ready to be picked up).

Thanks,
Taylor

[1]: https://lore.kernel.org/git/cover.1631049462.git.me@ttaylorr.com/
