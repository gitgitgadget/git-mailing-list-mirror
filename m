Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDDE20282
	for <e@80x24.org>; Fri, 23 Jun 2017 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754892AbdFWTo2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 15:44:28 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34344 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754773AbdFWTo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 15:44:27 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so7298905pge.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FfSGql57uf6qRzLgsRBaG9M4jKs55M6+Q+zUW6i+AQs=;
        b=lSZcwaG/xZ2djWPc9qkQKKY4hgPfz1gG1FPMXCepIJHe6GCjOdMd2he9OWXdIQ2D4l
         ly7+Y4YQjkWvuZHh3MbvTP6NTGnkuJXwPlduDBd9PPJKN0OmM1iFyLA2esybCRoj43wl
         S6aZ/tV0qqCaBaD2wM7vFVvfV8ezXSNNdCL4lyP+qG41N7PBVJhelIBg/miq4uu7Q/R0
         hUAy78yMTslGxnwggE/+B22nuMPPTow1oulexVXesFplctRs+FKl9N6RjQXWSk64jR1K
         BeMQitYsLe6eO0fUh1v/YC/43jO7f3TJaMjLVCgAP+85AKzfMDK1jM/VbSM3AUADfvCa
         yM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FfSGql57uf6qRzLgsRBaG9M4jKs55M6+Q+zUW6i+AQs=;
        b=TkvN/mhumWQWv9kV7TEr7mXzW+gF5aYIpiDEgjGEsY6NATle6NaqqgMSZyNrMJnXLu
         3ORl42dZME7SCl4x5TE6ggVN4UZbmlf7frPh4koPGANSbSiQqax/FaaFP3hEDEaZenlt
         mHzMdkerp3ck9d7ZBvmVoOlm7Gxqsvpm+Uyf1hvlJT29Dbr4qcmeJMPARz7KUwV3f/2k
         p32AqRJsl1dRrBC4emd3o+jXJBqmmthDo3GcSofmsX/5Sgs7edqZ9DBdHRjVr5A9pOk4
         xQD5FxX3/iN17RbIXwK/cbG3kTaBOfpiWRNKJ7/2GHnUo0efzpSdd6fc9yCIAJve0KQl
         9efg==
X-Gm-Message-State: AKS2vOxmN5YiM7Z+I/WaDrlS0Z9IwrgYU8VRaziTYeFxqfS3PEXlzK6G
        JEs0Ms0MbdBIDA==
X-Received: by 10.98.193.129 with SMTP id i123mr10009765pfg.138.1498247066371;
        Fri, 23 Jun 2017 12:44:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id q88sm6102670pfd.133.2017.06.23.12.44.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 12:44:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Daniel Hahler <git@thequod.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] xdiff: trim common tail with -U0 after diff
References: <20170623103612.4694-1-git@thequod.de>
        <xmqqinjmecuk.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZb+ziJGx6GvSVwX85Szce0zT=2gaF1GpPtz8ft1uhdPw@mail.gmail.com>
Date:   Fri, 23 Jun 2017 12:44:24 -0700
In-Reply-To: <CAGZ79kZb+ziJGx6GvSVwX85Szce0zT=2gaF1GpPtz8ft1uhdPw@mail.gmail.com>
        (Stefan Beller's message of "Fri, 23 Jun 2017 12:37:05 -0700")
Message-ID: <xmqqefuaebfr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So I tried finding out more about this hack,
> and found the patch that introduced the common tail trimming at
>   https://public-inbox.org/git/7vmysez0oa.fsf@gitster.siamese.dyndns.org/
>   913b45f51b (xdi_diff: trim common trailing lines, 2007-12-13)

A relevant one that makes me hesitate to take this kind of change is
this:

https://public-inbox.org/git/alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org/#t

that resulted in this change:

commit d2f82950a9226ae1102a7a97f03440a4bf8c6c09
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Dec 20 20:22:46 2007 -0800

    Re(-re)*fix trim_common_tail()
    
    The tar-ball and the git archive itself is fine, but yes, the diff from
    2.6.23 to 2.6.24-rc6 is bad. It's the "trim_common_tail()" optimization
    that has caused way too much pain.
    
    Very interesting breakage. The patch was actually "correct" in a (rather
    limited) technical sense, but the context at the end was missing because
    while the trim_common_tail() code made sure to keep enough common context
    to allow a valid diff to be generated, the diff machinery itself could
    decide that it could generate the diff differently than the "obvious"
    solution.
    
    Thee sad fact is that the git optimization (which is very important for
    "git blame", which needs no context), is only really valid for that one
    case where we really don't need any context.

