Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9B11F516
	for <e@80x24.org>; Mon, 25 Jun 2018 15:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeFYPev (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 11:34:51 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53725 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeFYPeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 11:34:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id x6-v6so9763302wmc.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b0HigQi1aI17G5lTseE/UhbiLzlHt0mRC5G6w0SSfdE=;
        b=f/D9ziCLteXiGPVSvWzrFNXaqGDL0NszcZkfeXz3Ni44+WTcL8qPd85DHN90GppU3A
         +Um4iEgV32y5bG+ezkTP3QnO9uAF8wuCxS089uyiNEizni3jfEdqteu9ieW3xlOCO5UX
         S1IJ7cDpVF4paw7r6MOy6BW+eScyHcbBnxd1WZjMhiZG04zde4cUtBBrIOM8N3pa5r0G
         vbFV23LijKT2FU43/QDoll0fAN57+VtKCKdXuNfyfm96s8l0hKv8h8HP/0AAkCkbZwH6
         Dpf1T8dPNGtDb0JhYJKevCFTJAW4XmcwqT/pyjSzyZZDjjMxaJhO0d9necMLeVuTsFDj
         Tl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b0HigQi1aI17G5lTseE/UhbiLzlHt0mRC5G6w0SSfdE=;
        b=jrTCvn+gQ5QLx6jmJ+5gBJbQbfQ4c8tzYxny/DHmNdgDMpncruuYy8anOtjocm/JRI
         42CMCy05hEBnrf5042H6Lmc/K28o/Y1UVzBTyH7QCScZvo6XZdFn4L94kfeePAmWvli3
         ioe8/TzUcXspL+haXaPFrW80fcCh48JxnrKLMWPqHv79k5iMiDRQOZluSYKeT5E/kMrJ
         TWKCCC4GQX38RmCYbR13pJ3HgzWyz7mQJ5J9pAF7x6MeNg0xZdbQWJhwyQrj8t7zeuZ5
         S67CZeigdyeeu8NZbq9o8MgaRKfzWWAh6AvcDSkkrNFr6E7CN1lyzDHVJChl9vTTQTZu
         fNDA==
X-Gm-Message-State: APt69E0VZaj4o859AvXdeqTYVEBr//9soVViTyICiuG8OZrOByHlKEGH
        QW1wFdnYca4ngglznw9gRBg=
X-Google-Smtp-Source: AAOMgpfjTNhWikpmcmUo+rO1uVjBJrfpDOBWROcIhY3xKPaagsWN4j5R7+GegfbC7CVpMcDZ+CxMaA==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr1378935wmf.30.1529940888866;
        Mon, 25 Jun 2018 08:34:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p10-v6sm7044387wmc.17.2018.06.25.08.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 08:34:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
References: <20180619154421.14999-1-alban.gruin@gmail.com>
        <20180621141732.19952-3-alban.gruin@gmail.com>
        <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com>
        <7094810.i0lmrLi0k7@andromeda>
Date:   Mon, 25 Jun 2018 08:34:47 -0700
In-Reply-To: <7094810.i0lmrLi0k7@andromeda> (Alban Gruin's message of "Fri, 22
        Jun 2018 22:48:03 +0200")
Message-ID: <xmqqr2kuq3qg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Hi Junio,
>
> Le 22/06/2018 à 18:27, Junio C Hamano a écrit :
>> Alban Gruin <alban.gruin@gmail.com> writes:
>> > This rewrites (the misnamed) setup_reflog_action() from shell to C. The
>> > new version is called checkout_base_commit().
>> 
>> ;-) on the "misnamed" part.  Indeed, setting up the comment for the
>> reflog entry is secondary to what this function wants to do, which
>> is to check out the branch to be rebased.
>> 
>> I do not think "base_commit" is a good name, either, though.  When I
>> hear 'base' in the context of 'rebase', I would imagine that the
>> speaker is talking about the bottom of the range of the commits to
>> be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
>> commits BASE..BRANCH on top of ONTO and then points BRANCH at the
>> result), not the top of the range or the branch these commits are
>> taken from.
>> 
>
> Perhaps should I name this function checkout_onto(), and rename 
> checkout_onto() to "detach_onto()"?  And I would reorder those two commits in 
> the series, as this would be very confusing.

I may be misunderstanding what is happening in the function, but I
think it is checking out neither the onto or the base commit.  The
function instead is about checking out the branch to be rebased
before anything else happens when the optional <branch> argument is
given (and when the optional argument is not given, then we rebase
the current branch so there is no need to check it out upfront), no?


