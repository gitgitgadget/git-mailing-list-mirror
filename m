Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA43C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068220720
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO4o57Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgAHNnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:43:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36308 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgAHNnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 08:43:25 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so2637147qkc.3
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G8whdwp9CY/52yljtmckj3wxo6SmFQpKLQotjXCK+7A=;
        b=QO4o57TyBV5wwAy2W8/opUv0df5rDhPbvne6Be6x09Jn3uNponwWr3c6FdQcGHKl7g
         QBqtMDQlQfdZQtEh/o8HLsO1jo0RG6NpMUyX2Mz5dzXj4QXRHffIAYoiUD6YKZfS0UxQ
         hj15Yg3bsQvzEik7l4noO1StxUwY5aFE0wqYpC4TgZ4gq7uxURt2XMIy3yXIApv/fwmA
         /sdQwngYcTKjLCy6toWhzqzOCpCryf2qcRch4PQZjIQDHcfjjBFjQebycV87qUDEEGg1
         hE4ONKkr/XJLTIe3pU8jTVgbYUZpQgNKFrRINAvfL9NClLdejKtZ7ePdGekNxEglZrVD
         03mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G8whdwp9CY/52yljtmckj3wxo6SmFQpKLQotjXCK+7A=;
        b=cckL4I5+uDb+ba19N9mVcB+nAf3MxKYqPDnlp1af2ItfVLC1dWtBnKgUwXLDA23dII
         tsP4aJZ4VAHriaXY9J3l2O7bOAI3ArLmivVEYa8Gg805YwN/7FjGjk7HmBm8CCrw59Wg
         vI/YmXiV8qisTqBHXai7A0FgGUF8QTflDXR4WnFFNGDUWSbKQMoTsf2YJEKIsauph79/
         1DRR6bhzSi1gqbkg76MZ1SkNFV/bsE9OdYnlDatUrjMeQkY9EZEjA8f6U+nGpdNXx+E1
         rYEXJY/9KPsnyCbn3f03M6TrK2dS+nvUszfe6N2ilOb/EKYbx7xYl/w6mHerms44GphV
         FWIQ==
X-Gm-Message-State: APjAAAVHn2yhHUyJvbN1vE4zIMqzgTg6zamQf7Rwy8Tk94LkDDMVfapM
        0W/Ggm6Iybq3jVJF1vp4Uk0FLtcx
X-Google-Smtp-Source: APXvYqwMNa0XoouA/LnsOogJPbDpkdULjAtbrEqY01JwMDJXwEBG4ecdmrPvh+uU9WFrId3waUkOhw==
X-Received: by 2002:ae9:e30e:: with SMTP id v14mr4237096qkf.344.1578491004301;
        Wed, 08 Jan 2020 05:43:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3d10:d3f7:2db7:a1e2? ([2001:4898:a800:1010:ee45:d3f7:2db7:a1e2])
        by smtp.gmail.com with ESMTPSA id r37sm1561851qtj.44.2020.01.08.05.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 05:43:23 -0800 (PST)
Subject: Re: [PATCH] transport: don't flush when disconnecting stateless-rpc
 helper
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
References: <20200108033451.GN6570@camp.crustytoothpaste.net>
 <20200108071009.GA1675456@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bc8f8c12-75d0-c79c-2778-0e7afe6b796a@gmail.com>
Date:   Wed, 8 Jan 2020 08:43:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <20200108071009.GA1675456@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2020 2:10 AM, Jeff King wrote:
> On Wed, Jan 08, 2020 at 03:34:51AM +0000, brian m. carlson wrote:
> 
>> A colleague (Jon Simons) today pointed out an interesting behavior of
>> git ls-remote with protocol v2: it makes a second POST request and sends
>> only a flush packet.  This can be demonstrated with the following:
>>
>>   GIT_CURL_VERBOSE=1 git -c protocol.version=2 ls-remote origin
>>
>> The Content-Length header on the second request will be exactly 4 bytes.

Good find!
 
> But when we've initiated a v2 stateless-connect session over a transport
> helper, there's no point in sending this flush packet. Each operation
> we've performed is self-contained, and the other side is fine with us
> hanging up between operations.

Makes sense to me.

> But much worse, by sending the flush packet we may cause the helper to
> issue an entirely new request _just_ to send the flush packet. So we can
> incur an extra network request just to say "by the way, we have nothing
> more to send".
> 
> Let's drop this extra flush packet. As the test shows, this reduces the
> number of POSTs required for a v2 ls-remote over http from 2 to 1.

> +test_expect_success 'ls-remote with v2 http sends only one POST' '
> +	test_when_finished "rm -f log" &&
> +
> +	git ls-remote "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" >expect &&
> +	GIT_TRACE_CURL="$(pwd)/log" git -c protocol.version=2 \
> +		ls-remote "$HTTPD_URL/smart/http_parent" >actual &&
> +	test_cmp expect actual &&
> +
> +	grep "Send header: POST" log >posts &&
> +	test_line_count = 1 posts
> +'
> +

Nice test!

> diff --git a/transport.c b/transport.c
> index 83379a037d..1fdc7dac1a 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -737,7 +737,7 @@ static int disconnect_git(struct transport *transport)
>  {
>  	struct git_transport_data *data = transport->data;
>  	if (data->conn) {
> -		if (data->got_remote_heads)
> +		if (data->got_remote_heads && !transport->stateless_rpc)
>  			packet_flush(data->fd[1]);
>  		close(data->fd[0]);
>  		close(data->fd[1]);

Looks good to me. Thanks!

-Stolee

