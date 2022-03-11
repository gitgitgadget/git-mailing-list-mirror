Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343EBC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbiCKQx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCKQx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:53:26 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC1618F22C
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:52:22 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id y20so1951503vsy.2
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrBPDMXbse0tAWSvrBbeVYRzMdnNc5YgYKFx9dIrang=;
        b=TB+jPpSt2aLOgVuvEhqf1EQsINQ7HH+v+hf9+6S2zY9/181m/P239EYHrZ6JSAGAu+
         b/ySB39UqoNGIuKXCiQR7SLWHFPIQA3H6BgOV5rrFqQCbv1X7SGYRzCTDxoe+MYbV28N
         VxwdwRK/sWLoSbSx23N+nNVqokZpwwuA/M6PwbOcE7LYA+FXCcflgxWsGvDp3x7sIwUP
         d+1ndKSAiF2KN+OgX8Tv+hhXMw6tlSVqkO+tDNFq3bQxoMMzET+JBKFJEHnWGjdbG2xT
         b1SusPYvFE74m3k5GFhPJUOU/hrXV4bLxdKBrdJJ7KvvRKLbPDVcctl+wkBX2DTzEvZ6
         pzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrBPDMXbse0tAWSvrBbeVYRzMdnNc5YgYKFx9dIrang=;
        b=eT1a4qvizbWNlljC6U0MDkMHrBqkhKU0LFC/4pq6v7RN7WBQeSJJ2DqJV3dG0ajqjE
         2phKKO71yKrSFTG6V73hfhlMfEZL2r1ROrb2MaWjwJxaHz6rr2bVsZ3a4GFfhTY77G2n
         +EfuEp9daqnkVePIIT0ZNhanl0btR6AgIvth2/MJwyZR5G16FGwda4GNQxOicLYreMEl
         zsfCVWx0l0eXVXHI0Lok+HrqRwp4Lvjhr3cPdXVQ4QPEGVKMbksxXe/UY3GyS7oz4FBx
         heNEj8BQRhbZ2FilR3S7q8EASO7zREkFhRRy6N3/Z8QVEzgleC9gxtD9zeqjERxIZwl1
         b8bw==
X-Gm-Message-State: AOAM53325a7J7EWF0kFuMNlwcet/mYy73j4ZEpdlF7VvmQuQE/8Sgg6q
        il8QdJYwe7PKE5LUEF+utyri9NILHt4hAD9GlgE=
X-Google-Smtp-Source: ABdhPJwaRV6NEr86CtKGP2nL+qo29yRrUmhW6pifWDre6GjC+rMVq1JZ3VtHa/sefW6QOpcTcdZ32JACn1bvaoxGzMQ=
X-Received: by 2002:a67:1a02:0:b0:320:a51f:8067 with SMTP id
 a2-20020a671a02000000b00320a51f8067mr5847368vsa.38.1647017541610; Fri, 11 Mar
 2022 08:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com> <20220309110325.36917-2-phillip.wood123@gmail.com>
In-Reply-To: <20220309110325.36917-2-phillip.wood123@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 11 Mar 2022 08:52:10 -0800
Message-ID: <CAPUEsph4Gzd4S_YNeCF+uHntGWXdcA2wY9XL=-+MZtJ0YZb-Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] terminal: use flags for save_term()
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 3:04 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> diff --git a/compat/terminal.h b/compat/terminal.h
> index 0fb9fa147c..24c4df4c0e 100644
> --- a/compat/terminal.h
> +++ b/compat/terminal.h
> @@ -1,14 +1,19 @@
>  #ifndef COMPAT_TERMINAL_H
>  #define COMPAT_TERMINAL_H
>
> +enum save_term_flags {
> +       /* Save input and output settings */
> +       SAVE_TERM_DUPLEX = 1 << 0,
> +};
> +
>  /*
>   * Save the terminal attributes so they can be restored later by a
>   * call to restore_term(). Note that every successful call to
>   * save_term() must be matched by a call to restore_term() even if the
>   * attributes have not been changed. Returns 0 on success, -1 on
>   * failure.
>   */
> -int save_term(int full_duplex);
> +int save_term(unsigned flags);

s/unsigned/enum save_term_flags/

Carlo
