Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE5C10DCE
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CEF205C9
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClStT7zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgCOKjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:39:35 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43305 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgCOKjf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Mar 2020 06:39:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id b2so11327848wrj.10
        for <git@vger.kernel.org>; Sun, 15 Mar 2020 03:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MnuUxCtFEzPGVO7ILwEecBjmqdiXF+n9GHJ76TO6Nf0=;
        b=ClStT7zb73wcAAGTqyDI+fuaUB4RZiTatzxeYsnDiDnOqwTF0o09QRh3ZFEsG/W1KG
         AJOkMLwsCoBHBcMJJZ5NiqcicLDJAUAP3E52nS+2hsg4PfrQFa3HXqNWsVKt07okiSup
         p/a4nZ/1JFDpD5cFhmCRwOvsXFe58gNhmUgwz0ztFUBdAgkRVn0lx9Xlj4JiV5trnOFO
         J74R5631HqEzNY8dJYF3xXznvZvLFFH/bQBQOI0S00mbVSFksz+YC+0JamvDaGk4N5/y
         rszj25K7rDp9QXhBFxjJP4H+tShevfnflahEn6noQKSlMexZYwzVQYTMnDQprvYGVeaM
         gm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MnuUxCtFEzPGVO7ILwEecBjmqdiXF+n9GHJ76TO6Nf0=;
        b=MRNTp+HzPV3MFPDaHYfZjjo3Doqo8eLl18YQ8CxbPHknmDzDvFTjeVJDp2daS2yyvH
         9gR2iuqshhkcRNOr/WAHPT8ZLzPJl+35SwVD3qPTOgv0kHvW/EGQ20r6KQy4U2UbDQfk
         XXi/XIYixfH2+Kw5vsQCisHi1UoLw2xsNYOrHEZwZp9EILP6nq5wZdTQC4YUJln9T3rm
         T0EBlcUWvVIlOYl0RRxlBfqjCUhnsUGjqviwluaxxzLfGCrGy3OJyGAhVwSxOX8JbqIu
         VhETkmVLU6+bq+MDxvd4Tx3GoaiW98fGZ82d8MBShEz9n0fZTbj54Zh1d7XrmzXC35Qe
         6X3Q==
X-Gm-Message-State: ANhLgQ0mcs3/M2DiRgr5xAXYfrwuR2Ym4PWfT3ukFfrSCcnvsytGRL7c
        CJJdpo15OjM9czfF9/PU4HM=
X-Google-Smtp-Source: ADFU+vs9oI+B7XOP78SgvAdAHG8BcmXOX3eQaUGYHzJawkYlJ1sZ1vg5LhaPG2hFeC7j8lCn+H++Xw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr30471387wrw.313.1584268772969;
        Sun, 15 Mar 2020 03:39:32 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id u1sm69569193wrt.78.2020.03.15.03.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 03:39:32 -0700 (PDT)
Date:   Sun, 15 Mar 2020 11:39:29 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 5/8] builtin/clone: compute checkout metadata for clones
Message-ID: <20200315103929.GH3122@szeder.dev>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
 <20200310182046.748959-6-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200310182046.748959-6-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 10, 2020 at 06:20:43PM +0000, brian m. carlson wrote:
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 1ad26f4d8c..00e5427ef1 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -780,11 +780,12 @@ static int checkout(int submodule_progress)
>  	if (!strcmp(head, "HEAD")) {
>  		if (advice_detached_head)
>  			detach_advice(oid_to_hex(&oid));
> +		free(head);
> +		head = NULL;

Coccinelle suggests to use FREE_AND_NULL(head) instead.

