Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FAF01F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 19:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752862AbeGCToJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 15:44:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38204 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeGCToI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 15:44:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so3432688wmf.3
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Nm1tpeCzbszddpoz50MjbKo2/KyEoe3RXJV9jb6iSgo=;
        b=Bch0PmhO5bCR0BgJnKW8gSuyKfGMlL7/PziJrUOmfcCQvcGHFT9b4YhahBBDuRSqRB
         gTkAVZ3rKbq8JLyt+Ax3w2BhTaKqRUQhDDXWCjww8rDs+BOGTcWEkvbRI5pmf0HMhgv/
         w6RaDikl+NJuKWYy5QM4OaJLxODu7Torou9DfSaYuBjclaVJnwbuVHgk/8zyk/c3UijX
         TPh3CVZPinlv0TPYCJsx/RdyJCaBZdJyl9O6XZaBo67zQvWkLNyJkHLcIO+zUkQNRuPu
         WLmfbhVmDySSe9J2AUT4J8yhZKgGZIa7IUfPNRJBNA0nIb0t9dq2kiJkPNqRVgBD1c9B
         9x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Nm1tpeCzbszddpoz50MjbKo2/KyEoe3RXJV9jb6iSgo=;
        b=cByRTZmuEn7LYho88aYJiMaBs9NjRHpaCzGSS0iJsqrA4n87RF8YX4Bsw7BcXbpf8m
         Giea3J3uOLNts3r8zbPox2oxbqhvSLsNXgarlqAnzpp7igvepeeJwzAwDJnKxEMBLOdW
         doCyuBIKBVFONI6qaVqvpmf7bVk4By5EO+MkhoPznqcQ5aUEgQHDBO6DA7BB85QW7vNp
         HZIrIE9134ebk+PkObNzSCiofniD0DFBGr181kRq4ITO8avZhcR7NEU39Nr6To7C8pfy
         UHMTQ86Fhuseiy9pqmOcoZjrpVMWs/Tbv2a20JFsEvn7ntWu6WVb9GPe1hdo7vv3esP5
         tSTQ==
X-Gm-Message-State: APt69E0Ri00CyrqFQssR3iceHfK0cVJsTaffHLbxR/v8U6fMSqXw20pt
        uHFT0MfKo2Un7dUmESYYwp+U8Fmz
X-Google-Smtp-Source: AAOMgpfTvwJMDGzBleyis/k4eSLNaqfdIZO92ZVtYFhS1RIiQZwK7l2CePdE0ZXb0HfcoBOru4MgRg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr11243241wme.141.1530647046668;
        Tue, 03 Jul 2018 12:44:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b190-v6sm4155199wma.24.2018.07.03.12.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:44:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 2/9] index_has_changes(): avoid assuming operating on the_index
References: <20180603065810.23841-1-newren@gmail.com>
        <20180701012503.14382-1-newren@gmail.com>
        <20180701012503.14382-3-newren@gmail.com>
Date:   Tue, 03 Jul 2018 12:44:05 -0700
In-Reply-To: <20180701012503.14382-3-newren@gmail.com> (Elijah Newren's
        message of "Sat, 30 Jun 2018 18:24:56 -0700")
Message-ID: <xmqq601wqf3u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Modify index_has_changes() to take a struct istate* instead of just
> operating on the_index.  This is only a partial conversion, though,
> because we call do_diff_cache() which implicitly assumes work is to be
> done on the_index.  Ongoing work is being done elsewhere to do the
> remainder of the conversion, and thus is not duplicated here.  Instead,
> a simple check is put in place until that work is complete.

Yeah, that is an unfortunate but necessary compromise until we
create do_diff_index() that can take an istate, and optionally turn
do_diff_cache() into

    #define do_diff_cache(...) do_diff_index(&the_index, ...)

if there are many callers that want to work on the default in-core
istate.
