Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66446C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 02:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6442070A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 02:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSggEvEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgETCwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 22:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgETCwU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 22:52:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB52DC061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 19:52:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id z3so1306634otp.9
        for <git@vger.kernel.org>; Tue, 19 May 2020 19:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hPXbuIR0PupjQx7FYyyTnyQJx4+5vTTAxaHOxyuS8I=;
        b=QSggEvEWvDMcwB5yGNkenZZ0/l7As7g3a3Gx+7TJmsNMlI/6xRKqWpdv0eyWq4Rtsa
         qtI9q04cA8iKAwXBiKVvhu2tiH2BybA9BROhfMe+xcw9b4ir/KzPSgSWzX/d5kP8X9fQ
         oXomFjso4GPTOLhE4WMOmbuxBvRybiWObFLgDLVF9HGO7UtamopdfFqk3K7+6+3aM0IV
         nLP0UJl6wgMMXeL0Z5ea8st5i2tQ9nJ5e1R8rbG1qWkhwQ9KwcMQxkgQljk55IkqhoaX
         V7761LtBmfNpRmPrcbHvoWG17L3yigzJsnXpL3Sy2R8RwKtoZat+kGO9ZWCKNNrK1Nho
         MTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hPXbuIR0PupjQx7FYyyTnyQJx4+5vTTAxaHOxyuS8I=;
        b=N7BB14KoLx2P5xrxCQrbec9C/oAqvS9G5OPu1cAKs0Zc+mh9aS2bVyJbuJKxXC7csi
         3COdIloZ+OA4BQuFnpRrUhmJkFfzwQrRv7GSu54TuXSpBvsS9q5bZ2nG5koNS5pClhl8
         T2eDAUCPVMHMUrJz+XiE6DgkhSWOs2NWQxKbduLaRzQZnCtJ+2GFxFW46sv016Rdj8iT
         r8+AcqNHHrzAsu2SzMTfvya9ktxULHHm0b+0/vJb2yy3UdX4+G/jDcfiSZtMxre6poIH
         D/l9D6kBAeQZeu2W+jORZ5So1oYwBzzWPZD9LF6lfSYPn/K6kYG9pm+bjqzQBLORIJ0j
         Tv1Q==
X-Gm-Message-State: AOAM531kg3TjfiDfgz4UzfzPb+KGIR3Vfo4cQqa4y5/tWP7BM+ygVcWd
        QCAu5zFQHPtcAttYj3PDAo5jLPpGRsxT+4ZpgTw=
X-Google-Smtp-Source: ABdhPJz/FQm9XDGzb1PRkbTgo4l+lle7srrZ2WX5FHH0wwW9a245bJl/7Grkmwsz9sjavXupwVGmWL+TU8rQvaoXuIg=
X-Received: by 2002:a9d:24e5:: with SMTP id z92mr1688682ota.345.1589943139811;
 Tue, 19 May 2020 19:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnazxueg.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqpnazxueg.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 19 May 2020 19:52:08 -0700
Message-ID: <CABPp-BG_0S0pbcGgDELt535eUVYuuv8gtr4Qfgn79xzeL6m4Jg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2020, #06; Tue, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 19, 2020 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> * pw/rebase-i-more-options (2020-04-29) 5 commits
>  - rebase: add --reset-author-date
>  - rebase -i: support --ignore-date
>  - sequencer: rename amend_author to author_to_free
>  - rebase -i: support --committer-date-is-author-date
>  - rebase -i: add --ignore-whitespace flag
>
>  "git rebase -i" learns a bit more options.
>
>  Needs review.

Had two, one from Alban and one from me.  Should this be updated to
"Waiting for a reroll" (cf.
<c3dad0e2-e381-499a-af02-ef3f49207c49@gmail.com>)?
