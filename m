Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C04C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 13:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B3E2084D
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 13:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9kSOlPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgDXNVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgDXNVX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 09:21:23 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89484C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 06:21:23 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 72so12311624otu.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3iMDfibJ5VfgQbD9QlreGsfR3zdTdK4lT8pfMpVjDG8=;
        b=E9kSOlPqtpKlQ057keIJriIMG2RxLg1Z+VZkp4mc6F3f0dfG7jJ2N3mIPbHFybeu/D
         ySgSECwEhAHZ5QRXoJkznwsFr1oimiYDFlBUvvCrJU55YE8x/FV/DnaGwxl1Fk05qYHD
         RyogTCxRsGpCkPuRxa0vgim17UUeR6qhXfrAK01PrfhSMyL+NuOfWvlxNSeDtdgNCIbj
         3FekKuAb1WuufkXe5o2BMuvkNGo7DovoPLYQNRyOFd10zBTxzjS1HWaWkQ8DK5AwiVvs
         /4SZ4zwkTIrgaPDDGFpYaiDp6sUx28AZu1sb5tU8oxeald55bXG9bRs0X3dLxkSQZT5u
         uRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3iMDfibJ5VfgQbD9QlreGsfR3zdTdK4lT8pfMpVjDG8=;
        b=mpsJ0QVA1KbcGxGKBQAP4Y/BJmDG0UJEwTlKcLbVtJspgbg7riS+vv+yJBcB3him3w
         3Vos5SoyRhwSnXkaEeUehmW2yON44Fj5tUkkea1v9ldqEGDdt4RHzWot40bFLNuwI5Uy
         l+k5S8oDsbz5phLOu6OSksie0pvTTrFx995ZhigqGXL88fBCT6ZSBqr7YzkG4D60MgKb
         fCJpBc562480yJHrrzpI6FQjEFTyz3p87bXtKJCHUL4hO5QlHo+YYGYGk2kIHGLu4nlx
         vaHb+Wm+afEOqbdiTVHBbFMUowSx2AxKKGMhOjkrpaCVIjG/LB0cGld/WqE31JnCwoP/
         vhyQ==
X-Gm-Message-State: AGi0PuZix4NjD4+xnim0WyKw3SGAigzi/Ygr9QpaXSqEbOvAmZp/GTrY
        zUkmtYPGhMNl4u4QwMXiD1p1Zv88jf0=
X-Google-Smtp-Source: APiQypKP1XzZl7J0hD1Uv7AentD3J1/oodEVV/wZrcyUNfHrXYyp8LWxms72vjkfhtwrTAlcJWw2BQ==
X-Received: by 2002:a05:6808:b0c:: with SMTP id s12mr6979037oij.163.1587734482695;
        Fri, 24 Apr 2020 06:21:22 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 1sm1554830oir.5.2020.04.24.06.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:21:21 -0700 (PDT)
Subject: Re: Commit change disappeared from repository
To:     Renato Botelho <garga@FreeBSD.org>, git@vger.kernel.org
References: <7b4f2b10-e80d-d4af-6154-6665e37da623@FreeBSD.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7dec4168-9eed-7f89-e33c-db0b50157407@gmail.com>
Date:   Fri, 24 Apr 2020 09:21:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <7b4f2b10-e80d-d4af-6154-6665e37da623@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/23/2020 3:22 PM, Renato Botelho wrote:
> Hello,
> 
> I'm sending it here to devel list because after asking around at IRC and
> also to friends we ended up with no reasonable explanation about what
> happened, and it lead me to consider maybe it could be a bug (!?!?)

This is a common confusion with Git history. The best description of what
is going on is [1], in my opinion.

[1] https://docs.microsoft.com/en-us/azure/devops/repos/git/git-log-history-simplification

There are other history options that will likely show the error.
Specifically, run "git log --full-history --simplify-merges <path>" to
do a full graph traversal and reduce the output as much as possible.

99% of these cases are due to someone resolving a merge conflict incorrectly,
and you'll find that merge with the "git log" command above.

Thanks,
-Stolee

