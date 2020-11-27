Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70775C3E8C5
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 21:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0972022210
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 21:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaQkUteE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbgK0VPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 16:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbgK0VOi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 16:14:38 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97921C0613D1
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 13:14:18 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f9so7175742ejw.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2020 13:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=As0yyXhb8FKwq+BrGAxBjx+w/7eyh1W4kqIKDnxZUw8=;
        b=LaQkUteEV4Spjxkx2VucFye6ra0khWHrVNJSLiuGKbghfCkb0krIFTbY6W8Q+c6wlI
         uPSLlhjHQWwGDNao515JXYXO/NRWuR0KL0XhJ/Y7NThi5JfYnrQ6p7X2RwCILF+SMBbD
         WDoH20uF5NpPkL8cV6d8JlOkbfLpKvdwUYpiLkd6N+fD0n02qZUiwqFcyxJ/xXRr/uf/
         wgKy6lFQmTL6lc6IFVcwBszLeSluYhNfKvEveTHuj7bUe5rA3xmb5J0Z6vYiNmfHkzt8
         Y+TOFDUwb7O4+rtLONXRyEacNGoi/L7rnFifp2ZddjUjPpXcZ3MTbLAxawxRJY7q4WTt
         Go5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=As0yyXhb8FKwq+BrGAxBjx+w/7eyh1W4kqIKDnxZUw8=;
        b=HDnE4cAjWx9ovGD0ZOsY9DZvyCKDvePAmbDQ/35VlWpznPnXVMPRourHH1f5QE+sha
         mIRwJ4B9e5SJDYrA8GL/JZRN+aeNE3WATmDaAqxY5vpW+xA8Hoi7XW7SUXEdv+kePjeG
         6e+LchYm9U4DO2NhjkArwyP6ZA5MCd5XbyG/KKyCp9PVonRd2x50EVpjnpp4/i45O9TM
         JcIG5ohjoH4p5G/6Ocedw46aTwBdUG7j8+rfmu1Hlj4or+0+FWoDiLo/ohHWLRdLNei2
         XlS+vI3tX8J6Jzl6p8ixEt9fj8lGx+jDqczhr63NPGH1KO0UjxdIeAkIorxfjmnGUbpZ
         N++A==
X-Gm-Message-State: AOAM5310l1kS/nhcfVAVSgS1pFDG2emR143jK/tnZ3bIlVkAY+4urlN+
        NVO/poojmWT5NeQqePQ8k2LMXFp78uI39zx9sDmcRsI+L9GSnQ==
X-Google-Smtp-Source: ABdhPJyPuyx+XVYGV1x8TqW3RyYVk0lMpanljvYTCGCyyRPXwUpukCk+eYHddr0W/dqjakE3SmrRzB6falyu1B7XNlg=
X-Received: by 2002:a17:906:3bd6:: with SMTP id v22mr9969362ejf.160.1606511657076;
 Fri, 27 Nov 2020 13:14:17 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 27 Nov 2020 22:14:05 +0100
Message-ID: <CAP8UFD0xoqVh=1BweBqNOt4_9xg4GvDd7Jf5f5_5z4H+PCVt8g@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 69
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Johannes Sixt <j6t@kdbg.org>,
        Victor Engmark <victor@engmark.name>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Tarun Batra <tarun.batra00@gmail.com>,
        Semyon Kirnosenko <semyon.kirnosenko@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Luca Milanesio <luca.milanesio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 69th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/11/27/edition-69/

Thanks a lot to Philippe Blain, Semyon Kirnosenko, Tarun Batra, Philip
Oakley and Luca Milanesio who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/468
