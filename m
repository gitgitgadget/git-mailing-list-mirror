Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B541C3F2CD
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2517215A4
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 10:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXnTgglL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgCCKR4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:17:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38852 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgCCKRx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 05:17:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so3590588wrw.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2020 02:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eHpymw4fNKSDEf0Yon5gEQMP/JnDDiRYl5ZaVkWqw6Q=;
        b=lXnTgglLyDLHVWZHLyfDArpnopaw0ETnwcwn2cS6yTjjObvUhJypM9oRk22bAU2DCk
         7GmWqQzZ0mkWvhOP/OZiVJCADGfIt749BqgOtsXP0Hkf8m4f1D0ygu2i6enqzd+VMk9I
         9pX3n5Vvkc2olpXuRitC1ixNHrVkbO472LfQi7e21I+f9fyvKXM51LpAMAQhN4LG4gCE
         qToAnDCrKMJd8g3EEY4QUQ3OMgB4H06NLEkD+cDEKxFxFd/DHrc6LlS/LwP2C/IoyVe3
         rtBhjtS5V80G2XiKHXVDdqTrDgLtnYtyq6F7v5fEzGNSHXSx5w8H6t+nxNWJCF0GT60J
         OJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eHpymw4fNKSDEf0Yon5gEQMP/JnDDiRYl5ZaVkWqw6Q=;
        b=PbwtWh8HaBe2i/GT3lVHoTXTwHaOUUcYz6x2c491Mk3J7CHMNuGI5bbdqGZoCN+47c
         5mcTqvLWchH7A67TLEQ6MuKC+gce5IiNLNKbRYo7F4uMZxDk0SCxw/bUr5WnwW9V/JWn
         RqkUfmpfKparDErrvCygH924e5VleXcrqhd7YNTRKFkeDulj5KI5RbHcsPU71m8g38Hq
         up33Wo3nk+20lY4IHa0TP5MQaxVQ+EP4Km9gqrkNCi6Gr1AloxSV4QyOPDI5qxPzoMc2
         FpVolNrwpihX847fAGamJwoiq6HMg88w8omuH/0dxZrlN8M00rti/5Bqyjl0LXikJ1/I
         fa0A==
X-Gm-Message-State: ANhLgQ3B69+0GZOLoIUz4n6Swly4ZglOIcchWQk/EzJSp5ygP79XZtqI
        qSV8Ph81UXX1FtzPHmgMdNM=
X-Google-Smtp-Source: ADFU+vu08G5kf2C62tuZJjtPrbZWJFNY32BkEFIMVDOz/DVfK4xMtGqBk7IeKxBoxsRzT8Xr9AYXvA==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr5026094wrn.71.1583230671690;
        Tue, 03 Mar 2020 02:17:51 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-654-1-330-2.w86-199.abo.wanadoo.fr. [86.199.217.2])
        by smtp.gmail.com with ESMTPSA id f23sm3259862wmb.1.2020.03.03.02.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:17:50 -0800 (PST)
Subject: Re: [PATCH] rebase-interactive.c: silence format-zero-length warnings
To:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Ralf Thielow <ralf.thielow@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <87196142-8473-7d19-4edd-7452eaefda1c@gmail.com>
Date:   Tue, 3 Mar 2020 11:17:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <pull.567.git.1582835130592.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

Le 27/02/2020 à 21:25, Ralf Thielow via GitGitGadget a écrit :
> From: Ralf Thielow <ralf.thielow@gmail.com>
> 
> Fixes the following warnings:
> 
> rebase-interactive.c: In function ‘edit_todo_list’:
> rebase-interactive.c:137:38: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>     write_file(rebase_path_dropped(), "");
> rebase-interactive.c:144:37: warning: zero-length gnu_printf format string [-Wformat-zero-length]
>    write_file(rebase_path_dropped(), "");
> 
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>     rebase-interactive.c: silence format-zero-length warnings
>     
>     I noticed these warnings a while ago and they're still there, so here's
>     my fix.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-567%2Fralfth%2Fformat-zero-length-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-567/ralfth/format-zero-length-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/567
> 
>  rebase-interactive.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index ac001dea588..0a4572e67ea 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -134,14 +134,14 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
>  
>  	if (incorrect) {
>  		if (todo_list_check_against_backup(r, new_todo)) {
> -			write_file(rebase_path_dropped(), "");
> +			write_file(rebase_path_dropped(), "%s", "");
>  			return -4;
>  		}
>  
>  		if (incorrect > 0)
>  			unlink(rebase_path_dropped());
>  	} else if (todo_list_check(todo_list, new_todo)) {
> -		write_file(rebase_path_dropped(), "");
> +		write_file(rebase_path_dropped(), "%s", "");
>  		return -4;
>  	}
>  
> 
> base-commit: 2d2118b814c11f509e1aa76cb07110f7231668dc
> 

Ack.

On a tangent: what's wrong with empty format strings?

Cheers,
Alban

