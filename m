Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEAC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 22:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAE121D7B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 22:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CooO+hCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgJHWbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 18:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgJHWbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 18:31:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FF2C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 15:31:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so5159703pfa.10
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BVeWsR2ZlmFEHiJSXMnr8eAunDewGTgFcX/DVx/3hxY=;
        b=CooO+hCW54DCjuzv03E3NuaoVztxChRGjsF/18tfoxVwiNA5+pNPsxeancjdLxkJkd
         K8EowWTnHjnMHCHFx3eB0l1TNB86UapV8YhvcM7kGKh9DMPBACY0plrjhUFsF/yDSldh
         xrzEtoDlogqCb4HIYE1EEUB4IhbIq7SA7L2pWVXCph2Bt+Et31eOjXc1U/7UyjhrHi77
         J3gFoIFwUb5C7u9GEJ7PcSWWbS2eh4SiFLCpymxbntAzObszovVVFdV2Fa1BypQ+cte+
         eWUSXfFmYJbg+6T9V6HsK2znvIEF0RqeaAjXX9DE1382+JaU5eDL06V3JaznrSjhJOah
         o49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BVeWsR2ZlmFEHiJSXMnr8eAunDewGTgFcX/DVx/3hxY=;
        b=WxQphfQNDHt0751j6GGUmWhxkQD/C5yduGxBbnr5/X4NfaSRORT3vUPZ85Md/oEWz2
         KQKByDR+myOT2wOe7NovgoseI/VJ1TUSK5xN0fj9Wh0d4Dp77B7Kp6o19bGNLOduzJLP
         w05TPfyZqu+3jz/tBNZqjT6yR9JutgSY/H17Gise9RV7918abPvscmIHq78HY8NZsino
         UXIImjGF6idvTBrUBSgKc2sZD/IIVfE/GuJxdUfKeH8sBweehHPXSSq4syYVon7aD06y
         JomnmWFVIuWJWnS+M1hpo1cZumjeqdRNKdQOR+M8qRWfA6enTi7vYkbvmadSW5JmoTLs
         e/zw==
X-Gm-Message-State: AOAM5336PbGZQvyFTF0pd/epCRlVqsDMm4DGVNWWXCCYcQNSks8WlTEA
        c8fPIZHFjH3uQ3nkY6lDTK7lVQ==
X-Google-Smtp-Source: ABdhPJyEKm7DFo98iSSbBE6JH1KlNbk6rtX5YltVtvvAPvpIjgfe1PRTQiaVzDPMey1kIjUYO04rmw==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr1154626pjb.192.1602196290864;
        Thu, 08 Oct 2020 15:31:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id e27sm8096105pfj.62.2020.10.08.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 15:31:29 -0700 (PDT)
Date:   Thu, 8 Oct 2020 15:31:23 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        peff@peff.net, hanwenn@gmail.com
Subject: Re: [PATCH v2 04/13] reftable: add a barebones unittest framework
Message-ID: <20201008223123.GC4095761@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com,
        git@vger.kernel.org, hanwen@google.com, peff@peff.net,
        hanwenn@gmail.com
References: <b94c5f5c6120347fd97bcc2dcc187fc86a802dff.1601568663.git.gitgitgadget@gmail.com>
 <20201008014512.1413826-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008014512.1413826-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.10.07 18:45, Jonathan Tan wrote:
> > From: Han-Wen Nienhuys <hanwen@google.com>
> > 
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >  reftable/test_framework.c | 68 +++++++++++++++++++++++++++++++++++++++
> >  reftable/test_framework.h | 59 +++++++++++++++++++++++++++++++++
> 
> Even if reftable will be a project maintained by the Git project but
> independent enough to be used by other projects, I don't think it's
> worth creating a separate test framework. E.g. as far as I can tell,
> when we import sha1dc, we don't import any tests, so I don't think they
> need to import tests either - they can run the tests in the Git repo
> themselves if they need to.

I agree with Jonathan here, I think we should stick with the existing
test framework.
