Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077B42018D
	for <e@80x24.org>; Tue,  9 May 2017 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdEIXge (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 19:36:34 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34059 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdEIXgd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 19:36:33 -0400
Received: by mail-pg0-f45.google.com with SMTP id u28so7200044pgn.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L93K192ff8HLAvhRa2ub700VI9BHbqkwefnWkjGoin8=;
        b=A7iG3MuIOjIn1hYwGc6/0GuQciiTb5KhMmM3MkyfJHNSshU/qDfJwjVbguEXqfTGRQ
         K8s2QJ9UeKFM/fvTHwWKvI12WAhrDGDy5S1eDv0vcorkZa/1mzS7tKQs0cDuuRfZ1LxP
         zC55F+JH0Km2ojcx63lJijiDGcDGYIswoWTi8t1pMFw4+xUxAQqVPdjBPoD/x5EkIRCs
         2hvCvpuS5oPoj7OO3wkNUPolxrI44bkaqrij54JRQj44LVEQW9iGacj7yPED82ICLw6I
         TdUTeOQuJCuAqOXFQ9AotaEo403Dc7qBKGzHzEP+sdHff4QUVW3YfbCi40ydWIG+kwJy
         nmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L93K192ff8HLAvhRa2ub700VI9BHbqkwefnWkjGoin8=;
        b=gb+FBvbfnw4iYnOqk18Tiy+tjLMMZHLhhMqqBfAO5zg7C95WTxEPKjRmWXPJxJGXZT
         X3VVb/Hpi3NAdYNvkrHu0vNZgW+3fme7L7pbEBwmApIWNuBFN2vLAqbedF7LzQSZXqNl
         Pc3D/C3/7qNyQ6JmYK3UZA298OeMeGpc+LRNLGrMoxRIPjL21yCFuRFuEMnCWsMyvjzG
         jDyvyMzNmjjc3Kk1ZaIfopwqGDcEYBYQz6yBGkJ1yKbPHRJEsUOexZiT5aRLKAJQHq/X
         ZJdY0oMtUTmJaYUnR1lm6YHWi0DKvkFFRnrzPToAqzHTBBv4C4OhoqwME0iLlT4seNTK
         N3SA==
X-Gm-Message-State: AODbwcDhr3qrb5b/7aOmgVsJjk3HmGjqmrvEXHiAeStnxmzS9wiNDPLl
        oItnlhBkqPrwvJSYeKKexQ==
X-Received: by 10.84.229.143 with SMTP id c15mr2426747plk.27.1494372993243;
        Tue, 09 May 2017 16:36:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id v85sm1774966pfk.5.2017.05.09.16.36.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 16:36:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH v2] archive-tar: fix a sparse 'constant too large' warning
References: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
Date:   Wed, 10 May 2017 08:36:31 +0900
In-Reply-To: <4bf9be3c-5d19-09e3-b8b3-dd58e00e623d@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 8 May 2017 21:34:58 +0100")
Message-ID: <xmqqvap9zjpc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> In a similar vein, on systems which use a 64-bit representation of the
> 'unsigned long' type, the USTAR_MAX_SIZE constant macro is defined with
> the value 077777777777ULL. Although this does not cause any warning
> messages to be issued, it would be more appropriate for this constant
> to use an 'UL' type suffix rather than 'ULL'.

... it is more appropriate because we know the recipient is
"unsigned long", not "unsigned long long", in this case?  As opposed
to the case of timestamp_t, which is opaque and could be "unsigned
long long"?

That makes sense to me, even though it took a bit of thinking aloud
to understand.

Looks good; thanks.
