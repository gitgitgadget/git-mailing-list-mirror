Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ECF71F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeHCRud (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:50:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34588 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCRud (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:50:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so5344852wme.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jwfQwLsUiEqxwQgyUd87LMHWKPLxnsjgToO+Z+/hySY=;
        b=fa7WN8mMnss6mSaCoriKmLTPDhmphycLPI3afCZluyINm7XnmiJFc2XSE6a88G3no9
         ID1XHietF8hCaFm7mojL0JC+Aav+q8v3AI581bcFAbsb3zc98Nxeo8ZND13Dh/7ewbd5
         GUGE1tRanEru7eENvF46VIOLOlVk5Ve7IJkV4byoTW5uARXX9jhlibbenMImXlrOwYU+
         WzAba06Fjrj5RKrrST2DOzoNlAsr2ELN3edW6cuWnoltZjpLXaQK/WFRE1wTNVmYDnlK
         afBskaOI0RtIEPLbCsxdwY3DDU0UB6GjlX/iHXCYvUpDJWjsoIsBVAdof7B5F9+y/O1/
         V6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jwfQwLsUiEqxwQgyUd87LMHWKPLxnsjgToO+Z+/hySY=;
        b=tNC0lvjgMKVKMiZZ1iMWWoTSOxoMNvtH0ZXtpuU4bA7z23+EJBNOxyNzC24fvaCKWs
         RpAbeDUR3KbIA1iDlBeomjLcOtzrLdvH3yicysBor6KeQhrMTr5wVVhWrMyMluulev9N
         BXlT5aunhfCzyrlIdmHyjfozSdBzaG5ev9/WlSonQ1/4f//qJ9A2srwjKB6CFiMFtQZe
         KtHw5vWFRsyT2x32GkL+GeF6EUGhu7n26RsML5YTpMW+hQRjgkFVWLe0FgWrb9h27eDs
         lev07OAp/U9/xBfMWd6rTufGolgRNvYZj1HgBIvciPJEdR/NUgR0+IMPZrEK3jJxdPoS
         6ZvA==
X-Gm-Message-State: AOUpUlGdS5VLMICUo0XkUuTz9fDGxP/voNgJ2MQTZG5SN/uWyZDvj0al
        5W9LGkqhAxYTTJStnyy8k2c=
X-Google-Smtp-Source: AAOMgpcw24DowD2wqhgphz/OemVStOFbMPiiv3GZoR8wFmbOq1aUSxJatRnyYQaYjZuk0Q+w3obcfw==
X-Received: by 2002:a1c:a8d6:: with SMTP id r205-v6mr5273416wme.6.1533311617718;
        Fri, 03 Aug 2018 08:53:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm5634477wrn.16.2018.08.03.08.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:53:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] sequencer: handle errors in read_author_ident()
References: <20180731073331.40007-1-sunshine@sunshineco.com>
        <20180802112002.720-1-phillip.wood@talktalk.net>
        <20180802112002.720-2-phillip.wood@talktalk.net>
        <CAPig+cSZ3Zm=qFcvGjyj_uStn=JMAYuskMa0O_2yxkKjaRWTSg@mail.gmail.com>
Date:   Fri, 03 Aug 2018 08:53:36 -0700
In-Reply-To: <CAPig+cSZ3Zm=qFcvGjyj_uStn=JMAYuskMa0O_2yxkKjaRWTSg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 3 Aug 2018 03:09:30 -0400")
Message-ID: <xmqqtvobzbsv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I think this patch can be simplified considerably by shifting one's
> perspective. If we admit that read_author_ident() is already correctly
> reporting an error by returning NULL (which is exactly what it is
> doing), then the bug is is purely on the calling side; namely, the
> caller is ignoring the error. (In fact, your commit message already
> states this.)

This approach looks quite sensible.
