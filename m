Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA70BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbiD0Q6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbiD0Q6R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:58:17 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A032242CED4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:55:04 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id e7so1190174vkh.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdxFIrxnQcO45qUcw1m0rai4EqeP4tmu2qm69bAQv8w=;
        b=Sw/dUUpPjPYie769EE406EoevzablCtrdj/TEYzZ9Qd34gnWeYLiFMm6dqjPES8zxe
         N97DGom7qMBGWWMnnYDyl30T6JOsXm2YxgITrH33C9NyIgjvCbViRgLUzZQuVdSeVOP2
         SSTapkNdhwzLuNY0NYDNVNsXPl7UBSwEcrfqKddbvgYGL2zehPsSqXpkR9HLZhheQazi
         WdCPPBqPhWF2GaZRFiqqzUXdyG8oA+EsG6K5acciY8EVssL7FPjJMiJU0mOiZyRBYFWU
         uEk/C20KdMfeS8mbFJCF5SuPkP0IHlmRONyaZLXZ7y8t8t5IIJ+TsEVFlL1aN7p1fMFU
         Etrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdxFIrxnQcO45qUcw1m0rai4EqeP4tmu2qm69bAQv8w=;
        b=fwE6u6vKtc1xwQv4j8w+YK1WkWogjQdIzeWESxJJcg0DxrXwiLWUTPHWbpmhvGZh9S
         Io+i17QWN3QqyvueLX7MFPso5OE03blNWRgnu5B1nnPbevVCHKBNYwkXe7fIccKC/T/z
         Q7n9oI1qhvbo6DXfFX6qk7LM7yzsDck7UX5ITnBXhOtafIO1m+oFcC6myYPqBG/rZGGa
         gUFTbSMXjo2oyQ3aEfcoPTGpORPDiUkbeXlAd2MuWLeZxWEY0B65dJJGj9vNFUgsDOk8
         41aOPxjOxF8Bz6J8hZc9daSR4JVjKyiM67BpDiXAMKX7B4MvcuYahFMukajK7p6uxVKC
         Mduw==
X-Gm-Message-State: AOAM530MjVdqHG7Hci1aH/yJJtLQmaZSqIYN9raCIul9SoB+mXpG7QxV
        oFpZbqiuC+ltnc+Ug7KeyCtLyqqoPsqobyJ8OLqPJasApjI=
X-Google-Smtp-Source: ABdhPJyMDgbwzBHiejGh8aMo/nrkQROvALqaxkw+RqdK2xqUfo2zCKAb4mPTnlEBrq9timNFbFeETwetbioBfwOidNM=
X-Received: by 2002:a1f:38c2:0:b0:349:9667:9232 with SMTP id
 f185-20020a1f38c2000000b0034996679232mr9195176vka.16.1651078503714; Wed, 27
 Apr 2022 09:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <57217c15-c6d1-32f1-a481-0003ba66e342@gmail.com>
In-Reply-To: <57217c15-c6d1-32f1-a481-0003ba66e342@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 09:54:52 -0700
Message-ID: <CAPUEsphumEJ=qBM9c9WLJ6fzL=mcK2+3fUViyHEvttaD-DsOgg@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 9:31 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 27/04/2022 16:38, Carlo Arenas wrote:
> > FWIW, I still think that using atoi with a check to skip "" is
> > probably as safe as doing all this extra checking as no one has shown
> > yet a system where sizeof(uid_t) > sizeof(uint32_t), but agree with
> > Junio that using long instead avoids issues with the systems where
> > sizeof(uid_t) > sizeof(int) and unless sizeof(int) == sizeof(long)
> > (ex: 32-bit Linux) which is then covered by the cast.
>
> if sizeof(uid_t) < sizeof(long) then the cast will truncate the value
> returned by strtol() which means we are trusting that SUDO_UID is a
> valid uid otherwise it will be truncated.

correct, this whole procedure relies on the fact that SUDO_UID is not
a bogus value (ex: it was produced by a non buggy sudo and hasn't been
tampered with)

in systems where sizeof(uid_t) < sizeof(long), it is expected that the
id we got should be able to fit in an uid_t so no truncation will ever
happen.

the only thing that worries me is sign extension but that is why I put
a specific cast.  for all practical reasons I expect uid_t to be
uint32_t and therefore using long should be better than using int
(through atoi)

Carlo
