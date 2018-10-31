Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9A841F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbeJaNkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:40:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33653 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbeJaNkx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:40:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so329265wmd.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m8tBUUnl8xCWVGpST0wis8FyvX9DIwRxenzv+NzZi2E=;
        b=hyHyVPF2QjtELcdasBaGSI01asXp7bBN3nWLQy9PRA3Cvf6TMBrK7El6zUKXpL0BtR
         G3rvidzsykpl65WqPaXrWe19uBVyY5gzTf11gnLRyIPcIqaJDdySd7IjwaNjWu/pYC9I
         Pviklu6EteTbZ6RQ0ScBzwXnr99+6q9+tyDi76sn7NJaT2qNHkNE7N/TNSre+JPfcD5T
         xLVFmeJXT08iElFL1Iw/xI4v57Lw8fO+AnkAk91iQx9f6TgiQlxLTXjcMUjyv6HF/IAJ
         mxPoP/9GwT3cyzu59rJe9U7z8+t4R5KovIIi/aqhpXPMG72UAlasGRNn3fv6/nc+HzYI
         CW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m8tBUUnl8xCWVGpST0wis8FyvX9DIwRxenzv+NzZi2E=;
        b=tYlQl2OLWpoNNdb6irthwzB112usOaUhf+5Cuw2Y/oKLaEehnZ6d6pN5391LsvWQzs
         SjNZq5HdXghLlc1Qewm7N8yQ7MOXvR87TLnvleh8x2E3PX2ClWErDR2DbVQxSP8XIeKg
         VtFMAKt838KSCBvquFNPEmLJvwixMyuGFWim+BB9b699EIUgDQdLdOu5ELD1iF3YhAn0
         Xg7/TCHK74jYgN7oIquXCxUvVVeK8VLH45QaVFxcqUHl+rmu9mEk+yMFjRP6B82TwvPa
         ZpzysEn0H3U0qt4BypbpPGMhc3VN7ws3jV3eS1ZKZn0DHk1CDMAFUpz0S1v30xprHUZ1
         ho4A==
X-Gm-Message-State: AGRZ1gIvOHHdkuuy8/+3ATMtEdsFhAsbZeU/Es5E0sDKBtx2UdxjunN/
        a2E6XOQ0NWxm6zLiugex4Lg=
X-Google-Smtp-Source: AJdET5cjIzjCUX43h3ni6bLZiEgs84s8XykwhY9uZtzvRJ6TRBlO4v1JMkcv6HO6al2RqjGuwuRcXg==
X-Received: by 2002:a1c:8cd2:: with SMTP id o201-v6mr913469wmd.65.1540961066971;
        Tue, 30 Oct 2018 21:44:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 125-v6sm22360585wmm.25.2018.10.30.21.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:44:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
References: <20181030231232.GA6141@sigill.intra.peff.net>
        <20181030232312.GB32038@sigill.intra.peff.net>
        <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
        <20181031043051.GA5601@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 13:44:25 +0900
In-Reply-To: <20181031043051.GA5601@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 31 Oct 2018 00:30:51 -0400")
Message-ID: <xmqq36smybbq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> See 692f0bc7 to find who did the fix you stole from, and for what
>> kind of breakage the original fix was made.
>
> Heh. I did not dig into it, but actually thought "I'll bet Junio had to
> get this right when he wrote the streaming code. No wonder he spotted my
> mistake so quickly!".
>
>> By the way, a very similar loop for pack_non_delta istream iterates
>> while total_read is smaller than sz, but it does not have the same
>> check upon BUF_ERROR to see if we've read everything.
>
> Indeed. Did you find that one by inspection, or did you peek at:
>
>   https://public-inbox.org/git/20130325202114.GD16019@sigill.intra.peff.net/

I looked for BUF_ERROR in the streaming.c and found two instances in
a very similar looking loop with a subtle differnce, and the
difference was due to one of them getting fixed in the past while
the other one was left intact as written at its inception.

I should have looked for that message to read the part below
three-dash mark.  Or we may want to transplant that comment somehow
to the function so next person will not be puzzled like I did?
