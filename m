Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F104C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 20:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjAOU6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 15:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjAOU6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 15:58:06 -0500
X-Greylist: delayed 181 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 12:58:04 PST
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38D13511
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 12:58:04 -0800 (PST)
Received: from [10.0.2.15] ([147.147.167.102])
        by smtp with ESMTPA
        id HA1rpc8fBG2OpHA1spiAYc; Sun, 15 Jan 2023 20:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1673816101; bh=sZqM/ovBTVowdkzpwpNNSYUgHk1vNE6Aa7VR9grhl5A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=jkiAzLwBP7HrO6RmuGZrZmbg0L38vvgeNJo6N9iA1kTULeDHBb3fP6jwbcKJBJNJo
         8Hn3QQ81hZ+2Gd8dQchfTzYHiYn1e4ZAGE91nyXjyyGsx4odR1bFoVDgWEev8ZAM8h
         gWX9NrTPSCNoLzYh0DkpL4Qr12F9p45C66ANR5dFkig3CZ66yfX/YI0tCnx6i3pKcw
         DyS1JHXpFYbf6ax8+wUF8ueXwP6tW/zb/Bi++oPXZeTDl3WTnQIMW7UtrDnNMjgBXC
         qCZSf4MkntCevvV2vgnJxvzw8Q4zBpXcIS07rRXvwoceB2QNUXhoRe+552TaZDpfIW
         LlDhRWnWlK9bA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Lo2Bd1Rc c=1 sm=1 tr=0 ts=63c46825
 a=O4HnXJxpn4bBnFCb4s/IkQ==:117 a=O4HnXJxpn4bBnFCb4s/IkQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=lEYq4Q8YialkbmfdOZwA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <c77892ba-e5cd-1192-ceba-d49edcb95da8@ramsayjones.plus.com>
Date:   Sun, 15 Jan 2023 20:54:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8RduNqadAfaOgs1@coredump.intra.peff.net>
Content-Language: en-GB
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <Y8RduNqadAfaOgs1@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDIoHQH1NL0G9dtXIh/t1qXXKPU5kqlz/4tPgALNsNVWHgDhd307nl6EF2cYvNIqFVWh0SRh7ZPaALtkTXmvYZY4kr+XISRTUIAsxqhmC4Spovv7CDQa
 Exzhx0rIitQGXRE1huTS7hwrZ181gsthXahXKlUdWCzfrf4dt/Rj/mP+DBBjUnFJx+cBjA1y7ZRD522+Id5STimCX2N6xV7HBdY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/01/2023 20:10, Jeff King wrote:
> The two options do exactly the same thing, but the latter has been
> deprecated and in recent versions of curl may produce a compiler
> warning. Since the UPLOAD form is available everywhere (it was
> introduced in the year 2000 by curl 7.1), we can just switch to it.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http-push.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 5f4340a36e..1b18e775d0 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -198,7 +198,7 @@ static void curl_setup_http(CURL *curl, const char *url,
>  		const char *custom_req, struct buffer *buffer,
>  		curl_write_callback write_fn)
>  {
> -	curl_easy_setopt(curl, CURLOPT_PUT, 1);
> +	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1);

My version of this patch had '1L' rather than just '1' - but it
doesn't really matter (and was probably because all the curl
examples did so!).

LGTM

ATB,
Ramsay Jones

>  	curl_easy_setopt(curl, CURLOPT_URL, url);
>  	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
>  	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
