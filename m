Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CB01F453
	for <e@80x24.org>; Thu, 31 Jan 2019 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAaTa5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 14:30:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33405 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfAaTaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 14:30:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so2873415wmh.0
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iFZmpgkb9sb3lMe3l2NQzgQUTpVnlpmkAwchZ4UC3rA=;
        b=A9rluYTygNDdW0aO6KHVyX6Mxug0RkgrtIFXe+95wWa4QKp48Jn6SNys+gwOdVysFv
         1QBiDizQBAeKOyxCNkb0DUddeUFBYN/7WrgOHco2/mf/9Y9w3YnMYMA0IbpwT4FWANMg
         sE7LgFuDTFTi3PStxJqmgzrd5hpk6DM331UBLzffV9blAqDnejbZehy+rUhVV/ekGWDq
         S4ULVCYD5+0KRUfaYiDA/w1pV9/epsIPI1M3FrdD0u2PXnfLGXqfZFH0aVIdc59Wt3Al
         FwpFJ+u+Yg/realPnj3ceewPgpPja/9gqhPnAGYROa8oLfzS5OdzOF8BMSLf2rDuWLn0
         PNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iFZmpgkb9sb3lMe3l2NQzgQUTpVnlpmkAwchZ4UC3rA=;
        b=l/pkAn1nGtThXF77Ga19rmRPjaS9IWkWZrh7/ur4IPhO8lqNehAx61TG4BxlFkjWjn
         3qmE6t1cF4Am0E1HPLv+sTB/PFuj0BAMy5O2p8dwveefANwCspgz36vo4GHgP9ooEvkc
         kX9ilvTUT58c93dTg2eeR65lVNjlB3R+f8AdWe0QTo0A4FJ2TouI3XvTHK4JmLqJc6aY
         oFQENs1B0jEPpqZWMOsoPWoj68Ba4H5AFK69jtsgkTMeq5A6sJTwDgpiGDb5DgvfDmUh
         DZkeM/qb37fGURASOJck74yrUDaVcP26KmzJOI05xTEf+RvsfgXOS26fiFkJD19dKqmQ
         ZsuQ==
X-Gm-Message-State: AJcUukfAczSH/Dh+yO68Gu5b5HhBYeVofLOyuWEs7v+USpcOCHuxb7dc
        gjrnFN6cmDqnO8K6yzhjM+w=
X-Google-Smtp-Source: ALg8bN6N0J5EW/r4ijcxeyaPx9R9sM2W34cY60B5slqK2TKlJ5MJvASRytzu+cU1KNh5MQlDVtqBOg==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr32189034wml.102.1548963053473;
        Thu, 31 Jan 2019 11:30:53 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e9sm7612093wro.16.2019.01.31.11.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 11:30:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Sun Chao <sunchao9@huawei.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v7 3/6] pack-redundant: new algorithm to find min packs
References: <20190112091754.30985-1-worldhello.net@gmail.com>
        <20190130114736.30357-4-worldhello.net@gmail.com>
Date:   Thu, 31 Jan 2019 11:30:50 -0800
In-Reply-To: <20190130114736.30357-4-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 30 Jan 2019 19:47:33 +0800")
Message-ID: <xmqqva241v6d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Sun Chao <sunchao9@huawei.com>
>
> When calling `git pack-redundant --all`, if there are too many local
> packs and too many redundant objects within them, the too deep iteration
> of `get_permutations` will exhaust all the resources, and the process of
> `git pack-redundant` will be killed.

Build each step of the series with "make DEVELOPER=YesPlease" and
your compiler hopefully would notice...

    CC builtin/pack-redundant.o
builtin/pack-redundant.c:347:12: error: 'is_superset' defined but not used [-Werror=unused-function]
 static int is_superset(struct pack_list *pl, struct llist *list)
            ^~~~~~~~~~~
builtin/pack-redundant.c:313:21: error: 'get_permutations' defined but not used [-Werror=unused-function]
 static struct pll * get_permutations(struct pack_list *list, int n)
                     ^~~~~~~~~~~~~~~~
builtin/pack-redundant.c:293:13: error: 'pll_free' defined but not used [-Werror=unused-function]
 static void pll_free(struct pll *l)
             ^~~~~~~~
cc1: all warnings being treated as errors
Makefile:2302: recipe for target 'builtin/pack-redundant.o' failed
make: *** [builtin/pack-redundant.o] Error 1

