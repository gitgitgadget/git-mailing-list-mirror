Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5160AC05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 16:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjATQf7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjATQf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 11:35:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A745917E9
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:35:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso5422089pjf.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 08:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHTz4LlqjTVzKu64MNle3KauxlHJ9RsdUQIIYkyfJwU=;
        b=i9x6PnAmcjHKdWuFWrYI3+8vCZe5X1J++Ue9JVijfT/1QDKawgK/cosfBrwlgYWkOA
         ppRWd3XlOMMY/4XpU4dSfSbPHzh3gIS52aJdh+ltCnT8zbZ+4K75Xdo9/cim7lQscwlV
         Arx80jWomKGejYIzHm6f9DOQxb3ALgJI9igjfkQLrmDakAqtRpzlLuJXJzzhjNTfGJ1f
         QWXpAcV71AXQfxi7RrLJ2T6KdwG8mzue6ucsTpSj49cgrobVBpK/A6wdCHMiFKpRKD5B
         LKCaHERK0c0ZfzHdi0EaBG3Aw0nqOn2qOy/pxWV4+ZaNYenx8LwTPOyMcYkhrl8g6jgL
         ilOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZHTz4LlqjTVzKu64MNle3KauxlHJ9RsdUQIIYkyfJwU=;
        b=zE8K5Tht/63gevzLa0bi9taWvIFzATzllk8NP6G1tD/pPkziNFGK9mMk5ZtSnSdrci
         6bylWMJs+HNVFIU9zE66WspQcWSRH/ap9Dn0DAEszxBp0RDXHSpNLjanOkksTLhCiXii
         MAGecVwFTlVg0nD4M/eC6ZkDew4HefXSXx+FU11qD8bEtebVvTsC5EUm80RKNJmHdNfS
         Pf1nnRSOB4qu0faCHcfMF5cskNdobDv0N3kJHCRz0oYxmMM1+a7Gq2hp+SgqO9XB6dHM
         Fjckto/YI/qYt0xF2msXHPbYMFCCnBM/qT2P5vtp2fiTzFwHfInekjONoVlreDcx9xaH
         U54w==
X-Gm-Message-State: AFqh2konYdfoElkD3QdUB3VVx69xZWXmI84uQpsMWxUnjhuiaGbFv9Nz
        Zuta/uPY+cAvc0mKEqLWe1U=
X-Google-Smtp-Source: AMrXdXscvBt+Yi/T55F8Y5z+stUTDrgPNvrGJwdWkiKux4BHYmIUMatlNq64xe1LtabKO2gHyIdhCA==
X-Received: by 2002:a17:90a:7182:b0:229:19f7:a60d with SMTP id i2-20020a17090a718200b0022919f7a60dmr16852067pjk.0.1674232488412;
        Fri, 20 Jan 2023 08:34:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a16c800b00218a7808ec9sm1742479pje.8.2023.01.20.08.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:34:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
        <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
        <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
        <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
Date:   Fri, 20 Jan 2023 08:34:47 -0800
In-Reply-To: <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 19 Jan 2023 21:30:19 -0800")
Message-ID: <xmqqcz79xizc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jan 19, 2023 at 9:34 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: ZheNing Hu <adlternative@gmail.com>
>>
>> Because sometimes we want to check if the files in the
>> index match the sparse specification, so introduce
>> "%(skipworktree)" atom to git ls-files `--format` option.
>> When we use this option, if the file match the sparse
>> specification, it will output "1", otherwise, output
>> empty string "".
>
> Why is that output format useful?  It seems like it'll just lead to
> bugs, or someone re-implementing the same field with a different name
> to make it useful in the future.  In particular, if there are multiple
> boolean fields and someone specifies e.g.
>    git ls-files --format="%(path) %(skipworktree) %(intentToAdd)"
> and both boolean fields are displayed the same way (either a "1" or a
> blank string), and we see something like:
>    foo.c 1
>    bar.c 1
> Then how do we know if foo.c and bar.c are SKIP_WORKTREE or
> INTENT_TO_ADD?  The "1" could have come from either field.

Perhaps it becomes useful in conjunction with %(if) and friends,
when they become avaiable?

Until then, I agree that the output format looks pretty klunky.
The calling scripts still can do

	--format='%(path) A=%(A) B=%(B) C=%(C)'

and take an empty value as false, though.
