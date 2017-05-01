Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 462DB1F829
	for <e@80x24.org>; Mon,  1 May 2017 01:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S638329AbdEABTN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:19:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33738 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S638316AbdEABTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:19:11 -0400
Received: by mail-pf0-f196.google.com with SMTP id b23so10111095pfc.0
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=juWQQ3AbdrPozHkmacpQliJf0JyoMoZcQH1s3ArHS4c=;
        b=urIcMwLnH17k9Nd8EXBZ17z2HxvYYsGUZFWOYUcPW/pBrzOPNho7keJOraYzgpiUQW
         CMR07G0TCWFh2Ulbjr8Cq61hTHz+YdS+huebAacKzhMnXhIfNbSHvyKbP3jl2H8+LeZq
         LuRV19My/n6VDR3oui1AGyXHd2WDEs6UioaVQnGiBTHuStQSpJqxM3mP7NYR3W7PtKD/
         SfLhWbqiW1yiHN9rTYgwG6QlbC1o/DDUGOUT0AEkZrC+i1edtGNusXGKvX2gCgR95/aO
         q2N/HLG4yOHMRBEjqzJGE066BL7n02z42PEb1WnIMd5wh5f1UZJMbd4DrnMsRyZCAUpd
         qULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=juWQQ3AbdrPozHkmacpQliJf0JyoMoZcQH1s3ArHS4c=;
        b=Y45sSXh+Opr/oTButsgDwCxRUeyfic24b/kGEg8w/AiW5KX38s/nktkhNnOyIaVMN/
         8LhnY/PRtDXOkZ/00szITReA9Q51RWNjBfLuhfcIeRE8zlONa9cWExRXZjLQ0V3HMCwP
         7EeQbfzov/wUTuKfWX9dNaoj4k60UyYXTje6DlIjx7y4xmid8A7bhAC4s3fzwdJa6a4T
         EJ23NNrdbV0VluTY9e6WWYffCqVlIJa/aQsCV+icW1u65wKL8K/QVo4Qye2GSpQHO2W2
         ryOXQGySCgEUv4C9X1oYejjyrsox/acIJFjLR5MHN/xgVKVqc6Mt//IWqyPJRBx4iONc
         qdkw==
X-Gm-Message-State: AN3rC/583ReoTI87RisXLPu36nxKIdCdKEK1/EmmNLvDC8nW6ddLTKEw
        B0Jx/ZglaqRT6V3VdFc=
X-Received: by 10.98.106.199 with SMTP id f190mr24836009pfc.142.1493601550522;
        Sun, 30 Apr 2017 18:19:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id v6sm5461997pgb.20.2017.04.30.18.19.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 18:19:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 07/26] http-backend: avoid memory leaks
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
        <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de>
        <xmqq4lxao0ds.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704281117040.3480@virtualbox>
Date:   Sun, 30 Apr 2017 18:19:09 -0700
In-Reply-To: <alpine.DEB.2.20.1704281117040.3480@virtualbox> (Johannes
        Schindelin's message of "Fri, 28 Apr 2017 11:40:01 +0200 (CEST)")
Message-ID: <xmqqh915jrw2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Hmph.  I find a "leak" of a resource acquired inside the main
>> function and not released when the main function leaves a lot less
>> interesting than the other ones this series covers.
>
> Ah, I missed that this falls squarely into the "one-shot programs are
> allowed to be sloppy in their memory management, essentially using exit()
> as garbage collector" category.

I actually think it was a good intention of yours and I would agree
with the patch.  The automated tools that find and complain about
these issues do not know about our local house rules like "do not
bother freeing immediately before exit" and will keep notifying us
of leaks. One way to reduce the noise level so that we can focus on
real issues they may find for us in the future is to squelch these
"uninteresting" ones by "fixing" them, even if our local house rule
says OK, like this patch does.

I said "a lot less interesting" and did not mean "it is bad for our
code to do this".

Thanks.
