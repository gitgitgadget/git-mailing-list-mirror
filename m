Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31856C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96242177B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH2dJBvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgIHTXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgIHQBa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:01:30 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343E4C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 09:00:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z18so4525723qvp.6
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OfqEBlk+Xu/3J0EqDF+zZuNiLo8HxViiCQv6/+I1m8M=;
        b=XH2dJBvo6h1JLDVTZ5eJXkRv0/9WzwISG6n9ZNhWIwmHsLppcpxX+Y0fxY0e8sPXsu
         SCETnHHAgjD5V/f4XvuFssgo18K6Rfdav7TTJDaDtje135ZsaiSoy4w0DqxXcp7aeNy7
         udLbOmqZRml9AOM0LwxZFUguYgtJbfAjQOZckIDFbB14uZpQFl6uFo5Uull/Xl4aeCXO
         aNltkGm5QTXGrE16OArnqEVko3KqrWlh5JcuFatukQHJG44ukV6pxo5MiNQ+HkC/8p7p
         NKM/gOzc2Hlk7aa7oZ/MQyfNJI2+rmvOIcJdAk0B98W1/0AEVS1Ua9DSXL/TSr3byUS1
         H1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OfqEBlk+Xu/3J0EqDF+zZuNiLo8HxViiCQv6/+I1m8M=;
        b=JQatmltblprhcXfpRm11su3mvmzYlPOCg4lvn+c/pz/8J/s6229RU8+SiMnaUSoQh+
         XqRO6NRDDCQU7LZ/vU4k0IXaikzqieT611miH8zQU1pqpjtkpHaWyQLdq3etSaRb8Etg
         sFZs/61tc6Y5fSeEG11yxr2+La3DwcwrDdXruoFDkNajcQ9pR8DGTYfFOCndwT96qvV1
         fRWjoisFMH5MN3OvkA2junwbFB2cUaAIf4Zo8H+AuHuoAkFf2E+jbaGXHJv++wZRvvV9
         tcJTciRBNS0K9ozZXVUiNJ/gVEw6ibFumKuWA0ik4oCUDx5265BS0aPgtBHcUXqUi8YQ
         gldQ==
X-Gm-Message-State: AOAM530Fvtpuc0J+Ym+cF2SPbaeylQCA4mK1fCmfTZR12AcEQrSwpLC3
        NW9YQB3ThypjxFoZlHpQwq9DT9O1Oa9kgw==
X-Google-Smtp-Source: ABdhPJyKph23iQK9pa4gB0BUiWd7VMy4mU8skTEO6YH0vLOzZPCNhh9cqP7rfGdmZWetJloc8QS94g==
X-Received: by 2002:a0c:b21b:: with SMTP id x27mr786456qvd.12.1599580828214;
        Tue, 08 Sep 2020 09:00:28 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.105.42])
        by smtp.gmail.com with ESMTPSA id c40sm15501292qtb.72.2020.09.08.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:00:27 -0700 (PDT)
Date:   Tue, 8 Sep 2020 21:30:21 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200908160021.GB40807@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <xmqqmu211s43.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmu211s43.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
Thanks for taking the time to review this patch.

On 09/07/2020 09:14, Junio C Hamano wrote:
>> The `--force-with-lease` option in `git-push`, makes sure that
>> refs on remote aren't clobbered by unexpected changes when the
>> "<expect>" ref value is explicitly specified.
>>
>> For other cases (i.e., `--force-with-lease[=<ref>]`) where the tip
>> of the remote tracking branch is populated as the "<expect>" value,
>> there is a possibility of allowing unwanted overwrites on the remote
>> side when some tools that implicitly fetch remote-tracking refs in
>> the background are used with the repository. If a remote-tracking ref
>> was updated when a rewrite is happening locally and if those changes
>> are pushed by omitting the "<expect>" value in `--force-with-lease`,
>> any new changes from the updated tip will be lost locally and will
>> be overwritten on the remote.
>
> Hmph, I am not sure if we are on the same page as the problem with
> the form of force-with-lease without <expect>.
>
> In this sequence of end-user operation
>
>    $ git checkout --detach origin/target
>    ... edit working tree files ...
>    $ git commit --amend -a
>    $ git push origin +HEAD:target
>
> the user wanted to fix the topmost commit at the 'target' branch at
> the origin repository, and force-update it.
>
> The --force-with-lease is a way to make sure that the only commit
> being lost by the force-update is the commit the user wanted to
> amend.  If other users pushed to the 'target' branch in the
> meantime, the forced push at the last step will lose it.
>
>    $ git checkout --detach origin/target
>    $ TO_LOSE=$(git rev-parse HEAD)
>    ... edit working tree files ...
>    $ git commit --amend -a
>    $ git push origin --force-with-lease=target:$TO_LOSE HEAD:target
>
> So we say "I knew, when I started working on the replacement, I
> started at the commit $TO_LOSE; please stop my forced push if the
> tip of 'target' was moved by somebody else, away from $TO_LOSE".
>
> The force-with-lease without the exact <expect> object name, i.e.
>
>    $ git push origin --force-with-lease=target HEAD:target
>
> would break if 'origin/target' was updated anytime between the time
> when the first "git checkout --detach" step finishes and the time
> the last "git push" is run, because 'origin/target' would be
> different from $TO_LOSE and things that were pushed to 'origin/target'
> by others in the meantime will be lost, in addition to $TO_LOSE commit
> that the user is willing to discard and replace.

