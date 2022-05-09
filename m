Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C34FC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiEIQbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239063AbiEIQbK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:31:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9141921AAB7
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:27:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf18so11598557qtb.0
        for <git@vger.kernel.org>; Mon, 09 May 2022 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9TE1N7Fb7Gy5GOuurGgQd1cQxccC1aAj1ZZaPsLY8U8=;
        b=KLDcoTvK9HKATkxyW/PW394mD+lk9MFFGjLF/DTVQ/KLE85paW4meSQxzbC80QjHtF
         E+6nIb3kENe5pXBNPM3pToeyJRQqhI3cBLSbPKIRzn/GfupPVN/7P9xcJeF1tk/jDuVZ
         4QCira0WrRJvJjPX/9i3EuUVauNU3PzE8kbh+MFhZQqZQa+xjScVQ71MS/Tb6/WPjTpk
         c+YDJMwF8cVAw8pU9UaHUhAy8LHFJSaqP4kQusKUL4P++njtoQh/LwFAi8o5dWZPXzyv
         aIrgtabC+Y/kyzyzVToBvbc43NZdVVyid8FblYwJo6hvN7++VwluEzxEVkKNQBLvCb35
         jHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9TE1N7Fb7Gy5GOuurGgQd1cQxccC1aAj1ZZaPsLY8U8=;
        b=zj3kqvaXLONDISApAalcyF7uQF3r09fC2YtM8B2ioyvv4dLW2ls72I8+pvo0vFP4xm
         HobS09H+vV6b1neHOrH7AB7H7GNpo8BMon4GocRxL/a5wWKAO0oyokJBILdI4NO7dck8
         ogbfA8vZjBv50YscF8ciD61cAvSQcjpScOaMJN3ns0qgTG4v1sBiMO47DclfsC+27AMb
         WSPgNcxzXB9CV9RgUvAbDUUQzFMZMQp03+Zq0HWxOt4SaOso7Md9rLjRkQbh5XW/zKcj
         0D6l1AcP1JKXYzoZU9KzOZH/MTiiuNkngPp7jbvinXVcXusKMcasBhbCo9MJNFxFxG1W
         PVxg==
X-Gm-Message-State: AOAM533qsuJQlq35GrCxj8q8H3wwKYbL2fuFEV1cvsOC5HD4n0UNK30c
        u6Rckrpp2DoR6hS0iNHKuuVlww==
X-Google-Smtp-Source: ABdhPJyZYdszs8wvyQpVnVENoSbvngD3fq9SAiIRiUoVgPlq6qX8tRKJfZ5T/LDLG2dw4AaL7xQq6A==
X-Received: by 2002:a05:622a:c4:b0:2e1:cb5b:9b5c with SMTP id p4-20020a05622a00c400b002e1cb5b9b5cmr15627049qtw.69.1652113633706;
        Mon, 09 May 2022 09:27:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a26-20020ac84d9a000000b002f39b99f676sm7813165qtw.16.2022.05.09.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 09:27:13 -0700 (PDT)
Date:   Mon, 9 May 2022 12:27:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Chris Down <chris@chrisdown.name>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <YnlA4NpNMuyVkQIR@nand.local>
References: <cover.1651796862.git.chris@chrisdown.name>
 <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
 <xmqqh762le32.fsf@gitster.g>
 <Ynk2q1XVGsLPvALn@nand.local>
 <xmqqv8ueelip.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8ueelip.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 09:08:46AM -0700, Junio C Hamano wrote:
> > I don't think so. bisect_log_printf() has only one caller, which is
> > bisect_print_status(). Couldn't the latter manage its own strbuf without
> > the need to introduce a new varargs function?
>
> I actually was hoping that other existing informational messages
> prefixed with "Bisecting:" (i.e. those that tells you how many steps
> are remaining) can go as similar comments to the log file; they are
> currently written with plain-vanilla printf(3), and could use this
> one instead.

I see. In that case I agree that we this function should take varargs,
and it should pass that va_list to strbuf_vaddf().

But this patch shouldn't reimplement the wheel here with a bare
vsnprintf() call that could be replaced with a strbuf.

Thanks,
Taylor
