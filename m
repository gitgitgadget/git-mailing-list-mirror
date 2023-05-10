Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C7C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbjEJCTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 22:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjEJCTC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 22:19:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C3B2709
        for <git@vger.kernel.org>; Tue,  9 May 2023 19:19:00 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55a5e0f5b1aso63902877b3.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 19:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683685140; x=1686277140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3YkEn6GnzXKVqgcT3rIr3H2R2YXovDZdWOMELRH22Mg=;
        b=CDlg22v4WmY+LxMdZ0RB6zOt2cjR+YVU21DSCj/Kk4yXlJv84m4DG287IE3UI+OZr+
         rfJcUY43sEoWu1xq1uuvQN8GeQNqKsH6k8KcPd3dHVCUR3WJp47Mhfl1mqDoC3tWWPEv
         1ZmHKGPvp6DH4f+P7f5ljNIV6LthH2EGtxKiDne/xyMKC1aZG4mzkge66weR4455O5mn
         K4po1jif+s35suHCExouwpPzltQ6B2xfgMqTuYV1vhpewSPz0wAZd2ePxFALyyOdOK8L
         6TmFVSgIWVsoz4qK6BBqLoOHIHD9+XTuijUiDERfXga6t/lRM7KtAZzXUw1wnKAOaAzF
         iUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683685140; x=1686277140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YkEn6GnzXKVqgcT3rIr3H2R2YXovDZdWOMELRH22Mg=;
        b=FXaGvY8uHteqLwTgQQfZEhz0mo0fXNPPZxVJfsSMe/T5D8mSce4OO3JVFjezIWbex5
         nWkFccgDCq/AX3BpSn7nyBkKYolZWWO2dcvdM7JKEewCEVY6TPMT5ikj4INZPZBi3zcQ
         7ph608M2n3QlgXhmXDTawt+u2rB0VPbONZ53cjlFrG9I3m+uXFPWSMoMaKQapgbuyfAw
         lmg/VK0z5WXjYe/wnRG6Yk9oxt8BEaCVH8OIFKMXayHU0nxcM2jqS84kBM03dbeiBnje
         k2s/SUVBDIkVbSlVuRzZexHomuRPjFvKZGeWQ3/oqiWgn9saOk+4OhQl3a2APztKpD6e
         ZUnw==
X-Gm-Message-State: AC+VfDyuvFDKyshtxlnUFydJkipvR3HppjKNwOCIRtsA7/CUC2HC8pjf
        ABmFb62vlm0JBifb1LCiOu/K971/kwSzZI1oni8e/Q==
X-Google-Smtp-Source: ACHHUZ5DfOE8pFIVwSI9jFQzTTN9U5sQU9Eh/gRP4cgH0sKlc14psFOIOJMcTr9FZRbYokWa5hd18g==
X-Received: by 2002:a0d:e0c5:0:b0:55a:1cb0:7982 with SMTP id j188-20020a0de0c5000000b0055a1cb07982mr18423551ywe.23.1683685139962;
        Tue, 09 May 2023 19:18:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p75-20020a0de64e000000b0055a9c2c8faasm3705239ywe.60.2023.05.09.19.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 19:18:59 -0700 (PDT)
Date:   Tue, 9 May 2023 22:18:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #03; Tue, 9)
Message-ID: <ZFr/Ef93eGZ4YKXY@nand.local>
References: <xmqqmt2d0x0f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt2d0x0f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2023 at 06:56:48PM -0700, Junio C Hamano wrote:
> * tb/credential-long-lines (2023-05-01) 7 commits
>   (merged to 'next' on 2023-05-02 at f027002b92)
>  + contrib/credential: embiggen fixed-size buffer in wincred
>  + contrib/credential: avoid fixed-size buffer in libsecret
>  + contrib/credential: .gitignore libsecret build artifacts
>  + contrib/credential: remove 'gnome-keyring' credential helper
>  + contrib/credential: avoid fixed-size buffer in osxkeychain
>  + t/lib-credential.sh: ensure credential helpers handle long headers
>  + credential.c: store "wwwauth[]" values in `credential_read()`
>
>  The implementation of credential helpers used fgets() over fixed
>  size buffers to read protocol messages, causing the remainder of
>  the folded long line to trigger unexpected behaviour, which has
>  been corrected.
>
>  Will merge to 'master'.
>  source: <cover.1682956419.git.me@ttaylorr.com>


This has been in the "Will merge to 'master'" state for a couple of WCs.
Are you intentionally cooking it for a while in 'next' before merging,
or is this ready to go?

Thanks,
Taylor
