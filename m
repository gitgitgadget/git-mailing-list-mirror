Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2A8201CF
	for <e@80x24.org>; Sat, 20 May 2017 10:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbdETKl2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 06:41:28 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35643 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdETKl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 06:41:27 -0400
Received: by mail-pg0-f66.google.com with SMTP id i63so12336731pgd.2
        for <git@vger.kernel.org>; Sat, 20 May 2017 03:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ARjZ5up5ykntd2kmhLNc4NLnfgKSxGBVopagkbvSE5k=;
        b=W9413aS2t1NGpmmAZJSJl6uzpv3SKONJ03iq3y9nUpMYf46FlQCAu1VRDlezl2YheG
         pAwhvStNZI+vA29rxCcDURaDFBfpskC51iD0fliy2+SMyxdUwNMFW3N65E0ywAJhsuLP
         qXx5uoNXVdFIILw5IP57JjhUZ6ef6jFo9M3/Q25rFNHFypVneIUv9avUrUJFgVdbYbxj
         BecWoVUrO/Or3gcP9+LMei8b6STeKEueZbbIKYKX6UqjDk4psR3RFwSeqOvHiz9KY5Il
         MQ/6C+QtRuklG35rwzvBQ7pLVPshyH99KX33Kso9EPx1+S9QkU5ALwMnujXWIFVteplU
         28JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ARjZ5up5ykntd2kmhLNc4NLnfgKSxGBVopagkbvSE5k=;
        b=U3c2JvmGM6dpOHdiei/lgIDulZaLAXvBZlf+eB+jQAdS/+A5m7tKfgdMNsfnz7xkaE
         z+x56fkRpucNkjuiapYhetacUbLtdGRZT505swf9ZbiW+dNPkry7egM87Y+mnXGI7NwU
         bwjcF1eM/A0wSLvmtTasK9T1deqgCdMopkbgsYz6JYpKc83cyK/M2oTzX40VWtW6j76v
         +rwT/THsRDzqnVeuJ8qV2/PgaHw1xaJsNlV9bTdLOxmFnOCZXHcqgPIWwqR6rtj2rpmB
         vCXHM+1f7qZL5fZ6Ogve5KPXur2cIp/cQYyrHB4hNMBDUyIwMtsi+lHe0sGtJWTc7KIU
         Xd4g==
X-Gm-Message-State: AODbwcAMymNNoMmNEil5dV1lpcIKRGUGZwytVJflzQ+Xp+4AxFPfSDIg
        d6NttZeNf7G9hw==
X-Received: by 10.99.127.78 with SMTP id p14mr14991775pgn.124.1495276886668;
        Sat, 20 May 2017 03:41:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id n23sm21151464pfh.44.2017.05.20.03.41.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 03:41:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: Re: [PATCH v2 3/6] fsmonitor: teach git to optionally utilize a file system monitor to speed up detecting new or changed files.
References: <20170518201333.13088-1-benpeart@microsoft.com>
        <20170518201333.13088-4-benpeart@microsoft.com>
        <41d6939f-0095-cfc5-cde5-2ebdd74a09b2@gmail.com>
Date:   Sat, 20 May 2017 19:41:24 +0900
In-Reply-To: <41d6939f-0095-cfc5-cde5-2ebdd74a09b2@gmail.com> (Ben Peart's
        message of "Fri, 19 May 2017 11:33:24 -0400")
Message-ID: <xmqqtw4fstd7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> After sending this, I noticed that using a different compiler
> generated a couple of warnings I should fix.  I'm assuming I'll need
> another re-roll but if not, here are the changes that will be squashed
> in.
>
> Ben

Thanks, in addition, I am missing the definition of TRUE and FALSE.
