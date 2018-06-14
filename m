Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9920D1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeFNRgw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:36:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41314 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNRgv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:36:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so7272860wrq.8
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9Pjetj7TCP6KQpbR4qq6xLLh0CYpsoLfs6lbrG/PIs4=;
        b=NynBftYaSrxAGLAuoWel/mojy2UoNQMM1VkPYQTktUrGZKXqpZx/KE5we1kzUWoXIv
         ZGU8g+Ah/85IiRPsrR9hFf4j74NzZ2aJEoUlXHFyQ9eER+fXIgWt+KkXynHGhmhbkNZD
         ZkyIEORZCjBUJVSZSFydSTsVn9sbVEczEQLMzQILBfv/jQhK2LG8347QKsXpcwau1G0v
         dllJYWSTrYezdZ9KbTCTFB9o0icPkAEUxHZR5NYGrEeoNPMPNaqqZmcLDTyy9r6HAgsc
         XPXIp6rT6EZ+xP4AhJ5JBmhZkx447hTZlXEuDOxhLJpyhHCSrfrnCa81dDE0ZCp54woZ
         Ownw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9Pjetj7TCP6KQpbR4qq6xLLh0CYpsoLfs6lbrG/PIs4=;
        b=mPzlq5GxB5MB8TEXPd5czSN9gJSJw3fYtley29gznRCQ4Z5ugRTt+uPg+bLYNpoa9K
         IycE9i+iJEY80aG8z4oClPAwFWI+MsE9RXQf1MANKErMxsmgrkcikckD1oigCwnzI5/g
         2LwSLiSwQ3A9dTX4qmk+b4xBKSDfqqrqnIE1c2FA1akcK6bZtQssWCEDBNcs01YoqSHY
         +Kj3ASmEON0+w+eWFx4mZJd7lobPBM50h2NsdpN8DV+388rHNUxhhF9XfzmtmikD/m+3
         M/Lx9STNpj/YlMkP7yy56MfGUFD+Aa1pTExPLWOGhaTnUCFLxlKTuY8BSsZaTln7J24G
         fJOQ==
X-Gm-Message-State: APt69E3QDguVVtnlfl1my0vtrr7EHXw7m0e9hJjCPhu6WMxM/9cMUn6+
        MQGWQArCQ+uw5z4MEcAlU1g=
X-Google-Smtp-Source: ADUXVKIFatbHjaE5Uma34eX3xvjJoVJI3KWzkYIO6irZWrZonDzGc81wHhafW3FyIK8J1y3qzb3kNg==
X-Received: by 2002:adf:9a4c:: with SMTP id z70-v6mr3338322wrb.118.1528997810402;
        Thu, 14 Jun 2018 10:36:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l10-v6sm6873134wrm.29.2018.06.14.10.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:36:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 24/30] merge-recursive: Add computation of collisions due to dir rename & merging
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-25-newren@gmail.com>
        <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de>
Date:   Thu, 14 Jun 2018 10:36:48 -0700
In-Reply-To: <7d1237c7-5a83-d766-7d93-5f0d59166067@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 10 Jun 2018 12:56:31 +0200")
Message-ID: <xmqqr2l946dr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> The value of PATH_MAX is platform-dependent, so it's easy to exceed when
> doing cross-platform development.  It's also not a hard limit on most
> operating systems, not even on Windows.  Further reading:
>
>    https://insanecoding.blogspot.com/2007/11/pathmax-simply-isnt.html
>
> So using a fixed buffer is not a good idea, and writing to it without
> checking is dangerous.  Here's a fix:
>
> -- >8 --
> Subject: [PATCH] merge-recursive: use xstrdup() instead of fixed buffer
>
> Paths can be longer than PATH_MAX.  Avoid a buffer overrun in
> check_dir_renamed() by using xstrdup() to make a private copy safely.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Thanks.  Makes sense.

>  merge-recursive.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index ac27abbd4c..db708176c5 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -2211,18 +2211,18 @@ static struct hashmap *get_directory_renames(struct diff_queue_struct *pairs,
>  static struct dir_rename_entry *check_dir_renamed(const char *path,
>  						  struct hashmap *dir_renames)
>  {
> -	char temp[PATH_MAX];
> +	char *temp = xstrdup(path);
>  	char *end;
> -	struct dir_rename_entry *entry;
> +	struct dir_rename_entry *entry = NULL;;
>  
> -	strcpy(temp, path);
>  	while ((end = strrchr(temp, '/'))) {
>  		*end = '\0';
>  		entry = dir_rename_find_entry(dir_renames, temp);
>  		if (entry)
> -			return entry;
> +			break;
>  	}
> -	return NULL;
> +	free(temp);
> +	return entry;
>  }
>  
>  static void compute_collisions(struct hashmap *collisions,
