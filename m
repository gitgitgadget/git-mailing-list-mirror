Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF711F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfJUQBB (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46922 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUQBA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so3828032wrw.13
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uJovKmolrO+GF9X9//y668T/mjHzIW7qVe2DVX3CuU=;
        b=udlTRDA4TkHY40V9iRiga2e68B0g7T/nC6ND/l264mIt0/pj8nODmXWihX5dCJYi1N
         gPCnW8SphlWDzfblb14OQY8u1TYHC6XupBUtIEKvyTh+SSABTxzGvmAIn2oAKlHM9nHO
         bZzaEE3dLpb9ZwV8NLv6gTLGgYNSxLQHloLiC4U8SGTR6N7aN0LzhiUQGwYlVfMyL4Uf
         /m9Z+gbBPHNb3uwOBFLXf48QYJLbwoMAdG9qPR+DX2XL4rbka42AiGDZpbX2n9K9ptgi
         LjYeqEvS/Nruu9q2KfntAglpad9r5nU97sWWi4cFpy+lCh8o7UbgzzCphzfkiCRvBc8u
         GvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uJovKmolrO+GF9X9//y668T/mjHzIW7qVe2DVX3CuU=;
        b=NPt/3Ar/pfIviWhGxKccQuUys2ZUt2JCAGloLA3gsc8NzzEcaXq/xD9az08U4+kG/D
         BLP1ie8AN9XHfUwJ2kFxunUGChhhvX1BZSS5uBUav+2AYvPYFgBHf1AiXU5zriCgSRoy
         zRDXaQX0mV+sb/cfHijSh0SqWOGcnsLFVpxFayXfHXbcEyKRVLja/mXHLVfakAW4qfXq
         zmxtrRXNHCX0VWbG7+pzka0eQrI8afWXRrAfkz7MDwlRS3lEgCE31pTbyJHaHM8SeU7T
         gvNWB7J/JvqXAvG/l0ppIY4WVCd1O7i/lWTUFbnPe9pjiL5IY2sgUXu8Yrg+0li9/7hM
         zumA==
X-Gm-Message-State: APjAAAXpvPAgfY7ZnKUTnANYXkoG8+5V7nFJd4YZP5LWblNLprqMn/gM
        0dXyfAQxD6kqE36iVnuGZ/o=
X-Google-Smtp-Source: APXvYqxKi3Z5jOkNY2cpBADUQIYXU2RZHMSWw5ffqIaA5CzaC2dRVz86imrMz0Imdb5vWRqBMa1FZQ==
X-Received: by 2002:adf:8295:: with SMTP id 21mr19921371wrc.14.1571673657181;
        Mon, 21 Oct 2019 09:00:57 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:00:56 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/5] path.c: a couple of common dir/trie fixes
Date:   Mon, 21 Oct 2019 18:00:38 +0200
Message-Id: <20191021160043.701-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191018113557.GA29845@szeder.dev>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 01:35:57PM +0200, SZEDER Gábor wrote:
> > unfortunately, see two more bugs,

And there are documentation bugs as well, both user-visible (i.e. in
a man page) and in in-code comment.

> > and one of them is a "proper" bug leading to bogus
> > output:
> >
> >   $ git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
> >   /home/szeder/src/git/.git/logs/refs
> >   /home/szeder/src/git/.git/worktrees/WT/logs/refs/
> 
> This one-liner below fixes it, but I haven't yet made up my mind about
> whether this is the right fix or whether there could be any fallout
> (at least the test suite doesn't show any).
> 
>   $ ./git -C WT/ rev-parse --git-path logs/refs --git-path logs/refs/
>   /home/szeder/src/git/.git/logs/refs
>   /home/szeder/src/git/.git/logs/refs/
> 
> 
> diff --git a/path.c b/path.c
> index 04b69b9feb..9019169418 100644
> --- a/path.c
> +++ b/path.c
> @@ -335,7 +335,7 @@ static int check_common(const char *unmatched, void *value, void *baton)
>       struct common_dir *dir = value;
>  
>       if (!dir)
> -             return 0;
> +             return -1;
>  
>       if (dir->is_dir && (unmatched[0] == 0 || unmatched[0] == '/'))
>               return !dir->exclude;

Now I made up mind: this isn't the right fix :)
The proper fix is in the last patch of this series.

Cc-ing David Turner, the trie's author; if I misunderstood anything,
then hopefully he can spot and clarify it.

SZEDER Gábor (5):
  Documentation: mention more worktree-specific exceptions
  path.c: clarify trie_find()'s in-code comment
  path.c: mark 'logs/HEAD' in 'common_list' as file
  path.c: clarify two field names in 'struct common_dir'
  path.c: don't call the match function without value in trie_find()

 Documentation/gitrepository-layout.txt |  10 +-
 path.c                                 | 122 ++++++++++++++-----------
 t/t0060-path-utils.sh                  |   2 +
 3 files changed, 74 insertions(+), 60 deletions(-)

-- 
2.24.0.rc0.472.ga6f06c86b4

