Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A466C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6898320771
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBXFZFBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKTex (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTew (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:34:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800E1C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 12:34:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id t6so14842911ljk.9
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 12:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VY33CubYTCd5qDqxqOz71vrqmoW09ygQCreuwCav0RU=;
        b=IBXFZFBOQW5K0Dqn2XBQY6w1V3pNOCM28b7rCg4YhZtprOpV4C4sf0sY7EyjoliFGF
         NK2HE/zBqkwB22+4PWK2FzsDsvPpB5/oA0tbPlvxVBF7Oj65kNhPYOkitEvagtK93uEK
         LdkaAGT+Cni6JMSRTIesR19pFdsUXb3tM7j9lqNfdwcaeT78K6cmaf3LXJOaMszw8gk4
         zMSy8kXxe1C+nV/HpwK93h1aYQaW1Ndn+hgd8Q3vEc9J6+oz9OS5TPNaYqgV2Yq4/kPM
         zyLp4JNFD4mlitwoG9UqiS7PVZDBNq7BbV1Bz5kVoCE2l7QAyWktuKu7cwe3vLMv1GiD
         Sxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=VY33CubYTCd5qDqxqOz71vrqmoW09ygQCreuwCav0RU=;
        b=OGaFl0gdjRYM2/aIzRN5MKuTjP342Txaz0zgD8P0+4pLtQUihAEQT0CNIOmbOolc1A
         civWaKOk4+FiBHEqhGOEmc3xwfdyQBOnpY/R1RNYAuQ8uF1uhEuYN0+Y4KhEnvODcJxq
         Km6xDN3OzfXE9E0JOAKwGUHTPyfUQ8M676HaoSTiUfB5Eb+yDMYNZnRSLL1S+Zg8/7i3
         rwFgGvAhHOxE7fzGH5/KYq/u4jjeutLNjQ/ZXnHFhw0U0sBVWAwiOJRRbDFYn/vCSYem
         kSGmVVg4olf4OWEMHiWH08QQe2Ah2hcEREBDOSyHB0OptgrJLRzxahwhxS+cbX04tp/g
         phvQ==
X-Gm-Message-State: AOAM533wB7TijD6Vbq4+9Kv1y4ca7yvlewti4GoWGQLE888juypjuaIv
        FxMvnoD6FsFhaQqPDdl9v3FsYQPS
X-Google-Smtp-Source: ABdhPJx6O/ngreFIrWsjKkzosc53+7w6FxZBpvsWx5nfCqlQ/80aYVSKzfZg8NMOi692HWjNtP5LMg==
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr3263564ljj.401.1597174490582;
        Tue, 11 Aug 2020 12:34:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j66sm11870217lfd.74.2020.08.11.12.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 12:34:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #02; Mon, 10)
References: <xmqqsgcub811.fsf@gitster.c.googlers.com>
        <874kp9biho.fsf@osv.gnss.ru> <xmqq7du59eb4.fsf@gitster.c.googlers.com>
Date:   Tue, 11 Aug 2020 22:34:48 +0300
In-Reply-To: <xmqq7du59eb4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Aug 2020 12:23:59 -0700")
Message-ID: <87364t563r.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> [...]
>>
>>> * jk/log-fp-implies-m (2020-07-29) 7 commits
>>>   (merged to 'next' on 2020-08-03 at 39fefa6b82)
>>>  + doc/git-log: clarify handling of merge commit diffs
>>>  + doc/git-log: move "-t" into diff-options list
>>>  + doc/git-log: drop "-r" diff option
>>>  + doc/git-log: move "Diff Formatting" from rev-list-options
>>>  + log: enable "-m" automatically with "--first-parent"
>>>  + revision: add "--no-diff-merges" option to counteract "-m"
>>>  + log: drop "--cc implies -m" logic
>>>
>>>  Originally merged to 'next' on 2020-08-01
>>>
>>>  "git log --first-parent -p" showed patches only for single-parent
>>>  commits on the first-parent chain; the "--first-parent" option has
>>>  been made to imply "-m".  Use "--no-diff-merges" to restore the
>>>  previous behaviour to omit patches for merge commits.
>>>
>>>  On hold a bit.
>>>  cf. <20200804200018.GB2014743@coredump.intra.peff.net>
>>
>> I believe I've submitted resolution for that.
>>
>> <20200805220832.3800-1-sorganov@gmail.com>
>>
>> Do you expect anything from me to push all this further?
>
> I was waiting for a reroll of the "resolution" with just one extra
> test I mentioned in <xmqq3650n2rc.fsf@gitster.c.googlers.com> in the
> thread.  With that everything would be good to go, I would think.

And I asked you to postpone that in <875z9v7b0k.fsf@osv.gnss.ru> for
which I got no answer. I repeat it here for convenience:

"
For now, can we leave these patches as-is and then add additional tests
on top, please? I'm afraid that adding them now will force me to rewrite
current descriptions, as the result won't be minimal anymore, and I
feel uneasy about writing commit messages for these permuted tests
anyway.
"

Thanks,
-- Sergey
