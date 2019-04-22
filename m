Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1AE11F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 07:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfDVHEE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 03:04:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45883 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVHEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 03:04:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so14725806wra.12
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 00:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jJmCkxJ9tJ8eTVs70nYdUJf8jxMri0SKDGC/IWxOw4=;
        b=lQfYiV+sDiYndMTyrrexfJpVU0/BSZXP1F4Y/vNJ2gmOnWZ+vpNZfiu5ifMhfQ4fk4
         Fbpyxt8NXzXC3KyJK3RQmWP54qmOH+SjAW0xMAw5YuC7ICXFwC094ISuYTNFisjd5KBG
         dnjuefdmtvFW+JRbOQCsjAqgR99sIoOCNaqy2YqdDaae1QYND7cepjWuGmrowho+TnBU
         v/InrI0j4DPjYCknUDUHfGbOon09QmU2+yZS7WBvr0WcNo+erfzNDgwT9slfMf3HbwFh
         Usx4RNcQstRGfRk8TE2hrN6rG6ukFVtN8rnC7/IXI3bkOrFAsPoAczOoOjoWctXVLNgX
         22gA==
X-Gm-Message-State: APjAAAX1NW6sqJQPnHPZ2uTTt7DELfgnu6nQ7QaFYVXxj8Cp4kcDm3tT
        D2hC7N0hesy/xFwUEjxEnjNQznLfK/Dvp/n/pSw=
X-Google-Smtp-Source: APXvYqyzjCW11jb32bvm0/Vhs6bdUl0Z9cBsBx8NWjIILOeXs/uWjBKuoFB3ufc/4q9AEUq1lVkLQP1s1ulz3DLcsbk=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr12542016wru.58.1555916642478;
 Mon, 22 Apr 2019 00:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555880168.git.liu.denton@gmail.com> <c019926b32016369e9f497d8e227107fdf192440.1555880168.git.liu.denton@gmail.com>
In-Reply-To: <c019926b32016369e9f497d8e227107fdf192440.1555880168.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Apr 2019 03:03:51 -0400
Message-ID: <CAPig+cQQqLc16=6iO=z6bBDMKD_dnG0ZL=7_onGibfYxoJsN=g@mail.gmail.com>
Subject: Re: [PATCH 4/5] difftool: make --gui, --tool and --extcmd exclusive
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 1:07 AM Denton Liu <liu.denton@gmail.com> wrote:
> In git-difftool, these options specify which tool to ultimately run. As
> a result, they are logically conflicting. Explicitly disallow these
> options from being used together.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/builtin/difftool.c b/builtin/difftool.c
> @@ -731,6 +731,15 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
> +       if (use_gui_tool)
> +               count++;
> +       if (difftool_cmd)
> +               count++;
> +       if (extcmd)
> +               count++;
> +       if (count > 1)
> +               die(_("--gui, --tool and --extcmd are exclusive"));

The more typical way to check this condition in this codebase is:

    if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
        die(...);

Also, I think you might want: s/exclusive/mutually &/
