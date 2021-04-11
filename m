Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622FC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BE360240
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 18:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhDKSEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 14:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhDKSEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 14:04:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98893C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 11:04:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l14so9645562ljb.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dvbk/JFcn3JLa7zqah2RAgoD3cZs+02uMX3Y9n1cfsU=;
        b=ov4Qk42AhpOV3TxOJ8IYFwezdFLvWLRkQM9KK/homVSVikTE7bQpA8RsqqOB1INH2P
         tEqu8PT9LvAsr5DEQpgof6Yd1BcqpI605MAcwTUEvdgu7MO6TXl6vR2lzyA/RLFOjtKk
         r0qsUFeEDASy5+xl+AYW8VzQsQOJggmxUUvkGS4MnUtjvSUN7pPn0WKB/buTRDEHe32M
         ZQKYMRTIzJbUulLT1nKpvnPKi5mV3/Evifeizxq85rUNIfFnu3lMT/5Phef7JD3Tds80
         tCE6WpexGzirLbOo/awqtyhhPJHl0+cEwxleQ4PHlicfpCYghRW7K2fE/wzuvZ+d6lvA
         RLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=dvbk/JFcn3JLa7zqah2RAgoD3cZs+02uMX3Y9n1cfsU=;
        b=h6CS69sUiReIqKtvre/Tybn45p6ea9iwKbIfWJWWIOniSXhFYdo6SqDd9u43tSX/0+
         +Xkr9U/wXOewquAslF+Ba8Yu1/jvufmKnde6xKj/c3mJmUAzX6opbwEh9xEL8ocHxHWU
         MGTOidKb6S0jeE4AefOxn74/WyCEgpGLBN2S2kqZ/BFwhYF+gzVilcHeSv1mCfXQDrCy
         cQN5lvGwccRD4l8hgVc1pVArJF/G8IVO3G6o+0SMMJr2rjHysjkInSFb7sCuZG1Nuquz
         mQxuFqxw+V5iqUW3Uqz1P0XPPaai5ZW36cEWoWPvGbW+47Hr/3FCmN/tCpbsWdE5Q57k
         tKYQ==
X-Gm-Message-State: AOAM5330NW7/BjJCIURhOvQKm+vxi8fkBbS8ya6UvcK3ZEEoaVbxP5OO
        JtcRy7EEcwOxJEccjqRKKTcoW9c06Ow=
X-Google-Smtp-Source: ABdhPJwHew7YZ7hV2eWaiGJVccJ7/KrK84lnJS23hcoPwHK2TdD2nMyCQKE2f82oE6NSgYTx94//jw==
X-Received: by 2002:a2e:9785:: with SMTP id y5mr1565292lji.56.1618164272309;
        Sun, 11 Apr 2021 11:04:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m1sm1682828lfu.206.2021.04.11.11.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 11:04:31 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 0/5] git log: configurable default format for merge
 diffs
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210410171657.20159-1-sorganov@gmail.com>
        <xmqqsg3whka6.fsf@gitster.g>
Date:   Sun, 11 Apr 2021 21:04:30 +0300
In-Reply-To: <xmqqsg3whka6.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        11 Apr 2021 09:13:05 -0700")
Message-ID: <87wnt84s0h.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> These patches introduce capability to configure the default format of
>> output of diffs for merge commits by means of new log.diffMerges
>> configuration variable. The default format is then used by -m,
>> --diff-merges=m, and new --diff-merges=default options.
>>
>> In particular,
>>
>>   git config log.diffMerges first-parent
>>
>> will change -m option format from "separate" to "first-parent" that
>> will in turn cause, say,
>>
>>   git show -m <merge_commit>
>>
>> to output diff to the first parent only, instead of appending
>> typically large and surprising diff to the second parent at the end of
>> the output.
>
> I think that it is a good goal to free a short-and-sweet "-m" from
> getting tied forever to the current "two-tree diff for each of the
> parent" (aka "separate"), and a configuration to change what the
> "-m" option means would be a good approach to do so.  It would help
> the interactive use by human end-users, which is the point of having
> short-and-sweet options.  Existing scripts may depend on the current
> behaviour, so the configuration cannot be introduced right away, but
> over time they can be migrated to use the longer and more explicit
> option "--diff-merges=separate".

Yep, that's exactly the plan I have in mind.

To tell the truth, I hope there are no scripts that use "git log -m -p",
or "git show -m", but I do want to be on the safe side with it anyway,
and then sometime in the future maybe we will be safe to change
configuration default.

>
> But I do not see much point in adding the "--diff-merges=default".
> Who is the target audience?  Certainly not scripts that want to
> avoid depending on the 'default' that can be different and easily
> vary per user.

There are 2 reasons to have "default":

1. --diff-merges=default and -m are not exact synonyms: unlike -m,
--diff-merges=default (similar to other --diff-merges options)
immediately enables diff output for merges, without -p, thus, for
example, allowing to output diffs for merge commits only.

The exact synonyms are rather --diff-merges=m and --diff-merges=default,
and then we get to the next reason:

2. We have descriptive long name for every other option, and it'd be an
exception if we'd have none for --diff-merges=m. In fact, it's
--diff-merges=m that could have been removed, but it'd break resemblance
with --cc and -c that both do have their --diff-merges=cc and
--diff-merges=c counterparts.

Overall, having "default" has both functional and consistency merits.

> Or is the plan to deprecate and remove the short-and-sweet "-m"
> option and standardize on "--diff-merges=<style>"?  If so, such a
> design makes sense from pureness and completeness standpoint, but I
> am not sure if that is a good design for practical use.

No, what I have in mind is resurrection of -m as more useful option, not
removing it.

Thanks,
-- Sergey Organov
