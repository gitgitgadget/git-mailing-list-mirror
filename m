Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69FC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 03:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235362AbiK2DtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 22:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiK2DtX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 22:49:23 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC44D5CB
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:49:22 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d2so3938134qvp.12
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 19:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYUPpCpRTQfVQUvxdEBIvotl3EcLt2SWon2LYybGGSM=;
        b=ZZsrIglnmmCoiC69ygg3FpXyb5TdOZostGrrpHNrevHBmmYIwNhDT7VSn0Iy0aLL++
         QzScU/7Nu0seQtlXSoUwCZ79fV3iZUy+qkJXKc0yHQG23uyj230s5SbmbbwDPTaZtvNw
         w73SRv3TAajQUkVjQSQdWTyb+hfgoQwIW+fdf/1wEYqVqEXIaVZaRqLO3JwsfwRX8TbR
         j0Tbs2iI+ALfIVSzUmGgdnVeG7dtWZc7ObV2+4ZMDjXuIu6pAfJc5PhQq/ZfG7jNzXN7
         CeMOhRZcVOqISOszQvDCY869l8FR2InDV51LVaM32t/BtXtyMrm0ahQXlUhaBp8yt+v1
         cttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYUPpCpRTQfVQUvxdEBIvotl3EcLt2SWon2LYybGGSM=;
        b=wgJxZ00MHYGV/b8PgxDS0XbHrs+cdNheQ3bdxxfJaTsx+H23u0r0I7jwrBKaFgjrf3
         +epSmO0yTo9IV4TG0vBRM5pyChH+r2+5FoG4ubiDlAsVOu+Dw1bnH5ZwcVfb+O6dg1I8
         XjXUjawXUlJIr+/zsTryxmErHdN6SYwrtmOzMzjl18sDY2VlgMDW9X73EjwDrB2kGvWi
         Zhe63yhAeH7ORLByTRqgf16mqIvpcbzUG97IXtCEEflJE/0fMNgCl7s4lsA40ZydA540
         k+Bt/5YwGl1QdnuqPkWV8zKq3dHYCcjElU8DEAV8t/rYeBsF1ga0SKJaJVFyWNRli/rc
         4Nhg==
X-Gm-Message-State: ANoB5pm9JVY8a3RoRIDO7UT1gbp57wN+b1rsA5gUlRcshIz8HArM9ADO
        2F/MXU4HbWVxfcYe9iwmIeYJONpU1zJMmK4iHkQUc7SCz5g=
X-Google-Smtp-Source: AA0mqf7E6A+I5U8OXeoNQcVDbK0rXcb15GF0lDX1zTE2t7igizWsVNNFOuV9HhF+h5k39uk/Td6Cbq6l/tTqr8yjef4=
X-Received: by 2002:ad4:4e85:0:b0:4c6:fa37:1d16 with SMTP id
 dy5-20020ad44e85000000b004c6fa371d16mr10731965qvb.106.1669693761025; Mon, 28
 Nov 2022 19:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
In-Reply-To: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
From:   Ping Yin <pkufranky@gmail.com>
Date:   Tue, 29 Nov 2022 11:49:09 +0800
Message-ID: <CACSwcnT9Pz3snq4Jp6K5qxHFiE_zo41bKVUjJ_LJ39WN7h=gbQ@mail.gmail.com>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
To:     mailinggit list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

sorry, typo, s/--color-words/--word-diff/g

Ping Yin

On Tue, Nov 29, 2022 at 11:46 AM Ping Yin <pkufranky@gmail.com> wrote:
>
> Result of "git diff"
>
> -  =E4=B8=BA1
> +  =E4=B8=BA2
>
> or (if chinese can not be displayed correctly)
>
> -  <E4><B8><BA>1
> +  <E4><B8><BA>2
>
> Actual result of "git diff --color-words"
>
> <E4><B8>[-<BA>1-]{+<BA>2+}
>
> Expected result of "git diff --color-words"
>
> =E4=B8=BA[-1-]{+2+}
>
> or (if chinese can not be displayed correctly)
>
> <E4><B8><BA>[-1-]{+2+}
>
>
> Ping Yin
