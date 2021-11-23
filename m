Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD3DC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhKWLIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhKWLI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:08:29 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D4C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:05:21 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso1846659wmr.4
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R0EtHbSiCx3P9/vgZvN4g8d5FigmA4iFdRCoMY0RGv4=;
        b=m8XhNn81sBqR1evvMe0FH7VNYPmaOxEliLzf+aZcK12Bw2fs0x9QRxHrPBlimNjWPO
         NwkKu37PxaP46uxVd3UymuOrUgxNkV9X0WjGTT7dhsKL/zDm6dp3gbK27bp6x6O/Gs+R
         p7uqsB+BmWwzTtGI+uO5JUM4iReJmO4eOWazNkzLvDVhDP/qWCCCY485hlW8HmGGK9oP
         vReKUtEFU99Rs5UY/vrCP+DMptFFqlzGkFYQjFYjRHLfvUtO5Cb/IN8FIJCcTqoeQQ1Y
         znqkoQq51vnPcuQCcTVTo27Kk7dyQlMc6fgsoSrRPqg/ySBEIqPlTM1G06iueK1jPqAM
         PwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R0EtHbSiCx3P9/vgZvN4g8d5FigmA4iFdRCoMY0RGv4=;
        b=xWDezsc+sr6h5pBpYy1RmfRTSulOON3mG/H9mEmDnNa7zM9eC5xTei/W63lym0jaCY
         dHzH4eSNsmhK6j4I65Y8kODj+R+mhC7a3aFVNtrBNE5pzpD4Xn1H4wioWZjFOAXSQ3hR
         vUPlROYzFwjkQA4OYZ6v/slDmC/6PEXBZdmbVLon1FocNHKbXoHh9wQFVxetyXJVdR9U
         t1M5oRBWqQPHQ2D1y8hNwU1IJdXLMSmifdtMF5mfHf9bLuaHy16hrCeJVvyVdwQVA6bT
         at2FHL7WdLVdYPkPxoRHcrVP+yi5T+FOrQwmJh2LJ0hUVk93th0wuQXHRMbr6fDwQSpr
         SoZg==
X-Gm-Message-State: AOAM532OngvSksmD7/CUQRR0GFy+XFCAaevjKRKJlMJCfM8LdnzYERNw
        G13wq52gzgiPnGepJYu0iMvCOaGc/PW5kw==
X-Google-Smtp-Source: ABdhPJw5xRlpqQB9pqnXb7tuSgdvsObqzL9oZbG1o/C8rAowZCL7CEZNxjs61SD6C1gdXpfOGdgq0A==
X-Received: by 2002:a1c:4681:: with SMTP id t123mr1932196wma.83.1637665519684;
        Tue, 23 Nov 2021 03:05:19 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id i15sm945833wmq.18.2021.11.23.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 03:05:19 -0800 (PST)
Message-ID: <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
Date:   Tue, 23 Nov 2021 11:05:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
Content-Language: en-GB-large
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>,
        Junio C Hamano <gitster@pobox.com>
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20211122222850.674-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 22/11/2021 22:28, Carlo Marcelo Arenas Belón wrote:
> If the editor is invoked without a controlling terminal, then
> saving the state and restoring it later is not very useful and
> could generate signals that the invoking process wouldn't know
> how to handle.
> 
> if git's standard output is not connected to a terminal, then
> presume there is no need to worry if the invoking terminal could
> garble it.

Checking if stdout is a terminal fixes the Eclipse case where stdout is 
a pipe or /dev/null but if git is started in the background from a 
terminal then calling isatty() will not prevent git from receiving 
SIGTTOU. For example if the user is using a gui editor then the 
following used to work

GIT_EDITOR=gedit git commit&

Now git receives SIGTTOU when the editor exits because we call 
tcsetattr() from a background process group. One can argue it does not 
make much sense to be starting git in the background but it did work 
before these changes. I think a combination of isatty() and tcgetpgrp() 
is probably the best solution.

Best Wishes

Phillip


> Reported-by: Alexander Veit <alexander.veit@gmx.net>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   editor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/editor.c b/editor.c
> index 674309eed8..214e3834cb 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -86,7 +86,7 @@ static int launch_specified_editor(const char *editor, const char *path,
>   		p.env = env;
>   		p.use_shell = 1;
>   		p.trace2_child_class = "editor";
> -		term_fail = save_term(1);
> +		term_fail = isatty(1) ? save_term(1) : 1;
>   		if (start_command(&p) < 0) {
>   			if (!term_fail)
>   				restore_term();
> 
