Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEE9C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EBD6120D
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 09:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhGTI1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhGTIZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 04:25:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B138EC0613E3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 02:04:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id h4so28895430ljo.6
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 02:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WPGtAZNcw8LUnQS525FVePg+eM6QAblgUXwdl7/piJA=;
        b=ENkOKFKMq50SV6LaJuaYuOFY3LO1FFf8VOfgQIuVHe9ILe+kKsdW2szYmt1y6lh0YK
         5XGLzrVcAtliOodeK60K7CFnHT6/0eflsaeMD/84o7Oumzh1QYd1uQNWqtmAY41NtyiY
         1eMcmzm27ozxxxjcBBMzeCG/162T0B0FhDX4U2KxKe+VUa1iPD1rzASUi/qW41/HuypM
         qyOeuRvR7SSTT7d/HxkJoD2uvIZatbir3zs7NhvwAo5Vnn76hquOoJcPpJkvrbJ3LYN5
         0dlHauDsdMm/e+BbrroTMJ6+aw9nR+AKwmDA47+8AAdUE1qt6EbrqiLKotZ5cE1dCcMI
         Skow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WPGtAZNcw8LUnQS525FVePg+eM6QAblgUXwdl7/piJA=;
        b=J0UnBeJKIdDcp/466rf8U1HA0KjKw8afmR2+5CwOqlKUPTAD8idx86q0sjxwKVlAv/
         P+dZttu0z/u4kcZSYjYXizJYSFx38On6ckjVuxgQ+2I9Hm6ZZem9xbgucxIMyMdcG6SA
         diFZXWGDpmgN/ZoUu3E6thnJaA1tt1zM3MB32/gB/7GJWtv4hHW9R4BUc5//x5a2udP2
         E+pLD2ZV56XmFhzVf8xrbOb5ytMwT0tXHASiMW9wUUcvkrcl2wGzU1opVXTHUJ+m75le
         AH0MDYZyHP/QDb/INkaqZbzGoIta2abCn5dxx9x50sa5CnK4q5XvJWrMeY35G4Hsj6nI
         zzMA==
X-Gm-Message-State: AOAM530cPE97uL+9gCjQjsZEuuVS6cEvHxDTEdv91/tg/HKIBVQvTrFa
        9By/h0o9EvRmldE9avjDbmXNjJKFpW0=
X-Google-Smtp-Source: ABdhPJwUVpLlIz/NG7syVKBMxVQmv0kLBQfUAlFzfCHWrgi/EYv9eBBfbbLgSkny7e+CCDBhFtcoTg==
X-Received: by 2002:a2e:a808:: with SMTP id l8mr26156010ljq.355.1626771857709;
        Tue, 20 Jul 2021 02:04:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q13sm1476841lfu.272.2021.07.20.02.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:04:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andy Zhang <zhgdrx@gmail.com>, git@vger.kernel.org
Subject: Re: why "git rebase" searching the duplicate patches in <upstream
 branch> rather than in <new base branch>?
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
        <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
        <xmqqmtqij63t.fsf@gitster.g>
Date:   Tue, 20 Jul 2021 12:04:15 +0300
In-Reply-To: <xmqqmtqij63t.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        19 Jul 2021 15:23:18 -0700")
Message-ID: <87a6mhgxv4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Andy Zhang <zhgdrx@gmail.com> writes:
>
>> why "git rebase" searching the duplicate patches in <upstream
>> branch> rather than in <new base branch>?
>>
>> hi, all:
>>
>>  I am reading the help of "git rebase", it says:
>>     "If the upstream branch already contains a change you have made
>> (e.g., because you mailed a patch which was applied upstream), then
>> that commit will be skipped. "
>>
>>  But, because we are applying commits to <new base branch> rather than
>> to <upstream branch>, I really don't understand why we are searching
>> the duplicate patches in <upstream branch> rather than in <new base
>> branch>?
>
> It is either a design bug or a documentation bug, or both ;-)

It's definitely /at least/ a documentation bug, as description of the
feature is not precise enough. For example, it's unclear if such a
commit will appear in the todo list of --interactive. Will it?

It looks like documentation of "git rebase" should be revised to make
clearer distinction between <branch>, <upstream>, and <newbase>.

>
> I do think it makes sense to skip commits from the branch we are
> rebasing that have equivalent commits in the upstream, as it is
> expected that upstream might have already applied/cherry-picked some
> of the changes you are rebasing, and you do not want to use the same
> change twice.

To me this only makes sense for the branch we rebase /onto/, and thus it
actually makes sense for <newbase>, and for <upstream> it only happens
to make sense by default as <newbase>=<upstream> in this case.

If Git currently indeed searches for duplicates in <upstream>, then it
looks like implementation bug, or misfeature. I think the <newbase>
should rather be used.

>
> When we are transplanting a series of commits from an old base to
> totally unrelated base using the --onto option, e.g. when replaying
> the contents of 'topic' relative to 'next' down to 'master' in your
> topology, however,
>
>> Old tree is:
>>
>> o---o---o---o---o  master
>>     \
>>      o---o---o---o---o  next
>>                       \
>>                        o---o---o  topic
>
> it is not necessarily obvious where to stop digging back at.

Similar problem should exist for explicitly specified <upstream> that
might happen to have little in common with the current <branch>, right?
If so, then it's already somehow being solved, even if simply by
ignoring the issue, so adding <newbase> to the picture doesn't actually
bring anything significantly new.

> In the
> above picture where 'master' and 'next' have ancestry relationship,
> we could try to see if the three commits on 'topic' branch being
> replayed match any of the commits in next..master range, but when
> using the --onto option, there does not have to be any relationship
> between the <upstream> and <new base> (they do not have to share a
> root commit).  So from that point of view, it probably makes sense
> to default to --no-reapply-cherry-picks when --onto is used, while
> defaulting --reapply-cherry-picks when --onto is not used.

I don't actually like this.

First, in general, changing default of another option is not to be taken
lightly. For example, defaulting to --fork-point when no <upstream> is
specified is already a point of confusion.

Second, changing the default is not backward compatible, so there should
be very sound reason to change it.

Finally, if user does specify /both/ --onto and
--no-reapply-cherry-picks, where would Git supposedly stop digging for
matching cherry-picks? Provided this is to be solved anyway, the
rationale to change the default does not sound strong enough.

Overall, it seems that we should take the <newbase> rather than
<upstream> (that is still <upstream> when --onto is not specified), and
apply the skipping logic from there, to whatever depth the merge-base
will give us. If it's already implemented this way, then only the manual
page needs to be fixed.

Thanks,
-- 
Sergey Organov
