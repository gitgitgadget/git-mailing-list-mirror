Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11984C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 11:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC63A235FC
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 11:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPkExsEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgIWL0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 07:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWL0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 07:26:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF421C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 04:26:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w16so22387535qkj.7
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KXseMFocU6eYMXa1jCpSip97Mwzgd5hRFuSBq+dsvw0=;
        b=fPkExsEu7KsmNu3Ej3LywKxDFq75o4qGyyXWBIPIFJe229RxyoLzjBVeQ+bIWui3h4
         DYely5Em2IfXmYbhD9EFUjIOxr7NWbvqHD3p+QMN2vGlbQiqn6bD6zAdxTvE6GwK1jEg
         3ZUlhPOXNqTpctWlXE6fY0QEgx6E9ny+RCxGWbHNeJ2IYvGSm/6yS5qlKl51auWJK0SF
         riAZhWMyB2RuqEmwFWS+SC01epQogf/yA9K+6i1AUqWv+woUUf9D03Pza5+DJqI9/92X
         NE5NpTsvSDjDbW1jrRFjfy2GFYf8/YghC2Hs2d9S22BR2lZmFmvk3Mpwk6C1XsxQlbyq
         Ep0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KXseMFocU6eYMXa1jCpSip97Mwzgd5hRFuSBq+dsvw0=;
        b=EeOpklTPCiSv/A9S1+KKCc0ZkVu8An8CCOsieZiHS4l24K79Ti0xRhGEUTH2qN5wag
         QLytf1H3U/8E+nCJQLpPKX7JaG+8xP4ujalUZ8lrPH4NmRRjZXrWx1ZView/05kpeCb5
         0m+kTiJXJQB8SAr+70E9m/XrvY9JHDVouQcxXCIZI+jUVj3od5/wmLb6x3oof3VqKKqN
         fe8NQqYIT+wN3KluRrMP35BQUoZYQnJmi4xUMK1IijLoofE9g1bzrl6LsX5U0GCl0Gfv
         nSQ0E1PbBWQJt1SsJBDe4H5eqH9mOfn5R7DnIxrjufcvPfKBSebQ39+EbGx2SPzoOfEV
         zwLg==
X-Gm-Message-State: AOAM531gu8KsDEMFbh+xJPZIr1KzrzyQ/qRtrpPWUqCZ8BWKZWov/d/4
        4bFxZnd1PdPFWQC8n2H2pr95A5f2isMv1zw/0Zc=
X-Google-Smtp-Source: ABdhPJxKdDqsahuCni6axcB1DRpsYfgQ3Ttfmv3J39dFT81UW5Fl00T02f/Kjj1Hckho0Hn6m3XmgQ==
X-Received: by 2002:a37:474c:: with SMTP id u73mr9947552qka.45.1600860374073;
        Wed, 23 Sep 2020 04:26:14 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.107.121])
        by smtp.gmail.com with ESMTPSA id s5sm15074390qtj.25.2020.09.23.04.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:26:12 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:56:06 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 1/3] push: add reflog check for "--force-if-includes"
Message-ID: <20200923112606.GA71705@mail.clickyotomy.dev>
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-2-shrinidhi.kaushik@gmail.com>
 <3c254220-de10-8e17-1175-f88e790c17a6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c254220-de10-8e17-1175-f88e790c17a6@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 09/23/2020 11:18, Phillip Wood wrote:
> Hi Srinidhi
> 
> I think this is moving forward in the right direction, I've got a couple of
> comments below. Note I've only looked at the first part of the patch as I'm
> not that familiar with the rest of the code.
> 
> On 23/09/2020 08:30, Srinidhi Kaushik wrote:
> > Add a check to verify if the remote-tracking ref of the local branch
> > is reachable from one of its "reflog" entries.
> > 
> > When a local branch that is based on a remote ref, has been rewound
> > and is to be force pushed on the remote, "--force-if-includes" runs
> > a check that ensures any updates to remote-tracking refs that may have
> 
> nit pick - there is only one remote tracking ref for each local ref

You're right, I will correct that. 
> > happened (by push from another repository) in-between the time of the
> 
> s/push/fetch/ ?

Well, I was hoping it implies that there was a push made by another
person to the ref while a rewrite is happening locally. 
 
> > last checkout,
>
> more generally it is the last time we updated the local branch to
> incorporate any fetched changes in the remote tracking branch, this includes
> `pull --rebase` `pull --merge` as well as checking out the remote ref
> 
> > and right before the time of push, have been integrated
> > locally before allowing a forced updated.
> > 
> > A new field "use_force_if_includes" has been added to "push_cas_option",
> > which is set to "1" when "--force-if-includes" is specified as an
> > option in the command line or as a configuration setting.
> > 
> > The struct "ref" has two new bit-fields:
> >    - check_reachable:
> >      Set when we have to run the new check on the ref, and the remote
> >      ref was marked as "use_tracking" or "use_tracking_for_rest" by
> >      compare-and-swap (if the "the remote tip must be at the expected
> >      commit" condition is not specified); "apply_push_cas()" has been
> >      updated to check if this field is set and run the check.
> > 
> >    - unreachable:
> >      Set if the ref is unreachable from any of the "reflog" entries of
> >      its local counterpart.
> > 
> > "REF_STATUS_REJECT_REMOTE_UPDATED" has been added to the "status"
> > enum to imply that the ref failed the check; "case" statements in
> > "send-pack", "transport" and "transport-helper" have been updated
> > accordingly to catch this status when set.
> 
> This is quite a long description of the implementation, I think it would be
> more helpful to the reader to concentrate on what the new feature is and why
> it is useful.

OK, I will try to minimize the description a bit further.
 
> > 
> > When "--force-is-includes" is used along with "--force-with-lease",
> 
> s/-is-/-if-/

Oh, this happened again. Sorry!

> > the check runs only for refs marked as "if_includes". If the option
> > is passed without specifying "--force-with-lease", or specified along
> > with "--force-with-lease=<refname>:<expect>" it is a "no-op".

There's another typo: s/if_includes/check_reachable/.
 
> If I've understood this correctly `--force-if-includes` does nothing on its
> own - I had hoped it would imply --force-with-lease

Yes, it does nothing if not used with  "--force-with-lease", or when
used with it and the exact commit to be expected is specified for
"--force-with-lease" (i.e., with --force-with-lease=<ref>:<expect>).

> > [...]
> It's great that you've incorporated a date check, however I think we need to
> check the local reflog timestamp against the last time the remote ref was
> updated (i.e. the remote reflog timestamp), not the commit date of the
> commit that the remote ref points too. We are interested in whether the
> local branch has incorporated the remote branch since the last time the
> remote branch was updated.

Got it. I misread the requirement here; will update.

> > +		return -1;
> > +
> > +	/* An entry was found. */
> > +	if (oideq(n_oid, &cb->remote_commit->object.oid))
> > +		return 1;
> > +
> > +	/* Lookup the commit and append it to the list. */
> > +	if ((commit = lookup_commit_reference(the_repository, n_oid)))
> > +		add_commit(cb->local_commits, commit);
> 
> I think Junio suggested batching the commits for the merge base check into
> small groups, rather than checking them all at once

Doesn't stopping the iteration early with the date check collect fewer
commits? Would batching still be necessary?

Thanks.
-- 
Srinidhi Kaushik
