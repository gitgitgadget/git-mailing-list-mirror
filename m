Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0961FC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 07:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjAaHth (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 02:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaHte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 02:49:34 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF7345F43
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 23:49:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso400014wmb.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhZM59c72wq8qCsqleTjhvFc/trRzf5ikhK/lJgtgmM=;
        b=fXk1mOBFdhMDCZf5TrP5CBneGlboGh7sZcuoPdiMnN0WPHzGC0PDtzDOR61sXNDDZo
         naKEcUXOKOEtUDhzUNPQLaor0C378HJ3dVlFgcxY/v55S6pj1u7oMe38OLNVcBA3e2SW
         82n6BtLLEB3uZ/98J7VvWtBAectCKW+f7kPUsSmkPb6NJG6ISZ6+51L4nAjzqjiQKoVA
         GRhQG6dyJ0y5pKJIv1OIrLZo7pUF3zRDGIoSQqJOM7WpeZ/ljER0B+Lk+v5eD0kgD3uh
         wCYTF7io3Y0sYLapxiY1tZcWxy2HHZO6o3w4sKX7ZuZAVzlIZh4K7bGBGqvNKA1Z0B5y
         tOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhZM59c72wq8qCsqleTjhvFc/trRzf5ikhK/lJgtgmM=;
        b=EnZaOjDAPBjzLz6Vq+VBioXBVaYXvg9ru+DQPgN1v+0epxG9L0d8XYxkGubCqn+zOX
         63F45ZXmG56mDHI0ye83zDrLIoDUGy+qAb8MCzZ8nrz9g8tDpat0psw10J395Aa48rX9
         U69BeqXZf8dW8moFAKaxU0e1aUzCPme7nojdU7894dxmdgpgNa0U4pExsI/TSl5h0/Eq
         SfH+3saqrmjfZs7Mgd6Celjjii0CeoQx8Q1Xnd9nFi1OXIWmNx7ZeYmI3AvhdiW7yUcN
         yyf0sajIxoeL4YpsZPOWWf292X6pXsLpLb1mqsxBSve+dHUlfKb9gCMS/gzgwCS9+RZG
         iy/A==
X-Gm-Message-State: AFqh2kquZIvDHa/Voi7tn2EJ4w6no12O9iJgkAqYh/PsuFW60xFtefZ3
        0ZUwhCjA/5a11Yv0veMjzbd7nA==
X-Google-Smtp-Source: AMrXdXuZ1hJhG7ElmW6yKseMzl1LKwuJGJWdQAsM+Q5jiS5hCrpWrA3+YIcab6y5qeiju9VNA3Aq6w==
X-Received: by 2002:a05:600c:3d8d:b0:3db:2c8:d7e1 with SMTP id bi13-20020a05600c3d8d00b003db02c8d7e1mr52404866wmb.20.1675151335780;
        Mon, 30 Jan 2023 23:48:55 -0800 (PST)
Received: from ?IPV6:2003:f6:af25:c200:dcc7:5696:ff63:6d6f? (p200300f6af25c200dcc75696ff636d6f.dip0.t-ipconnect.de. [2003:f6:af25:c200:dcc7:5696:ff63:6d6f])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm15734067wmb.1.2023.01.30.23.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 23:48:55 -0800 (PST)
Message-ID: <d1c4cbad-bbb8-d610-5e27-970d96dd7a74@grsecurity.net>
Date:   Tue, 31 Jan 2023 08:48:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
 <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
 <xmqqk0156z55.fsf@gitster.g>
 <9b5a1113-84f1-1651-bffc-6382462057dd@grsecurity.net>
 <xmqq357r4zvk.fsf@gitster.g> <xmqqlelj3hvk.fsf@gitster.g>
 <xmqqk0131zxi.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqqk0131zxi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.01.23 22:21, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Having said all that, I do not mind queuing v2 if the "use *NO_JIT
>> to disable" is added to the message to help users who are forced to
>> redo the query.
> 
> In the meantime, here is what I plan to apply on top of v2 while
> queuing it.  The message given to die() should lack the terminating
> LF, and the overlong line can and should be split at operator
> boundary.
> 
> Thanks.
> 
>  grep.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git c/grep.c w/grep.c
> index 59afc3f07f..42f184bd09 100644
> --- c/grep.c
> +++ w/grep.c
> @@ -357,7 +357,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
>  			p->pcre2_jit_on = 0;
>  			return;
>  		} else if (jitret) {
> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
> +			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'%s",
> +			    p->pattern, jitret,
> +			    pcre2_jit_functional() 
> +			    ? "\nPerhaps prefix (*NO_GIT) to your pattern?" 
> +			    : "");
>  		}
>  
>  		/*

Looks sensible, but maybe something like below would be even better?

diff --git a/grep.c b/grep.c
index 59afc3f07fc9..e0144ba77e7a 100644
--- a/grep.c
+++ b/grep.c
@@ -357,7 +357,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			p->pcre2_jit_on = 0;
 			return;
 		} else if (jitret) {
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+			int do_clip = p->patternlen > 64;
+			int clip_len = do_clip ? 64 : p->patternlen;
+			die("Couldn't JIT the PCRE2 pattern '%.*s'%s, got '%d'%s",
+			    clip_len, p->pattern, do_clip ? "..." : "", jitret,
+			    pcre2_jit_functional()
+			    ? "\nPerhaps prefix (*NO_JIT) to your pattern?"
+			    : "");
 		}
 
 		/*

It'll ensure, git will be printing the hint even for very long patterns,
like the one I was testing this with ("$(perl -e 'print "(.)" x 4000')").

Thanks,
Mathias
