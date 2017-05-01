Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB30B1F829
	for <e@80x24.org>; Mon,  1 May 2017 00:49:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S638021AbdEAAtJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 20:49:09 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34801 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S637990AbdEAAtI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 20:49:08 -0400
Received: by mail-pg0-f68.google.com with SMTP id t7so14089880pgt.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HmwAC6egpn8SqTKc7YzWaV7QTdaIgKZOptEMN0p8+c8=;
        b=hGTQSKRghmmn5seXVii+6t1JYGp7W21PfIuJyn/NyhjEgAMPBtwghPs2dyiMcmrV9c
         f7z8Qe5A3JtZzMxq7hcODMUXk5DuaJE9VvB1sW+DjclTLYEaiMeWScXOy0eloxMwM0wF
         Un67qSPuUN2qvYeq0gWlgtJWxWpK8IBv1bFhY6P2VePJbwL0SNYXW2FvkZy49PioflJz
         zdAnBjJTKXDw19xaYRAyDlqTtJg1y0itbygUrYy6EADQpjCI/QT3kPqJXHPqo082MLqI
         62BoCMG0SEQI9XNHp16xMbsWuhRaTJFPl1pq2FjIF7pQb9mCoIEotzcn6l57uyMLl1Pn
         qieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HmwAC6egpn8SqTKc7YzWaV7QTdaIgKZOptEMN0p8+c8=;
        b=kGbS8V3SgRnhc1J3h9JRdS8lui7WyPVE5bsRkeYRLnBC8rS0xj7wAPX31xrt+K0LnB
         kz+r7h+4Lhcx9/SL8eaP4IDbBe7AOn2e0mY43imTZgOhvk8DRknQ00im7wSbRczk4tSX
         vXaCXFG+EiSyq/MgoAeyNRKWN+ZkfHBboxgY/3FOCVnp2g4S0OiTC8JVQrtOTv1ChJig
         y1EekMwUAboOhY/aIlasxxb+QlfHdO2yxccfZb8AaZFg87oXxTwVYhtCTuLwEmtCPzk7
         GXRPJqh42Eo1BZRiOaL1z1g/QeoIRfxqjJ16HwHzWGmZqCQ3Mqa4SWU96XMSh64ZsehC
         gc9w==
X-Gm-Message-State: AN3rC/5fOaK1w6kZ1Ibs1xu8Hl721lFgAHlrDx1f33IHJDEq2huATex5
        7ViFGUT1vJSQaQ==
X-Received: by 10.98.199.18 with SMTP id w18mr24099057pfg.209.1493599747610;
        Sun, 30 Apr 2017 17:49:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:216d:aa3e:248d:bf63])
        by smtp.gmail.com with ESMTPSA id j4sm20090217pfk.91.2017.04.30.17.49.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 30 Apr 2017 17:49:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
        <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
Date:   Sun, 30 Apr 2017 17:49:04 -0700
In-Reply-To: <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net> (Phillip
        Wood's message of "Fri, 28 Apr 2017 11:08:12 +0100")
Message-ID: <xmqqtw55jta7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> This changes the behaviour of
> git -c rebase.instructionFormat= rebase -i
> The shell version treats the rebase.instructionFormat being unset or set
> to the empty string as equivalent. This version generates a todo list
> with lines like 'pick <abbrev sha1>' rather than 'pick <abbrev sha1>
> <subject>'
>
> I only picked this up because I have a script that does 'git -c
> rebase.instructionFormat= rebase -i' with a custom sequence editor.

Sorry to hear that.  As there is no way to unset a configuration
variable from the command line, "git -c var=" like you did above is
the best we can do, and that why treating unset and empty variable
the same way is often necessary.  It seems that Dscho gave an ack to
your message, so hopefully the final version would not have such a
regression.

Thanks for an early warning.

