Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF0F207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 16:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162930AbdD0QjO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 12:39:14 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:18411 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162914AbdD0QjM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 12:39:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wDN261g3xz5tlG;
        Thu, 27 Apr 2017 18:39:10 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6840543E;
        Thu, 27 Apr 2017 18:39:07 +0200 (CEST)
Subject: Re: [PATCH 18/26] fast-export: avoid leaking memory in handle_tag()
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
 <1eda2649781a15264e9995e705d19206185dbbb1.1493237937.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <885f5dbc-b5d0-5113-d2ee-e9bac47c4271@kdbg.org>
Date:   Thu, 27 Apr 2017 18:39:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1eda2649781a15264e9995e705d19206185dbbb1.1493237937.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 22:21 schrieb Johannes Schindelin:
> Reported by, you guessed it, Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/fast-export.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index e0220630d00..828d41c0c11 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -765,6 +765,7 @@ static void handle_tag(const char *name, struct tag *tag)
>  	       (int)(tagger_end - tagger), tagger,
>  	       tagger == tagger_end ? "" : "\n",
>  	       (int)message_size, (int)message_size, message ? message : "");
> +	free(buf);
>  }
>
>  static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
>

There is an early return in the function that is not covered by this 
patch. Look for "case DROP".

-- Hannes

