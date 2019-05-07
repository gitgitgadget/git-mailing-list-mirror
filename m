Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 666561F45F
	for <e@80x24.org>; Tue,  7 May 2019 09:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEGJtp (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 05:49:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41080 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGJto (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 05:49:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so18110985edd.8
        for <git@vger.kernel.org>; Tue, 07 May 2019 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LgkJsWNU805Wh0ErJR85C+70115g5FhT16yYMvzT2AM=;
        b=D2CvfRNCj5g6SCilc5J/5UgZ9gO7ph48SpfqyZd6cQg/2ObC9aol437su0bbNHurdS
         pdqyhaXm1wM8TLW81vOSJVBoj8uvL+O20feoeuwkoI/V68tP/xiF/FvdLHyfj5r3rte5
         z+eFtUee54PmiN6huxyQxuXKOxrnX/+MsX874iLHnxh+HzYA9FMyGf0HGBm9jp5ZNrOk
         +GCCpc/XIaZuhQk/AsBk+lZQW18fQ3ZVs3G3WiEkCrBaVehcoO4uQRb0vDN7oAJNfjRX
         2hw4I/f+KZxG7HrfujejN5lNQSLrQLz2FwjcCVZymcnjsyn3oAs1GNdJvR0N0J3r9t2F
         Lgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LgkJsWNU805Wh0ErJR85C+70115g5FhT16yYMvzT2AM=;
        b=kNpFm9puJSGwBiQ+EAx7SGng85yjFlhK4WlUYgSbuyOOUDUX6913fdErCwI6eRIZu3
         QUc2grJkW3vK0gmqlNTL9DiJEYKXDMq1iK3qkimptS6fXc9ilRe0Cd4hfuxeALF7cuUj
         sC0EulfpTfjedENsB30nzuOoHjVOlF4BHMJY1aoi0v5GRjJArS84inguYxmWrn+Oz4qy
         XxlKvjb5Rnc1fBtNUQClzEQ9yxhQbFAZzHt0UNM9CDsOdLoL+ZhjchauRZ+F2GyDdxXL
         nmUxvRZvWXbDA64I6Sg4wedp9xLvMNabXxdC8gyobp4iAZFgqA79K/mcjL1RX6TfJpYg
         jZ6g==
X-Gm-Message-State: APjAAAVTfoV1VgL9sIAvmzgtgzTq96WeRoCyVXHIeEFXGxTVl9HYhjJj
        d0lIva4zEQzFttDEHgxurx0=
X-Google-Smtp-Source: APXvYqx4FY9xRUgyq3r9E+Ewgx4uFYABv4U1Iz3w+fPr2/D1f+Djwjliw5QWrPfMMw+zZaiHTkVzHw==
X-Received: by 2002:a50:a495:: with SMTP id w21mr31561852edb.78.1557222583123;
        Tue, 07 May 2019 02:49:43 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id g24sm841796ejr.60.2019.05.07.02.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 02:49:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] commit-graph: fix memory leak
References: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <f4ab2a50873b2fd91926d7401f784479504d1b10.1557178485.git.steadmon@google.com>
Date:   Tue, 07 May 2019 11:49:41 +0200
Message-ID: <87zhnyh9vu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 06 2019, Josh Steadmon wrote:

> Free the commit graph when verify_commit_graph_lite() reports an error.
> Credit to OSS-Fuzz for finding this leak.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  commit-graph.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index 66865acbd7..4bce70d35c 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -267,8 +267,10 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>  		last_chunk_offset = chunk_offset;
>  	}
>
> -	if (verify_commit_graph_lite(graph))
> +	if (verify_commit_graph_lite(graph)) {
> +		free(graph);
>  		return NULL;
> +	}
>
>  	return graph;
>  }

This is obviously correct, FWIW the leak was there before the
verify_commit_graph_lite() refactoring I did, but I read the rest of the
surrounding code (but haven't run valgrind etc.) and it seems to be the
only one.

I wonder in general if there's a more sustainable solution to these
one-at-a-time memory leak fixes we're doing to these
libraries. E.g. marking some tests in the test suite as passing cleanly
with valgrind's leak checker, and adding a test mode to run those tests.
