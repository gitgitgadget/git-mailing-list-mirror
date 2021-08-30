Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E262C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDAF60FD9
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 13:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhH3NGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 09:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhH3NGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 09:06:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF06EC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:05:53 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s3so25774243ljp.11
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ntnN5I1gz7vzCorNYJ2ihGRprns5P/ED0p5C2qaPDM8=;
        b=TcCxsoUZbkLeTsEJM2v4JQJFzXLd9RLpxOInfvns1yKdzLMuGzyR1UzuC7j4hS7Bm2
         JiNEnXdesK1YEp1HMkb7+XRLFqdI6K0JfTgMOim7VEAKhz1Glyf6RJBpcOcWZu8hbeWT
         F1xb9hahDs394R2BmvbGYObuIVaDeVoLi1ccHFIvC/VmmMyB0IBTjr1xUQadUN3ThdYh
         DhAeEPry1yOKtSGOnIzTvO0iin+ujdfxx3w8ZBHSfpCmENA37xHHdzqbRGE2XrBSvjO1
         m2nJxmPCEEeSqmO33L+g1HT7JKf9/uxDcfwsY1L9c6GOEDh/oOQTvl4/6r3/RblJDix4
         ojxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ntnN5I1gz7vzCorNYJ2ihGRprns5P/ED0p5C2qaPDM8=;
        b=lVC6OzDeyR+sL3z4P/waAtK9snR9/pS2dofPBClxF9LMzapEvTmG/l4qdl9X26Otkb
         KJS0edNZ/gV9t60yMUSBELBHpzB1SppcD7BB/KsH+MzF7X8ArVUuwwLvn6Nx+hP0F8FD
         YSTgXt6HSgn4r6FhIiYGJCs3TpToWwRRYjtT5PbR7eeE/L46p0LEQaPX88Dvd6QkJHFz
         vbes/kJf3sV5pRso23RVgEmER/3C53+GrZCtTAZTpY3KwuBUiwKC001o4T2nL3aWjENy
         ftbpmujfKaHtQArAGWq9a2DfWcn4AZkJE6u9faIz41VMXazNbHhjUPYnM8v9tOwA2bjt
         5pfA==
X-Gm-Message-State: AOAM5319JpTZvxSdz2WKOWYryzZr0bcWXL/32mg2UeiOAde/SDnopBNC
        kl2nvct4NfbPydHE5bFltQlZpwcUz1s=
X-Google-Smtp-Source: ABdhPJzPuT/bdJBsL65gjTPbtpH0RY1shBaTffJRV+qE4HmDpmRl8dwOjO+YfIMtJjb9EE/YBrN8fA==
X-Received: by 2002:a2e:a801:: with SMTP id l1mr20955719ljq.41.1630328752051;
        Mon, 30 Aug 2021 06:05:52 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d4sm1385263lfg.127.2021.08.30.06.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 06:05:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
Date:   Mon, 30 Aug 2021 16:05:50 +0300
In-Reply-To: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org> (Johannes Sixt's
        message of "Mon, 30 Aug 2021 10:03:18 +0200")
Message-ID: <875yvn9j69.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
> to diff-index, 2021-05-21) git diff-index no longer accepts --cc.

Yep, this is expected, and I even put corresponding comment in the
source:

	/*
	 * We need no diff for merges options, and we need to avoid conflict
	 * with our own meaning of "-m".
	 */


> This breaks gitk: it invokes
>
>    git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD
>
> to show the staged changes (when the line "Local changes checked in to
> index but not committed" is selected).
>
> The man page of git diff-index does not mention --cc as an option. I
> haven't fully grokked the meaning of --cc, so I cannot tell whether this
> absence has any significance (is deliberate or an omission).
>
> Is gitk wrong to add --cc unconditionally? Should it do so only when
> there are conflicts? Or not at all?

As far as I can tell, --cc had no effect on diff-index, it was just
silently consumed. If I'm right, this line in gitk never needed --cc.
Then either gitk is to be fixed, or we can "fix" diff-index to silently
consume --cc/-c again, for backward compatibility.

If --cc did affect diff-index, then my commit in question is wrong and
should be fixed.

Thanks,
-- Sergey Organov
