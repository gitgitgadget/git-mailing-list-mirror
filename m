Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E70892023D
	for <e@80x24.org>; Wed, 17 May 2017 03:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752732AbdEQDl3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 23:41:29 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33532 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbdEQDl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 23:41:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id f27so104513pfe.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 20:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gHUqxoMLWLby1nB7IjBN2/r68GANFTO17uQzYKmTaoE=;
        b=X8+n4Spqtrhvd8ITdyyMtISeMNPstZa+chApSII8nderN+1QsMrClY7BeB+4/Hx1sk
         4iGceJGNKVmeyHzKYdOnNFlABkgIkb/YaDRl6ehjxDMPbpQV+Ruby1YDleOyaDN3NgSO
         c6vy5KnhDLpd42O3l+SmrBjgTcU8Y9rDcwmuRkNTr2vKZMGK3FD1ZMqsa1Xolvb+0g3c
         VYHlKglQSNNYaPa8QeD9kKIQ8C4PIlEnSo993jaGiK1jA3Srl9ysr1lOKAnhRtJbzbxf
         8FD01hAIcIg7HZu4RFhqdFaHyDj09jpj9qz6alIU0xpmukLvbv4q2twSsqnUoKYlLS66
         PfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gHUqxoMLWLby1nB7IjBN2/r68GANFTO17uQzYKmTaoE=;
        b=O7sVgQ+hevsAKIILyWd9vAkotIqe9RAOEE1qulh/y5pIrsNcNQo0CiJurv5gEOiZtb
         XlCwqZcY8G/g7twqR3unqaDWF0STgtrKvvVrAMKwD/pw8VPWkgw9vvKfpogcqJf6zaxV
         Dfotx1nDilPxeS+Se/+BujkqIeZpjW2ZBMO5mBPtiEZSrq4vC86kFiiCjbJbBbnDZHpb
         eSKnMYLGc0flf+awPKRHiVoKAYfw6covBQFu7zaKWCzgsldiUtJvOglFML6bMsfXTTgP
         kE5KJ+RHP2eVlV5su1/EjcN8PuT6UY7v7ptK6ZooWRGOwm0sTuYRSUOtMcprKW/nAoWV
         P6yA==
X-Gm-Message-State: AODbwcDEKJpBgQm4wmLFKg/5IozvsdoDwDpVGQcdcH4Oqn90y2cKnTzV
        AAW4m87bGu+jF8PmPlQMeA==
X-Received: by 10.84.131.67 with SMTP id 61mr1709313pld.8.1494992480410;
        Tue, 16 May 2017 20:41:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id q9sm793244pfg.77.2017.05.16.20.41.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 20:41:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        j6t@kdbg.org, sbeller@google.com, e@80x24.org, jrnieder@gmail.com
Subject: Re: [PATCH v6 04/11] run-command: use the async-signal-safe execv instead of execvp
References: <20170418231805.61835-1-bmwill@google.com>
        <20170419231327.49895-1-bmwill@google.com>
        <20170419231327.49895-5-bmwill@google.com>
        <xmqqfug4z0s0.fsf@gitster.mtv.corp.google.com>
        <20170517022602.jj26pf7eypxp2fjm@sigill.intra.peff.net>
Date:   Wed, 17 May 2017 12:41:19 +0900
In-Reply-To: <20170517022602.jj26pf7eypxp2fjm@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 16 May 2017 22:26:02 -0400")
Message-ID: <xmqqr2zoxi8w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is about finding "/usr/bin/foo", realizing it cannot be exec'd
> because it lacks a shebang line, and then pretending that it did have
> "#!/bin/sh". IOW, maintaining compatibility with execvp().
>
> So the command itself isn't a shell command, but it may execute a shell
> script. If that makes sense.

Ah, OK.  Thanks.
