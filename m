Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851CE7490C
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjJBUO1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 16:14:27 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031CEAC
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 13:14:24 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-775751c35d4so15116785a.0
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696277663; x=1696882463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf9iDuAM2t1u/YoSCsd0vSCqK8gsUg5pVKAGO+sBB4U=;
        b=yYtrif+qqz7MVMmWEvQworW4jLNhf2gEuWAJoiH3D438AsmzFFjI298XIiWZMQII4E
         P/qyd0pj88tKAvk/rxgWebZHNR6Fph2fdBPfFXUVRFgirPDm1dEgzj6rmKoizm1NX4S1
         lUJ2jd7dSKyZJOsRy0VrVCV/XBITltz4BiYwQfmmVbuIckzPlvLh02YMhGMzQP7u+P1d
         mmJ6rG0docgwGftHxzg84M0Dj85zv6KokGoZ2gUXsY0VT+/aSM5kg8YYijsAUyQdHqHQ
         D81JWTNdim613xMEj2MgDB8jrNpkwM9o39T3X93I69tH3FBVs2ATvcgf45hS/5ms/y+6
         j62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696277663; x=1696882463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf9iDuAM2t1u/YoSCsd0vSCqK8gsUg5pVKAGO+sBB4U=;
        b=PieD97Ut717D4ojx/unhNx0gVt0v8fPI5cguRsDj9Xo/4LOPSIj+tzk0A6fDQN6d/C
         U6TUCiHDkSRPJ01aY3kc8MlfitWjf78/JdIEs66PdoN4Q5etwJlAtA3imgba1aYoiLLm
         +GrnCrEt5th781KzEtm6Mr977PGAMFNgAW3Cdpj2EW68dWy3bfmtq1rJSdyTCmdVLR0L
         sTU2UOBGXV1HgynW0B3isMHtopSsy/FIc5b2XrQTqY/4PsTM7hV89KmLhWIofBcpufTS
         YFB2jo+B2LnJCIpjvwNVaA9FuXZgk3/Fx8C6ZWizleKfsfYDVoTyCqzOXUgWgMzsNEaD
         PRSw==
X-Gm-Message-State: AOJu0Yz+SCfW4cfmtRe7oaBVu5NHFTHg4054fRYug0hpD+mpWzxkoRTA
        vyIhzZT4iODMLLPc8gxad/ERZg==
X-Google-Smtp-Source: AGHT+IG5ZHR7/n2Z9t/xAFILGNRua0PmWxSRbYVJ1MkLPHNC8cukZiumxiIdhjzlvsUZZW/NnHo9bg==
X-Received: by 2002:a05:620a:410b:b0:775:a44b:6513 with SMTP id j11-20020a05620a410b00b00775a44b6513mr5674702qko.16.1696277663014;
        Mon, 02 Oct 2023 13:14:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j13-20020ae9c20d000000b0076cb3690ae7sm9267208qkg.68.2023.10.02.13.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 13:14:22 -0700 (PDT)
Date:   Mon, 2 Oct 2023 16:14:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v8 0/9] Repack objects into separate packfiles based on a
 filter
Message-ID: <ZRsknb4NxNHTR21E@nand.local>
References: <20230925152517.803579-1-christian.couder@gmail.com>
 <20231002165504.1325153-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231002165504.1325153-1-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2023 at 06:54:55PM +0200, Christian Couder wrote:
> # Range-diff since v7
>
>  1:  eec0c09731 =  1:  b23d216277 pack-objects: allow `--filter` without `--stdout`
>  2:  19c8b8a4b9 !  2:  27e70ccf39 t/helper: add 'find-pack' test-tool
>     @@ t/helper/test-tool.h: int cmd__dump_reftable(int argc, const char **argv);
>       int cmd__genrandom(int argc, const char **argv);
>       int cmd__genzeros(int argc, const char **argv);
>
>     - ## t/t0080-find-pack.sh (new) ##
>     + ## t/t0081-find-pack.sh (new) ##
>      @@
>      +#!/bin/sh
>      +
>  3:  aaaf40bd5d =  3:  7e692c4cfd repack: refactor finishing pack-objects command
>  4:  1eb6bc3f7e =  4:  227159ed4e repack: refactor finding pack prefix
>  5:  b9159e1803 =  5:  79786eb5e1 pack-bitmap-write: rebuild using new bitmap when remapping
>  6:  f2f5bb54d3 =  6:  205d33850e repack: add `--filter=<filter-spec>` option
>  7:  7ea0307628 =  7:  16b1621169 gc: add `gc.repackFilter` config option
>  8:  698647815b =  8:  92a5ff7cc7 repack: implement `--filter-to` for storing filtered out objects
>  9:  57b2ba444c =  9:  5bfd918c90 gc: add `gc.repackFilterTo` config option

These all look just as good as v7 ;-).

Thanks,
Taylor