Sorry, that commit message should have been worded in a better way.
What I originally meant to say was: losing any _new_ changes that
were made on the remote during a rewrite, i.e., when we have a starting
point ($TO_LOSE) from the remote-tracking ref that we want to base our
rewrite on (after checkout) and then if the remote-tracking ref gets
updated by a push from another user, _and_ we don't use an "<expect>"
for `--force-with-lease`, there is a possibility that changes from the
other push would be lost because we're basing our rewrite on an older
version (?) of the remote-tracking ref, and our push would overwrite
its new changes because the value "<expect>" when omitted would point
to the updated tip of the remote instead. The condition:

	if (!oideq(&ref->old_oid, &ref->old_oid_expect))

would evaluate false since we're using `use_tracking`. This essentially
reduces the behavior of `--force-with-lease=<ref>` to `--force` in this
scenario.

>> This problem can be addressed by checking the `reflog` of the branch
>> that is being pushed and verify if there in a entry with the remote
>> tracking ref.
> Sorry, but it is unclear how reflog would help.
>
> Before the "git checkout" step in the example, there would have been
> a "git fetch" from the origin that brought the remote-tracking
> branch 'origin/target' to the current state with a reflog entry for
> it.  If an automated background process makes another fetch while
> the user is editing files in the working tree, such a fetch may also
> add another reflog entry for that action.
>
> Unless you make a snapshot of the reflog state immediately after you
> do "git checkout" in the example, you wouldn't know if there were
> unexpected updates to the remote-tracking branch even if you check
> the reflog.
>
> Besides, you do not control the parenthood relationship between the
> commits _other_ people push and update to 'target' branch at the
> 'origin' repository, so you cannot rely on the topology among them
> to make any decision.  Other people may be force pushing to the
> branch while you are preparing the commit to replace $TO_LOSE by
> force pushing.
>
>> +     The check ensures that the commit at the tip of the remote-tracking
>> +     branch -- which may have been implicitly updated by tools that fetch
>> +     remote refs by running linkgit:git-fetch[1] in the background -- has
>> +     been integrated locally, when holding the "lease".
>
> The problem with "expect-less" form is that it does not hold the
> lease at all.  The point of "hold the lease" by giving an explicit
> $TO_LOSE is to force a push that does not fast-forward, so if you
> iterate over the remote-tracking branch at the time of "push", if
> you find more commits built on top of $TO_LOSE because a background
> fetch updated the branch, or if you find NO commits on top of $TO_LOSE
> because no background fetch happened in the meantime, what would be
> pushed would not fast-forward.  So I am not sure what the point of
> iterating over reflog.

Right, I agree with what is described above. But, in this patch, we are
looking at the reflog of the _local_ branch that is going to be updated
on the remote side. The point of going through the reflog is to see if
the current tip its remote-tracking branch is present in one of the
reflog entries implying that any new changes (pushes from another user)
in the meantime aren't ignored and overwritten with our push.
Would that be an incorrect assumption?

> If we want an option to force a safer behaviour, I think adding a
> configuration variable to forbid the form of force-with-lease
> without <expect> would be one way to help.  Perhaps make it the
> default, while allowing those who want to live dangerously to
> explicitly turn it off.

Yes, that sounds like a good way to mitigate this issue; but that being
said, setups where `--force-with-lease` is being used as an alias for
`--force` should probably be taken into consideration though.

Thanks.
--
Srinidhi Kaushik
