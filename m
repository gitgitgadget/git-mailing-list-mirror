Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E3A1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbeGWTl5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 15:41:57 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:53497 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbeGWTl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:41:57 -0400
Received: by mail-it0-f42.google.com with SMTP id 72-v6so218843itw.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BXWuWFyQj8JCUK3tFQAyieRlGJv0g4cLXN4RuVmwXhY=;
        b=Yepb/bzzH/64BKWDZb7mJBp/O8gf2jr4z32hY+E9BGDngZbhD4ncdR8RCUmrgBFTCH
         uMrOiwkqmEUOTBv9lE1BQB1lK085as0Xa7LqO0+Y/+UZN+pNei0lNJXG4oJZ16PltEG0
         6qo0VH8seDmhNFgFp0kkS+l2yLQCTSjozCKKNdCyPlQc8yMfnERIB14crypzPsby6Smi
         d7adPbTpq1U/s8jhfAedipTszhhNj/O9eZ7MecGJMWU24kUUTqpJtfNYjEeb1ITYEyjq
         xkLraivHvWsDORruM3DB5he3uKqjcIcgLdwr6QlrR6VPqkWgfSdI3Lh4JW7uvjGH0KdF
         TfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BXWuWFyQj8JCUK3tFQAyieRlGJv0g4cLXN4RuVmwXhY=;
        b=ChfSr+cyytbHzLJpkvOpk9Qw6K3+ZUOFoT85eVuCt2evqR9CsfOUxyH7d8VsWtYB02
         hs7BVMexzTfMy18oPNQkmXg8vWJd7tU5Dyk0isswVXJDYG4nEFO13DTU3WqTaYsDLyeP
         7AyLTxNZY/UkOllwnbH6c74iXMhIkh0w96hwJ1pOZzpp/d0gDj21ApBMFOaMVgiGKL7t
         HSKZ5/y073XC5ugG208wqC938XN1HikFzRLOzMYJ4A/Q0CEQ+oKgL3Mo4qn0QzR3vCf9
         P1SipO/vA38QfQa+K2rmw6oE1oPe4d6d57PdyivOyCp9lRsAfFfkEHcVFEY+bYtTRma7
         VyNw==
X-Gm-Message-State: AOUpUlEv5Vf6F8VtrI3nicTnqfa7UHuFF0JJTbxtbAmj0WMwWKdn3LAZ
        0yxMDT4oTK8IJTDkFStBam68eoxtgkzHRRH4fMs=
X-Google-Smtp-Source: AAOMgpdg0AUwHxlbQpUbDi52nUQoJMfy2fIYJNrXPpVH1872neum2vO8nmsaZyGzPhQRBdMB3sksTGvxpaaUGVTWxF4=
X-Received: by 2002:a02:7e45:: with SMTP id h66-v6mr12730690jac.97.1532371166106;
 Mon, 23 Jul 2018 11:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180720153943.575-1-pclouds@gmail.com> <20180722080421.12887-1-pclouds@gmail.com>
 <xmqq8t617rqv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t617rqv.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 20:38:59 +0200
Message-ID: <CACsJy8BskYdANe9HnuLj8sqa8hRqzSAQ+q11C8faJ-YBtA3Xeg@mail.gmail.com>
Subject: Re: [PATCH v2] pack-objects: fix performance issues on packing large deltas
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 8:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > Access to e->delta_size_ (and by extension
> > pack->delta_size[e - pack->objects]) is unprotected as before, the
> > thread scheduler in pack-objects must make sure "e" is never updated
> > by two different threads.
>
> OK.  Do we need to worry about "e" (e.g. "e->delta_size_valid")
> being accessed while/before it is set by another thread?

I left some details out because I think it's getting to a gray area.
We already do this

        if (!DELTA(trg_entry)) {
                max_size =3D trg_size/2 - the_hash_algo->rawsz;
                ref_depth =3D 1;
        } else {
                max_size =3D DELTA_SIZE(trg_entry);
        ...
        SET_DELTA(trg_entry, src_entry);
        SET_DELTA_SIZE(trg_entry, delta_size);

if the bottom half is running on one thread and stopped in the middle
while the top half is running in another thread, we have a problem.
But perhaps max_size is not that big a deal because incorrect max_size
may produce a bad pack but can't corrupt it.

I will have to study the thread dispatch code more to have a better
answer, unfortunately.
--
Duy
