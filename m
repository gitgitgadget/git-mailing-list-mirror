Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F331C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjEBSRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBSRC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:17:02 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84AEC
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:16:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6a5f03551fdso2929347a34.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683051414; x=1685643414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1MuLzQzyDFIuOcayq1miidS5yn+04WPpGWxbG5iAbU=;
        b=PZeTpelxwJYqcHRDva7qcBDrWHqYSE/9BMIFmE6r5+SWR9irDgnLD23Jj68+3oWan4
         EzAMG4QdM2mRf7Y1rkInNHvrx8SJMNwcD52nA2xjuneZn26ARaIjciMKd9a9trKwJvim
         QQEj67iRVDPyNgnBmxrF8YYfOLhLY+AI/UMQl9DOR9S96CuT38amK0j/FrXJMC7hsiy/
         tR3cH7Kg2+3uWg2ZnuL2uOAHvSZy+1Uaxd0tvEtuaN0hSuFWJq2XsLtg33QKUlhpo6Qb
         f3Pe3swhF68M0aSy26AzotnSqmfnrBKySqnNrc+6umpKLE2mbOfZ6rV3wK8KvQmFeQEx
         kBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683051414; x=1685643414;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y1MuLzQzyDFIuOcayq1miidS5yn+04WPpGWxbG5iAbU=;
        b=fAtfthwWTzh8LPoz5lR5AXUVwTqZA5Z+dGmS0+cge+8AadhYtAVZKGwvOuZK8p71zF
         sSMkXN5kMcXwy4ZRAqyjL1At7qYGJ6BExL9xvC7uA2KRfjNkCW/rOyzvudfgY7HqadOm
         Yvb7ocRzwRp7st8R0DZLWE+SHFMQXO/5PqH0hMZPL5hPfAPiuss4t16ePEzkz1exf8bV
         Pr0Uz3cIA+OGZK4rzbjawFj7yBJbLz7pBm3u3qBvfloCILFKHifcfiaTrd4V5XOVLGFM
         fmuo3GXE1w0676m08Kh+eeyQkg0Cd2Coa3JjW+ehmoqk8HhzaVH8QWteNnZXkptiKzUX
         i7cw==
X-Gm-Message-State: AC+VfDxoTbUXId7ePjMqbWXu/9Zr0CdmBdDCqs/UlINJ5Ytvzeyei+/U
        IGT92e0D0hOhk9lH4gm5u3k=
X-Google-Smtp-Source: ACHHUZ5evey+AUmU8dnC06AKhjh5AqJa0uGJiSJBV7s6jxdQSq2Gy+qs+wJfyMHF+7VrCLM4g6pwZQ==
X-Received: by 2002:a05:6830:c9:b0:6a6:4c81:bb9e with SMTP id x9-20020a05683000c900b006a64c81bb9emr9973462oto.26.1683051414217;
        Tue, 02 May 2023 11:16:54 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id l21-20020a9d7a95000000b006864b5f4650sm13297652otn.46.2023.05.02.11.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:16:53 -0700 (PDT)
Date:   Tue, 02 May 2023 12:16:52 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        M Hickford <mirth.hickford@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        "Harshil Jani [ ]" <harshiljani2002@gmail.com>,
        =?UTF-8?B?SmFrdWIgQmVyZcW8YcWEc2tp?= <kuba@berezanscy.pl>,
        Karsten Blees <blees@dcon.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Javier Roucher Iglesias 
        <Javier.Roucher-Iglesias@ensimag.imag.fr>
Message-ID: <645153949c192_1ba2d29427@chronos.notmuch>
In-Reply-To: <985ff655-51a5-2a0d-db09-5a53563fcc8b@kdbg.org>
References: <pull.1477.git.git.1679729956620.gitgitgadget@gmail.com>
 <35e1ebe6-e15b-1712-f030-70ab708740db@gmx.de>
 <CAGJzqs=D8hmcxJKGCcz-NqEQ+QDYgi_aO02fj59kQoHZgiW3OQ@mail.gmail.com>
 <xmqqa5yn3d0k.fsf@gitster.g>
 <985ff655-51a5-2a0d-db09-5a53563fcc8b@kdbg.org>
Subject: Re: [PATCH] credential/wincred: store password_expiry_utc
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 02.05.23 um 00:25 schrieb Junio C Hamano:
> > I am wondering if the lack
> > of comments is a good news or no interest.
> 
> So far, I have totally negated the existence of credential helpers. I
> can't offer any help in this regard, I am afraid.

FWIW the same here. I exclusively use ssh with gnome-keyring and that
works perfectly fine.

-- 
Felipe Contreras
