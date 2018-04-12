Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCF31F404
	for <e@80x24.org>; Thu, 12 Apr 2018 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbeDLVqO (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 17:46:14 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33361 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeDLVqN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 17:46:13 -0400
Received: by mail-wr0-f174.google.com with SMTP id z73so6473190wrb.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 14:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oaLNjNyIVjqiRFf/VN4tBviI2UFoWxc+EnR4ywaCLUY=;
        b=VCLX9dSQw12dWBDPRMMeUuESKKTmdDdid4VNdpGsghkeFLR7VkHcOSdi2eSY4Gxtdl
         CevBRPKHcpebnRwKb0MYq7y4WOWRu2kVt5nFPu8/nRIqgdVe4LPRZa1JyF8XbROPl13H
         hA070lMKjrWSsOH/xQtIHbWYnOIc1oFIxK3pdULn86XTL9CTEiClRr2BIdosYZlXRtIK
         cRQEdTFJGjIdFCvqUzdJ1Ak3WlW3Mst2jnTn9F6WQSRxnruRW9711ZyjUxvEPK/Zn6PS
         MvV2W7bLmknrORuL5g+/ZpQaekhICaI4eULZxfVr0SO8Vw7BxGYlS6LnGR7M/pPw9Iml
         JGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oaLNjNyIVjqiRFf/VN4tBviI2UFoWxc+EnR4ywaCLUY=;
        b=r/1gbLD4Fkjw7HlhlViaSbZyQ9U9gkyJJ2ZPD7gExOaop+j/HO1mQhpALe/moCGiDq
         whWxayr8kq4hjsdIlAuO7QN+ybMfJjxk1NBnkdPDMUv4FbtM8VvjZVfYl7TKZjG04/Wh
         mvju6LaxxSLimscyr7W2eLbubFd7/fhMFRn482azC59laAOUKjOKtmmxwngZGfcIk+PO
         IGqalSA81mgERW/t02MZZBGcUYTPiIVLXtJTFPfTBmtSojPO47DyySyTBynIIcRXLKE3
         onmtdXaLxCp1PPk7mAoN/56lO8GwA/xUjqVdb5kkWwEyIyTm9Miz3Sywcs1JhG3nNJHT
         Jscg==
X-Gm-Message-State: ALQs6tB9j5oewGX6jzqwZtJsidGjlw2+SCNEWqVBHx/wNR0jVGOXSsA8
        Tb4ehie1ttmx8DLkLFqbWaQ=
X-Google-Smtp-Source: AIpwx4+PgOrWZVc28lDwOu/g+U4belGoOvKw86JdszkzGuY89XrmWg86Qaqpcc+l0dgUlSomcsjXRw==
X-Received: by 10.223.224.141 with SMTP id c13mr2017380wri.88.1523569571875;
        Thu, 12 Apr 2018 14:46:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e13sm8492184wrg.79.2018.04.12.14.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 14:46:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Optimizing writes to unchanged files during merges?
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
Date:   Fri, 13 Apr 2018 06:46:09 +0900
In-Reply-To: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 12 Apr 2018 14:14:24 -0700")
Message-ID: <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now, the reason it was marked as changed is that the xfs branch _had_
> in fact changed it, but the changes were already upstream and got
> merged away. But the file still got written out (with the same
> contents it had before the merge), and 'make' obviously only looks at
> modification time, so make rebuilt everything.

Thanks for a clear description of the issue.  It does sound
interesting.
