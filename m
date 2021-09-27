Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C0CC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B52E6115C
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhI0Gjc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 02:39:32 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:6553 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233013AbhI0Gja (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 02:39:30 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4HHtHL5GbCz5tlH;
        Mon, 27 Sep 2021 08:37:50 +0200 (CEST)
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
Date:   Mon, 27 Sep 2021 08:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.09.21 um 02:39 schrieb Ævar Arnfjörð Bjarmason:
> --- a/cbtree.h
> +++ b/cbtree.h
> @@ -37,11 +37,12 @@ enum cb_next {
>  	CB_BREAK = 1
>  };
>  
> -#define CBTREE_INIT { .root = NULL }
> +#define CBTREE_INIT { 0 }
>  
>  static inline void cb_init(struct cb_tree *t)
>  {
> -	t->root = NULL;
> +	struct cb_tree blank = CBTREE_INIT;

This could be

	static const struct cb_tree blank = CBTREE_INIT;

> +	memcpy(t, &blank, sizeof(*t));

Is
	*t = blank;

not a thing in C?

-- Hannes
