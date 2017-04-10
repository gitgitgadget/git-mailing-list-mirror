Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0FE620966
	for <e@80x24.org>; Mon, 10 Apr 2017 12:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbdDJMFG (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 08:05:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33051 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdDJMFF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 08:05:05 -0400
Received: by mail-oi0-f65.google.com with SMTP id t63so6655379oih.0
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iDJNQ8LknVW/QSTllgN8ROOHTYUFZ9jDgiqZhzf7hPY=;
        b=JKRb3wbaNvzTPut1BHIjiai+WtQvt/HQsBfEmteVD3uBTFCdmpZsX3XTy12fy0oRfU
         Z6FfmfwqjLTXxD0UEVHnkIvnRfeddbx8dgwvW46E8DSp+sfA2AthDv2FDO8VXSHCpDj6
         g39vrzyvtrNEDGehwtFPyEgT3V+jEdnvuAyJRlufSZ1K4RUayST1vFJ8kLzQYCOZEWRk
         HXaC/QTP68iQs4EhXVDhNx6argzbzOZjbP6a2lwB+W0NaQyp9HU0U3Pgrle7QDlb3QX5
         nGpIv+2e0pe1Mb5qQyXLd5ZznHke+H8BnfbtZ43MHbYVZTJ3pVe9SC89OdLfgJ5QMoUp
         KCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iDJNQ8LknVW/QSTllgN8ROOHTYUFZ9jDgiqZhzf7hPY=;
        b=D9M+Bm8kpu5NssK8iEidTG4p21LsLWdxN3EFGxokbD98FzYQdXgCyGRvx93gg43GTM
         DwcUqy+01ifVyoIaJj/E7UBwKWQESRdxBOWebTysmn5seyp3CYn1FcfPdmrcuTk2Chif
         BtGO0OLKlndm+dKjQifRoIjIEnihx99wLIEtveBVBVmIDBHnHH+a+1A3Wy7jvlOaVTm4
         tPijmwElkQCEWJhlVYbOPIanxAPQ0HttMB7JEzCbY0/ZtAvdJLKAQFiQPlMdbaRInfRk
         HVDq0tk49X/CEUJDSFtAHylz8+97JTpKCEsaxS8G6k8Kz81yEsdQMNpu1LVCEmN/nxy5
         BhPA==
X-Gm-Message-State: AN3rC/7HbCR1CnKQdhGEgM6C34NIm4KxjE2l9JMcW1kSvFsI2k3xh9SexqUSiZrpsabc6uyeMwFHU8BpXcIGNw==
X-Received: by 10.157.46.246 with SMTP id w109mr16251895ota.225.1491825905009;
 Mon, 10 Apr 2017 05:05:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 10 Apr 2017 05:04:34 -0700 (PDT)
In-Reply-To: <20170407192919.10209-1-bmwill@google.com>
References: <20170407192919.10209-1-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Apr 2017 19:04:34 +0700
Message-ID: <CACsJy8D9oXDbOqEfPTuSdm0Phvwo6AxQh_Q5tG4k22_mFBT4OA@mail.gmail.com>
Subject: Re: [PATCH] pathspec: fix segfault in clear_pathspec
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 8, 2017 at 2:29 AM, Brandon Williams <bmwill@google.com> wrote:
> In 'clear_pathspec()' the incorrect index parameter is used to bound an
> inner-loop which is used to free a 'struct attr_match' value field.
> Using the incorrect index parameter (in addition to being incorrect)
> occasionally causes segmentation faults when attempting to free an
> invalid pointer.  Fix this by using the correct index parameter 'i'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 303efda83..69ef86b85 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -724,7 +724,7 @@ void clear_pathspec(struct pathspec *pathspec)
>                 free(pathspec->items[i].match);
>                 free(pathspec->items[i].original);
>
> -               for (j = 0; j < pathspec->items[j].attr_match_nr; j++)
> +               for (j = 0; j < pathspec->items[i].attr_match_nr; j++)

Ouch. Perhaps this is a good time to rename 'j' to something better?
attr_idx or attr_index, maybe.

>                         free(pathspec->items[i].attr_match[j].value);
>                 free(pathspec->items[i].attr_match);
>
> --
> 2.12.2.715.g7642488e1d-goog
>



-- 
Duy
