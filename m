Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89FDC2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9361E2222E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnQgDLmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgDFOpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:45:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52198 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgDFOpk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 10:45:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id z7so14888771wmk.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5j4nkkQBBp5x+gHmBQvjM42lRzVaGxZ1aWu4WB82Ylk=;
        b=mnQgDLmqKLPMcHyAnfd4E+mx0LGfyMUTsrketu0LTwrmRWN+B8w6L9kHcUwfYX8rcZ
         Kgz9FmHSVm8YgVsErMsj2LVyAwgoS8v/UAeLpLJC3Rg6un+WY4cTYnHGwNVrCCasKtD1
         vUZhRZ/yRcRIad98NitsL9yIzjaDi7UCjNbugoxIKmgbRFlnoVuj53PcUV0E3XIRoHge
         vBhlrrQLQTBwEDPjO9SP3YFMVXJqHWrQFND6pZp89RTHr9e9z6tUtSiAloa21YraopK0
         YyO70eIc8+MQ1HAB92nHounMPhojTSlHT5sGXThTvrAzH1P+EJ0XqpZhEKu8xpCrQzFO
         Wc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5j4nkkQBBp5x+gHmBQvjM42lRzVaGxZ1aWu4WB82Ylk=;
        b=f5kCXHWn9TMn1VSbBAVoRpyH2HOn3NaEIf57HMvZh/kGuBStaOwFWW+G9S59TLm9hG
         Z36Wh1pNbnS9oayOG6V0eVOzcadFyq5rkbUZUiffsKhIPXATW5+moJ94sdUWekfIuF3x
         4TIgQ2c/enx/9ckUD6F2vccaZMvm/RJHBkVgGdA8yvFIZvpgSCf0Dv2BOLLAwiGyvW13
         O73UAbTMxYO2qaRlJecWA/OvcEigdTeTwAjAu2Bkh4zUi1VRK8qRDr8wWcxluiyJCBER
         EhDH2suLJ3TRsJDKj9dbHRLJCT1nzJRg3CtN8h+GnMs8bAIOa79nh70M7rzboHL5sGFr
         qD2Q==
X-Gm-Message-State: AGi0PuZcMOUpoKxNhgCU+xISMbGvWgCNTmzw9AdTi+a8UVsvoQb16J6f
        iFENEoC+yAmfoupsVp/sjj4=
X-Google-Smtp-Source: APiQypKpOfj42zn9u4Igj7JNfouqqjZVETOmR3WWw9TWYQOrsBHXbTomcpgjAj4xDncUR6YoTY9Q3w==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr21984wmc.145.1586184338453;
        Mon, 06 Apr 2020 07:45:38 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id r14sm25735554wmg.0.2020.04.06.07.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 07:45:37 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 07/23] sequencer: configurably warn on non-existent
 files
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1584782450.git.liu.denton@gmail.com>
 <cover.1585962672.git.liu.denton@gmail.com>
 <2e7922b259851091b9014c761d340ff1a73a04e4.1585962672.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <02110ed3-19c2-9074-2b30-90a4b289b0a8@gmail.com>
Date:   Mon, 6 Apr 2020 15:45:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2e7922b259851091b9014c761d340ff1a73a04e4.1585962672.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 04/04/2020 02:11, Denton Liu wrote:
> In the future, we plan on externing read_oneliner(). Future users of
> read_oneliner() will want the ability to output warnings in the event
> that the `path` doesn't exist. Introduce the
> `READ_ONELINER_WARN_MISSING` flag which, if active, would issue a
> warning when a file doesn't exist by skipping the `!file_exists()` check
> and letting `strbuf_read_file()` handle that case.

Now that you've updated the function in a previous patch the 
file_exists() check referred to in the message no longer exists

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 6c26d61670..b771e8f4ca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -420,6 +420,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
>   }
>   
>   #define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
> +#define READ_ONELINER_WARN_MISSING (1 << 1)
>   
>   /*
>    * Resets a strbuf then reads a file that was presumably written by a shell
> @@ -435,7 +436,8 @@ static int read_oneliner(struct strbuf *buf,
>   {
>   	strbuf_reset(buf);
>   	if (strbuf_read_file(buf, path, 0) < 0) {
> -		if (errno != ENOENT && errno != ENOTDIR)
> +		if ((flags & READ_ONELINER_WARN_MISSING) ||
> +				(errno != ENOENT && errno != ENOTDIR))

We don't need the extra indentation for '(errno != ...', it should align 
with the second '(' on the line above I think

Best Wishes

Phillip

>   			warning_errno(_("could not read '%s'"), path);
>   		return 0;
>   	}
> 
