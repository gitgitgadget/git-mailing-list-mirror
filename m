Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAB7EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjGER6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGER6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:58:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB40F7
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:58:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40371070eb7so28301cf.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688579919; x=1691171919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LbSatkdgR+JA2svdMs0ZOXeX91cP6wld7/N5Rc4E6JM=;
        b=anUwVhacWVpvG3dPYNKbnbTJtP6mQrWG7YwZMFRs+Ww87sIQsK7GBSbtidNmM0r+rt
         xJMmYpDNgeE4EBLZ0dZaypwf3W5+1O7fv6aKWxY2UxWwfdcEyDmxAwNe3VHGxkhQ84Zn
         e7sNyY4/fYTY7JtqUu53//Tkj4CGIkOQ3Pd5SlR+SEm/L6Zfy+4fXyphhT6Id3VK9cI1
         9Hq0v69bKmOOvDlsFNKQ7j26C+h/0CnxqpF8R7xqqaoiSOsKFgXjXVIARQhByb1jwTrE
         67DGvgbQKLaET6qwf+pGvjcCFVU3epbazzBUNatt+NlmquzW4sGM0InAoSDi+qgU8Uu7
         mYlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688579919; x=1691171919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LbSatkdgR+JA2svdMs0ZOXeX91cP6wld7/N5Rc4E6JM=;
        b=RBn4vTqZIl0tplmXqG//L3qrooAV1UJI5cb4USHSU1/Q41F4XcmLt8B5inc7eCq0np
         Cr1YAbFe+Aoe1eCC0+pWxOra2DljeGer8CD3ZQkn2am879SkFaubpFdB4lnYXo1Ockti
         BJ8g4C35Go4n/o4bJS74G6YQDWrOv2jJHifsk8uVsr7PYcVHSpJYgIL4B9AaEcvWbtid
         DPvU8cf02LG2guaGJ7slX26h4ZBFIH5xDweSMbMjCUmL25BH89/QBgtfUr11ZcKMEVUA
         nB3JLSd5CcVP5T1qawHyonnrcgZZ6DatVmccVVL6aK3kcsaFkyjIQ/cFkL5QzTw/TqPL
         1LYw==
X-Gm-Message-State: ABy/qLbuwYET7E3JTkIE+X5+SU1+OXme6rBqqs2niAwVKl6Nph2DwlKi
        srO++Q6WPbRNqB9DO+Pg98lawLpY2ZNFlygZkTJnjQ==
X-Google-Smtp-Source: APBJJlGmjs4O0kSAujD2fJkd7EAnkUrDTzFqvsSZTntrqJ1GNdWCOlux4zwSA9aRSnHYxpSBimFJ4zCAjHr4UR35JEc=
X-Received: by 2002:ac8:4e94:0:b0:3fa:3c8f:3435 with SMTP id
 20-20020ac84e94000000b003fa3c8f3435mr3247qtp.27.1688579919304; Wed, 05 Jul
 2023 10:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230630202237.3069327-1-calvinwan@google.com>
 <20230630202346.3069950-6-calvinwan@google.com> <xmqqfs685zw1.fsf@gitster.g>
 <CAFySSZBDur-1+XG2AetS6jZ=mkv0esFFT5HgQnQ-SVsrpgKXew@mail.gmail.com> <xmqqpm561cw0.fsf@gitster.g>
In-Reply-To: <xmqqpm561cw0.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 5 Jul 2023 10:58:28 -0700
Message-ID: <CAFySSZBv+2tg6rOUJvtF7A0DUkxZtHQ-UJDLD8T_HMKKqBh8Eg@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] common: move alloc macros to common.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That will help others, but in the meantime I'll just tweak the
> commit log message to say "to common.h" -> "to git-compat-util.h";
> otherwise the series is ready for 'next', right?

Correct, I have it as "git-compat-util: move alloc macros to
git-compat-util.h". Thanks!
