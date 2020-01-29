Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C725C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 08:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3062070E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGXcL+zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgA2I75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:59:57 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:38156 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgA2I74 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 03:59:56 -0500
Received: by mail-qt1-f170.google.com with SMTP id c24so12653086qtp.5
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 00:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LI6kGYXIDEM/uIbfGcHKSpnvaGgdqL6C2gZ3NGvXmGo=;
        b=DGXcL+zs1jrecC427LE3bisF+jA/VHwzNfuqv50jn+2ARymdq5mKEUeZu4brpqhZxX
         lCy/Pngw7FCFPbN38NY8PK/fgPoxtt7/35peLWNP2WkgMK/5BfzYI+ZWO/2vvfQmUgA2
         0eSbDmhJkL9ejKgfXBRWVqXhuCNqOYZWesP51TxZMH0HQFl91OOrFMdpVC//wEbcAlWw
         5DwLdKCZUKf5Xz8pr/j4jwZBtTQ7czNbewzxgZHQruoe7IInpPfEIS0u8K2Vzaq0xjpr
         wF706IGcvigWDzG7ifMIx0L0e7N71lO9WMp5+C9HzsDDcYWfVjTZZ/twKbEgg9DQALvz
         f+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LI6kGYXIDEM/uIbfGcHKSpnvaGgdqL6C2gZ3NGvXmGo=;
        b=G/tXloGB5cTvArdKt+CZMqi6hl3MJiKwGrOwOkyFZpO6lWWcgd4aeEXLZdCS1nhihr
         EW/zpq+O5jFC+ZIMqbF3Vm/1IP/Be3ohKqCTLl5zV37HhOFVbtNZ92JH3L1H+jA+9trc
         6ngK63WjM6uG5+lD9lS8KX2vqkd4QqD76gzRNw73ZoPvgCv4otB8xd575ZKYERPzX5PY
         vTk1cwTRZQjmROAHv4LcFXuPm2uKvi7m9H4WX7zjq9nKE8hQ1iyCxsY47uIY+woRYtmA
         kFFk5SCaBoM9PCByUbOBdP504ks1qn/kEjTVd+VkzNocLyMkc45VdBqs15zSnCVE61VV
         1fEQ==
X-Gm-Message-State: APjAAAVnZxLqLuOfq8yuyAPkY6eIh8JIRmbgfQKI7dgZmKp6fQeWs19h
        IkhI21EYoWywLkXlyrfnkqOzsEfu
X-Google-Smtp-Source: APXvYqxahCa22auMReiEcgfQ/lo+Ou16LklToVC9J5/7wo62xSTQo57UMYdQC/WwvMPkg2KRpvAtNA==
X-Received: by 2002:ac8:4d0b:: with SMTP id w11mr22804604qtv.385.1580288395847;
        Wed, 29 Jan 2020 00:59:55 -0800 (PST)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id f28sm639010qkk.130.2020.01.29.00.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:59:54 -0800 (PST)
Date:   Wed, 29 Jan 2020 03:59:51 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
Message-ID: <20200129085951.GA124241@generichostname>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
 <20200126200728.GA233163@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126200728.GA233163@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Jan 26, 2020 at 03:07:28PM -0500, Denton Liu wrote:
> This commit has incorrect authorship information for Stolee. The author
> is listed as "Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>"
> due to a bug (which has been fixed) in GGG. We should fix the authorship
> information before merging to 'next'.
> 
> On the topic of faulty authorship information, I sent along two mailmap
> changes that were dropped[1][2]. Could you please pick these up?

I see that you picked up the patch for Dscho[1] but not the patch for
Yi-Jyun Pan[2]. Was this a mistake or was there some other reason? The
patch got a "sort of ack" from the original author[3].

> 
> Thanks,
> 
> Denton
> 
> [1]: https://public-inbox.org/git/20200114024938.GA17003@generichostname/
> [2]: https://public-inbox.org/git/21b8a0d08764c31de12ef7661667eb1117d41ac4.1578972215.git.liu.denton@gmail.com/
[3]: https://github.com/git-l10n/git-po/pull/408#issuecomment-573991430
