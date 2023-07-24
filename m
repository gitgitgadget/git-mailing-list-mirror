Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E5EB64DD
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 20:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjGXUI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 16:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGXUI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 16:08:57 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B1E10D9
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 13:08:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b9b89627c3so3678253a34.1
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 13:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690229336; x=1690834136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TNKMjsrNy9vh2nEaym0HjDXMDj5+8b9TA1H0cFJ5RY=;
        b=TkS1KAsYRXR2vFcEyZVJ70+ngLVHgnA2lh/HIU2A8dkQgwUOG9r+pxITWCQqPmklpz
         S/Hr1a/QJ0UlNqxRFhTh2sV/Srj9j4TLRN+7hK6iK18cNcOuS0oRricsYGq+MpAJjKQ8
         uoK0OuLoRRZQNb6H2iC6Sp0IQFeg+nxSgh8uUTNH5adTFbNkiO0cx1DwwPML3+UhQGu6
         6YexpFzn0bPUTCf6x4xlITXt0CPEGJ0QTvWuf1ZvOHNQ/OQul2P8N9j6Ze7Ngjxy/CkE
         MynKZ+WHMUtPvMBEr1o0MNiyn4kFhE4Sj6TZXEXNlI9bo6oPqGaYhX/ZacJbWXAhRwyR
         ISYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229336; x=1690834136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TNKMjsrNy9vh2nEaym0HjDXMDj5+8b9TA1H0cFJ5RY=;
        b=UeuKWhESyhjKKj2WcGq6Crudzl58Iat+f+WNEHtu5fJv3DUMX1pd2pE4KO8Jog3Osx
         7FM+jcysSAz05+UPcRxNu2OEzbJDT5fjfEslzWabtLvQxh0tHBtibB88EmhpfqJuNrps
         nvlrEbsDow0sUZ5IOuTYyKXaXEQxN24tkCZqC76ytFSdB7tILRaigXrq2LXPFqAycvq/
         SZehnnmWaDCX6Ne8RhoeQaU6E3FveUK3lolDequ4KByU9mo7PUK+pTK5VVqbxBgWwyqf
         6lmnB2wMoelGoRkb9peTocVnmQnno2kbcdYkMWarSiulptiowX2Mijhv9eQcZe1cBWa9
         8VRA==
X-Gm-Message-State: ABy/qLZ7nm45eG0TAhNm+894vRqGSOgyLTF9V7uRqStm0Ecx6cD000gR
        DHJ28eWoXbni+/o6JlzsT/T5m0OmwaNQv81R2TY=
X-Google-Smtp-Source: APBJJlHMhedmWsxtWl8FSXmx0dXqMSuFadLsp1kjAt8DqUsOwog/o6/Q+nnS0856xGky4AOSN1emgt+8/eU3tSCClco=
X-Received: by 2002:a05:6870:46a1:b0:1bb:739c:9e2b with SMTP id
 a33-20020a05687046a100b001bb739c9e2bmr3596553oap.57.1690229335710; Mon, 24
 Jul 2023 13:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230721060848.35641-1-alexhenrie24@gmail.com>
 <20230722212830.132135-1-alexhenrie24@gmail.com> <20230722212830.132135-2-alexhenrie24@gmail.com>
 <xmqqjzupqn3q.fsf@gitster.g> <xmqqedkxp3fn.fsf@gitster.g>
In-Reply-To: <xmqqedkxp3fn.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 24 Jul 2023 14:08:19 -0600
Message-ID: <CAMMLpeQwG5TbzwUKY=QOnHA-mey2NZgM+4ssF+qDrWJ=Vxs9Uw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] sequencer: finish parsing the todo list despite an
 invalid first line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2023 at 12:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > The structure of this new test piece, including the use of "log -1
> > --format", seems to follow existing tests, and very readable.  Why
> > do we have one extra level of subshell, though?  There is no "cd"
> > that may affect the later test pieces, and set_something_editor that
> > touches environment that may affect the later test pieces is called
> > in its own subshell already.
> >
> > Other than that, looking good (there may be a valid reason why the
> > test piece needs the subshell around it, but it was just not apparent
> > to me).
>
> Ah, now I notice that Phillip also noticed the same thing.
>
> I just removed the outer subshell while queuing.  Thanks for working
> on this, and thanks Phillip for excellent reviews.

That works. Thanks to both of you!

-Alex
