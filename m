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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0BC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E6E206E9
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I45Uy5Ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgDBNfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:35:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35711 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgDBNfB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:35:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id i19so3717171wmb.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aW4clHFVDCq1d6a1sSv9nOvtjRSWhHC8dBA1LBx1gs0=;
        b=I45Uy5UiVh3WbrM3VwutvP7sKiVUkqlBHcSS86QeLjpgCN8TFZs+ATIoHCSONJGRKl
         EwiPfY5ArnUao/MX/SkoRu355rdl+cuB5MvXn+nFXsOht7UBhok5lgiAjruTKGk3gQ23
         Jn0y77omAfqRhKbfLmX/zOHQBNLrxwoVshyV+H8jLS9SP4KG37fLc54Avel1G2ANRasR
         GGZGQFgHBjqzeW+PAvbUSjw2olaj0fgeJtlNDKLkFLewGiPW4cs+pXR5LKX1DNi+dazU
         koTHJqwFwAgeQLyN5PjcHEAN/eWEBxLt3v2ioc8zoFHzS0+gf6KgGVJYTVu3wRHhLIeo
         zjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aW4clHFVDCq1d6a1sSv9nOvtjRSWhHC8dBA1LBx1gs0=;
        b=TzWbnPA+utZnS68BIZym8poBuLJfFt6IYGBYsT7CA4Nz8maRLSj6QaHF3yxuu4XRDh
         V4ie/pIK3dYNs9/mGcfev/9EN73GRe5dXbaTALKvJ1oqnDFd3kETJLMQWM9ThxeO24Bv
         RJbw3SNFHT3bLfqXaCGklVNlTtevzs7jvkD5REJo0XlrasaAE8JUJuM4HUjkfn7r/9j0
         mufSy6KbGEa9i8Me8TY9oLYH+kzFcg3KwLn+WnpunCvDwpaNMf8kWnANQeWkQiQnocNE
         g8fFVbwTl2hkOQ30NzCuD5LphfX2HlDmyIS3cu1UvXnsImXOCm8iu5keDRXI5QSiwa4J
         IMkw==
X-Gm-Message-State: AGi0PubLzfdcF6BCFRgaPIX9nfS1bc+IdbFdWKE2xDYqLR2Ch0Ztw62z
        XPo0gCRGwdIAh1hjMTmNX6c=
X-Google-Smtp-Source: APiQypKrdMmHy3oGiynua/nFu9rYrljagDSzMdYSiuHSerQCSe+RiamHn8h+EW12/+H+oxzGulyMKg==
X-Received: by 2002:a1c:96cf:: with SMTP id y198mr3497528wmd.186.1585834499439;
        Thu, 02 Apr 2020 06:34:59 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j11sm7533027wrt.14.2020.04.02.06.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:34:58 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 03/19] sequencer: use file strbuf for read_oneliner()
To:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1577185374.git.liu.denton@gmail.com>
 <cover.1584782450.git.liu.denton@gmail.com>
 <7c37777f07191c8ac1d26300f9465b90758550b2.1584782450.git.liu.denton@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0b237d3c-5b2d-1714-9243-8f32621a332d@gmail.com>
Date:   Thu, 2 Apr 2020 14:34:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7c37777f07191c8ac1d26300f9465b90758550b2.1584782450.git.liu.denton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton

On 21/03/2020 09:21, Denton Liu wrote:
> In the original read_oneliner logic, we duplicated the logic for
> strbuf_trim_trailing_newline() with one exception: instead of preventing
> buffer accesses below index 0, it would prevent buffer accesses below
> index `orig_len`. Although this is correct, it isn't worth having the
> duplicated logic around.
> 
> Add a second strbuf to which files are read and run
> strbuf_trim_trailing_newline() directly on this strbuf then concatenate
> this strbuf with the argument strbuf at the end of the function. The
> function's external behaviour is unchanged.

read_oneliner() is typically called with an strbuf that is used multiple 
times with the caller resetting it in-between calls. This saves us from 
having to allocate a new buffer for each call. The change here negates 
that as we end up allocating a new buffer each time and then copying the 
result. I'd be surprised if any of the callers actually wanted to append 
to the buffer, I suspect they all call strbuf_reset() before passing the 
buffer to read_oneliner(). If that is the case maybe we should think 
about adding the call to strbuf_reset() inside read_oneliner() and 
documenting it as resetting the buffer before reading. Then we can just 
use strbuf_trim() on the 'real' buffer.

Best Wishes

Phillip

> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>   sequencer.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index e528225e78..c49fe76fe6 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -431,26 +431,28 @@ static int write_message(const void *buf, size_t len, const char *filename,
>   static int read_oneliner(struct strbuf *buf,
>   	const char *path, int skip_if_empty)
>   {
> -	int orig_len = buf->len;
> +	int ret = 0;
> +	struct strbuf file_buf = STRBUF_INIT;
>   
>   	if (!file_exists(path))
>   		return 0;
>   
> -	if (strbuf_read_file(buf, path, 0) < 0) {
> +	if (strbuf_read_file(&file_buf, path, 0) < 0) {
>   		warning_errno(_("could not read '%s'"), path);
> -		return 0;
> +		goto done;
>   	}
>   
> -	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
> -		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
> -			--buf->len;
> -		buf->buf[buf->len] = '\0';
> -	}
> +	strbuf_trim_trailing_newline(&file_buf);
>   
> -	if (skip_if_empty && buf->len == orig_len)
> -		return 0;
> +	if (skip_if_empty && !file_buf.len)
> +		goto done;
>   
> -	return 1;
> +	strbuf_addbuf(buf, &file_buf);
> +	ret = 1;
> +
> +done:
> +	strbuf_release(&file_buf);
> +	return ret;
>   }
>   
>   static struct tree *empty_tree(struct repository *r)
> 
