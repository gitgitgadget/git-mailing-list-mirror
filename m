Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA4C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 03:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5264EA1
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 03:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhBIDQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 22:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhBIDOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 22:14:00 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D43C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 19:12:59 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v206so5107705qkb.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 19:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ecdwtuBQmdsZhzJ6aVkg8/xWRyoOeonvqTr5JvYVIuE=;
        b=bL34sT2w7KuzSsttkxIeJQmxz3eMoknSKXmwPUFRbev1BXRW94LqH2TyIFDwwi8T1K
         ImD2QBNwMt4BdiD5NSQU04c1Imv+UR/jLtW454ZpmKH4jTRpI7rbv3Xhn59Q5TXDltU6
         i4JQtohpijAAdjA0NcZsr2McW9hBHaaA3GZjM2jQPRFOr2iS9o71G/Or2AbFUrKO4bG6
         Y/puVP0GgPg4fbWDdIf7q6sFF6YBXe4mn8vd+s6MtTzFaMpwUyS8Tvk4YrCSC1rlcU0h
         12k/iuV5SH7sw/7wmSHtZsmdPYrh7acFCJRR278blih4+NCHjcz/cXYJexnqHrIXDPuH
         pjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ecdwtuBQmdsZhzJ6aVkg8/xWRyoOeonvqTr5JvYVIuE=;
        b=s6GoNzwvn3gG6o7CWcHfGNg9DkNFKoZfjRXPLXmFRK1b+2dxDrX8HtngXpGMtDDXDQ
         b7quT/0NKzwMgeDpJ/evMHTpmqptRFOynBQNu4Z5SOcVHphiPgefLpH2fGiHvAQuQ/9e
         +kR1PoPzepqH6TpoFSkBiB7hpaejD0dpec8VXjDPJgkIpWZ5Pmzm8zNPHVG+INFippVs
         EUUNfiY3lJCcCe/4xn7U8XuLNogwYh+V1Du1kINqDWmk2TAArfNQiVkmzPKc8EvinanQ
         eYh0oOt7z2C3L3xWD09KLR8yAffgVcDqo2AeLFYS/x5LrwkSIoGBNjXoFFMtQvJnc8Zk
         1KZQ==
X-Gm-Message-State: AOAM533D2vsIAmWbRzygDgKMp7+mjwiG/cBUXUuUbagxlGwov0HDgpHk
        URkyBJx3ZWUE5b+Bw+4KduqPO7+u2Wtx/g==
X-Google-Smtp-Source: ABdhPJxLp+BPgyoiLHD6mif8dEcDn5dvcc+CRgNcYbnLJ/E2pD+qplWDHWlmaIZTDMuD/YExx3xy2g==
X-Received: by 2002:ae9:f20b:: with SMTP id m11mr20547686qkg.464.1612840378385;
        Mon, 08 Feb 2021 19:12:58 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id i65sm18093592qkf.105.2021.02.08.19.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 19:12:57 -0800 (PST)
Subject: Re: Git Commit Signature Encoding
To:     Rene Schumacher <Rene.Schumacher@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <328de960-ac67-e313-ecc3-b5b505e42bea@gmail.com>
 <AM7PR83MB04346479474921F3DC0688CFEEBB9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <962853bc-9e60-968f-c64d-35757f72e8d1@gmail.com>
Date:   Mon, 8 Feb 2021 22:12:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <AM7PR83MB04346479474921F3DC0688CFEEBB9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Le 2021-01-27 à 04:41, Rene Schumacher a écrit :
> Hi Philippe,
> 
> thanks for getting back to me so quickly! And sorry for not providing all the details right away.
> 
> I'm using Git 2.30.0.windows.1 (I believe that's the latest), gpg 2.2.27 (installed via gpg4win 3.1.15), and PowerShell 7.1.1. You might have seen my second email to the list in which I described that setting the OutputEncoding in PowerShell to UTF-8 fixed at least the display of the é (and probably all other umlauts and special printable characters). The signature output from git show --show-signatur is still printing the ^M carriage return character at the end of each line:
> 
> commit 69022a47744fcb3801572ac5d14295bcab274295 (HEAD -> master)
> gpg: Signature made 26.01.2021 17:55:36 W. Europe Standard Time^M
> gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2EF^M
> gpg: Good signature from "René Schumacher <rene.schumacher@microsoft.com>" [ultimate]^M
> gpg:                 aka "René Schumacher <reneschu@microsoft.com>" [ultimate]^M
> Author: René Schumacher <reneschu@microsoft.com>
> Date:   Tue Jan 26 17:55:36 2021 +0100
> 
>      another commit with signature
> 
> diff --git a/file1.txt b/file1.txt
> index a7f8d9e..6ddadea 100644
> --- a/file1.txt
> +++ b/file1.txt
> @@ -1 +1,2 @@
>   bla
> +blub
> 
> Since git verify-commit does not have those carriage return characters, I'm still wondering where they might come from.
> 
> Cheers,
> René


I've tried to replicate with 2.30.0.windows.2 and gpg 2.2.27 (that comes with Git-for-Windows), and could not, neither in Git Bash, Cmd, Windows Powershell or Powershell Core 7.1.1.

Maybe if you can provide a complete reproducer with all needed steps (git init, gpg --gen-key, etc)
you would get more help in the Git-for-Windows issue tracker:
https://github.com/git-for-windows/git/issues

Cheers,
Philippe.

