Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9237DC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 19:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiJFTaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiJFTaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 15:30:11 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D34F9B841
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 12:30:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso5241191pjf.5
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 12:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCmZhTuhPjHvEn3+Y+o0lG5dHtwIJTaibu+bxYc6MEE=;
        b=VuVn0XfhzHUuddlOM6gC0W5j4lENySoxqi6u3tOJeVyuM33w9CFyLpq8LaZZCDwvpH
         yn0fvPZ3/DWwOMZBsBr6pOws9Gy8gJsTnint3OTfXoU1UwTV9kHD+WQbfCJQT62V7ZV1
         Mt/jgdYCWEt+JfRNav45MeqaMkNL4pp7r9fdY1iMYNOryHQjSIOIuY530/Q4X3jpVnqv
         xG5LDvmvk1LRF8PAefdSuTf4U3oRuZ5S4+56qLZZ2ebcv16FVxTkCFlK4249DEmI8mxC
         OToUN+OwAo/Rzyn8mOc1gHa5lgHmXELXiaEEQP5HqFYU/Rw2YJNIY9cxV5Nf+9hE2p/I
         M/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HCmZhTuhPjHvEn3+Y+o0lG5dHtwIJTaibu+bxYc6MEE=;
        b=BPrrjRLRL7A55x6s+AB4WPmWg0vrL7g15228YcbEsEmF9+cP3yfqTG3fx1xOZDJ4vX
         ZZS+T09C9Lg1B2+imGaTvXT+I6tG2lVLUIEefWBGV2JATokdqnvJka/q8eDo6b7n+TQn
         o6HoedP6GE7Bz+MigwRMaQCBTczsAFwWv4TTYQK54hW3pW2V741jzQFF2gLYjdGMGceP
         VozGYQktZ5uxCFUE8VWVZDhKDXizIo81Co04DOk/onPplnEw5AaplqcHYvEGkZr6wvmh
         z1kNGYL7pXw5X5rpOmBak3B7teRlrBEJHMivSkR/u9vssgvUHLf73fNbKcJnqokRJGog
         prXQ==
X-Gm-Message-State: ACrzQf2FkIUcB4wHUKB6KoQ1G/VtdW57lzjJVLahnR2wGEWB4U7WcOuI
        nTgW9sRPTPUwzhXkVWlmbbc=
X-Google-Smtp-Source: AMsMyM4IOYn2875agBmHMaUoPUqLPd3jjKSdkHVNgpUgJhJ/pg3lbhLfUdt9VRgpwn5+e6VvV/FmCg==
X-Received: by 2002:a17:90b:4c10:b0:203:bef9:987b with SMTP id na16-20020a17090b4c1000b00203bef9987bmr1267079pjb.9.1665084608377;
        Thu, 06 Oct 2022 12:30:08 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001785a72d285sm636plb.48.2022.10.06.12.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:30:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Martin von Zweigbergk <martinvonz@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: Bug report: `git restore --source --staged` deals poorly with
 sparse-checkout
References: <kl6l35c4mukf.fsf@chooglen-macbookpro.roam.corp.google.com>
        <54ee4a2a-1937-8640-9297-8ad1516596cc@github.com>
        <CAESOdVAh68HoQoyicfZn4XbjGfiRFCu1zFQmUjMcSAg3tUzr4Q@mail.gmail.com>
        <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com>
Date:   Thu, 06 Oct 2022 12:30:07 -0700
In-Reply-To: <96c4f52e-bc66-f4ee-f4f6-d22da579858e@github.com> (Victoria Dye's
        message of "Tue, 4 Oct 2022 13:34:59 -0700")
Message-ID: <xmqqv8owkaww.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> Restoring only into the index (as I think `git restore --staged` is supposed
>> to do) is weird. 
>
> 'git restore --staged' is intended to restore to both the worktree and index
> (per 183fb44fd2 (restore: add --worktree and --staged, 2019-04-25)). The bug
> you've identified is that it's not restoring to the worktree.

I think you misread 183fb44fd2, which says --staged is to restore
the contents in the index and --worktree is to restore the contents
in the working tree, and both of them can be used at the same time
to affect both destinations.  As gitcli(7) says, --staged here is a
synonym to --cached here and should not touch the working tree.

Having needless synonym may be a source of confusion, so we may want
to straighten out the UI a bit around here, but that is a separate
topic.

Thanks.
