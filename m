Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A952C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA5222C4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S+Xpf4Qc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgBTXX0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:23:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42968 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:23:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so169654pfz.9
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 15:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VVhmHRTGSL2tU109VrXUmK8gIqB6Ucv1XmK37mEwbIQ=;
        b=S+Xpf4Qc076agQVwm9krITwhbcHED2uMlrpK5f8z7U93Ke9YGDWMxuMltxezyQI3zB
         0gzqART8OPKMaTQQDWeBZRkvtXeQNRu8Ag1S2M6fZdVGwlnnFwPwEs0eFVYfORqcvnt9
         FV++8dTxss5VVrA91FHAeqe5bvSHefMcii3i2FMHhn9MYVyX2fQrMqB61nG87dz1NivS
         NnVibeavgorRKuvDzdfYDDfHGuxsNFVSt9PjZx43hzr7eba5NjKB/TWVu1gptP6OLL57
         tpvJu9a4Md7xFd9ON8E/eC4FsQaSUQBr/5K5a7moXdB2xg3u/VR2tkOS9k6z8bOfk/2J
         Mduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VVhmHRTGSL2tU109VrXUmK8gIqB6Ucv1XmK37mEwbIQ=;
        b=d7MUiEV0hfSvezEC0Mn/aDPWgk9mhRj8RHiCY61As45mc3bziYJjOBrFs8DEGCmRGM
         9fOgDIhgeHq3zo7XsuMTOBrDVK0kxaf1sjtSbgEM5fn/vrsnAWIiXxev+bLRZVGvqRaC
         sXxGQxZytbFtG4dVI8bpyiuTToPLN+HxxHzMZuhpvSDQcYDQqzjgQb3F44aL3P/MAuIv
         /KUp2y2NrDif9qtBVGApZahhg4lmPb57997mySRc4VZE6Go3RLMpI3CUUN8sISFskaMn
         nyjg8I56qc5Btoj9tAT4ITiLdvweTm8z2vhYGiDKh9oU+Bv6+R9JF6Y87ZQ97CzOD87x
         o3Pg==
X-Gm-Message-State: APjAAAV1gDHokoGtJeykoWBoDoBBd9zDru9Kk9cT147OP++zSVdBIQfx
        Rf1idCrLbEV7t7niULRYr8jrng==
X-Google-Smtp-Source: APXvYqwGbwoi74oY/sEAs0DI7IG+K1cQ9thbyYO+DvI4dMn2JuCzdYpIyQ4IdnPZDomEepIoY74hPA==
X-Received: by 2002:a62:e10b:: with SMTP id q11mr35012926pfh.48.1582241005281;
        Thu, 20 Feb 2020 15:23:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id q8sm366486pgt.57.2020.02.20.15.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:23:24 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:23:20 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 06/15] bugreport: add compiler info
Message-ID: <20200220232320.GG2447@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-7-emilyshaffer@google.com>
 <20200220024903.GC8390@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220024903.GC8390@danh.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 09:49:03AM +0700, Danh Doan wrote:
> On 2020-02-19 17:58:49-0800, Emily Shaffer <emilyshaffer@google.com> wrote:
> > diff --git a/compat/compiler.h b/compat/compiler.h
> > new file mode 100644
> > index 0000000000..ef41177233
> > --- /dev/null
> > +++ b/compat/compiler.h
> > @@ -0,0 +1,27 @@
> > +#ifndef COMPILER_H
> > +#define COMPILER_H
> > +
> > +#include "git-compat-util.h"
> > +#include "strbuf.h"
> > +
> > +#ifdef __GLIBC__
> > +#include <gnu/libc-version.h>
> > +
> > +static inline void get_compiler_info(struct strbuf *info)
> > +{
> > +	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
> > +#ifdef __GNUC__
> > +	strbuf_addf(info, "gnuc: %d.%d\n", __GNUC__, __GNUC_MINOR__);
> > +#endif
> 
> I think we're better having
> 
> - get_compiler_info placed under #ifdef __GNUC__ gate,
> - get_libc_info under #ifdef __GLIBC
> 
> Then have a function to merge those information together.
> Correct me if I were wrong, as it is now,
> this is only useful for Linux people with glibc.
> 
> Anyway, clang also defines __GNUC__ and __GNUC_MINOR__,
> IIRC, FreeBSD people started to move to use clang instead of gcc
> as their default compiler.
> 
> Gentoo forks are also known to use clang to compile their ports.

Yeah, between your comments now and Dscho's comments on this patch in
the last rollup, I'll go ahead and refactor it like you suggest.

 - Emily
