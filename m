Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07006C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 00:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiKHAcp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 19:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHAco (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 19:32:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ADE1DDEA
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 16:32:43 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z3so10322695iof.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PpFmJzWs1QCzP4vtXyzCxL5uWZ+M3dRPulExBxC0Mk=;
        b=E/npuAyfUT1h21c208Spbo8ozRcCmkJO3nGs3YS881XUF/Pg22IprPzSn+UgRPKpW7
         RBqA4gJH65aK79vdqzwZvekw2hvR5TO6lbVG9KQBqnm36+tSOdhQWoSlmd0PnAEf0yYe
         R4BQIfTkIHxbhVKB57GzWSBCk11Pogbzo4gualj3v7GfVLn/vOh4UA7LYuwtTf+H0pEB
         lYWkxtljCmr0V6dxOAvz4x10i0IcIcJ+VvlXazDrSQswIOBEZkv2227SWByBRRHrZ/JR
         lVqTMPWGWfx4nDy7xggAOJ17cBaum6VTBG8LBIRVJ1l5ularB9cVSH/epkLFEQFBtQY7
         snWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PpFmJzWs1QCzP4vtXyzCxL5uWZ+M3dRPulExBxC0Mk=;
        b=mMId5+B+v/BrFsTzb7lpOWgjSgo+SCwJuP4DH3vK4yhAV3mlFJYzaiXYCHOfdF6WwE
         9ArLcl1oTUi0aaWM1bZnRYeA++sJlY1aWGGCZlUfiXxW5Ayay1PdgIlofPU7D/TfuHcM
         LcnMQeZRswzmthoF8ix+qCqf9x/WwmCBa5b61tkuADhZTdKejHf8p+QzhjDU3ZvHoQLl
         13QfUpckOCfZzorXC5kC4sO7xga2an5wAxbwGkthoc0FakSwDUaLC02NrtvEm/jcReAL
         TUwdRKmk8MP0qk3m8KkEkqs96fz7qUCufh8q0OIc0K0M8IkevrQJl1Hg5rEol7fdMcp7
         pAcg==
X-Gm-Message-State: ACrzQf0o9JkXmKD0frCpJN6b1JAgPGapC3P6YZycEmGucNKqnhtFaWqf
        GT8pDZxFh5JyeNDsJ9UHGdiLjGxcdhVSlw==
X-Google-Smtp-Source: AMsMyM7kYQByLW4gp9V51WzKs8i+5GNu81dYEOKX52qBVAq3sX7DAdlcFc//qllr+6axOsSuvfGQxg==
X-Received: by 2002:a6b:cd48:0:b0:6d8:7cbc:80b2 with SMTP id d69-20020a6bcd48000000b006d87cbc80b2mr10362474iog.195.1667867562350;
        Mon, 07 Nov 2022 16:32:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z101-20020a0293ee000000b0037556012c63sm3204161jah.132.2022.11.07.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 16:32:42 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:32:41 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Message-ID: <Y2mjqUT95dW8LMQk@nand.local>
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
 <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
 <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
 <221107.86a652vfth.gmgdl@evledraar.gmail.com>
 <Y2l8xhB+PGS+jBmQ@nand.local>
 <221107.867d06tluz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.867d06tluz.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 11:36:58PM +0100, Ævar Arnfjörð Bjarmason wrote:
> So, I'm (now) saying I don't care which form we use in the sources, but
> that' it's useful to document things as e.g.:
>
> 	--no-checkout::
>         	No checkout of HEAD is performed after the clone is complete.
>
> Instead of e.g.:
>
> 	--no-checkout:
> 	--checkout:
>  		Do we do a checkout when we clone (doing a checkout is
>  		the default).
>
> Because the former convention shows the user at a glance which of the
> two is the default.

Thanks for clarifying. For what it's worth, I slightly prefer
documenting both options as long as we clearly specify which is the
default behavior (and thus implied).

But I definitely do not feel strongly about it.

Thanks,
Taylor
