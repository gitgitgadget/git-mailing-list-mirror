Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A5C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69C6613D9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFJOOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:14:53 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43523 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhFJOOw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:14:52 -0400
Received: by mail-ot1-f52.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso27597831otu.10
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EI/4yt9kCybngGxWbW3ut92JavCNtzsQ3Eq0x8clkwQ=;
        b=cPU2YJ/fXBmYo9f9eWGB2EcFOd0z3zC90Kpr3s4/DcvxfUwUxwh5aPOvqJJpb81A8g
         4dHWy9yceIW+dosnNbHsIW8qkHJTFUCQDTSek29qYC4gllm0LcaMSRuW88AX2QMRH9pu
         qMu3FQ3OP2oH7shrFVxEfKYdFP+CGIY2olmkUU8tEAKCOmndwqYxc1W3d2S/nZxFeQyw
         xi9DSs1DeBABK0OYg7ekI0e5JKDmjlHKHYREH6DCgL+R2YJl2VmrkSiBTl/hh9QQqsJK
         5UJ1yT5bwCqF52wSmRV8q61RouB7c8dCWFNVSB5i+cOD0qDK72mivYEvD5/C+1La/EXz
         hkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EI/4yt9kCybngGxWbW3ut92JavCNtzsQ3Eq0x8clkwQ=;
        b=gLaNqNAH0Vc8wnODIWD994gB/eZeTXkeqhCQitRKdGYZg4z77hWcs0pVo4Adg9//EB
         cTIiu47fFUKmsQuWoioYe8KJltvZ5u5vfiAcqwhfJC2suljiVLewxCDqcASkgHkqn5D2
         F10ZewUTHWvkIAWGjBE08ge442XRBzL1UnW1Xl/2HPIQ1fYU3WlZLcEohAHaMSkVFpDl
         S8LFq2/cHfflCRfzqfutCOw3Z4jzuDI/Olhhg9suW+sYIohn7Pj67Em1ZNr4VVr6yKlv
         hKNDp8kc6LO5WWqZPesbD+BcoWektGXeb+kbbyd+cdDkue6MQ/KtzODTUeRnvCfAKiJY
         /PqQ==
X-Gm-Message-State: AOAM530xZ+DQqSQywmztAsm8tqXp6b5NHlVUNbTM/FYHp9q10OiUyA+E
        lO2hC/BIwIu3GfcMewbgSQ4=
X-Google-Smtp-Source: ABdhPJx+9eCxCAwZIlDVwlVywcr9o69mkE41TppUku4GYC16dUmTyQ0aBwU4y7F77l3KCLgZ7t6xyw==
X-Received: by 2002:a9d:a78:: with SMTP id 111mr846583otg.93.1623334302569;
        Thu, 10 Jun 2021 07:11:42 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id e29sm564834oiy.53.2021.06.10.07.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:11:42 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:11:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c21d9ce8848_b25b120884@natae.notmuch>
In-Reply-To: <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-5-felipe.contreras@gmail.com>
 <b4b9264d-1c17-1a62-f0ec-2791ab20adeb@gmail.com>
Subject: Re: [PATCH 4/7] checkout: fix merge.conflictstyle handling
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> On 09/06/2021 20:28, Felipe Contreras wrote:
> > Currently both merge.conflictStyle and `git commit --merge
> > --conflict=diff3` don't work together, since the former wrongly
> > overrides the later.
> > 
> > The way merge configurations are handled is not correct.
> > It should be possible to do git_config(merge_recursive_config, ...) just
> > like we can with git_diff_basic_config and others.
> 
> It would be helpful to explain what the problem with 
> merge_recursive_config() actually is rather than just saying "it should 
> be possible ..."

The problem is that you can't do this:

  git_config(merge_recursive_config, NULL);

As it was explained.

That is the problem. I don't know how that's not clear.

> > Therefore builtins like `git merge` can't call this function at the
> > right time.
>  >
> > We shuffle the functions a little bit so at least merge_recursive_config
> > doesn't call git_xmerge_config directly and thus override previous
> > configurations.
> 
> Rather than papering of the problem, how difficult would it be to add a 
> field to ll_merge_options and pass the conflict style with that rather 
> than fiddling with the order that we set a global variable.

Probably not that difficult, but then we also need a parser that
converts from "diff3" to whatever values we decide in that new field. We
would need a new parse_config_conflict_style() function.

And that function will be only used by `git checkout` and nothing else.
So I don't think there's much value in it.

That problem whoever, is orthogonal to this series.

> Does this change affect 'am/apply -3'? - Do they still read the config 
> setting properly?

Good question. I'll have to add more tests to make sure that works
properly.

Cheers.

-- 
Felipe Contreras
