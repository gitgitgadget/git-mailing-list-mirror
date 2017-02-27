Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569B51F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdB0ULQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 15:11:16 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32991 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdB0ULO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 15:11:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id p185so1113632pfb.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VEHaSvC8J5jYo0bnphDqpa0kd6UkQHBVdfROuW0xQcU=;
        b=b8zVwpgETQpNX2f9rvdHamvHcXzlDqgfJyZjFTsAjk1/zq/6buUzY046UwsZk7a+8c
         I3VwcGh02KESrgIsh8RnaRKNi5zhXdGl5qRqixWPGZSxkNInCfy/vXI78lZVdGNtjWBc
         0KOHgPdFNRjYEop7R6BC7HbD4VUH9QFciQgDeyIFubuMP+njpFkKGnbogX4cXuyjPIta
         qdD/hU/x35z9ClC9+rH0lLcHog6HWOUCIuZ4mQh06bPE6oTihqd63YqDMV0rLRCL+8lG
         3vcfHTYWxhVT0mFZaOnRL27612+I8WjJPXHS/uJzfZXEBFTQd0nkSNLXyg2djPYp3UoT
         Z+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VEHaSvC8J5jYo0bnphDqpa0kd6UkQHBVdfROuW0xQcU=;
        b=bHpAI6JTVuLfZnn1RGr2dbsc2lt5oHXyFMrD3jLDvHxPg7enozyUPtPreL6XpVTq7r
         BST+/eOiqwAGj/1NlvY7Ehg4vZrIU6usICS0q61KYo3/AtoqGDKKeeY8iUbi3kgdQg67
         oz9/RH6e0esOzqQa3bxKaY5ht51xwda+6OXvooCFbKxf1zn9c7xi9wXYNQNZfNz7sQ4f
         6XHk7GLwkZHDKXzt1Fm4uCy5uutsKFnunF3uUg87qeb/C6h2BKgGaEq3TaSwN8RRQDj6
         SNqP6jQXxKmlikXFr/5J+a/1AJpIWO5I2b+Um04lqAD1ik4IfSCkqSSJMgiE1SUoVnO/
         DYxg==
X-Gm-Message-State: AMke39nDL7xMMosjp9NuZnlmpQ20eD93ow1ADjSELrJ7pCxhkOphYBiC+waxLtOgxhJmww==
X-Received: by 10.84.176.131 with SMTP id v3mr26429969plb.7.1488226219961;
        Mon, 27 Feb 2017 12:10:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id j185sm32365957pgd.13.2017.02.27.12.10.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 12:10:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
Subject: Re: [PATCH 1/2] apply: guard against renames of non-existant empty files
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
        <baf195cc-ef81-bbad-4e01-4149498efedb@web.de>
Date:   Mon, 27 Feb 2017 12:10:18 -0800
In-Reply-To: <baf195cc-ef81-bbad-4e01-4149498efedb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 25 Feb 2017 21:51:47 +0100")
Message-ID: <xmqqinnvwg2d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Would it make sense to mirror the previously existing condition and
> check for is_new instead?  I.e.:
>
> 			if ((!patch->is_delete && !patch->new_name) ||
> 			    (!patch->is_new    && !patch->old_name)) {
>

Yes, probably.

> or
>
> 			if (!(patch->is_delete || patch->new_name) ||
> 			    !(patch->is_new    || patch->old_name)) {

This happens after calling parse_git_header() so we should know the
actual value of is_delete and is_new by now (instead of mistaking
-1 aka "unknown" as true), so this rewrite would also be OK.

