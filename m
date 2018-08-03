Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52F511F597
	for <e@80x24.org>; Fri,  3 Aug 2018 06:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeHCICk (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 04:02:40 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36885 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeHCICk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 04:02:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id d5-v6so2105489pll.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 23:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jOVbw9Zk0iQC67zOHBnZVFvjyX1EQX5jpgK/f9ITNN8=;
        b=DdjQsX+ubVmCpxzq1vQI6J/7mdtikLuIdPpLD5IQ2FuWOwSRHCIK71qLEo5lo4gW9c
         noyKEufZndcyqdnRql/N3WNB46mi+VGQq2BkAIu9PJgRyd7NPILCRzucsirPaZeb1KHb
         uusP4ngOIPRZwMQhrop3eK15IGoDJ3KgoBes+JISZqO2tGha/BPyuMuB1kUyKRtkKm/y
         iAWTqZ2h7fvpHrR4mByg4K80xnT6k9S0OixORr6IjThXeYlKMQLwJPibcMEHCeCrf5Up
         Q/OcsVH7FBxjvUaZaaNqssAZ9rphg3sa/a3x0r3ibHNMfYwtLU6VLi0jJV6OzEB2MMLp
         wfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jOVbw9Zk0iQC67zOHBnZVFvjyX1EQX5jpgK/f9ITNN8=;
        b=ir6EuKysSLjJ+YMhadKEvtbcRS9ak7wm+B8KcbL+08GTbIDOnrm8UT4jBu9Is4aUfS
         6SDtd+j9ljzH+cXX5FyIPBEZu0B6IsuU23LTuwHyfVRkUwv8tLXUE/64JWCU2FbDW7KQ
         Wc7IN5QQBmRq0sipdsyYqb3E/3rtRkmlt6nZ0iZuxOFmfLpvrPzcXteehyR+XnPUmOA/
         odqjkUkgBBIlinbEm8pSAJvGN4zFtnViEDtite3HlhAzFvXr1WKbNYHdGEehyr+NClyz
         CeUOGbtmtO1IhwN9Jb8Er9wPDt1RhPrXdQci60wtl1rVNVpiggZLbNSqOaUUETW1Vava
         8qRw==
X-Gm-Message-State: AOUpUlFV8S3emvUlXnQiJEyJu5i31raSVhSJZLIKCJOLFHWBU0wv9KFn
        sR5EzdIPbWtVCcog7IVbb7puXjV6
X-Google-Smtp-Source: AAOMgpf9qHxMJOnt1SAmT0P+hJqqo0pltzEp8DeYM4BxT1wM5SsYmMkB5UHnF4Ok6OOii3Jvkko41Q==
X-Received: by 2002:a17:902:7592:: with SMTP id j18-v6mr2228454pll.72.1533276478102;
        Thu, 02 Aug 2018 23:07:58 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j15-v6sm5320951pfn.52.2018.08.02.23.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 23:07:57 -0700 (PDT)
Date:   Thu, 2 Aug 2018 23:07:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] color: protect against out-of-bounds array
 access/assignment
Message-ID: <20180803060749.GA237521@aiede.svl.corp.google.com>
References: <20180802093208.27420-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802093208.27420-1-sunshine@sunshineco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Eric Sunshine wrote:

> want_color_fd() is designed to work only with standard input, output,
> and error file descriptors, and stores information about each descriptor
> in an array. However, it doesn't verify that the passed-in descriptor
> lives within that set, which, with a buggy caller, could lead to
> access/assignment outside the array bounds.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  color.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/color.c b/color.c
> index b1c24c69de..b0be9ce505 100644
> --- a/color.c
> +++ b/color.c
> @@ -343,6 +343,9 @@ int want_color_fd(int fd, int var)
>  
>  	static int want_auto[3] = { -1, -1, -1 };
>  
> +	if (fd < 0 || fd >= ARRAY_SIZE(want_auto))
> +	    BUG("file descriptor out of range: %d", fd);

The indentation looks wrong here.

Combining that with the other suggestions from this thread, I end up
with this v2:

-- >8 --
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: color: protect against out-of-bounds reads and writes

want_color_fd() is designed to work only with standard output and
error file descriptors and stores information about each descriptor in
an array. However, it doesn't verify that the passed-in descriptor
lives within that set, which, with a buggy caller, could lead to
access or assignment outside the array bounds.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 color.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/color.c b/color.c
index b1c24c69de..ebb222ec33 100644
--- a/color.c
+++ b/color.c
@@ -343,6 +343,9 @@ int want_color_fd(int fd, int var)
 
 	static int want_auto[3] = { -1, -1, -1 };
 
+	if (fd < 1 || fd >= ARRAY_SIZE(want_auto))
+		BUG("file descriptor out of range: %d", fd);
+
 	if (var < 0)
 		var = git_use_color_default;
 
-- 
2.18.0.597.ga71716f1ad

