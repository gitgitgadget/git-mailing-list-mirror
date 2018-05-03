Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A64C200B9
	for <e@80x24.org>; Thu,  3 May 2018 01:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeECBGq (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 21:06:46 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:42604 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeECBGp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 21:06:45 -0400
Received: by mail-yb0-f182.google.com with SMTP id 140-v6so5956204ybc.9
        for <git@vger.kernel.org>; Wed, 02 May 2018 18:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2xaBEfOeWVjVG8vx+uV0avq9BLAMzJkpr2Cm1s5FDy8=;
        b=Qyx/lpspvJ7zNWjnrTG4ChLmvNqhaH3H5BMOCrFT6ihJBqpiuqBKyAR/lR3NOuMTy9
         c8ski6SkkNrbjU16jwo4yPm7nmXh7lgX1AX3Epf7bKNl3AAvVf+0Tvd/51EgwrZlycNm
         xvCUi1aChJbzegcbjQ156iPOhMrIm7l03BgyUDE2etqyyoVe13QkWLK55zZKm0vN7QRj
         WPiYaBoU4rBA/PskKNPRcyhQgc7c8FfQMVtgZckoYG5skiNUhq3AtQ2EULa+MLa1jvYw
         x/o/j0OF1Yi+d9MSILyHj8aUMVoOmLveyKbdObllRGCn34NH+51Rc/lUENM5x8pwJWAc
         TL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2xaBEfOeWVjVG8vx+uV0avq9BLAMzJkpr2Cm1s5FDy8=;
        b=P/tNyynVV1clEULajTRzW0qBlyyFX14mX1+YbnpbkRxzbKAMt0sMzR/Sad52m92L6H
         G29Kj1ZGF/SMAUFDQnDD6xbm3wiQY6fd5MypZ5cr/ixz/YQW0kJ6VngKX4TUmitBOlhv
         5TO627l4bQ0clZTdPzUeS2VplDF3tGIIF92Juh+uOnWt8KSVBrHPNxIJEwuLSkA8tyHx
         f/1MzUIBa3LUvKW8X1AkUNbID5KAhBlyW2DDaWWPBYazz5Ooqv5XB9x8nOPImhlCJKfQ
         oBJYyFQv4+GP38lG5/sYagU/Vao6efqnekIqzciY5ogSTP5LkHhAQcp9enfl+pqDQ9Sk
         aBeg==
X-Gm-Message-State: ALQs6tAYA0u4Wf8FJgbtFe6PJkjA0dKeLEEVr7NkVnaJDNXK6QIFa7gH
        n9n0Nm67r0H1a63wfxP+ttONepc04PtwhsFVOF3qIw==
X-Google-Smtp-Source: AB8JxZpAreWJkVJUb/5du/O27Ov5YDfh7XX8S6/TluMQQfSi7UK4n9B+2SNEo0EphfnctGt4KaUwqQ/DwLzc/8+iwCo=
X-Received: by 2002:a25:69cf:: with SMTP id e198-v6mr14182830ybc.247.1525309604214;
 Wed, 02 May 2018 18:06:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 2 May 2018 18:06:43 -0700 (PDT)
In-Reply-To: <20180503005358.89082-6-sbeller@google.com>
References: <20180503005358.89082-1-sbeller@google.com> <20180503005358.89082-6-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 May 2018 18:06:43 -0700
Message-ID: <CAGZ79kZnOhq4iSrM7wRmXsTF4ugLUxQcf0cN-SJFwoJHge1rWw@mail.gmail.com>
Subject: Re: [PATCH 5/5] submodule: port submodule subcommand 'foreach' from
 shell to C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 5:53 PM, Stefan Beller <sbeller@google.com> wrote:

> +struct cb_foreach {
> +       char *toplevel;
...
> +               OPT_STRING(0, "toplevel", &info.toplevel, N_("path"),
> +                          N_("path from the top level of the invocation")),

This is a leftover from my experimentation that I hinted at in the cover letter
that would be used to implement $topmost.  I'll remove this in a reroll.
