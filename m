Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77225C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIZR6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiIZR5j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:57:39 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F147B51
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:36:08 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id s14so9299848ybe.7
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zbMz874QgGhWc7MDTCvw/trh5/3EwnMIpB7fH2irJVo=;
        b=elf2NHpuLL9n2enBq/S/rVUvWVsvqq8DfSzNnRZWe8kWfL3H3JgaFgYQBM82WZC8A9
         XNRKXWyxRE6M2ERNdcEQ1jJxTy2VpC7y760t0TnNOsAg65uCzjNc79SbR4TiAdKfFGyY
         ofscVNL2e413kMTOmtD/scOCgbfMSTx2JFhM6YpTMFy0HliqP+EEMUefkVVvKzPHvZ+j
         xHdZX5I1LHybfVyiEa+cJIBMX+fwoiPI/Ve8AeGQwL+gTGSIM1quuh4XOaVx/4fBCA4E
         bnAnPQ+FSjZ6a6bvFR1kaVQP1ZKm76/UVXnum21lK+WWKi4sXgEmkyd+lHwlvlWijPuC
         yziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zbMz874QgGhWc7MDTCvw/trh5/3EwnMIpB7fH2irJVo=;
        b=smtIonQBv1u1GfduTRumf0l2CS/0xxCCNBAUnjCLOTAdLsRCGhcuye8OcwhXfT6AkP
         52hwxWlQvZ3rUT9ZNcCIXwdYnuavJ0VsnauLTMXbQiRzlh9Lp3eDwNX0dH2jmeeTmAwI
         a2zUJdgsk0blYBo8RKVmg6P3/1pqVo9D9ndqe8kFUM1UjzAfC/2CqjDgMAoZKA6zdkkV
         F28yhZa6pCegUCKq5LXVsH5s1JBLL0TQMKioRYRREhN11a1XtomP0bW0ISZshCH9q/8G
         j0B/EJcvB0DXZ6i351Ek25fxBfRqjuC0gydZypgBoZqngVgl8sOsbf33gUA0mA6Ws388
         RREQ==
X-Gm-Message-State: ACrzQf1WSEi3mLOw+0kilU92AxWCGdowAcMRp/Li4iRJ7eOyRsizn6bP
        CRsVIFRluUw4fblG+3yXxscNtWnUrSmHefQz/9A/eg==
X-Google-Smtp-Source: AMsMyM72w1IISb0MEkASsc+k18HV1nO2msT781GWgyFc1e84gbbqYy2enpDL8et/ty8UUypHFzaIuKAT5RSgqw5vvbE=
X-Received: by 2002:a5b:5c4:0:b0:67b:89d6:cbf5 with SMTP id
 w4-20020a5b05c4000000b0067b89d6cbf5mr21641117ybp.286.1664213767464; Mon, 26
 Sep 2022 10:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220922232947.631309-1-calvinwan@google.com> <20220922232947.631309-4-calvinwan@google.com>
 <xmqqleq9u8u3.fsf@gitster.g>
In-Reply-To: <xmqqleq9u8u3.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 26 Sep 2022 10:35:56 -0700
Message-ID: <CAFySSZBxwMHOD0c7T5cF3kkcej3+c2i97u=2t4jZthSCvuEhDg@mail.gmail.com>
Subject: Re: [PATCH 3/4] diff-lib: refactor functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unlike the original, this always makes two needless structure
> assignments for anything that is not a submodule.
>
> Can we fix that regression before moving forward?
>
> Even when ce_mode is a gitlink, if .ignore_submodules bit is set,
> the two structure assignments between diffopt->flags and orig_flags
> become necessary, so the original was already doing extra copies but
> we do not have to make it worse.

ack

> Strange indentation.  It is unclear why this bottom 1/3 of the loop
> body of run_diff_files() need to be a separate helper function,
> while the top 2/3 does not.  The resulting loop (below) becomes very
> hard to follow because the reader cannot tell when diff_change() is
> called and when it is not.
>
> Overall, I see this change detrimental to diff-lib API at this step
> in the series.  Later steps may show something more rewarding than
> the downsides we see here, hopefully.

I'll see if I can come up with a way to rewrite this so it is less confusing.
Alternatively, I could remove this refactor.
