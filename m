Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7601420248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCCBiD (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:38:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCCBiD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:38:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id n2so1719657wrw.8
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c3xjpxY/acm5QSTl6C0WVONFYy0dgOTLE/bxlWQyW6o=;
        b=QMRhpih/CoITYhODV87QVJWx7YWLcPBrMapYa11z5Y8nREzZvc85W76PCfYnAZrhgs
         78DXsrvXjKun0qLCAi4Xwy82cra0LNqsqBtWsb1GpZMYrXQnIekLxk5dhyCJA3mrLHg5
         kWfbQ+bAu17V8eON75Yxhtk7XyxIm1TJrpdgkREe/SjKE3xgJKocslRm4qXlzdqAJNqe
         Rrwzn56DlQRJgyQuq97k93ZjhG0xXMcwUssJ6/3o6aEhgLEuDigRShx368NhirdP72GY
         FZPl15ANyc97L7C1j08c7FH2ypQtXw79LBT2MzPF90afGiLUyoXQzDp51TyRfqQthLA9
         p0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c3xjpxY/acm5QSTl6C0WVONFYy0dgOTLE/bxlWQyW6o=;
        b=fuYUAKeKKG+XMqWkVI3ppTxQy+aEsDlP14vvXQgH8C3cHOYv5u+A6bQk8K2CRhmn8O
         +RcP4EUT4hx2cYHUczFJaJ9rB79RoouA5JrSsEMA2gh4W+l2+IUB+Zc00Cnp0eO2AYwR
         vHQR0tV0o/dviBSGs3cNKUjS0qvJDgwmK7OkNuigiIG/C+UWcx4E3Vb45vZnysUdzvFG
         1gazj5Kp8hkjVG50hxR1ITJJJrmicAxagHrJ3/u1+sc3qNFdl8pE6EtqcoRPDC3VtK1i
         ozeuv8RIuvMq6EYxPxMgiqel40GOiUN8kJV2KjTOTU+Eolmxx63QtM7arwrjvwJr1vhi
         5r7g==
X-Gm-Message-State: APjAAAXUJ5H8FMAuULYgRkZ17mvTgHK89Z00B5sfW02Xuqv8LBgNO7YL
        zf6sW3m32rJoMAuhjADNvVJ5DCQTWmc=
X-Google-Smtp-Source: APXvYqzEDofsgrRhGjMJopqapoKqYVDQxMA383pC/eyeRrBNafnOGt8zk24FhmPcdZCJL98TB18lLg==
X-Received: by 2002:adf:a49c:: with SMTP id g28mr154072wrb.147.1551577081183;
        Sat, 02 Mar 2019 17:38:01 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e193sm3900005wmg.18.2019.03.02.17.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:38:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Manuel Guilamo <manuel.guilamo@publicis.com.do>,
        git@vger.kernel.org
Subject: Re: Prevent reset --hard from deleting everything if one doesn't have any commits yet
References: <15568DDA-F501-48C9-A1C0-97C72C29DA23@publicis.com.do>
        <d1b34077-1c0e-7a2a-d2c7-da013dd56cd9@kdbg.org>
        <20190301134759.GA13402@sigill.intra.peff.net>
Date:   Sun, 03 Mar 2019 10:38:00 +0900
In-Reply-To: <20190301134759.GA13402@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 1 Mar 2019 08:47:59 -0500")
Message-ID: <xmqqa7ic3fgn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Wouldn't that mean all of the file data is available in the object
> database? Unfortunately without an index, there's nothing to mark which
> file was which. But `git fsck --lost-found` should copy out all of the
> file content into .git/lost-found.

If we had a hierachically stored index that stores subdirectory
contents as a tree (or some tree-like things), "fsck --lost-found"
would have been able to recover even pathnames, but with the current
flat index in a fresh directory without any commit, we'd get bunch
of blobs without any clue as to where each of them goes.  It would
be far better than nothing, but leaves room for improvement.
