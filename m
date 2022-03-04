Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D52C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiCDXyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCDXyU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:54:20 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04141E1139
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:53:31 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 1-20020a630c41000000b00378d9d6bd91so5275991pgm.17
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 15:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=wZGyVLq5VYZzRdgnlgI8uTzTTH9xRq4GDC8TaaoUBQc=;
        b=GrnOI2iZwHYPEm6HJzG7OdUHZXwpmM9AEOpYIbIdJAAQystX6qMniBhjTZcmMuyba4
         MNeL25/0sEqOmAMLbxl1yXsO/em070reeRLkKiwe+GzjejuXEk2MZ38kdCrR/ZfTB0CQ
         Mglyl6hBDLYIe0O3TEriJv6wPKCVjublyRGO3MWOgWs1q8Kt9MHNhoZGhcAUJj+Wf9kb
         7RpRotcWeMH2JJF4Xeea7fVWNcV/Axefy6DFGh5hzYunOVM3GnNZD+1e54JWEj/R2HiT
         FKaTD08UWVV+4/fgCp0UpGWXIMd8XHZ012PFxoNXxs7D+vHXbfduPIemBz0a52RaNw6j
         vtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=wZGyVLq5VYZzRdgnlgI8uTzTTH9xRq4GDC8TaaoUBQc=;
        b=x8w8sGEuRzOwiWkrGnZC/o4BGDp8DGj9zMD/CKXj5w08W/LEldSCg+MFw2H5tnqHoJ
         zwHoSbmM1WgTc0znHU32iXlCE4QunLB7FIxWJv7o2B0Y0ygoTQRgDmZohPyeBBkmFyrA
         OJBKa3uQvbhzmfpypR/jr5+XEDIYb2+PJbUqP/aBs5NfH9gwlGO24bVDj9wBD7llowy+
         86NJR+pjZzNpkpddW3ePWQ3lnLUwGTKrZE64BjzBvSB07Vc8wUqE+qs4psghnLnV5GC4
         RPgGCXtnzeh9LqPpI6dHvD3qPJ3hZpPvWKt+pEhflqR12jVspPlhZ+0ARgeJxBz0MaCd
         xj9Q==
X-Gm-Message-State: AOAM533G3B4o9b0cZCrf+gI56QR12qJkXfpsgSE3+bblFCg61zFzRBso
        iC/OKCkV8FOyLVntIGMDP4bHBxLWza4WFqDWUDnA
X-Google-Smtp-Source: ABdhPJwqvC9BydiJjGnznajzF1JGxE++v3Oya1OxoL4wYBUv3yDOHxyDUH6d0TZ7azL56gZBXQc6O4SqAu+UJatFHvp2
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:218d:b0:4f6:4127:df4f with
 SMTP id h13-20020a056a00218d00b004f64127df4fmr903484pfi.73.1646438011089;
 Fri, 04 Mar 2022 15:53:31 -0800 (PST)
Date:   Fri,  4 Mar 2022 15:53:28 -0800
In-Reply-To: <kl6l5yp34nif.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20220304235328.649768-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> >> +# In downstream, init "submodule2", but do not check it out while
> >> +# fetching. This lets us assert that unpopulated submodules can be
> >> +# fetched.
> >> +test_expect_success 'setup downstream branch with other submodule' '
> >> +	mkdir submodule2 &&
> >> +	(
> >> +		cd submodule2 &&
> >> +		git init &&
> >> +		echo sub2content >sub2file &&
> >> +		git add sub2file &&
> >> +		git commit -a -m new &&
> >> +		git branch -M sub2
> >> +	) &&
> >> +	git checkout -b super-sub2-only &&
> >> +	git submodule add "$pwd/submodule2" submodule2 &&
> >> +	git commit -m "add sub2" &&
> >> +	git checkout super &&
> >> +	(
> >> +		cd downstream &&
> >> +		git fetch --recurse-submodules origin &&
> >> +		git checkout super-sub2-only &&
> >> +		# Explicitly run "git submodule update" because sub2 is new
> >> +		# and has not been cloned.
> >> +		git submodule update --init &&
> >> +		git checkout --recurse-submodules super
> >> +	)
> >> +'
> >
> > Hmm...what is the difference between this and the original case in which
> > the index has no submodules? Both assert that unpopulated submodules
> > (submodules that cannot be found by iterating the index, as described in
> > your commit message) can be fetched.
> 
> In the previous test, the index has no submodules (it's completely empty
> in fact, so we don't iterate the index at all), but in this test, it
> does. This lets us check that there aren't any buggy interactions when
> both changed and index submodules are present.
> 
> I think such mistakes are pretty easy to introduce on accident - I made
> one pre-v1 where I reused .count between both iterators (instead
> of having .index_count and .changed_count). It passed the previous test
> because we didn't care about the index, but it obviously wouldn't pass
> this one.

In that case, describe this difference (one has no submodules in index,
one has other submodules in index) and maybe position this so that both
test cases (the no-submodule-in-index one and the
other-submodule-in-index one) are next to each other.
