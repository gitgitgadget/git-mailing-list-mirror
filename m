Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC12C4332E
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DFD2067B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbhAZWDh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391557AbhAZTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 14:12:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52B0C061574
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 11:11:56 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so8382464qvd.13
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SgTbLwoM3fpI2CeyN2uV4PTG5B3ATTbW8wS/aFuNKzI=;
        b=jEDhpzK/SuOPYdgpck4xhlOTOxOvQeSUpQPiRKsqIvDNP8p4EXUzzUxKInI10R5LoM
         ojz9jgY4vN7G9qUlCgD08fjWwbO9wYwN3Y9t9m9dlFz40wzNWMgjATpx1O1NYpVqIp8c
         ljIiA32morqAitCf5hPnDDjdJjey7QxH49id9zIDsM6DAqNFRI/Z2Fh4KYsVNusijpbj
         liMhl0CqrGn0oBpc/MWbqj/UQZG7DJF2OOZyiMRf7PJVpNjYyv+1AYOf/cgNCVpg0LjT
         txFKR4z+pNDVYRtQgVuHJDDCUkWISv63fvJ6OyznHzO5r64bHTdZ8NpA4cogaICWQOzS
         5KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SgTbLwoM3fpI2CeyN2uV4PTG5B3ATTbW8wS/aFuNKzI=;
        b=pjS8biunNtY1EnEAaosWmkKV5oPja2AYG6/NTqmis9a1WGemBBv1ScQ4GW8QlMp67V
         GZJ1gDUYRphojlguo7eXZmCFlFdBiFAu8w51+yb0aCLNY2vi0NtsQy6VnH7lMc4JoYJI
         ESB0TRbWKsRBZ2XrJgLfESLx/pobQm8IQTY/sq048RxAgAwB/doQ+RhvK9220G7tYSQi
         0cGdRlwfWZMzDn+sEeC+kV70YKIaPeK/NtxB3lILG/leimJb/+LbUoRMqsLD+fkDcV7X
         YHp3+5qYZ2cRv2n0KsxWDmG9Tpj2e4QDzgpoN8BxFni7FePFV0KzsmaZh+E/v8aSxOgm
         YJBg==
X-Gm-Message-State: AOAM531O848CTknw+05fW8Ye75xTh4NddVX/YK3x1HUncdeqk9/TqNGO
        FV3tCDzgvNhCmFuDtHNou3wvHJIbzPsJ3Q==
X-Google-Smtp-Source: ABdhPJzZngXunYLseNDQrpRmDRUBCWTiJXylIk3YjR2Z/22OSAzkyp8si+ySrig2NnEPJ9bPG+0nZw==
X-Received: by 2002:a05:6214:118e:: with SMTP id t14mr6987735qvv.50.1611688315607;
        Tue, 26 Jan 2021 11:11:55 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id a21sm14941717qkb.124.2021.01.26.11.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 11:11:54 -0800 (PST)
Subject: Re: Git Commit Signature Encoding
To:     Rene Schumacher <Rene.Schumacher@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <AM7PR83MB0434B67B0F15E4433347D555EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
 <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <328de960-ac67-e313-ecc3-b5b505e42bea@gmail.com>
Date:   Tue, 26 Jan 2021 14:11:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <AM7PR83MB04349E882710B0EC0E186A09EEBC9@AM7PR83MB0434.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Le 2021-01-26 à 09:30, Rene Schumacher a écrit :
> Hi all,
> 
> I'm trying to fix an encoding (?) issue when viewing gpg signatures for commits in PowerShell Core on Windows. Apparently, git changes the output from gpg depending on the command used. Here's what I see:
> 
> git show --show-signature
> This command shows strange line endings and is unable to properly display the é in my name:
> 
> commit d7a43da0bd3bc7e31dd46afb8ccd78735ba43a36 (HEAD -> master)
> gpg: Signature made 26.01.2021 15:28:26 W. Europe Standard Time^M
> gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2EF^M
> gpg: Good signature from "Ren<82> Schumacher <rene.schumacher@microsoft.com>" [ultimate]^M
> gpg:                 aka "Ren<82> Schumacher <reneschu@microsoft.com>" [ultimate]^M
> Author: René Schumacher <reneschu@microsoft.com>
> Date:   Tue Jan 26 15:28:26 2021 +0100
> 
>      Commit with signature
> 
> diff --git a/file1.txt b/file1.txt
> new file mode 100644
> index 0000000..a7f8d9e
> --- /dev/null
> +++ b/file1.txt
> @@ -0,0 +1 @@
> +bla
> 
> 
> git verify-commit
> This command does not show the line endings but still fails to properly show the é:
> 
> gpg: Signature made 26.01.2021 15:28:26 W. Europe Standard Time
> gpg:                using RSA key 3848D5B2A3D45419D7F564F97802B995CDB4A2EF
> gpg: Good signature from "Ren82 Schumacher <rene.schumacher@microsoft.com>" [ultimate]
> gpg:                 aka "Ren82 Schumacher <reneschu@microsoft.com>" [ultimate]
> 
> 
> git verify-commit --raw
> This command does properly show the é in my name so I guess that gpg output is correct and there's something happening while git parses the gpg output:
> 
> [GNUPG:] NEWSIG
> [GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
> [GNUPG:] SIG_ID jBtyyA8QIDL0tD5fneVqJo7oU/8 2021-01-26 1611671306
> [GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
> [GNUPG:] GOODSIG 7802B995CDB4A2EF René Schumacher <rene.schumacher@microsoft.com>
> [GNUPG:] VALIDSIG 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 2021-01-26 1611671306 0 4 0 1 8 00 3848D5B2A3D45419D7F564F97802B995CDB4A2EF
> [GNUPG:] KEY_CONSIDERED 3848D5B2A3D45419D7F564F97802B995CDB4A2EF 0
> [GNUPG:] TRUST_ULTIMATE 0 pgp
> [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23
> 
> 
> I already set the environment variable LC_ALL to C.UTF-8, which fixed the commit message output (see first screenshot) but unfortunately not the signature output. Any idea what might be causing this and how to fix it (if possible)?
> 

What Git and GPG versions are you running ? And what Powershell version
(I don't think that matters but still, a complete environment description
usually goes a long way).

Can you come up with a reproducible example ? (Complete steps starting
with 'git init' and 'gpg --gen-key')

Cheers,

Philippe.
