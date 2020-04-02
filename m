Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F02C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EFC206E9
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJtTmo7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbgDBNjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:39:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45872 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388623AbgDBNjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:39:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so4206996wrw.12
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fimOfw9FogffF5IizLhTuTW7Q1H4OrV3Ppa9ou6Kd8w=;
        b=PJtTmo7d7nfy2AsqDocfMbIrvUfnM1tVFfn9MnpFyp6yv8T+tZzQApTt6zLfhHTzcP
         BQCje45VbXUbjDl/zxi4Ogiov2lZJRqjACvzddJDJn9TcMnSsxtjcCA9wE2YkqO8hMhL
         VHP/Xq1nj+UZkaPsZOrD1nl6rZCtDXdZiloStOymEseI6uiwC0Wbk/Uzm5Xtv4CG12+6
         09L+lqQFmKdodI0Ib4jmUNp4VbSIJojvL80Dmi02xC8gIKqRImBk71L8LXitTjSpynQ4
         Lor4+gAqKtoTLqyDNSi7w5/pbYgWw848cxQHAdu66oBfnvhE0sed6e349vRF0XJuExX+
         0nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fimOfw9FogffF5IizLhTuTW7Q1H4OrV3Ppa9ou6Kd8w=;
        b=WHE1IC7jAeLmtGeYpMibxwK04GlXbpCjLJW1ey+5kaNq5Dngik+1hlVQyOhRRuR+zq
         ezhr5Ri1iVzOlsNc9LaTf/aiLmjrQgNumL0qSy90GOfXZAntQ67VVsv0uVEFexDIpIr/
         Inqz4WxBCwK0bw4qGAOYTd9S91zVqcWyv1tKa0jAxOKD53uY1Dd8ZRveeZwlYYKSXdey
         F1UNutXq550EqeVbEAYY4m2JwTk1ttyLNDaA7/akNFO/eUaSbOo0AtSEfNq4bPL4umFi
         HVl6hr99MAKHDEuGsRTUIG/B5VYp7TBDCbhieOAxIeDdkNHQppJN0VMaRzS53afSarr4
         eiYA==
X-Gm-Message-State: AGi0PuZ9MZr+I4rXQelSragmqFIeVHIcPknz8R47CqTJDQGyXFjifSgG
        AozC8KvezCthW8s2WyXZCrs=
X-Google-Smtp-Source: APiQypIjBY8EwQfiwF17e3TAWBh7y9+Q3dxOA6bYq5z1xyx/IT/fCVfXWsPecgWg/U+z5P8dtOWcMQ==
X-Received: by 2002:adf:e848:: with SMTP id d8mr3483191wrn.209.1585834768050;
        Thu, 02 Apr 2020 06:39:28 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id n11sm6846628wmi.10.2020.04.02.06.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:39:27 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 05/19] sequencer: configurably warn on non-existent
 files
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <e42f4bdd4d763be4062f12fa6f1481849e87a0ad.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5c81eca7-0990-1c60-7f9f-04bce05be3ba@gmail.com>
Date:   Thu, 2 Apr 2020 14:39:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e42f4bdd4d763be4062f12fa6f1481849e87a0ad.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> In the future, we plan on externing read_oneliner(). Future users of
> read_oneliner() will want the ability to output warnings in the event
> that the `path` doesn't exist. Introduce the
> `READ_ONELINER_WARN_NON_EXISTENCE`

This is a rather cumbersome name, I think Junio's original suggestion of 
READ_ONELINER_WARN_MISSING is nicer

> flag which, if active, would issue a
> warning when a file doesn't exist by skipping the `!file_exists()` check
> and letting `strbuf_read_file()` handle that case.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index abb2a21e9d..92e8d38290 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -420,6 +420,7 @@ static int write_message(const void *buf, size_t len, const char *filename,
>   }
>   
>   #define READ_ONELINER_SKIP_IF_EMPTY (1 << 0)
> +#define READ_ONELINER_WARN_NON_EXISTENCE (1 << 1)
>   
>   /*
>    * Reads a file that was presumably written by a shell script, i.e. with an
> @@ -436,7 +437,7 @@ static int read_oneliner(struct strbuf *buf,
>   	int ret = 0;
>   	struct strbuf file_buf = STRBUF_INIT;
>   
> -	if (!file_exists(path))
> +	if (!(flags & READ_ONELINER_WARN_NON_EXISTENCE) && !file_exists(path))
>   		return 0;

This isn't the fault of you patch but it would be more efficient to do 
the read and then check for ENOENT/ENOTDIR rather than calling 
file_exists() first

Best Wishes

Phillip

>   	if (strbuf_read_file(&file_buf, path, 0) < 0) {
> 
