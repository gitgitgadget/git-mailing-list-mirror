Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5158D1F404
	for <e@80x24.org>; Mon, 12 Feb 2018 18:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeBLS4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 13:56:55 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34508 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752972AbeBLS4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 13:56:54 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so4219755wrg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/UUdMwsTPZGqorgst7ASuoar0USRYlBP1SmDJsKlOJg=;
        b=fqlzDqcPXEhax10tINEHCnUK0ZEKjke6SfEyW3EP4KZsm4w1lemOm6ufc3Srxn2Wd0
         cfl60uFn2XIk7r0UDQ6VukTZbPam6iRp0ZaB1u6imtvNLl05jrsnegKmZO60jR1qSIwX
         vXaMSp2Jth6AUN8/Mc+PrLwYMsdtnz6+e/4wypCavQw8MOWC7+6AuxUG0zb9IsvAWzJd
         FI+xISBJ89ZSZ5DHQuo43Ne6AVAFPI8M/M/j3tHX05RCTDvNXssXi7RM2BO78nrHjkJs
         4Bt7+5wrp03SACmpiQC+QbFQgs92qYyj4krHUrYDeXePJVPIkpJ8V2niIdtQCLDcIAY9
         Y5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/UUdMwsTPZGqorgst7ASuoar0USRYlBP1SmDJsKlOJg=;
        b=eWlGzvT6cpobEM5O0ThU84yVKyrVUVQ//eHErrBUX88w5vvkyeF6s0wqjkt8MhDlOH
         flGDcsv6ScDi/1hl7H60bnJpdUzuuW3MDpWnoZdwKDcQskuVjtUoglKRAlMlmKMbIlpq
         R6G9ZDMkiL8ET53QxbQQj5lThSv0tDkVljrPAPeUqQ0U707iSkHfQx4RXIT6XXKMW4Bb
         d+5MPAxPQB+r9Q+ZWf/sGC2sPAWom01PWR43n6Rq5MYtUkw8bc/77VgUXEuS/vFQFXFd
         4EbLBx5PeaaFuUkHIvDfC7gGa93Grw45rKiNHkOxN5ZYt8wgrjCcMP4ewTcT0JlO2YPm
         /6Fg==
X-Gm-Message-State: APf1xPC/DuFXjQelxbykSLRLrY3sGNWJ/eoL2FavD641ATt6uVKVKwRw
        vzX1rmdaYvXWMsHpMa0wEX8=
X-Google-Smtp-Source: AH8x22482Qy4jrnbn+1xvGu9R3j91wHbLn0qj9t5qJdXMuf2wtQyT8U7d4ff91KNDZQHxdDxddjVuQ==
X-Received: by 10.223.144.198 with SMTP id i64mr11635785wri.6.1518461812680;
        Mon, 12 Feb 2018 10:56:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q81sm12865439wmd.3.2018.02.12.10.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Feb 2018 10:56:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 07/14] commit-graph: update graph-head during write
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
Date:   Mon, 12 Feb 2018 10:56:50 -0800
In-Reply-To: <1518122258-157281-8-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:31 -0500")
Message-ID: <xmqqeflqt4st.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> It is possible to have multiple commit graph files in a pack directory,
> but only one is important at a time. Use a 'graph_head' file to point
> to the important file. Teach git-commit-graph to write 'graph_head' upon
> writing a new commit graph file.

Why this design, instead of what "repack -a" would do, iow, if there
always is a singleton that is the only one that matters, shouldn't
the creation of that latest singleton just clear the older ones
before it returns control?
