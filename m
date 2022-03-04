Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A09FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiCDXrP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCDXrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:47:15 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F75D18A
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:46:26 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id j10-20020a17090a7e8a00b001bbef243093so8196464pjl.1
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 15:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=ucaDCctkt1WHei8RC4tPFUap5ctXzA+Kvh3uZTliDcQ=;
        b=BTPAqFPg8J8xho4v40yNrUAQngLMqz0znEWV2JuhEn45tkMaBoYpPiIvqNgtenqYzs
         hZOBToXHzBEfta6B+68V1Wnp3lSlKdIF71ldnb+92rtCTu2DQeGMiSXjTmU1EQg8YHen
         2Si2erRqnLtakcT1g5qVn85pms1FlhrXd6ZbRzIaQuKNo9d4fWl0enzThaJ1Oj8dPXs6
         p/UHVBhdbOsG/TDFhrSDp0q9e8m2JGmXcd1OvCu16XQMoZNOm+8QgY+msJ+cf1XvdSjb
         B4xe5JWW39/XHeLyUaVUo0c5b+rk7L6HNhtxbMCd/ApF1jTafkJWbhd21iWJbxK397IM
         u6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=ucaDCctkt1WHei8RC4tPFUap5ctXzA+Kvh3uZTliDcQ=;
        b=IrQMfDCmaUqlp+++k0jzQsOr5ppaGZ1W39BjDJeP0oi2nUmFZ3bP3BXARHAw8I6IaC
         By1H81Y2z2o/UCwBGZE693qRcbJC+TbgekRx6j0O/gqBqjuqak2pK7x331MWABJzmwII
         D+rZjtKM0Ep6OMApmxhAhtYnebkc43Q9ErC0wvlf42z4R4oRiUeKdi5uy3uwTcdf+iwa
         x/m2j/F8I8yUzWqe8zUnjDn3a6a8z3VkzbcgB/ZDEKzlUu+LRPCS+pUIsEuLcHYbNlvp
         rnK/xK++ICkimWbASUzpNlfvbflceui8Dj7DofDQG+Mkg6/lsZqKSlj9Q3vIBT3Q/a+h
         okZQ==
X-Gm-Message-State: AOAM533rxbJ/csmNMBpsLA/gEM+Ngs2l1yzakw5gcOWI40ELaWx1VpM3
        BobXKqGSwEjKIWHIPcODC836VcLtxbjsijjYC9bV
X-Google-Smtp-Source: ABdhPJyr257dxxef0jxYvEqaPUi/ioz5qu30Qze7be4z8QRcQhn0KdSarijzItogKeYtSftsn+uCOOyCMvz2JOWD20ES
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with
 SMTP id pj3-20020a17090b4f4300b001bc7e5ce024mr757650pjb.0.1646437585727; Fri,
 04 Mar 2022 15:46:25 -0800 (PST)
Date:   Fri,  4 Mar 2022 15:46:22 -0800
In-Reply-To: <kl6l5yp34nif.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <20220304234622.647776-1-jonathantanmy@google.com>
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
> >> +	# Use test_cmp manually because verify_fetch_result does not
> >> +	# consider submodule2. All the repos should be fetched, but only
> >> +	# submodule2 should be read from a commit
> >> +	cat <<-EOF > expect.err.combined &&
> >> +	From $pwd/.
> >> +	   OLD_HEAD..$super_head  super           -> origin/super
> >> +	   OLD_HEAD..$super_sub2_only_head  super-sub2-only -> origin/super-sub2-only
> >> +	Fetching submodule submodule
> >> +	From $pwd/submodule
> >> +	   OLD_HEAD..$sub_head  sub        -> origin/sub
> >> +	Fetching submodule submodule/subdir/deepsubmodule
> >> +	From $pwd/deepsubmodule
> >> +	   OLD_HEAD..$deep_head  deep       -> origin/deep
> >> +	Fetching submodule submodule2 at commit $super_sub2_only_head
> >> +	From $pwd/submodule2
> >> +	   OLD_HEAD..$sub2_head  sub2       -> origin/sub2
> >> +	EOF
> >> +	sed -E "s/[0-9a-f]+\.\./OLD_HEAD\.\./" actual.err >actual.err.cmp &&
> >> +	test_cmp expect.err.combined actual.err.cmp
> >> +'
> >
> > Could verify_fetch_result be modified to consider the new submodule
> > instead?
> 
> Since submodule2 is on the end of the file, I could modify
> verify_fetch_result() to concatenate extra text on the end. But if it
> weren't in the middle, we'd need to insert arbitrary text in the middle
> of the file.
> 
> I can't think of a good way to do this without compromising test
> readability, so I'll just do concatenation for now.

Looking at it, I think you can do it by adding a section that verifies
the "Fetching submodule submodule2" part if the file is present (so, no
change in behavior in the rest of the tests since they don't write this
file) and also modifying check_super to allow specification of the sub2
part (or making a new function for this).

> > What's the error message printed to the user here? (Just from reading
> > the code, I would have expected this to succeed, with the submodule
> > fetch being from same-name-1's submodule since we're fetching submodules
> > by name, but apparently that is not the case.)
> 
> Yeah, I think this might trip up some readers. The message is:
> 
>   From ../same-name-2
>     b7ebb59..944b5ac  master     -> same-name-2/master
>   Fetching submodule submodule
>   fatal: git upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
>   fatal: remote error: upload-pack: not our ref 7ff6874077503acb9d0a52e280aaed9748276319
>   Errors during submodule fetch:
>           submodule
> 
> Which, I believe, comes from how we fetch commits by oid:
> 
>   static int get_next_submodule(struct child_process *cp, struct strbuf *err,
>               void *data, void **task_cb)
>   [...]
>     oid_array_for_each_unique(task->commits,
>           append_oid_to_argv, &cp->args);
> 
> When the following is true:
> 
> - the submodule is found in the index
> - we are fetching submodules unconditionally (--recurse-submodules=yes")
> - no superproject commit "changes" the submodule
> 
> task->commits is empty, and we just fetch the from the submodule's
> remote by name. But as long as any superproject commit "changes" the
> submodule, we try to fetch by oid, which, as this test demonstrates, may
> fail.

Ah, so we try to fetch an OID from a submodule given by a fetched
commit, which is different from the submodule the client already has
locally. This might be a sign that we need to store more information
about the submodule so that we can print a clearer message. I haven't
looked into this deeply, but this might be possible by putting more
information in the util of changed_submodule_names, and when we have
already seen that submodule, to add more information to the util instead
of skipping it.
