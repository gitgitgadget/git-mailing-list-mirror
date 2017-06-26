Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60EAF207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbdFZSAq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 14:00:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33762 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdFZSAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 14:00:44 -0400
Received: by mail-pg0-f66.google.com with SMTP id u62so1048957pgb.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2cUlZy4qyP8hgcoVjvuVqObxS2kQyDFrN/t5w98zy3s=;
        b=SfS49mdTFuX4Zs0kFZUURO4qnQxbPyPvtXXOer2VvdKTe2ad4wdzkznoSZOmeb305I
         00XrF/uKARoU4GbGjyqVDA5WELJDTVC+EPxkBpe6wCRFF4rRWbM9WlIKwqrf6I/ryNl4
         AhmFBWXGOO/n4OwMqOEQMHojwwB2BG17G7XJAU09nycbOcMC4+50EJJ3oLzRPJ5Hp5/j
         N56onPZWXEigrT8Inu/Beq6vYt/F5usnQJ201kgDSfEK2HU7wpqRvSsOb6Gp4mFTtUNK
         KXlqTZtHAwNNQPj/tRZJTXrtfizX7KhQq01zmJHr9RjopU1YrdCIakfPRbbytcbS+YzX
         QhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2cUlZy4qyP8hgcoVjvuVqObxS2kQyDFrN/t5w98zy3s=;
        b=q4SNm96krDtY2v+D/6g2b6k4+LgobE6ffCXuTsrk4MUaSxyQ6uPN7GWqLgeAQ0AyWK
         xQ5eGdOtQt/ESdRmL4Gg005rHfKmrzpEkC4vvjgX0XpUbMmtvR2625ZNeGax8leure+E
         EI9ZcHFOER0XgOcq/4813/4exwT6qWEXeXAmhq/gTzcpJPTC7yxxW4M9c51P6iM6O0mU
         NMLIE1IVudstFKUEASrw8Yop71vsikucZVlZFfJCo+M2jpfFQW2W05N2sOIxFZIXyhjw
         uWPT3IUED8KU6XZ98yzIljdaIZYLnBEYAUCfjDaFCoSatfXWHMZLOd2W26QU59OIyBTw
         9zQg==
X-Gm-Message-State: AKS2vOw2SGo4kHgXWmDScfWPbVNIT+yRUbWlN2FECkQyImDrkKXy6Sq+
        /YhiwWJXeCCJbA==
X-Received: by 10.84.248.79 with SMTP id e15mr1464086pln.118.1498500043920;
        Mon, 26 Jun 2017 11:00:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id g184sm1477581pfb.3.2017.06.26.11.00.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 11:00:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 5/6] convert: move multiple file filter error handling to separate function
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-6-larsxschneider@gmail.com>
Date:   Mon, 26 Jun 2017 11:00:42 -0700
In-Reply-To: <20170625182125.6741-6-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:24 +0200")
Message-ID: <xmqqinji633p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Refactoring the filter error handling is useful for the subsequent patch
> 'convert: add "status=delayed" to filter process protocol'.
>
> In addition, replace the parentheses around the empty "if" block with a
> single semicolon to adhere to the Git style guide.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c | 47 ++++++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)

The patch looks obviously correct.  Thanks.

> diff --git a/convert.c b/convert.c
> index 9907e3b9ba..e55c034d86 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  	return err;
>  }
>  
> +static void handle_filter_error(const struct strbuf *filter_status,
> +				struct cmd2process *entry,
> +				const unsigned int wanted_capability) {
> +	if (!strcmp(filter_status->buf, "error"))
> +		; /* The filter signaled a problem with the file. */
> +	else if (!strcmp(filter_status->buf, "abort") && wanted_capability) {
> +		/*
> +		 * The filter signaled a permanent problem. Don't try to filter
> +		 * files with the same command for the lifetime of the current
> +		 * Git process.
> +		 */
> +		 entry->supported_capabilities &= ~wanted_capability;
> +	} else {
> +		/*
> +		 * Something went wrong with the protocol filter.
> +		 * Force shutdown and restart if another blob requires filtering.
> +		 */
> +		error("external filter '%s' failed", entry->subprocess.cmd);
> +		subprocess_stop(&subprocess_map, &entry->subprocess);
> +		free(entry);
> +	}
> +}
> +
>  static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>  				   int fd, struct strbuf *dst, const char *cmd,
>  				   const unsigned int wanted_capability)
> @@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  done:
>  	sigchain_pop(SIGPIPE);
>  
> -	if (err) {
> -		if (!strcmp(filter_status.buf, "error")) {
> -			/* The filter signaled a problem with the file. */
> -		} else if (!strcmp(filter_status.buf, "abort")) {
> -			/*
> -			 * The filter signaled a permanent problem. Don't try to filter
> -			 * files with the same command for the lifetime of the current
> -			 * Git process.
> -			 */
> -			 entry->supported_capabilities &= ~wanted_capability;
> -		} else {
> -			/*
> -			 * Something went wrong with the protocol filter.
> -			 * Force shutdown and restart if another blob requires filtering.
> -			 */
> -			error("external filter '%s' failed", cmd);
> -			subprocess_stop(&subprocess_map, &entry->subprocess);
> -			free(entry);
> -		}
> -	} else {
> +	if (err)
> +		handle_filter_error(&filter_status, entry, wanted_capability);
> +	else
>  		strbuf_swap(dst, &nbuf);
> -	}
>  	strbuf_release(&nbuf);
>  	return !err;
>  }
