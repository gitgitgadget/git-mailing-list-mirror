Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C4ECD6101
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377153AbjJIQQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377121AbjJIQQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:16:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2AF9E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:16:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4197310af61so32247151cf.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696868184; x=1697472984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DbkjGN4gH5tOrRztuDfokyhQI9eyp4sZLdbKG6Chbw=;
        b=gr8VMv6WJ2T26bYsR7gKjUdusiiqnCeWeVIeVS3EN5duBYzph6XPh62jJHHRx8iacH
         2wZiYkTlTMewdCCsAVsr/Ip57VE2T/OE++dQkDePfTCcfRH8o93ZTrdzG56BSGclYJQp
         y/geOq80M8VFY9ygZh2cv4ympEMpiYv1mr0g89UKtc+fV02e1livYnLwO+xIVbBpfE7p
         d5JLS5piY1XH1upWfH2bsxc/KHNf2jop0A5sn8HJufyDFakFX1eBD/RwLjK59mVpjbnT
         c9C0mZ7BqmLOKzpaE7uirBXwLXe9+uQbJuDg1DqtpiCSEnJvl8dqXeht0cPER60L5xh3
         GGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868184; x=1697472984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DbkjGN4gH5tOrRztuDfokyhQI9eyp4sZLdbKG6Chbw=;
        b=a1b6gzHe1A5wuZ1jvYWR4FJ6CHx3qhO52D9nODdoiI1mBo3q0tMl/USp5X3ZqKlaau
         y2MqdrASUpc1CN27RwjyYlzdNKhhb2OE8FtOAwh8UfuF5XVtFdQl62ppW+/ZaucDHHiy
         17vkaxRe0XygC7pJINFysgTWMsQS8ZehUocoVARV8EeBxjQGeZwWU1+GNxwuA/rjJZ5N
         itD+1qpGYp0QJkgfzLtIZ+wCfVYAxmo0XX00GP5YfQrYA2dIQ+Ps05bExhdvdzo/DaAf
         nho0sqKq566ASDYWUefJa3C+I0SJWIxqdCD29Rr99bcha255j2rh+Gd9Qy7FeEnPB3T0
         ZUUw==
X-Gm-Message-State: AOJu0YyUbdSN6Z+GlXDmlViEXT8Vjlabra6SPK2uMfyvzK3napzpBFi0
        Tgnl5wQ2qtM9EpJcPwcVUDlREujSFD3WxBtIna3OmA==
X-Google-Smtp-Source: AGHT+IFQSXwZlqvdpskH5wxAX6MnF2cHHdsKYpmOuzV+HMR3S7KTZKywzmtxsne+qkAxOXby6lZynQ==
X-Received: by 2002:ac8:7e96:0:b0:405:37fd:be80 with SMTP id w22-20020ac87e96000000b0040537fdbe80mr19995833qtj.28.1696868183887;
        Mon, 09 Oct 2023 09:16:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85648000000b00419792c1be7sm3796113qtt.30.2023.10.09.09.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 09:16:23 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:16:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #03; Fri, 6)
Message-ID: <ZSQnVnK0k3bdk5zX@nand.local>
References: <xmqqh6n24zf1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6n24zf1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2023 at 01:20:02AM -0700, Junio C Hamano wrote:
> * tb/repack-max-cruft-size (2023-10-05) 4 commits
>   (merged to 'next' on 2023-10-06 at b3ca6df3b9)
>  + builtin/repack.c: avoid making cruft packs preferred
>  + builtin/repack.c: implement support for `--max-cruft-size`
>  + builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
>  + t7700: split cruft-related tests to t7704
>
>  "git repack" learned "--max-cruft-size" to prevent cruft packs from
>  growing without bounds.
>
>  Will merge to 'master'.
>  source: <cover.1696293862.git.me@ttaylorr.com>
>  source: <035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com>

Thanks. On a semi-related note, did you want to pick up my patch in

  https://lore.kernel.org/git/035393935108d02aaf8927189b05102f4f74f340.1696370003.git.me@ttaylorr.com/

? That should address a performance bug that occurs when a repository
(incorrectly) chooses a cruft pack as its preferred pack source when
writing a MIDX bitmap, significantly impeding the pack-reuse mechanism.

Thanks,
Taylor
