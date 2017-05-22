Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825CF1FF30
	for <e@80x24.org>; Mon, 22 May 2017 06:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbdEVGRw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 02:17:52 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36656 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdEVGRv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 02:17:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id m17so72006366pfg.3
        for <git@vger.kernel.org>; Sun, 21 May 2017 23:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=34f5eN1GzGHZQ5zqwZLdU/uILA2Nmj9dGUmF5UfYoZ8=;
        b=onEGoNiPKxq1lLnFmRFHqRvK0cBz1/6U4+CH+DXa9IRdiUz86JiwUusL+cijDuYw1i
         5INpskTeaAvkYr45Hn0O1i0zsblJeke/HHxzJIfs1jU1YHzCzjzqQnuz3Cv12ixGD7Lc
         rHvgN+HBJOnOICWgdu/wdN3Ga17x/CHkjJTcyv2HE/NYB0fgrZZcpoS53Ptb3BSroa3J
         bosS5hsm4hojL0kT7U1veyOQW8z7aPEaXOekbHNiCs7TRnrw/9eRJVoBCR+Z7+snP9u8
         0ppaZW5ZGlqFNdDt1gejpa11T2y5mbU85glK93xj0NVunHONQVIQz/Q2NpamOygyx1q6
         KhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=34f5eN1GzGHZQ5zqwZLdU/uILA2Nmj9dGUmF5UfYoZ8=;
        b=PEonX15yvvgx1KgjgDg2yOs1gCyxzxnxOXe8WA+ZTLfExVSArndXaGoesos3XrHF0+
         OZW7fsvKxbD6guo/R0wEVGvHmoQ3gPcz1bu9y7VabIkw02gyWfTgOYC0qMV8OMRkRy+0
         TnlF87R0DeE9ToqlSCBBYENqLRpf3NQMk8i5FvG6YW5boWmaNSRKLFRPTrwEstaBbQlE
         h4nhxkUidP/t4bSfrUwmnsE+4oN7bMZf7vyE7SF09ScMzzHeU4ts9i3IVJ11AEy1oKCB
         /tWJfFOgm1qk1IxpfCOiNS/KDLRi3IfEvorvvBy/QfKE/mOMf8T9ewmE7HTMSB2hE5/C
         5kLA==
X-Gm-Message-State: AODbwcBMlgNh0FLnhlzwN3rxgPHUnKkVHUau329Zud/0sqjdZBK8YW7/
        /00AocOt17bcc7l+ssc=
X-Received: by 10.98.103.87 with SMTP id b84mr24216162pfc.235.1495433870412;
        Sun, 21 May 2017 23:17:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id y20sm23419684pfb.93.2017.05.21.23.17.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 23:17:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] clean: teach clean -d to skip dirs containing ignored files
References: <20170518082154.28643-1-sxlijin@gmail.com>
        <20170516073423.25762-1-sxlijin@gmail.com>
        <20170518082154.28643-7-sxlijin@gmail.com>
        <xmqqtw4do5tf.fsf@gitster.mtv.corp.google.com>
        <CAJZjrdX9BnuxY3tmpswG+yEdDm1+AR8rc5wKGZyVCMp-jP218A@mail.gmail.com>
Date:   Mon, 22 May 2017 15:17:49 +0900
In-Reply-To: <CAJZjrdX9BnuxY3tmpswG+yEdDm1+AR8rc5wKGZyVCMp-jP218A@mail.gmail.com>
        (Samuel Lijin's message of "Mon, 22 May 2017 01:58:53 -0400")
Message-ID: <xmqqk259o1o2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

>> By the way, instead of putting NULL, it may be easier to follow if
>> you used two pointers, src and dst, into dir.entries[], just like
>> you did in your latest version of [PATCH 4/6].  That way, you do not
>> have to change anything in the later loop that walks over elements
>> in the dir.entries[] array.  It would also help the logic easier to
>> follow if the above loop were its own helper function.
>
> Agreed on the helper function. On the src-dst thing: I considered it,
> but I figured another O(n) set of array moves was unnecessary. I guess
> this is one of those cases where premature optimization doesn't make
> sense?

I actually did not mean to give the variables more descriptive names
and preserve the original 'main loop' (namely, not adding the "skip
if NULL" which would never happen in normal case where "-d" is not
used without "-x") as "optimization", whether it is premature or
not.  My suggestions were purely from "wouldn't the resulting code
easier to follow and understand, leading to fewer bugs in the
future?" point of view.

As I said, I am undecided if the result is easier to follow than
your version ;-)
