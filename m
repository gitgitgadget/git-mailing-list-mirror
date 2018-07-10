Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C7A1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGJSWX (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:22:23 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53803 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732406AbeGJSWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:22:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so25614139wme.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=X7/gMob3v8hEjH3bqdlKqXz2leLJIRAscnNaQJ7EqFM=;
        b=QO9498vAB9+zVLqVdT2wLqdfVb31Y1O04qDQMBWyOD9g+W++IKG2O1H+64k9qb5lij
         g8u0gKZl4sNNoX3htkJo6JguCKCDEYf/zNidJnx8Ru/ZRK9WfhNaqqMcSzr/AmjcbLJG
         aFXROhNrzOF6eteUKOWvZ8NZjcjcdyWSBhiQha1h4eqdMJVR3lsNziunWmj6bM7uRb+r
         rbqGBMvAuKYn6+jpf8fBBfvi9aGZKMwZiC4DmpKmc9F9z2ihBDVcYzsFfK54ATVKD/RE
         x+eq0eeX3jMmCClbDyD1tAC/w4BpftCKxmP41f3MsUSfXEiC6W765FRSvdV1Q5WzpscV
         yk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=X7/gMob3v8hEjH3bqdlKqXz2leLJIRAscnNaQJ7EqFM=;
        b=B3ng+GLC0bwzEXTES1BNIst/hGAyYHWM9JOQexP0fktvcDRXqfGr5rrEXqC6QfQpMc
         H9BNRcg/JM7ija/P+ug6e+Mzf8QVcrLrd+RX86WOJfxIHdQzflD8zX0OqXNkJcDg03+a
         /PewQDAWV1xnZz3Q+01JqwDfKxeg/worde6FErSd+3d8hHEbWkn4SoM/AZ00PI5n1K3y
         xBsTfFIO/w+eg0XC4anLp+ueLXhbeC4vArQbgEQPl0gOo1uZqUM6sI3qRAR9kNKVNVtT
         AlR9YYogWNQsUpDYOJxHKzjR+PJatevjja8kdvuVO5tAk8+++C8FkqBNeklH/EsbmhYL
         VQeg==
X-Gm-Message-State: APt69E2kZM8AP7DpllTXYf13BEYODd7GAXS668Rcd7iSsbcgIzFLlvZQ
        x3QS4kmCAHoSksFB4gnAMT4=
X-Google-Smtp-Source: AAOMgpfvKwrQD30KKbijFHfC371kUPRD8NjrNErjEaXfj3lr9boLdl2V4a/1nIKLPbMZPrhokv3BNw==
X-Received: by 2002:a1c:228b:: with SMTP id i133-v6mr16393014wmi.69.1531246932749;
        Tue, 10 Jul 2018 11:22:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u4-v6sm2337wmc.1.2018.07.10.11.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:22:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 07/13] rebase -i: rewrite checkout_onto() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-8-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:22:11 -0700
In-Reply-To: <20180710121557.6698-8-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:51 +0200")
Message-ID: <xmqqh8l76je4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This rewrites checkout_onto() from shell to C.
>
> A new command (“checkout-onto”) is added to rebase--helper.c. The shell
> version is then stripped.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---

The only change relative to the previous round seems to be that this
round does not pass verbose flag as a separate parameter, but reuses
the opts.verbose field where "struct replay_opts" is being passed
around.

Looks OK from a quick scan so far.
