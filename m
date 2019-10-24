Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3321F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 19:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfJXTSJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 15:18:09 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42078 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfJXTSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 15:18:09 -0400
Received: by mail-vk1-f202.google.com with SMTP id n192so11158973vkc.9
        for <git@vger.kernel.org>; Thu, 24 Oct 2019 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5ay0HJCKMdI7sI+C1DBWBuBVJda55BMXSBK4TXYMkkQ=;
        b=bFqTDtHp7khlHfQixIIFHXv77uARc8wCzYFAXTvHkA3Sjx85YOu0DSYQz8N7AE1cw8
         bh6/JYapeihEdLAB2eRuCFB0AB3HcgIdrlOq7sIegRlhqw4hXjHIvCeWJVK4mn0TUYtC
         9ivVpmr0mbEIddw2HRIfgnvzUIkewjTPY1Sk7YmmMHNz76Rw/26XpSHVyUSqUmMiQ3fE
         iSO4+W+dmQPl5gPngcDsmSEp6Rhwfx9PWyk6jT0VmQe5sj98iD8dfpg992rMFechnHQ2
         ni1FuKkXi5mUDZ1+6g2yh583WgEizd+i2y9M5pySpWWgUCuvIJLR59U8Tct0d3EuS7eL
         A6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5ay0HJCKMdI7sI+C1DBWBuBVJda55BMXSBK4TXYMkkQ=;
        b=rQX668vMeD+Nfj2uQ0efREJfdWJAc+Ug3p5YJ5TYuciMPhixeBMNEY+SIfD1fT0cMC
         g2Xj2V1l+/nbISx8qrf7yBOZF0pUiA4BfFomCFVZOuMPvpgRQt361eU7ABKQtjaH00WS
         UE+Z1c6pqWsowLYdlalW3I4Yyvw9rBfeoGVEntNpW31RNFA1xXbCxe8EoPLcH7p8X1Z9
         Xd59LkmczFuzgogZ9mrdfBumPiUbjvxvdCDOAlc7uIP5OKowxWl6+52rGK28aCre1/qI
         QogEnBFDJpUZ384fq7zPbG9x7Qmsttwoiyj3DWYAwDkDRBkTSygKWjy2hGYY11ubHkk+
         x7aA==
X-Gm-Message-State: APjAAAVytyz6quto9g7giU2XRFdAkPAL5C7XG5LWhiM2oaXI/RnQZInB
        MxCQsz0AYAEEK1reO7NRXCmFJruSuRqA0jLpKJys
X-Google-Smtp-Source: APXvYqyN0kAOuIGYUUL5KS9oqqtGnIOUNkO+PY3eG6gYAR+qtFUxO3y88qwtkp4MLcerlbcxWX8pxsEZpSkU+cp7Wupk
X-Received: by 2002:a05:6102:52b:: with SMTP id m11mr9931902vsa.162.1571944687971;
 Thu, 24 Oct 2019 12:18:07 -0700 (PDT)
Date:   Thu, 24 Oct 2019 12:18:04 -0700
In-Reply-To: <xmqqo8y6g3yu.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191024191804.57275-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqo8y6g3yu.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > fetch_if_missing is set to 0 too early - ".gitmodules" here should be
> > lazily fetched.  Git must set fetch_if_missing to 0 before the fetch
> > because as part of the fetch, packfile negotiation happens (and we do
> > not want to fetch any missing objects when checking existence of
> > objects)...
> 
> Is it only me to feel that this is piling band-aids on top of
> band-aids?

To me, this is moving a band-aid, not adding another one. But to the
bigger point...

> Perhaps the addition (and enabling) of lazy-fetch should have been
> done after "checking existence" calls are vetted and sifted into two
> categories?  Some accesses to objects are "because we need it
> now---so let's lazily fetch if that is available as a fallback
> option to us", as opposed to "if we do not have it locally right
> now, we want to know the fact".  And each callsite should be able to
> declare for what reason between the two it is making the access.
> 
> The single fetch-if-missing boolean may have been a quick-and-dirty
> way to get the ball rolling, but perhaps the codebase grew up enough
> so that it is time to wean off of it?

This is one of the alternatives I mentioned in the original email [1]
after "---". But to elaborate on that, I prefer sifting regions over
sifting calls.

Sifting calls into two categories might work, but it's error-prone in
that we would have to do the same line-by-line analysis we did when we
added the repository argument to many functions, and we would have to
modify functions like parse_commit() to take a flag similar to
OBJECT_INFO_SKIP_FETCH_OBJECT. Also, we would have to do the same
careful inspection for future patches.

Instead, we can control whether a region of code lazy-fetches by moving
fetch_if_missing to the struct repository object and using a struct
repository that has fetch_if_missing==0 when we don't want lazy
fetching. Besides being less error-prone, the infrastructure for this
has already been built (if I remember correctly, for submodules, at
first).

The microproject to put fetch_if_missing into struct repository and my
Outreachy project 'Refactor "git index-pack" logic into library code'
[2] are steps towards this goal. (I don't think that the latter is
strictly necessary, but it will make things simpler. In particular,
passing "-C" then the_repository->gitdir to index-pack makes a few tests
fail - not many, but not zero; and even after we resolve that, we would
need CLI parameters ensuring that we marshal everything we need from
the_repository, including fetch_if_missing. It seems better to libify
index-pack first.)

[1] https://public-inbox.org/git/20191007181825.13463-1-jonathantanmy@google.com/
[2] https://www.outreachy.org/apply/project-selection/#git
