Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7EEB20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbdLEW35 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:29:57 -0500
Received: from mail-yb0-f182.google.com ([209.85.213.182]:42722 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752195AbdLEW34 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:29:56 -0500
Received: by mail-yb0-f182.google.com with SMTP id t127so815761ybf.9
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 14:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kitware.com; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A1a6OqfwaCWsFqHcVD2NP5yy0x/m84N8vH7OLbRZAB4=;
        b=cB0XmgNBuYSV+dEOWdE/vzEiaOTRW+CRIMi3fPztXoYdFTEU7aVw72oBAb7PgnmIqX
         4LjCaJ8E7PXSx+DqUcgPNPf7LRKEY20zsy50vAjXd3+9fHggiH7hhxZmngM7cdMmTEay
         bQiCYjNsw+gN+9fznX1cC1k3zS+IkCNF/qW5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1a6OqfwaCWsFqHcVD2NP5yy0x/m84N8vH7OLbRZAB4=;
        b=rhSi48M/CoUUs+2e0hfdvMti/YWCD7LFo0uzR7b2hbxlNyD2BC+SBFiqsF1b9MFW5S
         HV/oU0h/7lg7vDBI7CHRvqhvbdBQt8HvxsOYFiVpWC3hqDQGRF5wrgdjO1fHN5ZOzrn6
         v1AwMk1KL0O9nkGhE7gyFGU4dxeujHzqG286NrJSCTq/ugjFXjFUB9Eqyhr0ooGmaco3
         5ylUAWbvLsxWryFXC8H4Q0PR6zbo4xW2taPu+7KC9Gh4mFvzA4IjZ/3MQ7vCSmtDOLHK
         ZCq8oWzB4B963CHgs21JZA7Qg7XqL+1lFOby5Sol+BLLA1Hj/KxwX3a0ppr/OoV8Od7a
         6igw==
X-Gm-Message-State: AJaThX5uMAg0qEGOTc4qitExOLK1UPcoFiQ537h6Q3Jnf8gyejX4efZo
        ukdLs87Xh2S6NO85U70GO+Jg4A==
X-Google-Smtp-Source: AGs4zMaRMh6rq9zuqA4NjNGAYMEgbpeanzQTUBuct8ctpPG8vPUusmBQuRC/9ijOl18QT7GhkhCjYw==
X-Received: by 10.37.192.196 with SMTP id c187mr14656004ybf.366.1512512995858;
        Tue, 05 Dec 2017 14:29:55 -0800 (PST)
Received: from localhost (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id w198sm610042ywd.28.2017.12.05.14.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 14:29:55 -0800 (PST)
Date:   Tue, 5 Dec 2017 17:29:54 -0500
From:   Ben Boeckel <ben.boeckel@kitware.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
Message-ID: <20171205222954.GA9217@megas.kitware.com>
Reply-To: ben.boeckel@kitware.com
References: <20171205194801.GA31721@megas.kitware.com>
 <20171205221337.140548-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205221337.140548-1-bmwill@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 05, 2017 at 14:13:37 -0800, Brandon Williams wrote:
> This patch should fix the regression.  Let me know if it doesn't solve the
> issue and I'll investigate some more.

Our test suite passes again. Thanks!

    Acked-by: Ben Boeckel <ben.boeckel@kitware.com>

--Ben
