Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B944C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 10:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbiDDKg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbiDDKg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 06:36:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F52E699
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 03:34:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d10so5699532edj.0
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0nGHyv5nAQZS4XPZO7ZQcONyraEYiWfYyZObVR+Ojn8=;
        b=P2jddiswrQi4t2G+PrrT/uvAyIpdr2y/wvBdUS4GHqPncCByuZzLvVu0aCGsWEX795
         6IwpMMVg+JngAuiftRMPV0fSySNcMay26tFEscT9FLcrlSMfgT0usvV2/I9K9jLtzRBF
         vw2BYFLYVSnSDCWWNkQbuL8PhzMezhDiTnTEhq1zhRKfsq8jBiDKLDfev0/rTanHReX4
         wbhffMcPWYBQWmFoFQdDEX3Yty47wK1OQQQFZj5zAB1MgbPVwPJfeFg41+G+F+GY4m7q
         xzrD9dh5/Z2vpg+sOgjVMaQQPxigJDvDy3OvGwlS4ZoOpGvN8L1tLUAnEGHHE7I74VKq
         K81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0nGHyv5nAQZS4XPZO7ZQcONyraEYiWfYyZObVR+Ojn8=;
        b=RuP3WYXoQtrhvYQcS+cASi2POVnTSa+XjtXYvHXtRSRKskmJgsf3q3/dGiYTfSUe9G
         WLA9K1UI/fQ5OJJENoC1j/+S4BvZWMzURD98hitJQmBOeNfv2L+NoHInjA4bIJP2GASj
         mlK/2otpRNO5hWsY06IVHD8ua6pqnoVwzf/dxql7TwMrEfmJTyHepFrM/8eA516lWUwi
         3Mdd2JiyU8JzugNMVfbm3SbCwU5WUcfhHNi81thh3h8JFGcaCi/ZVB7eIxxURsYyWpaD
         xHh24DBM5kj+Mt+ShnEfbAPHhfizgdZ7Elx/tJHhkJWyrJMYqOb2VcaJdCkt5J2I6Wwk
         +iJg==
X-Gm-Message-State: AOAM5313+ek/p3K/2+6hhSJNjw7TNcBDq8Rm+JiB1/ZhKSbtPo/Ued1v
        Xb8kauhMwuiP4lpcdKDm0e6S3wMOa9U=
X-Google-Smtp-Source: ABdhPJwfJyoAXyrPcZj1kv01bf3lQuPCx1iRN4MNeKioY2qUpJaeCGhavj5G3mvA0IPUSbJlNGj42g==
X-Received: by 2002:a05:6402:254e:b0:418:d759:dc48 with SMTP id l14-20020a056402254e00b00418d759dc48mr32697213edb.104.1649068468591;
        Mon, 04 Apr 2022 03:34:28 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ka6-20020a170907990600b006ce54c95e3csm4191197ejc.161.2022.04.04.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 03:34:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbK2V-002SgW-HX;
        Mon, 04 Apr 2022 12:34:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Markus Vervier <markus.vervier@x41-dsec.de>,
        git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
Date:   Mon, 04 Apr 2022 12:14:54 +0200
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
 <xmqqbkxhvoh5.fsf@gitster.g> <Ykoqxx40Fk0DiF9i@mit.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Ykoqxx40Fk0DiF9i@mit.edu>
Message-ID: <220404.86h779jfws.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


COVID19 is spreading via E-Mail now? It's $subject =~
s/Covierty/Coverity/g :)

On Sun, Apr 03 2022, Theodore Ts'o wrote:

> On Sun, Apr 03, 2022 at 02:36:22PM -0700, Junio C Hamano wrote:
>> I have old e-mails from the scan-admin@coverity.com but the last one
>> seems to be from late June 2018, which is ages ago in Git timescale.
>> I do not recall us paying for such a service so I am guessing that
>> they had some program that open source projects can enroll, get our
>> public sources scanned and get the result sent back?
>
> Yep, that's the way it works.  Someone has to use tools provided by
> them to build the open source project and upload the results for them
> to analyze.  Coverity predates github, so it's not new-fangled enough
> to automatically pull sources from repositories; besides, their paying
> customers tend to be using their tool for their proprietary software,
> so they haven't had any incentive to create an auto-analyze tool that
> pulls from an open source repository.
>
> Some folks at Red Hat do have scripts run out of crontab, that will
> monitor git branches on projects that they are interested in and when
> they notice that the branch has been updated, they will build and
> upload the raw material used by Coverity to their dashboard.  Eric
> Sandeen has been doing this for e2fsprogs, and a few other file system
> related repo's, and I suspect if someone asked, he would probably be
> willing to provide the scripts that he uses.
>
> You do need to be the project admin, or someone authorized by the
> project admin, to upload new data for Coverity, or to look at the
> analysis of the Coverity results.  I have no idea who the project
> admin is for git, but I'm sure if you, as the Git maintainer showed up
> and requested to be added as one of the project admin, the open source
> ombudsperson (I don't remember the exact title, but they do have
> someone who interfaces with OSS projects), would be happy to oblige.

Per
https://lore.kernel.org/git/YarO3nkrutmWF7nb@coredump.intra.peff.net/
Jeff ran this from his fork, I'm not sure if that was because he set
something up in the git/git organization, or if by project admin you
mean that any fork of it can set this up on their own.

>> https://scan.coverity.com/projects/git/ (visible without signing in)
>> seems to match my recollection. They haven't been scanning since
>> late June 2018.  I wasn't the primary developer who registered us or
>> who has been reading these reports but if I recall correctly, we
>> weren't doing anything custom, and fell somewhere between just "we
>> are curious to see how well Coverity works" and "Yay, a free
>> offering. We have nothing to lose, other than our time, to sign
>> ourselves up and if it comes up with useful scan result that would
>> be good".
>
> My experience with e2fsprogs is that it does have a fair amount of
> false positives, but I've been willing to wade through the false
> positives, and mark them as such in their web dashboard, because the
> early warnings it gives when we've pushed new code that has a
> potential security problem is worth it.  But make no mistake, it
> definitely requires a certain amount of maintainer time work with the
> tool.

Yes, also per the linked-above output it's quite noise, but there looked
to be some legitimate and hard-to find issues in those reports. It would
be nice to get them running with some regularity on our main branches.
