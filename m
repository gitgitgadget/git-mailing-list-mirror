Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5405BC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 21:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38E664E77
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 21:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSV0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 16:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSV0C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 16:26:02 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66875C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 13:25:22 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id j1so2509052pgh.4
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=F4a88zCrECouAM6F84Qn2/MZVOo/braPBAgigbji+ow=;
        b=RNqd42fB5yHoeHIZYdsiHuZ7g6Q65eMIailrkmJH4VTcqjg0xSvExk2ZcIYPz3HYth
         q737wGat1AG22wqwusvTT6SmBD/SCLVAMLuDmVtVgSePsaT/q+MROqlONtQas92Q5A33
         ky7uMgSr8SmRnpMMqA1Kua+fIDrXXU/trA5t7HlvHriek38ZBSspnLwrCchPh7PDxFZ8
         vSOG5F38QvOGJQyHKTZ7sVQZP1U1WjVp3bQObar4AluAW0OELUKrSXPfqiN6KDd7rFmd
         KUCXiCMkhxUGiXyTiHfluE4Vtqg8e4eD8lQwaiT6GKRPWKi8wN0rGjytv6ROkic+hBlw
         WB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=F4a88zCrECouAM6F84Qn2/MZVOo/braPBAgigbji+ow=;
        b=dEF0oo4wtMwTzhEc6QWRqLljugx27/jKnBmZStad9huFNmbKYAJM0Rik5FHOUhgFwX
         KJiZ96MgiS97aYs58dEhsKxxvUyKr+nmNMmPjxMXeynEk865ZYQogOlt23OPVJSKsH3i
         hQDd+69g7FzFqHgfl5wTIIpFhbl9dBTdBC7SFa2lHreAZKlQt3I+IdkgQ/hNcWfucjYg
         QaGS+rNh+qh71EGVb+LM13M1K/ccbjCWhQgTwjnnYsrkb2TlRH300one+/2d8KTNRp3g
         fk9wPOWl2KQ2KaxaCEVQlunvWor9G+YSpdVXtIaa/7wlN9X0NyGxzUm/jCIsYlvLxjPC
         GDOw==
X-Gm-Message-State: AOAM532Rxd9dL9ODF3FRbk22/+srRTY0gJ1v7BPZR2SIKkdNKhMpUxQy
        Db/YsSd47Yr4rxdpDXh6y2M=
X-Google-Smtp-Source: ABdhPJzHIpDSBbQGKnIx4rNw7Tj1zb7vHKdstTABlVmHL4doFqTiHPRIBbttGC0/UrArZp2oD76dsg==
X-Received: by 2002:a62:3805:0:b029:1ec:f57c:8189 with SMTP id f5-20020a6238050000b02901ecf57c8189mr11117153pfa.37.1613769921898;
        Fri, 19 Feb 2021 13:25:21 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e5a1:6f53:fb5:29c2])
        by smtp.gmail.com with ESMTPSA id o5sm6341527pjq.57.2021.02.19.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 13:25:21 -0800 (PST)
Date:   Fri, 19 Feb 2021 13:25:18 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 4/4] tests: remove most uses of test_i18ncmp
Message-ID: <YDAsvpIzgsIhh+5X@google.com>
References: <20210120182759.31102-1-avarab@gmail.com>
 <20210211015353.28680-5-avarab@gmail.com>
 <xmqqa6say0h8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa6say0h8.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>> As a follow-up to d162b25f956 (tests: remove support for
>> GIT_TEST_GETTEXT_POISON, 2021-01-20) remove most uses of test_i18ncmp
>> via a simple s/test_i18ncmp/test_cmp/g search-replacement.
>
> I am a bit hesitant to take this step, primarily because the
> distinction between test_cmp and test_i18ncmp is serving as a sign
> for tests to identify if they are dealing with translatable messages
> or plumbing/machine-readable messages.

I agree: in particular, I would value the ability to run tests with,
say, LANG=fr_CH.UTF-8 and catch localization-specific issues that way.
Removing the test_i18ncmp helper removes that ability.

That said:

[...]
> So, perhaps we should bite the bullet and just take this step.

If we don't have a convenient way to keep "testing the testsuite"
(i.e., some kind of CI run that uses a locale other than C), then I
agree that explicitly removing the test_i18ncmp / test_cmp distinction
is better than letting it bitrot.

Thanks,
Jonathan
