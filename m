Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B49C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F0D2222E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjP5OmBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbgKQTw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgKQTw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:52:29 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB1DC0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 11:52:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so24538779wru.6
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 11:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ccyo1zJYHFy54yRcvc0tSPrOzieTkjk57wmPrVIYjUc=;
        b=WjP5OmBphP41hT36tZ+JRLJ4eu9ksZEWpXWWMMD3HYIS5kuCZrF6fYC/aXDwkio2ui
         DpekZFZKD2gmBrihcFzcXNGGHrf6LjBWf8ZjqY1NywVJVzky17WfXd0aLSFtCa52vdjL
         ul1O88Oa7eS7Kodve63ejs729Ja0hg5Mqdjif/MzKx3PY7FXQuQaC+KuAPFMIYy5kzvq
         8OEv304pnzeIiffA2Zn3CbdC/zTUqujk4EbeFvNpbdNrjQLij4bAgvieEfFCst5t+sXm
         coqoaPZGSiEGiaiO9cjooevrroL8RycysdH03bO33YKIoleLB5Ngk8hHROi/OwSQsV3+
         XwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ccyo1zJYHFy54yRcvc0tSPrOzieTkjk57wmPrVIYjUc=;
        b=ZN4nlhx+x/9p4piHYN33C2vHbG6cP4zVCgfLdAkNv6gLLa6YJq7JCsoP0WcthheJjS
         mBv6BPj4HklFRQabGN+ps2ncH8UCsHRyec/Od4LFERoF151QscosHts5fBtUif8K/Cnm
         uCG0yKPiFIHxKB+7Wz1zF9ipENtGPJxUhFfreEdmCAAImFyaq8zPWtNql1dwc6RWCwWT
         6flz8viH9lyf1k2/0KI5JUbiHne9x/B8JdVBibefFgoHUg/kZ7NT/bQt1moPvJvxAdwy
         HXxb++H4oJO3SIbTgEvwNtysWViWsvJEb/4JW36Bl/i4xSOopurW6sGHqZ6bCzm7MRvL
         ZknA==
X-Gm-Message-State: AOAM532uG+X7IkLTNvshfon8jgC7rNfvdudMP4Sh6rify+wPVBIsalU/
        Vpmn+/un/1TUM+dJlYpahIvbwP35ZFGIzbX8TWg=
X-Google-Smtp-Source: ABdhPJzmwks/ENeIzbzbYgyCQGeWewv8IwigMHR5kxmacF72rzWAvNxprdrtbSL/M65snvm65vsIumw2RYMOLAvR9NA=
X-Received: by 2002:a5d:4349:: with SMTP id u9mr1143995wrr.319.1605642747415;
 Tue, 17 Nov 2020 11:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20201112223452.1526315-1-felipe.contreras@gmail.com> <xmqqtutn6ccp.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtutn6ccp.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 17 Nov 2020 13:52:16 -0600
Message-ID: <CAMP44s3dFZ4EjOgYd_e5JvNQWH_6bjLAHCYMa7n2kOFXWHCwcg@mail.gmail.com>
Subject: Re: [PATCH] completion: bash: improve alias loop detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 17, 2020 at 12:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > It is possible for the name of an alias to end with the name of another
> > alias, in which case the code will incorrectly detect a loop.
> >
> > We can fix that by adding an extra space between words.
> >
> > Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>
> OK.  An extra local variable would not hurt and makes the code
> easier to read.

It was there on v2. Which now may be a more reasonable sequence.

--=20
Felipe Contreras
