Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B22341F453
	for <e@80x24.org>; Tue,  2 Oct 2018 19:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeJCBxH (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 21:53:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37605 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbeJCBxG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 21:53:06 -0400
Received: by mail-ed1-f68.google.com with SMTP id c22-v6so3105090edc.4
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1IEEYAFqqQgFxugJ5vw07DOOkcU3+9TJh4A8nWPRbM=;
        b=fKknwDLoix2E63MsFLzHlnIleC9UJw5d38Pbitr6HJ2VEQWlZqlLFsAGhiNlMR3QGj
         kQn4QsxTli24AS6Puj+s7R/64RxHePV2l7oIyf+PhRdXTvmUmcABq1Wm1io86MyzJ6yA
         508cf7KzWC4OgdUTDdWmPD687g99OQeVu0bpMCS44hxaTbNsJHjkLC3NcCW76vIbbMfq
         SD72NGpTzjSGQjSZkHVhlLcvoD1ALlqJIa/4u7j0YGYtiMQwQEjckUbuHpJpY7N6mIFK
         7VMlJCW2kJJCyqDhQD1bqTYq7Di6jh7ElreiupD62BYcDVMKYmJPc3kdlyLQ2zZQfogn
         7CSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1IEEYAFqqQgFxugJ5vw07DOOkcU3+9TJh4A8nWPRbM=;
        b=Xd/tvMoP/UZltALyA48SIwhojGzViBhTW5NF6cTCx2Dua1G/QICAJwDXqi6CvCU5RC
         c6QAWwEzBGBgDYWglVKoZn8oZP9H6VerR5Dhc7sjWWXVdtmaqQFcV4w2jR3WB1cWh0KU
         jUpY/fSlE05DYHoJS/7WSJ8V0M1iFvwu8U9vHZO4mH9w9GMnsNjzYrzaDxZ72zZV3pso
         ak7cKdAJZa20qw8q0L/TCVNpKHHHqVo8qDpzU7l2TfmuRUBEBvQ2EvHUhBJFrbEClNX1
         CBGiEvaqThIiRRpxSSL33sZKoa812wPq7XsTOLzsAQIA4VIr8GkMoFDA4wzraxJsVZ07
         Vdag==
X-Gm-Message-State: ABuFfohwAAzKbSFWJTGTS8d2vCZX4sZ+GyEUJb7g1VumnJw+T5lOJNSf
        iupysmJpJfbRCvyKCiv8T2HGljKnXSIkp9YmrJAMeQ==
X-Google-Smtp-Source: ACcGV63Lgy7juSh/58x+Pjb0T0KvILgaHtVgoJjW8TPbRkUjxqDrzlkOcHGMgtiXBFD8fvJ4JuUcilOcnfvztPj0lz0=
X-Received: by 2002:aa7:d9cf:: with SMTP id v15-v6mr12195805eds.25.1538507295202;
 Tue, 02 Oct 2018 12:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20181002175514.31495-1-phillip.wood@talktalk.net> <20181002175514.31495-3-phillip.wood@talktalk.net>
In-Reply-To: <20181002175514.31495-3-phillip.wood@talktalk.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 2 Oct 2018 12:08:02 -0700
Message-ID: <CAGZ79kbX+DssZaCS_fV-eNR828Yd-vsLJ6F58Lifn2f8j+oXvA@mail.gmail.com>
Subject: Re: [PATCH 3/5] diff --color-moved-ws: fix a memory leak
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 2, 2018 at 10:55 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Don't duplicate the indentation string if we're not going to use it.
> This was found with asan.

Makes sense,

Thanks,
Stefan

With compute_ws_delta growing bigger here (and having only one caller),
I wonder if we want to pass 'match' instead of match->es (and pmb_nr),
such that the function can also take care of
    pmb[pmb_nr++].match = match;

Then the function is not a mere compute_ws_delta, but a whole
setup_new_pmb(...) thing. Undecided.
