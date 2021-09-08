Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F929C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E855D60238
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243548AbhIHBcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHBcx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:32:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467A5C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:31:45 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n11so544082edv.11
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ypRFJq9rLzUznt5X1H5LJDJbFPJpn8Di7fWRY/X+9ck=;
        b=Pe/prvz1Wzj1YPieriV0PXHsQgWry33NegDdTiJGh9uhu0espqJrxpoOSXdGEPsYHK
         ThL6XHLyjLXR5mJaXr/zwC+l19WJbnjzNWL4vJ7Jc8L1SW7I0TuwB/n8T8UknYkG5FG/
         EF6Cc9tcOg6TQ7nol1Rb/ygO6dUke9DkeBjWt3yX3AI427xhYXvq9S6i6ieZxq0IcAm9
         EktI45idVBZTsutoT8ogGnDeK2hYt12Nq4FyOAEkqDZrnBU7wy8vD8VuT8dtK3DJwYrz
         XJZG60d5aD7mNNTaSlVPqUCXkXGi9iM7sdSgDHTs3ZiHhLwhLdsC+zRY1Iv860QWrLeB
         QwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ypRFJq9rLzUznt5X1H5LJDJbFPJpn8Di7fWRY/X+9ck=;
        b=CNzizeDJtbuGDizKpy71sCsKX+HfKGa7F6NgIQ+HDZxnAGfq3OM8CIp57n3hybfAXb
         DmI2wfdBoo592OaYkDY+n9uWwrFwMVL1vxncRccB7rFzS7rpLOCyPT5pX3Pd2ukj9mT3
         1fs+YaN7aLYnx47wUuuDauFPWcPVmG97WwPskYRIZRG8aGXeDG3bljESvRBWIJYBEbjG
         Phi4ExPlQrmp+i4dKgoP12ZAwgL23LCP1LQe/+wop5eCP2y+TgpuPYIIdAV2oaD61MG+
         HSE57DTzOTO8muZmTLp7s56awLDUw3vH9SpOia/egIMqKQ+T1DapQPfXfwQ2lijqKpzl
         zAEw==
X-Gm-Message-State: AOAM533fuumL8nV6NaGzebONKMz416uHDpbxpFHubEOmZfNhKGc4iMJq
        Btd0mgsW+1/uluZsatXntzL8bPmpi0YpLQ==
X-Google-Smtp-Source: ABdhPJwLsUU+YM0ThLEuaArJKwRmbazKl1uDw50ARESuaEOv6oRfNyK7Avg0n0N0elF7Fa7eTLNxWw==
X-Received: by 2002:a05:6402:1385:: with SMTP id b5mr1227552edv.276.1631064703600;
        Tue, 07 Sep 2021 18:31:43 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm32843ejb.20.2021.09.07.18.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:31:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/11] Drop support for git rebase --preserve-merges
Date:   Wed, 08 Sep 2021 03:30:41 +0200
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
Message-ID: <87czpjkg3m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Johannes Schindelin via GitGitGadget wrote:

> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which w=
as
> included in v2.22.0), we officially deprecated the --preserve-merges
> backend. Over two years later, it is time to drop that backend, and here =
is
> a patch series that does just that.
>
> Changes since v2:
>
>  * Removed the no-longer-needed script_snippet variable
>  * Enhanced the commit message of the git svn patch to clarify that the
>    deprecation happened only in v2.25 there
>  * Adjusted code comments that still talked about the removed option
>  * Removed some no-longer-needed ACTION_* enum values
>  * We now also drop check_todo_list_from_file() because it is no longer
>    needed
>  * The todo_list_add_exec_commands() function is now scoped to the file
>    (because there are no longer any outside users)
>  * When users still use the options, they are no longer met by Git's blank
>    stares, but by a helpful error message suggesting to use --rebase-merg=
es
>    instead
>
> Changes since v1:
>
>  * Rebased onto v2.33.0
>
> Johannes Schindelin (11):
>   t5520: do not use `pull.rebase=3Dpreserve`
>   remote: warn about unhandled branch.<name>.rebase values
>   tests: stop testing `git rebase --preserve-merges`
>   pull: remove support for `--rebase=3Dpreserve`
>   rebase: drop support for `--preserve-merges`
>   git-svn: drop support for `--preserve-merges`
>   rebase: drop the internal `rebase--interactive` command
>   rebase: remove obsolete code comment
>   rebase: stop mentioning the -p option in comments
>   rebase: remove a no-longer-used function
>   sequencer: restrict scope of a formerly public function

I've looked this version over & followed all the discussions on the
earlier rounds (this year), this looks good to me. Thanks a lot for
working on it:

Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
