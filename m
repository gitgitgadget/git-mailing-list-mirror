Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A6EC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D9123877
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 18:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLGSZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 13:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLGSZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 13:25:06 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02C2C061749
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 10:24:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id o128so9478371pga.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 10:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OM4kL4dJrQf7ypIIssXQgyrwlCiWZMb38MKt2cJ/1AY=;
        b=JMQ1oNrBIJm2bRXGjEXcrwmP03ykGcI5er3yrrTvJkfPrjQcquSvE2IoUKzWmCUeEp
         lLezU8vvRecogO4ofjgZo1bt9/jjSnaw7wPtjobWoKONpDrHVnpov2NVbkwQf0pc5xCs
         w2og+y16IYCo5cstN/ACsfYx8R6nlPzDBjuETKrrVtwtpAwsqQ9K1Si148T3T+XnsQuS
         7xbeooEuJ2WIJ64iXTnhV5Li418fF8IldgfhqgKi20/PsfI7ZhQDFmiD+B9vYpFsinqN
         1iPI9S/cimA4GXSRGP4frfOyJoo/laiTbGm4lnd+xF3cB3FwZGvX2+o9G0ynHffOvIeD
         9cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OM4kL4dJrQf7ypIIssXQgyrwlCiWZMb38MKt2cJ/1AY=;
        b=bJz2lLdf+HhdIPdjp6ED3aEMvCJKJMvMUSNfvtBtm8QACXJD/mwQVauhshYfAbAIHL
         gVDxR97PYLKYNx7LTb61jgZdQ7Au6xCyvnz6nsXuR1wjzC8900vqacF8VEGDOKMkcFi3
         hFWLEFOMXL9QlYOgDR6B4esG9AeLonb591Jd80so6iXaeNjbLwqShsrw79ZWZjesdEPF
         aHsfU5dyQ6Ggtw0Hvl/hUCy30qZkvAKPCiEfRrqKmEIChVVJ7dfy4l547McXr/Zauj5q
         VqcrDsipVxXXqkTN7WUH0AI4AlQwwuYWCrfvgDMu+4KYvPBi8Ve+tdDb8oBmZZtTEAhb
         q6JA==
X-Gm-Message-State: AOAM531f4nXDkq/2KcND9VLIWZIuPdGAVcClC+isV1oXr5X9VtZpNznL
        s2Qrmyw0sba5enmFo20jxMwU2bV/+aTgOvgpvdAZ
X-Google-Smtp-Source: ABdhPJxozXu7XKlzeX/5eiF0MsziTsJinJ9WPhG9Bja6DBLlytU2218gDoRtlDZ6SjLqBqL6RXuPmWPgPzIlzeswFNOM
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b601:b029:da:d459:65dc with
 SMTP id b1-20020a170902b601b02900dad45965dcmr15551332pls.26.1607365460088;
 Mon, 07 Dec 2020 10:24:20 -0800 (PST)
Date:   Mon,  7 Dec 2020 10:24:18 -0800
In-Reply-To: <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
Message-Id: <20201207182418.3034961-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     me@ttaylorr.com, jonathantanmy@google.com, git@vger.kernel.org,
        dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 12/2/2020 11:35 AM, Taylor Blau wrote:
> > On Wed, Dec 02, 2020 at 12:08:08AM -0800, Jonathan Tan wrote:
> >>> +			c_ent->maximal = 1;
> >>> +			p = NULL;
> >>
> >> Here, we're setting maximal without also setting a bit in this commit's
> >> commit_mask. This is fine because we're not propagating this commit's
> >> commit_mask to any parents (we're not continuing the walk from this
> >> commit), but it seems like a code smell. Suggested fix is below.
> >>
> >>> +		}
> >>> +
> >>>  		if (c_ent->maximal) {
> >>>  			num_maximal++;
> >>>  			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
> >>>  			bb->commits[bb->commits_nr++] = commit;
> >>>  		}
> >>
> >> As far as I can tell, this means that this commit occupies a bit
> >> position in the commit mask that it doesn't need. Could this go into a
> >> separate list instead, to be appended to bb->commits at the very end?
> 
> I don't see any value in having a second list here. That only makes
> things more complicated.

It does make things more complicated, but it could help shrink commit
bitmasks (which seem to be a concern, according to patch 23).

Suppose num_maximal was 3 and we encountered such a commit (not
selected, but has an old bitmap). So we increment num_maximal. Then, we
encounter a selected commit. That commit would then have a bitmask of
???01. If we had not incremented num_maximal (which would require a
second list), then the bitmask would be ???1.

> >> We could even skip the whole maximal stuff (for commits with existing
> >> bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
> >> we're going to append to bb->commits at the very end". That has the
> >> advantage of not having to redefine "maximal".
> > 
> > Hmm. I'd trust Stolee's opinion over mine here, so I'll be curious what
> > he has to say.
> 
> It would be equivalent to add it to the list and then continuing the
> loop instead of piggy-backing on the if (c_ent->maximal) block, followed
> by a trivial loop over the (nullified) parents.

That is true. This suggestion was for code clarity, not for correctness.
