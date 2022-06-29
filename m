Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2AFC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiF2RLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiF2RLA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jun 2022 13:11:00 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975F1A818
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:11:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z7so12496169qko.8
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGKLaqaoALTeekngFIqkVERgt9u91+IwTgltGHzrHNE=;
        b=1/brD5juQQ44QGWds4ieWVMHCftZMCaF9C6iV4bYByRArJDT7k72As79CXG0iG/QQM
         pjoPYJHsc8xmfzEV9L+BipQLEaK9BRhuiBX1A/0tKOe3QVvsAAGvy7RgtmtbQ74hRkVN
         re+9IUTZ6kfTI4H1a7VYOJvdLdULTlPdWy+2987YXGFuTVA8PGkodscqoETit+kztMBI
         sSny6fvXTALTlnKBk9seRb8GXwfCiXLJP5OdtRq5vx6ue1kdWmAHPaZb4RGz+dygYeRe
         p+Y3uOjT/groZTgRGH9LF5YDcLhve8ygvWhpc8QLOGgThZsH9IPl7k+lxHss8Rrw2zeK
         udzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGKLaqaoALTeekngFIqkVERgt9u91+IwTgltGHzrHNE=;
        b=uHa/6yml5MoTEV6kD/Y5UgWz/L/3N+nqHixOpQEgsAXGcDtDzHOgdTV6oDYvMcoSLP
         TJVP9YBjRpM4h/GicAAAL5o2Fjh0u32z19+qRxhx/uJNyl3s0Y8V6pA2NXeT0XnzkN/b
         HyjzHizz0Mc35hBx10QaOERkeO+1kEIoa28jO3bk5kVRMOUhcmrbJz4+P4s7zrunLI75
         7J566Y2i/bblJcyFEHDKCY5nfdPTpGBR8/cgWudLp5agQODvxmJVAR+1QfCD5zIURFDl
         LgmFBUs5fcDlni63Zz/q89logGYkQq9LqK6bqw9z5ePkOFbqo53v+cGP4N7DyUo136Dh
         QTKA==
X-Gm-Message-State: AJIora+VlHymDji/jOHpXt4Z/ljRqdDCRtyDFD2XiRrvDdsmSfdDz0tM
        gUDtdN+n2uQhd693K0C32McZRJ3BJVS+vA==
X-Google-Smtp-Source: AGRyM1s9GIKI2vKAUgw4XmTtr7o/QRymqPWAJ1KN1TYuTriY/UaScGk5ppAyOjnZ3G9LZfBXAUlf3w==
X-Received: by 2002:a37:a644:0:b0:6ae:ea03:83e8 with SMTP id p65-20020a37a644000000b006aeea0383e8mr2910813qke.775.1656522658942;
        Wed, 29 Jun 2022 10:10:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm14982851qko.34.2022.06.29.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:10:58 -0700 (PDT)
Date:   Wed, 29 Jun 2022 13:10:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     stolee@gmail.com
Cc:     git@vger.kernel.org, Gregory Szorc <gregory.szorc@gmail.com>
Subject: Re: Race condition between repack and loose-objects maintenance task
Message-ID: <YryHoXhmkvkl6X2j@nand.local>
References: <CAKQoGamCrRMqtzziuzi8mL6E7uA3SC1WXiMGT_4rpbk1jcu_OQ@mail.gmail.com>
 <YryF+vkosJOXf+mQ@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YryF+vkosJOXf+mQ@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 29, 2022 at 01:03:54PM -0400, Taylor Blau wrote:
> I see that Stolee is already on the CC list, so perhaps he could chime
> in on the above.

I haven't looked at the maintenance code too closely as of yet, but I
have a plausible explanation for why maintenance is removing loose
*unreachable* objects.

Ordinarily the loose-objects task alone will not remove any loose
objects which don't already appear in a pack. That's because we first
try to run prune-packed, and then the equivalent of `git repack -d` to
consolidate loose objects together into a single pack.

But, we only do that for the first 50,000 loose objects. Anything else
gets left around and then is likely removed by the `git gc` task which
is run separately, and after the loose-objects task.

Using cruft packs won't change the race fundamentally, but storing the
unreachable objects in a cruft pack will mean that you can keep more
objects around stored together in a single pack. In other words, making
it safe to increase the grace period beyond what you would ordinarily be
able to do with the classic pruning mechanism.

Thanks,
Taylor
