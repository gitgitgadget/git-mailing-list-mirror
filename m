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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E770C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D09D23AC6
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLSMLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 07:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSMLp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 07:11:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E283C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:11:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o17so12413236lfg.4
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pqaBF1RUgXLy2kMIg30BHuiI9tt5Lm6KBcrFVXWoGoE=;
        b=VUl7f/lEsq4DLwqrbz9TxOCFJo9Djdgl4+go5ZzPPGbW+xEcSy7/VNicrpr3KB+69h
         xApZB/OK2psbh4CSwhq10JB+4FaBe8felJwGjiz3aFsBPmsAGZ++V2jY2FkTHfbx5uIb
         fARubKmKPH5omKEK2Ga5whs0f3ptBtfOuy4XP17h3EHCtPbpg4pOi6iyfuoMaNowyS+7
         KqSPEaELQP4TeUe/t1gUZYAg6XyRRWmMVSArvuIJpLcG1CYI28T4/eEPOpbnNEz4dpUw
         W+jSsk3SoI6rqSHh0IZD5zwMLGHecx+Nod7GRl7nD69Pr5ysRdxlW5QnGPqg5RmVTDuZ
         REuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=pqaBF1RUgXLy2kMIg30BHuiI9tt5Lm6KBcrFVXWoGoE=;
        b=ktuY9n/8QaKwq5N21nbY68klQBVMj4w90Uo8QH+9QEtaOfBsXWZQNztM07tIEVG5Do
         xX0y4AeKFCgk5VX1pMDFxrnHgcNyo00gFOQp8zKw4GgGtjzrCrVfvkLAPjdsh/5iNOwB
         dYGG3M5nWAEjOxjcRJ/U0sGLPMq4dSEQs7xIxul/jA60kxKwR7kZ5hKqZGVun2z2phGz
         08/UAohZUP2KWUSUa0S1BvkDlUXYh4YtA0kTJcF3qvwTyRLxsAeDCzdMGaiq8SS2KR6T
         fE3jE17YSnwbagTeWu69LrX1mBmqjmEQWQwkbroY8n2svBlV5esOjmHDp9rQalwClAQB
         peKw==
X-Gm-Message-State: AOAM5306HJCpAleokZD3s686C4ar8XmW8e7TDBzNEK0/VxL9cw5bdZpP
        o+q3VjU3zO5jnQRgfV+vZvjOd8whFtQ=
X-Google-Smtp-Source: ABdhPJz0NPea5DubO+mR4qlhTyM5K7Z8jTQK2rao6qP8+xImpk6RK6RbAhJhoZviTp62iNfXpu3mZQ==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr3569026ljp.254.1608379863572;
        Sat, 19 Dec 2020 04:11:03 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u6sm1280203lfk.127.2020.12.19.04.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:11:02 -0800 (PST)
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
Date:   Sat, 19 Dec 2020 15:11:01 +0300
In-Reply-To: <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 09:01:36 -0800")
Message-ID: <87o8iqm1wq.fsf@osv.gnss.ru>
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

[...]

>> >> diff --git a/log-tree.c b/log-tree.c
>> >> index f9385b1dae6f..67060492ca0a 100644
>> >> --- a/log-tree.c
>> >> +++ b/log-tree.c
>> >> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>> >>         int showed_log;
>> >>         struct commit_list *parents;
>> >>         struct object_id *oid;
>> >> +       int is_merge;
>> >> +       int regulars_need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>> >
>> > So rev_info.diff has changed in meaning from
>> > commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
>> > That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
>> > comment to the declaration of rev_info.diff to highlight this?  (And
>> > perhaps even rename the flag?)
>>
>> No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
>> still enables all the commits to pass further once set. It is still
>> exactly the same old condition, just assigned to a variable for reuse.
>> My aim was to avoid touching existing logic of this function and only
>> add a new functionality when opt->merges_need_diff is set.
>>
>> It looks like I rather choose confusing name for the variable, and it'd
>> be more clear if I'd call this, say:
>>
>>   int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>>
>> ?
>>
>> What do you think?
>
> I think need_diff would actually be confusing.  It can be false when
> you need diffs (e.g. --diff-merges=cc with no -p, because then you'd
> need diffs for merge commits and not for non-merge commits).  I'd
> stick with your original local variable name.

The problem is that original name I've used lies to the reader, or, more
precisely, tells half-truth. True meaning of the variable is "do run
diff for any commit, no matter if it's merge or not". So "need_diff" is
already better than "regulars_need_diff".

Maybe "diff_all_commits" will do?

Thanks,
-- Sergey
