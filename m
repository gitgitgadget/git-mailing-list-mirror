Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BC7C77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 00:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344680AbjD1At5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbjD1Atr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 20:49:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212B213A
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 17:49:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24704a7bf34so7929172a91.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682642985; x=1685234985;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXjoB6a//8VucABOD8HdQ6Y5ADobIgomXg3tTRX+B9I=;
        b=kvXEnVWwWGYZao/fdrr9pWghl8XotVO+7COZVDtYCb2yKbH4IFZTcNxV8o7LsfOw8W
         nzoZcsA0oA+H4f448MsHvO8OoX/lpblXIBgj/z6iAKXUpgBCD4pH9V24QDLMYJBC8EFr
         BB6wXqV913ms6wcXq8mH+pZbs4c56DIoZLASsUlK3D/zX+ie4wocDDHk5gnw9aQ4MCJV
         IHef1zdoyc3UYEUs5kXK6SqmMNUJSIl8Ldwh4GfyNmUgJJsw1ALx4PJC0+6CxNbfn33l
         QoH5rSDtXukSWxjY6SIWboLZCB9OcxyGl1pkbsW1nyrHx94qUUtTAitOMbcRLgWAFApY
         48tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682642985; x=1685234985;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXjoB6a//8VucABOD8HdQ6Y5ADobIgomXg3tTRX+B9I=;
        b=ZfNFYo2NbeTVeo/A0yO1vn/mRaSjhHJPbJA/DhhqxyKP6NGU70O1s6nqjtiG6NzfXc
         iWhBjbxECBVh5Ay63hFIaKawzI7LtOb05x+2oEGjwkr/Mvefya1iCJqzONV7Gq3QgJZW
         7Sbiz0jRDPqHOq8eQaG2/Beqxy6vb70VxeWmLCBjIv9exma6PVlPX7r7I0ajBViGvEu6
         GFoxY8wUn9Y1JXXvEZavc5kCe6skfAeZbRKonRboRjKVa9RYMdo5Oc6tZBziZmjvi12L
         O6i9KWCB0MHT4KtD4O/xIhAhU0vTCpDpbtA2JDj9VXy+IEmVV4whlapzm1uYsdX/JCll
         Y6Rg==
X-Gm-Message-State: AC+VfDzZSB79j5/T8W169gel30ZGuxB6d2ydtUU6/5gFSeJLo2/dr/39
        N828U4RByyJPukV7K41j4WOPioC8sIs=
X-Google-Smtp-Source: ACHHUZ7VvtHc00dwhMtTS9jbmcxqolAncfjVG24C3ViC0bzJ3eg4P42eXp2rjCBOgZz9uGn1AFk+gQ==
X-Received: by 2002:a17:90a:2ec7:b0:247:1997:6a1f with SMTP id h7-20020a17090a2ec700b0024719976a1fmr4083776pjs.12.1682642985213;
        Thu, 27 Apr 2023 17:49:45 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id ay6-20020a17090b030600b0023fbb21214bsm13725622pjb.17.2023.04.27.17.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 17:49:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] worktree: warn when removing a worktree with orphan
 commits
References: <f702476a-543a-da9b-ccd9-4431c80471e1@gmail.com>
        <1897dff1-bb4d-9715-dd1c-86763c052589@gmail.com>
        <xmqq5y9lc9ep.fsf@gitster.g>
        <51adbbcb-bbfa-58cc-03a4-82809c0c555e@gmail.com>
        <xmqqwn1xnahy.fsf@gitster.g>
        <CAPig+cRm1XaMzgDQZGS8vwpD_k8srQH0NGmziT_J7mtTHnR7OA@mail.gmail.com>
Date:   Thu, 27 Apr 2023 17:49:44 -0700
In-Reply-To: <CAPig+cRm1XaMzgDQZGS8vwpD_k8srQH0NGmziT_J7mtTHnR7OA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 27 Apr 2023 02:16:28 -0400")
Message-ID: <xmqqpm7ohluf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> There may be a misunderstanding here due to the unfortunate
> construction of Rubén's example which muddles together the output of
> `git worktree add` and `git worktree remove`. For clarity, his example
> should probably have been written:
>
>   $ git worktree add test --detach
>   Preparing worktree (detached HEAD 2efe05c)
>   HEAD is now at 2efe05c commit-a
>   $ git worktree remove test
>   HEAD position was 2efe05c commit-a
>
> although showing only the `git worktree remove` command would probably
> have been even clearer.

Ah, you are absolutely right.

My "huh?" against the apparent inconsistency between "checkout" and
"worktree" regarding the order of "this is the end result" vs "this
is what we left behind" does not exist, as "worktree remove" does
not involve being newly on a detached HEAD and it is the one that
may introduce a newly abandoned line of history.  So everything
makes sense.

> Such example output does a good job of arguing in favor of your
> suggestion to use phrasing which is more alarming:
>
>   $ git checkout -
>   Commit 2efe05c "commit-a" left dangling
>   HEAD is now at 7906992 commit-b
>
>   $ git worktree remove test
>   Commit 2efe05c "commit-a" left dangling
>
> (Hopefully someone can come up with better wording than "About to lose
> history leading to" and "Commit ... left dangling", neither of which
> sound quite right.)

Yup, I am obviously worse at phrasing this than you are ;-) We'd
need a good wording that is alarming, even for those who squelch
most of the warning given via the advise system, without becoming
too verbose.

Thanks.
