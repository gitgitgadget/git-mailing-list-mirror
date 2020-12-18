Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE24C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04BA23B7E
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 20:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLRUyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 15:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgLRUyU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 15:54:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB8C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:53:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s26so8742780lfc.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 12:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WRvdR4s/IwVVhc5APQ7MKRWCZJ0V30vGsDTRoafzSwQ=;
        b=pQk5SHMCQp9QkcnsbenkJ7iXsDAV+n2X9GmcxCwic6zwH7aoVIk6627R3hEZGqCXGz
         rNAsq06Zh5huauT7Rrhab6RmHWUCABcj5ZLigXfQEOIx3NfvWMOb1h3z7XSO+w1i+YAw
         8wTQgXzZ3oZcDzGQ6LKqJ5MachuS9hnEfY2tcw+YXOkH7NlM2sVjkVlsRj749ABBktQ8
         hTRw/VpHDTG9rNKp08T20q45MQlL/lwdHx9Vzg0wKqfQu9rAnZ3oytdDoY2IQn0m3Moe
         phoXqkXpG/OZ5WmtDnsVk70zF1xo5JlVqjH/iKrrPnuW/O/IJV3Mb8KnXRQlVdGwhtRn
         JQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WRvdR4s/IwVVhc5APQ7MKRWCZJ0V30vGsDTRoafzSwQ=;
        b=jKtUdrqbzx3YAlQc0EjYQflok7Wb2ZTCEiFfPzfTqoerE3RIZ/e2ik4DSW7ZuMAGqA
         vALmfqhaESglsForxCA4Vu0v+KEfqYIbci57IL7ldv3Kc0xYb7abVz/bnPYuUK9ZlBOs
         lRuxDiOixueCVzgQvsioyIczKZgqEYD+vSWoNYgoqZEIeOQOZuaUUZ/UzlsU96YlqQ8t
         8pL0ElIkto3s9OCFKo2wOCS7Fc1AoE29m8NAKTeo53p8zAUUTVVqqq5ulOjy8T8fRvpb
         z1N/b7rl4hshQ/IFj0N3xMt+TtuIZLIam2TkVnnEbrKznd8r91TEVjetQ4U5+tsE6Tp/
         6CZw==
X-Gm-Message-State: AOAM53063WsVhAD1W1qdxRskviwnQ7EVYk47XG9Vbs6bm84Dco5k9io0
        jhjU611PLRh+jryXIgdU6KHCRz+IUQQ=
X-Google-Smtp-Source: ABdhPJz0zRDhAGgGdlVsA0+phhuRnEbeAJovdxcf7AqPWv1z1SOz8140pLgcA+ZSZVatz+6niOtULw==
X-Received: by 2002:a2e:7816:: with SMTP id t22mr2407687ljc.449.1608324818257;
        Fri, 18 Dec 2020 12:53:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q13sm1042602lfk.147.2020.12.18.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 12:53:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        <87wnxfb2gt.fsf@osv.gnss.ru>
        <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
Date:   Fri, 18 Dec 2020 23:53:36 +0300
In-Reply-To: <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 09:01:36 -0800")
Message-ID: <87czz696pb.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 6:42 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> New options don't have any visible effect unless -p is either given or
>> >> implied, as unlike -c/-cc we don't imply -p with --diff-merges. To fix
>> >> this, this patch adds new functionality by letting new options enable
>> >> output of diffs for merge commits only.
>> >>
>> >> Add 'merges_need_diff' field and set it whenever diff output for merges is
>> >> enabled by any of the new options.
>> >>
>> >> Extend diff output logic accordingly, to output diffs for merges when
>> >> 'merges_need_diff' is set even when no -p has been provided.
>> >>
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  diff-merges.c | 16 ++++++++++------
>> >>  log-tree.c    | 13 +++++++++----
>> >>  revision.h    |  1 +
>> >>  3 files changed, 20 insertions(+), 10 deletions(-)
>> >>
>> >> diff --git a/diff-merges.c b/diff-merges.c
>> >> index 725db2312074..ffe20d8daa4a 100644
>> >> --- a/diff-merges.c
>> >> +++ b/diff-merges.c
>> >> @@ -10,6 +10,7 @@ static void suppress(struct rev_info *revs)
>> >>         revs->dense_combined_merges = 0;
>> >>         revs->combined_all_paths = 0;
>> >>         revs->combined_imply_patch = 0;
>> >> +       revs->merges_need_diff = 0;
>> >>  }
>> >>
>> >>  static void set_separate(struct rev_info *revs)
>> >> @@ -51,9 +52,11 @@ static void set_dense_combined(struct rev_info *revs)
>> >>
>> >>  static void set_diff_merges(struct rev_info *revs, const char *optarg)
>> >>  {
>> >
>> >> +       if (!strcmp(optarg, "off") || !strcmp(optarg, "none")) {
>> >> +               suppress(revs);
>> >> +               return;
>> >> +       }
>> >>         if (0) ;
>> >> -       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>> >> -               suppress(revs);
>> >
>> > The "if (0) ;" is still really weird.
>>
>> An idiom (see my previous answer). I'm fine getting rid of it if you
>> guys find it weird (that I'm not).
>
> I've never seen this idiom, and we apparently have no uses of it in
> the code.  If it were near any code I was editing, I think I'd rip it
> out as a preliminary cleanup patch...but maybe others have other
> opinions.

Essentially, this is poor man replacement for non-existent:

    switch(s) {
      case "str11": case "str12":
         do_things1(); break;
      case "str21": case "str22":
         do_things2(); break;
      case "str31": case "str32":
         do_things3(); break;
      default:
         default(); break
    }

Notice that all the case statements, except the last one, look the same,
while with bare "if() else" constructs you get the first one looking
special:

    if (!strcmp(s, "str11") || !strcmp(s, "str12"))
       do_things1();
    else if (!strcmp(s, "str21") || !strcmp(s, "str22"))
       do_things2();
    else if (!strcmp(s, "str31") || !strcmp(s, "str32"))
       do_things3();
    else
       default();

Now, fixing it is as easy as:

    if (0);
    else if (!strcmp(s, "str11") || !strcmp(s, "str12"))
       do_things1();
    else if (!strcmp(s, "str21") || !strcmp(s, "str22"))
       do_things2();
    else if (!strcmp(s, "str31") || !strcmp(s, "str32"))
       do_things3();
    else
       default();

and it makes reordering and #ifdefing slightly less painful as well.

Just saying rather, than insisting on adopting or even accepting it for
the Git codebase.

Thanks,
-- Sergey
