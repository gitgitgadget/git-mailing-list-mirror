Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207EAC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40B621E92
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLIBc4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIBcz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 20:32:55 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC6C0613CF
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 17:32:15 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f17so152077pge.6
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zUzHjIbhMyYskONN+MPrQM1nu/Zm3nHi1wRZX1D1qtU=;
        b=jBMBQwsLhPUTYj5fU22mS9XuQ2qMDkN3Z9gwkKSJxo7S6su6qzo1ECBBLfwsjipENv
         yiiyP2NopZX76gjF6w6LLT6nudsC35nqVUa43Hx+8JZ1XmEzXN6LUtNu981BVXfV9FD+
         Rhy50Mhe6fCe3uzJZXP5i0UFNLxCtLWrjFQZvMEXWaFtecbvTW+SbGtA0XiMWYBSPE0v
         mE4nePxxSM9FGIBonpF9BiGR7AlyVhKOmeno4UsAAe7wJkzrPk+ZaKh18gJt6j+LS2lX
         jpV7aMZZD/c/Q4SEARoS1Lvumrk5lRYuN1/HKSvRXrIJby8UR4EelDuJ9VwnCmGdhIeV
         aP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUzHjIbhMyYskONN+MPrQM1nu/Zm3nHi1wRZX1D1qtU=;
        b=ue2gKL26aBBn2vgsLcic9VLt9TgMmW6AXtTyuE3WtMvdfhRtMnsXWWAMWgHSR11u0I
         cLv2b5xjrFNlQdUZfCdN2LUlofdO1dnecsjzls6fEWVryHtFMP94tiiguL245D7CyxRn
         bjFnCE8D6fJ5ffo/og+Xc3bIqDcHDp9CT0hCgbUOaDUDFLMcZNVWvJVYMzhfV+emUDZX
         5nRVLSwfTIrPFJO4ojvEl/sXOAL/VL73bVDkexqyc3b8E6dolKtThp2LdlFpnN/zY1yF
         cOi49idOXKD3TYNZCArM5u87Ym2t3pbjSEJgYuw95ZZrXpAjlNMOI5Ghr+AU0p0h1T2k
         mBSA==
X-Gm-Message-State: AOAM530PsMkRiEcDiQFqcSgsXsaNlWrKFMyeqLIotaIt4qGONk7rf58y
        EE5Yf1GnUd9wBTx/j7qs9w8=
X-Google-Smtp-Source: ABdhPJyjTB4gGN9OIBUw9MXxrRJOB2VjZCp7pg7Wfxh8MjOHUfsOe5sj+g0Lv+9KlRePbLxq0lnEwg==
X-Received: by 2002:a17:90b:2314:: with SMTP id mt20mr304165pjb.119.1607477534744;
        Tue, 08 Dec 2020 17:32:14 -0800 (PST)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e5sm66599pfc.76.2020.12.08.17.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 17:32:13 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:32:11 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
Message-ID: <X9ApG0jUxJrPDK9d@generichostname>
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209002619.25468-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,

On Tue, Dec 08, 2020 at 06:26:19PM -0600, Felipe Contreras wrote:
> It's not efficient that everyone must set specific configurations in all
> their ~/.vimrc files; we can have a project-wide .vimrc that everyone
> can use.
> 
> By default it's ignored, you need the following in your ~/.vimrc
> 
>   set exrc
>   set secure
> 
> Then the project-wide configuration is loaded, which sets the correct
> filetype for the documentation and tests, and also the default
> indentation of c, sh, and asciidoc files.
> 
> If you have the shareness syntax file it will be used for the tests, but

s/shareness/sharness/

> if not the sh syntax will still be used.
> 
> These default configurations can be overriden in the typical way (by
> adding the corresponding file in ~/.vim/after/ftplugin).
> 
> We could add the vim modelines at the bottom of every file, like other
> projects do, but this seems more sensible.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  .vimrc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 .vimrc
> 
> diff --git a/.vimrc b/.vimrc
> new file mode 100644
> index 0000000000..d250ab26e0
> --- /dev/null
> +++ b/.vimrc
> @@ -0,0 +1,9 @@
> +augroup git
> +  au!
> +  au BufRead,BufNewFile */t/*.sh set ft=sharness.sh
> +  au BufRead,BufNewFile */Documentation/*.txt set ft=asciidoc
> +
> +  au FileType c setl noet ts=8 sw=0 cino=(s,:0,l1,t0
> +  au FileType sh setl noet ts=8 sw=0
> +  au FileType asciidoc setl noet ts=8 sw=0 autoindent
> +augroup END

A couple of nits. We should tab-indent this file since the rest of the
project uses tabs everywhere. Also, perhaps use the full name for the
option names so that it's immediately obvious what each setting does?

Aside from that, the settings themselves are sensible and I'm for this
patch.

-Denton

> -- 
> 2.29.2
> 
