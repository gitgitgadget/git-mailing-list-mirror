Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E587C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDFV1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDFV1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:27:23 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994FE9
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:27:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i6so47587959ybu.8
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1680816441; x=1683408441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ka8a5kyrzLlK66M7+FgZBTD6aCvwDA7OMa/xEm+0RY0=;
        b=D5KiyGZf4kK7188CRQT2b7I96Tx1YT6DmEknXeCr55Z1Qw4wi/VAfntzFwsjPBZHmx
         GBRc5bYcK2t53zYis1yDZdi5id8746oflE6YSbaWwS2gER2WvKynEOIsRNfliMKrBEgP
         BtMZCT24eQh4q+tHcBx0oCmi1Hr0FACTHX6GFi5CAssr7RUz1Ik91WftdQtItjuQytdE
         4e0e6CwrbgOngYvcLPJ0m23pchp9/pvPVPrON3GbZV0yyu4IP/EvQ1oc9RnaJ3jm/ZQC
         liIji0fOoAQVdNHHreNgUu+8duBdLV8c29H2jDOa2+aRDnYdvnboYakeviIHvWpt/1DL
         Ql+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816441; x=1683408441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka8a5kyrzLlK66M7+FgZBTD6aCvwDA7OMa/xEm+0RY0=;
        b=sHInEr3GIOi7o398/yvVeWQ+UWcv61ulOY+J2IjV/MUXsvAhX3quYhZcoZrMrfoudy
         +fF2qdYsZo88zJ6qT0qa557Jhgsf3MvBkKwuptKRtAQ0YBL8RR76et3W3QmI3fGsRcuM
         MLrhMvrQ4wSs2e9ws7SJ8erHfdMipZDB2tNaILhZ80/IBmK9/WDWBs/nYE4LHFsPptCT
         1OevTQt8ZReoLo/x30zcSLIGB/YxaWZTR4HHipquGo+QlvoHiHiG2jSYn+Igh8BpyW91
         5s1Ck6570d8mhqmu55gFrRpSCLd6cwFXFozrCFhCWQLqeoK/nQ8uIPeb9OTVSI5Xcu8K
         F9Mw==
X-Gm-Message-State: AAQBX9fR/ZSuC+96GKZKS2NJpqriwl0mSq+dSqfLpcFEPXAfkxcoHD7N
        10yPYBbIZbwjNb5aOHw22ylnfQ==
X-Google-Smtp-Source: AKy350ZCKqZ33jcmCPBRQmw9exoAP82B99J9UeYEfPA9fOVexjCl4FMOFjlZyH7nWZKQwfizQ3B7Iw==
X-Received: by 2002:a25:e7c2:0:b0:b35:637f:4fb6 with SMTP id e185-20020a25e7c2000000b00b35637f4fb6mr754482ybh.28.1680816441577;
        Thu, 06 Apr 2023 14:27:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w26-20020a25ac1a000000b00b7767ca7482sm660415ybi.31.2023.04.06.14.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:27:21 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:27:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] clone: error specifically with --local and symlinked
 objects
Message-ID: <ZC85ODogr79t0ZXZ@nand.local>
References: <pull.1488.git.git.1680652122547.gitgitgadget@gmail.com>
 <xmqq7curxk22.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7curxk22.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 04, 2023 at 05:13:41PM -0700, Junio C Hamano wrote:
>  * if lstat() succeeds, but the path is *not* a directory; errno is
>    explicitly set to ENOTDIR.  Unfortunately, if lstat(2) failed
>    with ENOTDIR (e.g. dir_iterator_begin() gets called with a path
>    whose leading component is not a directory), the caller will also
>    see ENOTDIR, but the distinction may not matter in practice.  I
>    haven't thought things through.

Yeah. The real tragedy here is that there's no way to signal that a file
*is* a symbolic link and represent that as an error code in errno.

So I think the best that we can do here is to continue to report
ENOTDIR, and have the caller figure out what to do with it.

Thanks,
Taylor
