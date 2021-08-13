Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C92C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C3960EB2
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhHMQnR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbhHMQnR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:43:17 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F27C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:42:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id g12-20020a1709026b4cb029012c0d2e483cso6463740plt.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tKbw0PbWmf55c0k2LRTUEP6lxHi4uzQLcEv3EiYAnZo=;
        b=Bs03IBYZIza6897DOs59lc2/rDskjRb4u0ozn6VNM7dsXXjfPBCAkHrSi3HXwLbOkX
         rDU5jryXm3Dzfea623QwAnf2Ztq0v/0jwpXuBFP3urBh9qjVfck0CRW7NhnT6w+7ipGN
         OAZmgkYfSkDe6qNa7Gr0jjuQRXvrxP37N/KINDdnikq8wr5+QRH4nFRRVM7hrILTXnSs
         KEJ4cp8V+XbNxtBF990I+cpWpmuGl9VLUqPI16nV+DNqMYavUHe3MjDUMzYikwYUCBU9
         z3HlYPxxfNni0eqAbOU5zDanK+S8sIlegv/Sxb+twodeH8UX1WVnHtji72dCJ8BU6a5g
         TPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tKbw0PbWmf55c0k2LRTUEP6lxHi4uzQLcEv3EiYAnZo=;
        b=qZjsRZ5PBuKY0D/8smBnd27b5qA9Y/w+sY7Rgg1uAdkaa96IorIxR+tnCkzYYCy58a
         dUOjvIMj/N1HwRQa5mxBmLSV8lxGK780+wwcBBC0kBZl/L3FLkWKxAtY7AGJU2qQU5g2
         cyiSjbNYdeqnTv82YEgRaL/BiUW3VBdtruAzE+DOJlBO2v1mZRmV1uxdYQcE+WYRLiyM
         WUOb8oTjgqPOJQKS6syAI2/ObzCa7w/cpCdIk91Y+zcQmikb3Ubkip0kXcmLnQ1MMd5N
         eey8+3125DryAzocRU//0r+j6tGF4/g39FC+kwx41P2LZz/KVqGhDeuz91uDT2gWHBI5
         H9IQ==
X-Gm-Message-State: AOAM533/GEzgup01iB/gNuMNkDNIlQ8QSdZzsRUDChQvzan+7O21xNjr
        TSH0YuegbAA8nNzdiTlwTQosaq1ntsxKEQdqHJRM
X-Google-Smtp-Source: ABdhPJyTjknKtd1/7pcq+9WNqtS+lOtCUR5AR8GGpr3VcTn6Fb3Jy1q1LgfgvicqDKZkrLHBTRZBDwvvodRecwhGrf8F
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:396:: with SMTP id
 ga22mr47023pjb.0.1628872969286; Fri, 13 Aug 2021 09:42:49 -0700 (PDT)
Date:   Fri, 13 Aug 2021 09:42:47 -0700
In-Reply-To: <YRRGKKYYQiYTxtJ5@google.com>
Message-Id: <20210813164247.3218774-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YRRGKKYYQiYTxtJ5@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: Re: [PATCH 5/7] grep: allocate subrepos on heap
From:   Jonathan Tan <jonathantanmy@google.com>
To:     emilyshaffer@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +static struct repository **repos_to_free;
> > +static size_t repos_to_free_nr, repos_to_free_alloc;
> 
> One thing I was curious about was whether it would make more sense to
> use an existing utility library in Git to handle this. But I think we
> kind of are, since ALLOC_GROW is used, so this is idiomatic for Git
> project. Ok, fine, I guess this is life at C ;)

Yeah, this *is* the utility library :-)

> > +static void free_repos(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < repos_to_free_nr; i++) {
> > +		repo_clear(repos_to_free[i]);
> > +		free(repos_to_free[i]);
> > +	}
> > +	free(repos_to_free);
> > +}
> 
> Should repos_to_free_nr be reset here? I guess it doesn't make sense to,
> since we'd be trying to use-after-free the initial repos_to_free head
> pointer too if we wanted to reuse this array.

Hmm...I guess that if I'm going through the trouble of clearing the
repos instead of just letting all the memory be collected at the end of
a process, I should also reset _nr and _alloc. I'll make that change.
