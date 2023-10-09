Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FDE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 01:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbjJIBbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 21:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 21:31:20 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24B8F
        for <git@vger.kernel.org>; Sun,  8 Oct 2023 18:31:18 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7740729ae12so271723585a.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2023 18:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696815078; x=1697419878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoMkuVqzgHslOfuJPmTiw0SSpwAf/LNQUtArSboiP6c=;
        b=Q5flKhHEq1yPK18kE9NjTh51/yF/h/ut9VVV4bVskdaRmXnKNy6YYp2KOTftXxAyuB
         REzWGrqx824hEeGw/uqkzAQQE7UMWHH7YIOmHxZpFJjcNMKgqkSpANOw956xbdgjN0uV
         kU1tQW8HS4s0XB6qi2CoVDEL43MrNhlzaYPcppG4F5ECyyL0DkBT+uWtT9fWeOBEpL9C
         YIsGsTPhDVnTyl5OAtJdyLKZnz+05Hxt8k2z0AkC/zlZ7188cgk2VVNiY/5EZXRDZIWO
         JN++ZgxT/PpL96Q4zic0pbjYH2+EKML69JeIAp9J0oe7QpXYUaUyTAR4K8wMasEIUtCr
         JGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696815078; x=1697419878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoMkuVqzgHslOfuJPmTiw0SSpwAf/LNQUtArSboiP6c=;
        b=FHExS/g3Ywkq+Qu1Yh7fJkhGHe1jiMUnxWDSM0yoVcpuVV1m2p3jgkgzBfTKejiBsJ
         WVn6OKdkOljeOKov0YUM3tr6kDCny38lErSkEFdBq727Buzxc6JlN7wNbzR87rM9y0l5
         YI8OTL0mqHuXW/ZqOgm6fMrL1EQa51/X4ZBQrSN6d+djtux91byGVttcTf05PitPfvVS
         yE7Afyb1oNDb/XDuNZi8QQ1n5SchJDCyNjbI8DpujODeoLQ+6Hy3JWupn0UPHMswlckm
         +3C+vdfSsQcpwwzys2R7eRjbjAgTDKAT9XQDmRGYVI6K514IhjeICEl191b8G6E7qNZv
         +djg==
X-Gm-Message-State: AOJu0Yw2UXWCrROeRy0i471lfv7d0rGprIGAxoCpoxNZCdVUk4ezy6Zb
        N09ZPRPoFF0r66Lxjuf3qnihpg==
X-Google-Smtp-Source: AGHT+IF6p0ljy1PhL1vkywfTaXSm1FEBXT7vsYCY+0bDW1WUWiBoXa4tgEPMrzb9XLwr5T62uIj4lA==
X-Received: by 2002:a05:620a:841:b0:767:2471:c880 with SMTP id u1-20020a05620a084100b007672471c880mr13619505qku.28.1696815078071;
        Sun, 08 Oct 2023 18:31:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cw6-20020ad44dc6000000b006648514e276sm1242159qvb.78.2023.10.08.18.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 18:31:17 -0700 (PDT)
Date:   Sun, 8 Oct 2023 21:31:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Biederman <ebiederm@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] bulk-checkin: introduce
 `index_tree_bulk_checkin_incore()`
Message-ID: <ZSNX5CQPWOy5B+cg@nand.local>
References: <cover.1696629697.git.me@ttaylorr.com>
 <cb0f79cabb7921ab7e334ad8a467ae84853bbd39.1696629697.git.me@ttaylorr.com>
 <E81727B0-A523-4A45-A606-61442357291D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E81727B0-A523-4A45-A606-61442357291D@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2023 at 10:07:20PM -0500, Eric Biederman wrote:
> On October 6, 2023 5:02:04 PM CDT, Taylor Blau <me@ttaylorr.com> wrote:
> >Within `deflate_tree_to_pack_incore()`, the changes should be limited
> >to something like:
> >
> >    if (the_repository->compat_hash_algo) {
> >      struct strbuf converted = STRBUF_INIT;
> >      if (convert_object_file(&compat_obj,
> >                              the_repository->hash_algo,
> >                              the_repository->compat_hash_algo, ...) < 0)
> >        die(...);
> >
> >      format_object_header_hash(the_repository->compat_hash_algo,
> >                                OBJ_TREE, size);
> >
> >      strbuf_release(&converted);
> >    }
> >
> >, assuming related changes throughout the rest of the bulk-checkin
> >machinery necessary to update the hash of the converted object, which
> >are likewise minimal in size.
>
> So this is close.   Just in case someone wants to
> go down this path I want to point out that
> the converted object need to have the compat hash computed over it.
>
> Which means that the strbuf_release in your example comes a bit early.

Doh. You're absolutely right. Let's fix this if/when we cross that
bridge ;-).

Thanks,
Taylor
