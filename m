Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5ACC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FD523B42
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgLIOJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgLIOJB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:09:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37D3C0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:08:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so346011lfg.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iHBk1L9XTrUhNyIZsRB3O3SaFOdCsx41ZWeifshGRko=;
        b=NSTALt8tqCOANbWsZMkC395zcypLBSjkhgxVu6uenvqs6y/jlSkck6EIoYOsREV2+s
         /hkUUZuWIjqI96WEoZc3zjsa/b4aNajSTXva+wiEJPa+m6249v/Q0/9izaoBwxd1IFYK
         XdtRHkwgRcUneiz2MdWrVIEsZeom8+9cmGqpyYQ3ugQW+QGiH8JS3h2XUmhEWJlPDAx9
         nyCFzQVzfzVDYpHgdFOGxH9H3ED/A5XXtY3aGdfcjhE3hOMIzpKOQbL55ARAFjYA3Tqq
         u/kzlVjO+csjK5eWdOFf/81M3rWt9Mef3HbODNE98oE2UXMDzMW9945qlcaQK4UoS20T
         PFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=iHBk1L9XTrUhNyIZsRB3O3SaFOdCsx41ZWeifshGRko=;
        b=D9CmPiodk1fDzz9Skf03xHURTcKHhTNh6WnCtmpoORQvimpQmbW0hnMH9k6w7z5Och
         tFbQC1tPxCTKRx3p8r5PnMZ59+WJS51mlWoNvC4DQNPB8XmXQHnNNCVHw0VOZd7JC/ak
         j4VWJy3amSmH7Zv3oPITvz7P5RWuSu57txnR626mdECp1iK1UpWaYMAQoPzgrL/cs9vl
         AjA382NeFkfbwYdTgwCfR9myHpslT6xtbVSRfKW2LsbqvfVeBuori9ytzklbO6TeAASu
         ElzAuXosxx/iEvvOma+SHnyiNHeqgHNV3yvnVUq9lEGWvh4qnKbHWJr3+DNV8Kl5qPwL
         RWPQ==
X-Gm-Message-State: AOAM532ujkZDv8ZYr5C++GovOmfnVscTFSIg1pNmeJdoW8XI9TwuqNhc
        +SeLz4DApPtVCV5lY1vWTRIj6b6HTp0=
X-Google-Smtp-Source: ABdhPJxywcLa/3TM7Uf/fzdKPsgp/YM8lTILriMeST5qqOIAkzIBeuO9Xq8pcLmliGlgi0V/V/z4Ng==
X-Received: by 2002:ac2:51ab:: with SMTP id f11mr1153417lfk.510.1607522898878;
        Wed, 09 Dec 2020 06:08:18 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b8sm243388ljo.68.2020.12.09.06.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:08:15 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <87y2i8dptj.fsf@osv.gnss.ru>
        <CABPp-BGuLX8Msghbo6L7vB2Wqys=Xg_uvV2Aui-1q4-+ijuNEw@mail.gmail.com>
        <87y2i8c4mr.fsf@osv.gnss.ru>
        <CABPp-BE3D7ifQx6MZCT_ntRnG0QZm1Ga10SJ=DN+6bpF6mX2GQ@mail.gmail.com>
        <xmqqtusv4w2g.fsf@gitster.c.googlers.com>
        <CABPp-BHCtrKAWR1v3OrUgX8iSfxvDwN8p+yiJy=G1BFfnSopjw@mail.gmail.com>
        <xmqq7dpr4qa0.fsf@gitster.c.googlers.com>
        <CABPp-BHWhiUZ=wCSz1f0oxtHiRzAKCPVmoUYDf+mvvm63ykCEw@mail.gmail.com>
        <xmqq360f4npg.fsf@gitster.c.googlers.com>
        <CABPp-BEAmB9DA7RXrf6vJGbHfGU37V4sE0d1CW+2vRwp_uAudw@mail.gmail.com>
        <xmqqtusv362t.fsf@gitster.c.googlers.com>
        <xmqqpn3j32ka.fsf@gitster.c.googlers.com>
Date:   Wed, 09 Dec 2020 17:08:14 +0300
In-Reply-To: <xmqqpn3j32ka.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 08 Dec 2020 22:40:05 -0800")
Message-ID: <87v9dbf4xd.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
> A clarification and a correction.
>
>> I suspect that the real reason why "-m" does not imply "-p" was
>> merely a historical implementation detail...
>
> Now I remember better.  The reason was pure oversight.
>
> In the beginning, there was no patch output for merges.  As most
> merges just resolve cleanly, and back then the first-parent chains
> were treated as much much less special than we treat them today,
> "git log -p" showed only patches for single-parent commits and
> everybody was happy.  It could have been a possible alternative
> design to show first-parent diff for a merge instead of showing no
> patch, but because the traversal went to side branches, the changes
> made by the merge to the mainline as a single big patch would have
> been redundant---we would be seeing individual patches from the side
> branch anyway.
>
> Then later we introduced "-m -p"; since the first-parent chain was
> not considered all that special, we treated each parent equally.
> Nobody, not even Linus and I, thought it was useful by itself even
> back then, but we didn't have anything better.
>
> I think it was Paul Mackerras's "gitk" that invented the concept of
> combined merges.  We liked it quite a lot, and added "-c" and "--cc"
> soon after that, to the core git and kept polishing, until "gitk"
> stopped combining the patches with each parent in tcl/tk script and
> instead started telling "git" to show with "--cc".
>
> By the time the change to make "--cc" imply "-p" was introduced, it
> was pretty much given that "-m -p" was useful to anybody, unless you
> are consuming these individual patches in a script or something like
> that.  So simply I didn't even think of making "-m" imply "-p".  It
> would be logical to make it so, but it would not add much practical
> value, I would have to say.

... and then later the "--first-parent implies -m" change has been made,
that would't work as expected if -m implied -p in the fist place, as
it'd break "git log --first-parent".

>
>> If I were to decide now with hindsight, perhaps I'd make "--cc" and
>> "-m" imply "-p" only for merge commits, and the user can explicitly
>> give "--cc -p" and "-m -p" to ask patches for single-parent commits
>> to be shown as well.
>
> After "now with hindsight", I need to add "and without having to
> worry about backward compatibility issues" here.  IOW, the above is
> not my recommendation.  It would be the other way around: "--cc"
> implies "-p" for both merges and non-merges, "-m" implies "-p" for
> both merges and non-merges.  It is acceptable to add a new option
> "--no-patch-for-non-merge" so that the user can ask to see only the
> combined diff for merges and no patches for individual commits.

OK, so, do we decide that -c/--cc must continue to imply -p and thus
request diffs for everything?

If so, I can rather change --diff-merges=combined/dense-combined
behavior to /not/ imply -p, thus effectively making --cc a synonym for
"--diff-merges=dense-combined --patch", that will have zero backward
compatibility issues.

Looks like it'd have everything covered. Old options won't change their
behavior at all, and the new set of options will behave differently,
exactly if designed from scratch, providing new functionality.

>
> Both "--no-patch-for-non-merge" option, and making "-m" imply "-p"
> are very low priority from my point of view, though, since our users
> (including me) lived without the former and have been happily using
> "log --cc" for a long time, and we've written off the latter as
> pretty much useless combination unless you are a script.

I think my above suggestion covers all the worries without need for this
nasty "--no-patch-for-non-merge" option.

That said, -m is useless, period. It'd likely have some merit in
plumbing, but definitely not in porcelain. So I'm inclined to let it
rest in peace indeed, dying.

Thanks,
-- Sergey


