Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE47C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 09:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiCAJpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiCAJps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBFA6005C
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 01:45:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qa43so3724172ejc.12
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fAyDYRH+Gn+qIMKbmf8aY1HvD5rKagQb6gRdXQTPFk=;
        b=oosITxSpch0Qdir8uFeou0+i91bbB/XIJyjUoMl9512yMk7jT9lNxvgRY/KGlbzSq7
         0XGyoWXYgshr0NIh9lqa1IIX8DeTuVSHImvAR4Fql5XXqPZGgJMGDSHo84ItGM4DTjic
         ghWrdTDwP1/VcXK1cC0QG4WvajBX+YNsX08muzWnHoWP2TzLqWcQAg+OBdIUxMIemdRw
         g4ejgtCumfy+MPxPY5EnsoA/NDFtxQSSuX/DbokqiHbxDojJLjMEp5wcqno0jp7oJCDa
         7fCM24btG4yjv8dC3/UxgP4Mlda0NvdgcQhLICxasGEBu4d16aY3upotwdO3u9TGGZ5i
         KfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fAyDYRH+Gn+qIMKbmf8aY1HvD5rKagQb6gRdXQTPFk=;
        b=6xxfrIomtEW+sYhymxcXSpccw/ojSA0z+Vjsm711QdeQzhP4KTcHQoxtotcIXOjqrp
         FLNQZRc/4orhVNak9Rou1mjxZU71lKMsPatUZq5BsrmH1sn5LK5dnoObrjtx2rPQ800F
         pEJuJtUfxDwZ9lWUBUwgVS3bl7HikSGdn37dEGUf6SAwlnwLQvCPYrgqNIVUgLIyYReM
         NK8tfiwBkHhPnCKF1F7SLXIQvSVJC45TMhDnhaetCLP9uECQ87KolTOPalvgUVsj5AoD
         615SebRpwTg/gtS5qPNhvXVc5WcTwIL2AybhT1ST6qBxuKLBm8ql+iKDaedbk0vY/3jQ
         X/ew==
X-Gm-Message-State: AOAM531DcuC9YKFrxtbeOD12j7bP2ULhARAFim/pbdtCzJ/fJaBd4x9K
        79kCt8Abwsgqtw+1sJuiLp2/dsQCe+DJe0elGxsVPpmYIHs2qA==
X-Google-Smtp-Source: ABdhPJxbIWjRSeHAvjG1AZTlk5fxRzY26rcAjwM+NYSob96VsoKtDxBb2PWfj6dKUJTzcYP6z1DTXoVNbW9RCA9lUFI=
X-Received: by 2002:a17:906:a210:b0:6d5:9fa:11ce with SMTP id
 r16-20020a170906a21000b006d509fa11cemr18806803ejy.172.1646127905799; Tue, 01
 Mar 2022 01:45:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.1646041236.gitgitgadget@gmail.com>
 <a1806c56333ee96f9cda8c77ae56517181b691c0.1646041237.git.gitgitgadget@gmail.com>
 <xmqqr17my6pq.fsf@gitster.g>
In-Reply-To: <xmqqr17my6pq.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Tue, 1 Mar 2022 10:44:53 +0100
Message-ID: <CAPMMpojHUds8dxKNQcMe6nLj_W6ANazpTH38jBzWix4oLHshPg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t7063: mtime-mangling instead of delays in untracked
 cache testing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 28, 2022 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +chmmtime_worktree_root () {
>
> Not "chmtime_worktree_root"?  Is doubled-m intended?
>

Oops, typo, fixing.

> > +     # chmtime doesnt handle relative paths on windows, so need
> > +     # to "hardcode" a reference to the worktree folder name.
> > +     cd .. &&
> > +     test-tool chmtime $1 worktree &&
> > +     cd worktree
>
> An unsuspecting caller will be left in a directory it didn't expect
> to when "test-tool chmtime" fails, which is not nice.
>
>         (
>                 cd .. &&
>                 test-tool chmtime "$1" worktree
>         )
>
> at least until the tool learns to do
>
>         test-tool chmtime "$1" ../worktree
>
> or
>
>         test-tool -C.. chmtime "$1" worktree
>
> Oh, isn't the last one already available?

Ah, lovely, thank you!
