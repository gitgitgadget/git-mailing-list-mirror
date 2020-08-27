Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9607C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAA02074A
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 09:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAUS8HXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgH0JPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0JPK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 05:15:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D1C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 02:15:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so3015781pfw.9
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=BmyOUDt85Yt6RSpruODx+UDC/gLVEWJDADPQ2Yvl0yg=;
        b=bAUS8HXlDAVLBJ1C+x8BmbbIrfbCiCyj8FDily1JP4RwHEz1kpdzgYaEb/MszUsAGR
         47XEIdtbzBD9f8PoF5V4Kk6syHRpOrhjnPs/u4hVf+lbIX17+D/lkyOwV888z9Kdppct
         dFBD91oX2uwkfk6DtdIUQPzXZelRYMw/BXV+jyybIivImuy50JmjkdkEBX6P2vhLlTCw
         +D/5QjZPetLfCnv9qdKgvqjzynNE0FCVHCc1AyDbaOqUe3twFje3YGbe/NJH7n7SbPy8
         BMOVziF1YBfctW2nhG36r1j5i5dyC3tPh9jDd3rkvGE+D92aezZmGqg5s71m4+39BmFf
         tF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=BmyOUDt85Yt6RSpruODx+UDC/gLVEWJDADPQ2Yvl0yg=;
        b=lDIVi8drLCPNULmnnuT/Th9aHGUDTFTDGAcP1i6R72+ltQCGlmPO+VO12lOp8UthW/
         jDpQg2oOWP5wQfN/u6CMJObEC1ymK/glzYRxBl+W8/w26tUfwtKuxlM6SF6mrJRIGM9V
         ZKHu529ItRxQwyAGdfUK+S0JNSASbUDYwGu56qo+Y3SBuSs6DEdg/Kph9oRJTx4KK3H4
         kCRnjpc0fessbc6QsRenXnBZF8Ub5RZ8w9J0GaD/BV2JXEm03cJ82xst/c3JqxwD7l7F
         7IX6Usv0zRtAyPMc1W1a+BoVlu50yVb4PVC8D5FZth4DDSn0XRG/66W0P2mfaNmi4wQM
         B28w==
X-Gm-Message-State: AOAM5303YgTvlOZWukt2Imt4svwCGZiMaT1Yhx+pXNj7tGcA/UOtjTRR
        JpvnVAuxQc5K4ocfuQFI+PQ=
X-Google-Smtp-Source: ABdhPJwg7OJs/vS2NvNWsH2KkH3EBXQI7icyorkjle+Ok/UcTDYCj3/F+HcKJnJIm+EAj1NBEK/Sqg==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr15331889plt.91.1598519709466;
        Thu, 27 Aug 2020 02:15:09 -0700 (PDT)
Received: from konoha ([2401:4900:b81:a787:19fc:518d:6f59:7c])
        by smtp.gmail.com with ESMTPSA id w199sm1928159pfc.191.2020.08.27.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:15:08 -0700 (PDT)
Date:   Thu, 27 Aug 2020 14:44:41 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com, peff@peff.net,
        shouryashukla.oo@gmail.com
Subject: Re: [PATCH 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw
 compatibility
Message-ID: <20200827091441.GA6656@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfi21zb8.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Interesting.  There is a mirroring if-else cascade that begins with
> "if (S_ISGITLINK(p->mod_dst))" immediately after the if-else cascade
> started here, and in there, the same verify_submodule_committish()
> is called for oid_dst unconditionally.  Should the asymmetry bother
> readers of the code, or is the source side somehow special and needs
> extra care?

I understand what you are trying to say. The thing is that the
conditional `if (S_ISGITLINK(p->mod_dst))` already guards the
`verify_submodule_committish` when we have a status of 'D'. So, we do
not need another similar if-statement for that. It does seem a bit weird
to someone who is reading this thing for the first time, hence, I will
mention this in the commit message.

Apologies for the late reply, I was a little busy with something.

