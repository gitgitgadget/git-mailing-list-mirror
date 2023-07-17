Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65BDC0015E
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 20:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGQUOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 16:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGQUOj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 16:14:39 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B62B113
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:14:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b9d16c1f3bso1365872a34.2
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 13:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689624877; x=1692216877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl7o+6owiMyt8rrL5DLhu3N1OL+7R/KUIM0C7Oz4M48=;
        b=JkUCWig1IFYgdcD8mlpMzobiFAdL+D/n40NSB+ENoOgtY/I29uo4QBpPHe7g02fZzS
         9NV0Zi4FiGxdpU17lcGMSDy3PaSfXk6fbDEKCGoQih/Q8AP9V3NtzHBm5W9PoCX9+vJt
         cYrUu5YhIjRcfr+6ih82bmShdwaUv3c9X2FF+6k6LYlx1/bqknu4iqTg/63ytrYblEDW
         ab3QrM9rXB4jNeHSgqEo8xbn0rxETcrVZ/JIUNdVSBPzoI3zLvPgR8HzE0xccNHIaDbP
         H3jmbFrZY6ZOR/IxtGzB5QRIxANdIEvycc3J57CF7G0Mupzn2WfbjFDOHWm9okFseo3j
         RVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624877; x=1692216877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl7o+6owiMyt8rrL5DLhu3N1OL+7R/KUIM0C7Oz4M48=;
        b=SljcR/QV+X74yfh947iKwL77HWTsjHFxJtQNm49f7nIR2n2yfHaVZWqtPFz8lGq0Vo
         VhPYFxOQPu4p9Ni1QK8+bP1+Ef4EE1+AxEVCxTT+zNmam81t1ZNOUaX+OngZmFDiCqsf
         ecklgoKTaQl+hUkjkeH7YlbBZYJbI6oQsfhg+W1nCQuqpIz2P1IINvqQH2bpckdf2zep
         MjVu16fZJcgCqJTcZxnWS6mlhzYhmRqwqBkekbX58Wnrw7FvqRDW+OUJ90iDkkQCG9Wb
         hBQBd+FI7cpEKk3jnH1GYgwRE3qJSi0Wbidmu9ynOfiEM1QCV/Gj8+5SsFFiwhXO2CUp
         ke7w==
X-Gm-Message-State: ABy/qLYcUtGnBd2kRu4xQNk8G/9chBqdg9B9nB1UBVG17Y50BQyp+C74
        slWp/ptmszRMN1com2v5dYsub0a47JG6p3q3Z8qxQw==
X-Google-Smtp-Source: APBJJlHfTd8ZeO4siBNjn7A+XdyepcGAj2BhtTKhqyOSs1XjS+4AOAx94S7Q7vIIozJQkeMyv1JeSw==
X-Received: by 2002:a05:6870:a79c:b0:1b7:89b5:7c11 with SMTP id x28-20020a056870a79c00b001b789b57c11mr15644461oao.9.1689624877651;
        Mon, 17 Jul 2023 13:14:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j5-20020a0de005000000b0056d51c39c1fsm70374ywe.23.2023.07.17.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 13:14:37 -0700 (PDT)
Date:   Mon, 17 Jul 2023 16:14:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     AtariDreams via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        AtariDreams <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] Prefer fgetc over fgets where possible
Message-ID: <ZLWhLH2xRq20jFFY@nand.local>
References: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2023 at 03:38:11PM +0000, AtariDreams via GitGitGadget wrote:
> ---
>     Prefer fgetc over fgets where possible
>
>     fputc is meant for single characters, fputs is for strings. We are
>     better off inserting sole \n characters as characters, not whole
>     strings.
>
>     Signed-off-by: Seija Kijin doremylover123@gmail.com

I tend to agree with Junio's assessment that adding churn here isn't
strictly necessary / worth it, but if we do end up taking this patch,
note that the subject should reference `fputc()` and `fputs()` instead
of `fgetc()` and `fgets()`.

Taylor
