Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498ABC761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 16:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjDDQZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjDDQZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 12:25:01 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29EE7C
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 09:24:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o11so31841435ple.1
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680625499;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rx2juzGiawqSKZAsNo8mEaR2dCBd48YSVUQESvWJlsM=;
        b=A1Cai3ezyp9B+XvLW4/uzsnfLMOY7bV2ZrHQf9flskcIMEQW7CVGRG0o/iUP5zW+Bl
         mqZuOENe+K5OocoAtU7nxO5NCQhgkxkiJQl4DHRwnyPD+GAWuKAGqFZl6VLdMaytb5JW
         ljvs377kqRNXeJq7vEuyrSqndczKRCWT1RRBG4uBY5Bp3+vW+9WWQuJiPiZ5PQ1fyzKP
         NTiWTToRsD25RUZ77j4JI99j/60PrAMSwutZvcG9QuvbHWFkv0MtmMw3omgB+VOwKmqv
         fvDcoiLuKMSKyaYK+p86sAHAGCG9YUfoESsavjbWVSKS9DXnzAWRLOj7Uuod2hzTYjCI
         RYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625499;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rx2juzGiawqSKZAsNo8mEaR2dCBd48YSVUQESvWJlsM=;
        b=HQI412eYHRBTzLp/mv+kGFkrsj8PqJb9+cki0XcEAonx6EYwcIiT8sCrbsad7xZeIk
         tFJw47Cu+N5cG4UFmCdE72+f8HTOe+E16kGPuQ8yW6sv/48uhwPZxdn7B7DSR2lyPZw3
         76nrJv/1SiXTvUo1hMBjcsEuZ8qdGNQRvvSipLgDpNbHxQ0BMt+tkL5XLeupQohxm1Ci
         dGdWuVwegswmbd/Ob4RDI4/kYPdRMfkWMaNq4l0SzGl+kgCHTZwhVLD8h+OlKcZFtYhw
         rUUrYpQFX1LG+Dpkb4S0DopahPhWRuSDtrkLr69p3zINEaL9FEXp7+rv9zgQlLlhT0wv
         bL4A==
X-Gm-Message-State: AAQBX9c2yn96KbVpsSu/tzdhq6KOZsTl4KsPh2RTZkzlmGYVg6CNEsHv
        EcO2rtDJ1N3+bJ7lFl+hcGY=
X-Google-Smtp-Source: AKy350aajAqseMls2Sq4T/mxSPsTpWyskqq5aDKRr3cXN51ONIsZKE2OVdul/3yTU8dNUxQMaKtdvw==
X-Received: by 2002:a17:903:24e:b0:1a2:17b1:71b with SMTP id j14-20020a170903024e00b001a217b1071bmr3371383plh.66.1680625499248;
        Tue, 04 Apr 2023 09:24:59 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902ed0b00b001a22d274045sm8593986pld.144.2023.04.04.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:24:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Clement Mabileau <mabileau.clement@gmail.com>
Cc:     ClementMabileau via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] branch: improve error log on branch not found by
 checking remotes refs
References: <pull.1476.git.git.1679478126.gitgitgadget@gmail.com>
        <pull.1476.v2.git.git.1679515402379.gitgitgadget@gmail.com>
        <xmqq355wctjq.fsf@gitster.g>
        <cffce108-c39d-f13f-9fb6-60624f7e7cea@gmail.com>
        <ff7bb1f4-e35a-66ad-1116-6bb2b906fed3@gmail.com>
Date:   Tue, 04 Apr 2023 09:24:58 -0700
In-Reply-To: <ff7bb1f4-e35a-66ad-1116-6bb2b906fed3@gmail.com> (Clement
        Mabileau's message of "Tue, 4 Apr 2023 15:30:33 +0200")
Message-ID: <xmqqmt3n1up1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clement Mabileau <mabileau.clement@gmail.com> writes:

>> Now I hope you'll understand why I suggested this patch. Maybe I'm the
>> only one that ended up in this situation, in this case I'd understand
>> that you would no longer be interested in the patch!
>> However if you still are, I'll be happy to make the modification you
>> asked for.

I do not think I made any request to change anything, other than
what procedurally is necessary in order to record the authorship in
the resulting commit correctly.  I did question why the new behaviour
was an improvement and your response helped me understand the
motivation better.

> Well, it would be nice to have an answer in order to know if I should
> abandon this patch or not :)

Ah, sorry, I didn't get your response as a conditional "if you like
it, I'll work on it further", as we usually take "how deeply does
the original proposer of a change believes in it" as a strong hint
when we need to decide if it is something worth pursuing [*1*].  I
am not so enthused to drop everything else and invest 100% of my
time and attention to this change, but I am not opposed to the
change being proposed, either.  We haven't seen anybody other than
us two to speak on the review discussion thread of the previous
round, so I do not know about other developers and users.

The usual next step by the author is

 * Update and resend the patch(es), taking care of not just
   correctness of the code but also making sure that the proposed
   log message reduces the need for those questions asked during the
   review of the previous round [*2*].

 * Wait to see other people who find the change favorable.

 * After that, the patch may be picked up, advance to 'next' and
   then to a future release.

but the author can abandon it at any step.  After all it is author's
itch and all we can do here on the list is to give encouragement and
help in polishing it.

Thanks.


[Footnote]

*1* We do not take it very kindly when somebody says "I am dreaming
    this and that change, I think it would be great, and if you
    promise it will be included in the next version of Git, I'll
    work on it", and respond with "We do not know how good your
    change will be until we see it." plus "If a change is so great,
    we expect you would work on it even only for yourself,its
    greatness will spread by word of the mouth, many people will
    yearn for it, and eventually we would come to you begging."  A
    change, in which even the original author does not feel it is
    worth their time to invest to perfect, has much less chance to
    be successful.

*2* Reviews on the previous round may have asked "why is this change
    needed?" "what is the intended use case?" etc.  The proposed log
    message is the place to explain these.  The goal is to make it
    easier for future readers of "git log" to understand so that
    they do not need to ask these questions (unlike reviewers who
    can ask and get answers from the author of the patch, they do
    not have anybody to ask because the author of the patch may not
    be around forever).
