Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266CB1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 22:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBAWUv (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 17:20:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38109 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfBAWUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 17:20:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id m17so5093458qki.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 14:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PO8r+e7xrgCbrbqX4YXNyevdNKCT580GO/bN2pGowSM=;
        b=L0UpEBKUE240bR1CKrxd5KwiW2dRy230BQpsmN234eeVmU0dIiK0qnwH9P3wZkLG+C
         NZEqWmdmCG7Quzxiue+FiZ1H7tk/ag/CnpEzahRGOtAuiQvaenrCbKyoT69uRAV/BxN/
         +0RTAdubZjd5yrdrd5a0Wo2K+cs41eM+bsoTd3pqD7zrgvFeIO8G0kw8CYIKdC/xiwnB
         n8QKlcW+ut58gQxNPGMU6JiXfBTNtMbwmRj44KBegoK60IfWyROHwmTIJpH8o6xGurSF
         koSVp6g2Rm64Be4xEItwtvSD8QMKnk8lOr9O9kUuhCEfNMNBYIUBe1gM4+V6+VtB5/xh
         iReg==
X-Gm-Message-State: AJcUukeZxYoofRQq04xvdo6PqbSKDA4sx8cSycO0OB+0pKzrzNUAPHG1
        jNjDkfZKU9mZEudMDzetRVZ/jOdKC7ag/c0LDmo=
X-Google-Smtp-Source: ALg8bN6OZN8LSLh8zmrIMDwH8LkkZIcm2W36XrGGdKhB3xY8HmvsZrq+SvotlUuziffA6l+UcV/At1ASvV7+IoOFgMg=
X-Received: by 2002:a37:9584:: with SMTP id x126mr37875786qkd.36.1549059649620;
 Fri, 01 Feb 2019 14:20:49 -0800 (PST)
MIME-Version: 1.0
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190201220420.36216-1-nbelakovski@gmail.com> <20190201220420.36216-2-nbelakovski@gmail.com>
In-Reply-To: <20190201220420.36216-2-nbelakovski@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 1 Feb 2019 17:20:37 -0500
Message-ID: <CAPig+cSfw=dun__contMMiHrdsZPPN68U4UzfBGz4Yt8DwO7mQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] ref-filter: add worktreepath atom
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 1, 2019 at 5:04 PM <nbelakovski@gmail.com> wrote:
> Add an atom providing the path of the linked worktree where this ref is
> checked out, if it is checked out in any linked worktrees, and empty
> string otherwise.
>
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> @@ -214,6 +214,11 @@ symref::
> +worktreepath::
> +       The absolute path to the worktree in which the ref is checked
> +       out, if it is checked out in any linked worktree. Empty string
> +       otherwise.

This may have been asked previously, but is there a reason this name
was chosen over the more extensible "worktree:" with "path" as a
modifier (i.e. "worktree:path")? I scanned the thread a couple weeks
ago and did see mention of "worktree:path" but did not find any
followup. I ask because it's conceivable that someone in the future
might want to retrieve other information about the worktree beyond its
path (such as whether it's bare or detached, etc.). By using the form
"worktree:<foo>", we leave that door open. (I'm not suggesting that
this patch series needs to implement fetching of any of the other
worktree properties, but just asking if "worktree:<foo>" should be
considered.)

> diff --git a/ref-filter.c b/ref-filter.c
> @@ -1562,6 +1628,13 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>                 if (starts_with(name, "refname"))
>                         refname = get_refname(atom, ref);
> +               else if (starts_with(name, "worktreepath")) {

I think this was brought up previously, but shouldn't this be strcmp()
rather than starts_with()?

(starts_with() would be appropriate, if you went with the suggested
"worktree:<foo>".)

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> @@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
> +test_expect_success '"add" a worktree' '
> +       mkdir worktree_dir &&
> +       git worktree add -b master_worktree worktree_dir master
> +'

I don't think 'mkdir' is needed since "git worktree add" should create
the directory itself.

> +test_expect_success 'validate worktree atom' '
> +       cat >expect <<-EOF &&
> +       master: $(pwd)
> +       master_worktree: $(pwd)/worktree_dir
> +       side: not checked out
> +       EOF
> +       git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked out%(end)" refs/heads/ >actual &&
> +       test_cmp expect actual
> +'

If this is the only test using that newly-created worktree, it might
make sense to squash the two tests together.
