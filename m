Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D255EC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbiFIRSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243571AbiFIRSC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 13:18:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F41BD8DA
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 10:18:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id q12-20020a056a0002ac00b0051bb2e66c91so12539672pfs.4
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=mUeC0BwfcaIMuBeVuJKqtOQPq68JX2V05S2tSQr5q2w=;
        b=DyT8IBQjwJgCN0j3U55hWQ7CiIbs0SGwVgJh4cHiWfRGIh033JKpp5KKv/qQVF5VfR
         hq3MSfSqY0+ugi7gGyO+ctRJ0i8oRwcQj4ortLlUof+OXPzK5qLXIhfLimXE5s9GVALr
         XidGBtBGd9awLc3aPSiyIVF2nmRlrWfvr0ldkiRcOBvONV/4/MRvJnAue8n78kXIXuBI
         +m3qA2FJQ1WDmQ1RjntB3endVsXpU+GTOg6yEOR5oBvyHp7M+IkREvRrrOERpjAEz358
         NRSpt4YwtyVnuxsvlDI31/Iu4D0YGb1iYTZCdQ4/odWev4TH3BNxUzLB5kzaUNsSNJ6C
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=mUeC0BwfcaIMuBeVuJKqtOQPq68JX2V05S2tSQr5q2w=;
        b=JX34ByLrZW5nK7ZmEhdcIzcZbLWu1DaEypOfsMHsr21BGun139E7l17cQ8dohCPHvv
         AC8SjGo5+Wwo9QonhM6ndTmk5HKDUfhyWCq5BfzgCd4aRen+KYUlnxL++F0ka3ZMNs8p
         k58HjV6x2Y/petFfgGNdGFR9Fqs4bULX5m+Fo6pbBDiJ4Rf4KpadPTfEFzNIjaXNa9LE
         wVgHcnqAZL7aOTWwIYaVtKe0RtceRKZp7yy11MGBc4ibSzCF2udKQqEclr1TwGmQ/Yju
         KmnlMHgD9H719bpCQyjfnA8PXuxLvDuc9K2ZNIPT2wKUt8tV3PQrLDrAJuPTUYWG/bdt
         AHZQ==
X-Gm-Message-State: AOAM532LeZX/K5qiuce5yNSsO88Lokh/yXE6wiUzQ94HCdv5iX0f8ETH
        AIPYgiwvGa7gtgZnu6cVnzQvuxf4yxpbBibodz7U
X-Google-Smtp-Source: ABdhPJzmFM80322pSQw56+wffP+1Qr5NYqXV1asu1egEi/a04fE6RPgnTbZna6BSJKAGnvI9z1OIegP+0oTE9JkXi4Up
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:a58b:b0:168:b680:c769 with
 SMTP id az11-20020a170902a58b00b00168b680c769mr288750plb.32.1654795081144;
 Thu, 09 Jun 2022 10:18:01 -0700 (PDT)
Date:   Thu,  9 Jun 2022 10:17:58 -0700
In-Reply-To: <xmqqh74upyz3.fsf@gitster.g>
Message-Id: <20220609171759.347681-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: Re: [PATCH] connected: distinguish local/remote bad objects
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> If the missing object you found is reachable from existing tips
> (i.e. local aka UNINTERESTING) and also from what they should have
> sent (i.e. remote tips), when we discover that the object does not
> exist locally (but we can have an in-core shell object whose object
> name is already known because child objects that are closer to the
> tips than the missing object do exist and point at it), does this
> new heuristic work reliably?  
> 
> Do we always die and report bad_object() with UNINTERESTING in the
> the flags variable, or only when we are lucky?
> 
> IOW, if our current branch pionts at A, while the other side says
> they are updating it to B,
> 
>     X-----o-----A
>      \
>       x---B
> 
> we try to traverse "rev-list ^A B" and make sure everything exists.
> If we find objects 'o' missing, it is clear that it was something we
> were supposed to have on the local side even before we started the
> fetch.  But if 'X' is missing, by the time we notice and report a
> missing object, do we always reliably know that it ought to be
> reachable from both?  Or do we have 50/50 chance that the traversal
> comes from 'o' earlier than from 'x' (in which case X is found to be
> missing when we try to see who is the parent of 'o', and flags have
> UNINTERESTING bit), or later than from 'x' (in which case X is found
> when trying to see who the parents of 'x' is, and we may not know
> and we may not bother to find out if X is also a parent of 'o',
> hence we'd still say 'You do not have X, and we were looking at 'x',
> which we got from the other end, so they were supposed to have sent
> it', which would be a misdiagnosis)?
> 
> Thanks.

Ah, good catch. I'll take a look into fixing this. (A misdiagnosis would
defeat the purpose of this patch, yes.)
