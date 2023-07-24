Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082CBC0015E
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 15:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjGXP1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjGXP1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 11:27:05 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6156512F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 08:27:02 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1b05d63080cso3523215fac.2
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690212421; x=1690817221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkrURNiuSrhwiFVc+QAwIIZkLXpFXB+Xw68Z7lhg2oM=;
        b=o0g4V1LmWzSKir3+X4haBuB8JUrx9bcF/LQrU1YtdUNjwbZJyj61a/5XRy8DsfD1UT
         cxKSewbsWoJHzZ+bQMI43UFRyhjwgZBySYTPS2VTVJ0utpKBhJM+LcC/Xkav4HBOG/c8
         5A7aNSnHHoZB46QWt+z3OHHTALXm7WlkuDb1HF7u3D295PjYN/Gc3juvVVJyiI6vLYId
         cMVpt0qxtMSZdvCoDqxIoQYQHMDu5gHOZTCBRDC5fWhtyQU2uI6muDdMCZijnbZaBJ2a
         qi9QOBMmoJuCmfzmwo6e1kdqW8KKhN0OV10ZCxz+HADmxZSFByU7J1u1smg5PsDbdtAW
         O1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690212421; x=1690817221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkrURNiuSrhwiFVc+QAwIIZkLXpFXB+Xw68Z7lhg2oM=;
        b=hgmH5SGA3ZQLXknkVszD/ZW/91zxxjJIc+R34/81iTq+ewUENqJDK6pCM/nxXaXfje
         cei5qs/WjTAId0bAxy9+bQVpxMCpt+DCdUAfPc6eWn5ABPFnEKBdpUA+XUS9gIiqS5JD
         HGiasZhqnkPSQy1anVh0b5t1QSbQifB3ruCNNpQoi8q0pN4mQmdGyjK5If1vytfYf2jJ
         /u23lM9yAF361KRshQzGTcqo7yEXn0uB716nXm8ZhG/mU1m97MBpD+UVNeU1xFxigqmG
         VlVKvYSjiHMKrzEqh6d3v39ggznzyuXkOTgA3qIqPIXO39dTJKT/TvHfNl2Emq+piCMM
         D+nQ==
X-Gm-Message-State: ABy/qLaWDyv8zzKY+PbM9MMJcsZ44YUzA2MacoYX6aQn/+8ZnBz3gvkt
        3zYcGAG4geTVXPDjVf6smL5BtbYkORdt0sNyq2w=
X-Google-Smtp-Source: APBJJlFrxYRUByqPqOgToIwtOVjTGOpaGmC37w7CHnDTZy8wq6oeIS0T2qWX4X9DBAttaPHSvEW7BheZxeP104DAYI0=
X-Received: by 2002:a05:6870:b68c:b0:1b4:6d3b:3e15 with SMTP id
 cy12-20020a056870b68c00b001b46d3b3e15mr11169250oab.3.1690212421557; Mon, 24
 Jul 2023 08:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com> <20230722212830.132135-2-alexhenrie24@gmail.com>
 <0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com>
In-Reply-To: <0d1c5bfd-3ae5-83f0-a333-bbb8510a973a@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 24 Jul 2023 09:26:21 -0600
Message-ID: <CAMMLpeTBBS7FExevcvCWut8wFbcDSDBhUUq+tCaXfOPiY+3GXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an
 invalid first line
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 4:02=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:

> On 22/07/2023 22:28, Alex Henrie wrote:
> > Before the todo list is edited it is rewritten to shorten the OIDs of
> > the commits being picked and to append advice about editing the list.
> > The exact advice depends on whether the todo list is being edited for
> > the first time or not. After the todo list has been edited it is
> > rewritten to lengthen the OIDs of the commits being picked and to remov=
e
> > the advice. If the edited list cannot be parsed then this last step is
> > skipped.
> >
> > Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
> > in edit_todo_list(), 2019-03-05) if the existing todo list could not be
> > parsed then the initial rewrite was skipped as well. This had the
> > unfortunate consequence that if the list could not be parsed after the
> > initial edit the advice given to the user was wrong when they re-edited
> > the list. This change relied on todo_list_parse_insn_buffer() returning
> > the whole todo list even when it cannot be parsed. Unfortunately if the
> > list starts with a "fixup" command then it will be truncated and the
> > remaining lines are lost. Fix this by continuing to parse after an
> > initial "fixup" commit as we do when we see any other invalid line.
>
> This version looks great apart from the test being run in an unnecessary
> subshell which looks like it got left in from the last version. Junio
> might be able to correct that when he applies the patch.

I think I see what you mean now: Because this test never performs a
successful rebase, rebase_setup_and_clean is overkill. I can send a v6
tonight that uses 'test_when_finished "git rebase --abort"' instead.

Thanks,

-Alex
