Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FDC4167B
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 02:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiLZCH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 21:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLZCH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 21:07:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56B6E63
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 18:07:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o8-20020a17090a9f8800b00223de0364beso13665043pjp.4
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 18:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNkCHg+JTyuIwSWugpXpBDM3//2eSC7uyMAyOdnC0N0=;
        b=pJ/pHhGUXZHO7jb5hByAUpH3ZMLChmlx6MEk1pQUA5Tvo8epIe3e4hWuPPfWUyyqPB
         bRk8FSnkFFgKKU/ef/LZVf4lIQhM4OB2C9QHCmt7SKEUQWpakLbsouDK8YE0An7wBl/w
         EOCe4jSQFNKro0GQHQBl4b0a8S98Q8YfEEOaOTzEndkUix8Y8Kq+YsZdfLxpbb5SoITp
         PRQjMkPVuTee9X6pEuUYxwhvP03wFj5MsXk1snPhpUVBky1iqcRkB3A9b4prTiRs+w+d
         YQhW5WQqntKOjIvLksiM/Nn6+0bgUyyf0ezBsAPSxoQqxcNn6vgq9RvozpMzDyBFd537
         247w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNkCHg+JTyuIwSWugpXpBDM3//2eSC7uyMAyOdnC0N0=;
        b=xxv48bcAnxgGEPMXU3wUyOz5Vcr0pyJJz3JwwvIvzmcmIQaNVDrIYqJR4dZ19KJvEn
         4sJRvBeQOz9VdqGnW2lVlHwLzqUmYV7h0iy9Bcz2tUT8m1AnaMISyHdRfGX0+HBbdwmA
         ajSQ4Y5oOSbblQpcCPYe0Oj6HRNYcBiT+z11yLQLa9B2KibEIhcV5kEExNYefoNIaFKg
         YGkqvzr0T3lriCnzrwcL4PEvyiJgq/kxD1Ou9UPqltYAFEWA8xSB2i8hLueGA9h6mfl8
         +43QkhVlm2XIpt5VUzpzSOJAUIif5bdkw6uuPBRrHewEw3KEW/fITwPdRf0sy3kcd/a7
         eRrg==
X-Gm-Message-State: AFqh2krWRQxmTGbHggZAIpADgW+tSwwSSpsRA79lKD/1X/iAcAxciaJj
        XkdA7P04hQyNrLlatL+j1eQ=
X-Google-Smtp-Source: AMrXdXuzjfewUiephGCZL+q+4sCAbMnveiwBWcYu4VL7hMshA2Bt+u7r2M+w+tGnR9Dt+uZaW759RA==
X-Received: by 2002:a17:902:aa85:b0:189:894c:6b48 with SMTP id d5-20020a170902aa8500b00189894c6b48mr19095893plr.59.1672020446327;
        Sun, 25 Dec 2022 18:07:26 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001869581f7ecsm5935745plb.116.2022.12.25.18.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 18:07:25 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH v12 2/2] win32: close handles of threads that have been
 joined
References: <pull.1406.v11.git.git.1671823177.gitgitgadget@gmail.com>
        <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>
        <fa5cbfa5e0ca86e2143346068c9b99856cdded0c.1671932405.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Dec 2022 11:07:25 +0900
In-Reply-To: <fa5cbfa5e0ca86e2143346068c9b99856cdded0c.1671932405.git.gitgitgadget@gmail.com>
        (Seija Kijin via GitGitGadget's message of "Sun, 25 Dec 2022 01:40:05
        +0000")
Message-ID: <xmqqilhynciq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Seija Kijin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 65e15a560d5..83e088dff0a 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -41,10 +41,13 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  	case WAIT_OBJECT_0:
>  		if (value_ptr)
>  			*value_ptr = thread->arg;
> +		CloseHandle(thread->handle);
>  		return 0;
>  	case WAIT_ABANDONED:
> +		CloseHandle(thread->handle);
>  		return EINVAL;
>  	default:
> +		/* the wait failed, so do not detach */
>  		return err_win_to_posix(GetLastError());
>  	}
>  }

This matches what got an Ack from J6t in v7, so I'll queue with
Acked-by: added.  Thanks.
