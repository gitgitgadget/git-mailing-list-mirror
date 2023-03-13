Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295E9C61DA4
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 17:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCMRMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCMRMN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 13:12:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD6A12BF8
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:11:44 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a9so13696332plh.11
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678727451;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/wfw1RXip1lpn7hFp57TCKiJMwQHTuFwymtyuXqBsQ=;
        b=pphLjnIdPSLf3P30qpHFkoBe+vaAGeWEXccjyCb4apB4msPrYGI+tUY8sKxe6uHKkB
         TYlca7XwxMhjffRY/KgKJhooUQ4JSmLvM8EdQl2NA64sTQWYvctNRyskF1hs/3+X32h5
         kw4yDKXiqOjrWO5xQkuSy0Az5x9w+3y/MVGCXwAbrySBKQd8TzL+MuogVQH4yqombcmu
         11sf8nWB043Ng+M4SSfXqfR4q66X8S5YyLcRL363fPKq8StMCTHUmnvb7tg/k/fcTwiq
         LhVGku83/LkLfJtV9CktAZOlCN9zJMB8nMj6DcKvnRpBzrwoDlNevne7fkjFGw+ykTuZ
         5RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678727451;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b/wfw1RXip1lpn7hFp57TCKiJMwQHTuFwymtyuXqBsQ=;
        b=btmLkmGWruKmamcpX88PnXW+4tcri7YzRLXQWWigNFVEqd/cqtSL806Q46FQe+Ob7U
         szkJC+joEVHIzW9US6yMbhp03GxHXjN4L6vCuA66Z0SLIX8+5fHtsPPw7gP0YBrmSalJ
         wseUDqeQ6Sf5ZMMeN1EGiilLGgpltAlUTuzIb6G3xk/sJmzk6+Vt6YFQj1ytlcAdaH7s
         XzLFVi/7jKzKNJl/mYnp/a94kZUXzdOhnQHpswH0CqLCcSHf1yBDUeVLk6nlRnSzMGj5
         OrCYpHBGZnWVDiaTPJqiWiUUTRqMSRYMiXB/HSV/VrLkH/DJ2PO3ftv6BB/F7HZ9rMHb
         HjkA==
X-Gm-Message-State: AO0yUKV7pLNJEFxQ1uUJMAsHaPnUWdHPh6PiRS5VaQqJJHpgNvPI4C6O
        vtf5EdyOc2nWoWSpDEgVGpR3J4Ky4Vs=
X-Google-Smtp-Source: AK7set8m/Qjn6PuRWK5fU7TZ7BXfxzcXrLOBKF9AkeM0lp+g8KlaRhOeIv4/yrhUTPzb9zWUiGYi5g==
X-Received: by 2002:a05:6a20:258a:b0:cc:d514:62cf with SMTP id k10-20020a056a20258a00b000ccd51462cfmr33636008pzd.43.1678727451545;
        Mon, 13 Mar 2023 10:10:51 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b0058bcb42dd1asm1807354pfn.111.2023.03.13.10.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 10:10:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Better suggestions when git-am(1) fails
References: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
        <ZAlPtxZ/0Z28r5tF@coredump.intra.peff.net>
        <xmqqedpxq4if.fsf@gitster.g>
        <ZAr6vIOe3WbTIohE@coredump.intra.peff.net>
        <xmqqh6us7epk.fsf@gitster.g>
        <ZA9RYncZaqoA0mCw@coredump.intra.peff.net>
Date:   Mon, 13 Mar 2023 10:10:50 -0700
In-Reply-To: <ZA9RYncZaqoA0mCw@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 13 Mar 2023 12:37:54 -0400")
Message-ID: <xmqqpm9cwp9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 10, 2023 at 08:28:55AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >   1. I feel like "-p1" was pretty standard even before Git. You'd
>> >      extract two copies of the tarball, one into "foo-1.2.3" and one
>> >      into "foo-1.2.3.orig", and then "diff -Nru" between them to send a
>> >      patch.
>> 
>> I would too, but then we wouldn't have accepted the request to add
>> .noprefix configuration; I do not recall where it came from.
>
> I always thought it was an aesthetic thing for humans viewing diffs (and
> likewise mnemonicprefix). The original thread doesn't give much
> motivation, though:
>
>   https://lore.kernel.org/git/1272852221-14927-1-git-send-email-eli@cloudera.com/

Interesting.

Comparison with mnemonicprefix is a bit unfair, as it does not break
other tools, though ;-).
