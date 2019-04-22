Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0BE1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 07:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfDVHHi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 03:07:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37197 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDVHHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 03:07:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so3061026wrr.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 00:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EX5U0tvQmBhieHLht3pANpyyitPLNOQfiIhP7nCOArM=;
        b=c4I7+qxXrK46htVNUYIIlqkdrd3m7DR2RBpHBGJnT6Mkvec+i7nPm6E8fZch+B30is
         8Am42ltzaIH10eiBQTvzbVBPKszPjyEYpdgSjNGMb7OmEpVbhKUO/pqfhagP2F9bsrrX
         n6cc1iGS3v4OD4NGx2nel3aYZRk8Rvy+0aHp9ATQ/7CXqXBC47o+4KETtweZ71IhTJ1u
         CEMmcbQVUW4DIuxiTwZygq6xNUBvD0RrHG83WsaW22yAPLNzsMnWEDygvDsUKWDW8z2w
         Diib6W43v/7x3yaqblYJfzV7ImhGMrhZT+Sfq3TjMuFPb3WyYGIYsOzib3QDNywvu7FB
         ra8Q==
X-Gm-Message-State: APjAAAVj5eFITyZ87ZpbLtrRMZkudtYWENd13RZu3eL9YnQ4gly1CQkz
        o0pJTi5wpATJNpH+kl7VH9B2etmVf/rX3VmhAS4=
X-Google-Smtp-Source: APXvYqzftnFxHSkC5+NBJkD4s+f2QTp5vA1gNu6JbQvcTCvjlMVK4zX6rZj0RAowBbfFxUuORuF/rmjBQh8BbeCQXzI=
X-Received: by 2002:a5d:6a89:: with SMTP id s9mr12555160wru.58.1555916856967;
 Mon, 22 Apr 2019 00:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555880168.git.liu.denton@gmail.com> <692875cf4baaeee8b47fd7e95d0b787d1a08f64e.1555880168.git.liu.denton@gmail.com>
In-Reply-To: <692875cf4baaeee8b47fd7e95d0b787d1a08f64e.1555880168.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Apr 2019 03:07:25 -0400
Message-ID: <CAPig+cTJf_2psxrtsOi2h7c3ZbDj25WqLGPNaLqBmoVpM+6FRg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mergetool: use get_merge_tool function
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
> [...]
> Rewrite `get_merge_tool` to return whether or not the tool was guessed
> and make git-mergetool call this function instead of duplicating the
> logic. Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not
> the guitool will be selected.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
> @@ -28,7 +28,10 @@ to define the operation mode for the functions listed below.
>  get_merge_tool::
> -       returns a merge tool.
> +       returns '$is_guessed:$merge_tool'. '$is_guessed' is 'true' if
> +       the tool was guessed, else 'false'. '$merge_tool' is the merge
> +       tool to use. '$GIT_MERGETOOL_GUI' may be set to 'true' to search
> +       for the appropriate guitool.

What is the likelihood that code outside of our control is using this
function? If there is such code, this backward-incompatible change
will break that code. If the likelihood is excessively small, perhaps
it is not worth worrying about, otherwise, perhaps this warrants a new
function with a distinct name.
