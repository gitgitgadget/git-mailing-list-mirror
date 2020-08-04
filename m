Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785CC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1803122B42
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftuZfUV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHDVxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDVxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:53:45 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C31C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:53:44 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id q68so10273389uaq.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=DcaSPqn0RDkp1MmZxNeg+65Ko+lUjijWc9yFtCiLzE4=;
        b=ftuZfUV1QnXZoALrGvqEvbHzdsxKz7/KYSnLLplcHHQs1lKRglO5leCcStZ9YVGenA
         otQRprpnFiLGd/ZVm57ofFHg9W3brgf5UOGhflV+Kx9IQwJ3rCWJ9xNnatpUwyoDC1qj
         lRbqzUhyvqalzjwpJaF0UblzJ6Jt0ZA5LCUMMKRqgcLLOUCXfimoip0hEdmBL7UoNaQf
         pqOblpaDV58ui3WrmBBGs4DeyNaytKwbEQ/eaPcHiKyLdAh2Ftd9g+VwzJSmPi7DFicF
         DmN/tbJeM1I5n2cUwonDTwYL8FOZMcMRjKVnC34Oks04m++BMe1RxOEtwuyq/CD1I1Pa
         dwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=DcaSPqn0RDkp1MmZxNeg+65Ko+lUjijWc9yFtCiLzE4=;
        b=OHjlJqp78H7UTFLRfiRf4Bh8dQFtt6fDKrcvsatqSrdWkfFr4GqRVac3taKnmoAHio
         JX4NWDrR0CcqsWse4I3WBDN7OKQA/gL2ktY1/RAsaEaAezMpIpAjIqlw30Xsxs2zN8B3
         eVIvZMoIHsXZ3hQdeBOL4PcTZ5egUVq3Uopab71RVYoZUK2LSsqu1Kid2tAvHiNHr6bp
         V5WAurXgPJOm1Q1ViyorvOrOdEUHZpCDntX8rdlrRDubhityilxAsnq/cGI4WF4HU2Yp
         jbVcJhu7f1z3MPbdQsEENkWpveFOm1ICTXux1EPDKdM6qhDnXfRYtQ8sAL5gIsOsfa3f
         Ba7A==
X-Gm-Message-State: AOAM53148yeN+owxX3VHGj3HLwF4MAZXacnW+ZWr+oZnoJcGJC9BXWGL
        P4X6oIAtXLZJm7LXvClKIvev/jsWCjDULrlTrxaLmdfH
X-Google-Smtp-Source: ABdhPJxneDNe5BCH9WTv/bmlHNJoh4pOK+JWCft7gelhkbqNnpmEqpsyU3qGclgmrj6a3KhIJem0BzXungF2J8lbUhM=
X-Received: by 2002:ab0:4264:: with SMTP id i91mr31696uai.27.1596578021523;
 Tue, 04 Aug 2020 14:53:41 -0700 (PDT)
MIME-Version: 1.0
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Aug 2020 14:53:30 -0700
Message-ID: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
Subject: avoiding fetching specific refs from a remote
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've recently had a few repositories switch their default branch from
master to main. Currently, for backwards compatibility these
repositories have kept master around as a synonym for main. It's
unclear when this will be removed.

This results in the annoying completion behavior where:

$git checkout ma<TAB>
main
master

Essentially, because both main and master have similar names, tab
completion requires remembering to type one additional character than
I am used to.

I'd like to be able to customize my pull so that I either (a) exclude
the reference when performing a fetch, or (b) exclude the reference
when tab completing.

I don't know if there is any mechanism already in place to do this, so
I'm trying to figure out which one would be most preferable on the
list?

something like adding a remote.<name>.excludeRefs which would allow
specifying a set of references to exclude from matching the refspec..

I realize I could customize the refspec to list the set of things I
want, but then I would miss any potential future branches until I
updated my remote config again.

I would like to be able to remove this annoyance for myself and colleagues.

It seems to me the easiest solution would be the sort of exclude
option, as this enables generally skipping out on specific refs, and
could be useful beyond just this initial impetus.

Thanks,
Jake
