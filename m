Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C85C433DF
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05BF2250E
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 01:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SqfE2D1l";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="COXpYuuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFByH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 21:54:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56838 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHFByG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 21:54:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E7E3478BC3;
        Wed,  5 Aug 2020 21:54:03 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=oeHRs+XN0Z3YS2iLjIwXeJYXT6s=; b=SqfE2D
        1li6sjCYi4Nk56SeEtSA+S3GQHPLVe3ZmynP4WAuOYKWmINgnoGrF6FjV69OaKrE
        Yw1RGp+kTmT5w6KGHFjLQR/z7/swnL4qYRN9E08jax8XBigEePHLggJxBpTXbNbB
        PwekcgdSRWvTMn/eUOZYCMzkfNfJj1FuKZfFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA9D078BC2;
        Wed,  5 Aug 2020 21:54:03 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=yf2G9c7l73Fc5zjv8qMGvj8RmkGq0kvJIf8Qls6LMzs=; b=COXpYuuyD7fFdNgreF4r+ChtXktqgdca+sYpu78wPyFzuYR4ZrSVlpCqxLo6dfhIxNkAyUTReP47Ap+bf0fj/kDAD9MK074/U3DEq4e6q1FSoA4X8tifsV0fGcGDlgz2AJ7QXrnaBfrsjXj26mQAKyhFNrbflRgBnlId+dva+4E=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3383278BC1;
        Wed,  5 Aug 2020 21:54:03 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     christian w <usebees@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: ls-files bug report
In-Reply-To: <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
References: <CADjceoQxoL932W4mkfhG6VOgrQBhs9k6tXkWSkraKVPmUP+uCw@mail.gmail.com> <878ses4pay.fsf@kyleam.com> <CADjceoRtFmM2H1z48HcmvWBF1KmMrwMnE6YdC9HJGFjdXXivJw@mail.gmail.com>
Date:   Wed, 05 Aug 2020 21:54:01 -0400
Message-ID: <8736504k06.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B436F3A8-D787-11EA-A490-01D9BED8090B-24757444!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

christian w writes:

> Sorry for the insufficient reproduction steps.
>
> I managed to figure out it has something to do with git repos within
> git repos. It happened to us because of go packages that are inside
> our repo. These are the reproduction steps that work for me
> consistently using Go version go1.14.4 darwin/amd64. This is the repo
> that gets cloned into src/golang.org/x/debug by the go get command:
> https://github.com/golang/debug/tree/66ec140f2f72d15dc6133502edd2bb7238b1740c
>
> $ mkdir testdir
> $ cd testdir
> $ git init .
> $ GOPATH=$(pwd) go get -u golang.org/x/debug/ || true
> $ git ls-files --others '*.txt'#
> src/golang.org/x/debug/

Okay, removing Go from the equation:

     $ # in fresh repo
     $ mkdir a
     $ git init a/d0
     $ touch a/f0.txt
     $ git ls-files --others 'a/*.txt'
     a/d0/
     a/f0.txt

It looks like the spurious a/d0/ entry doesn't show up until v2.27.0, in
particular 95c11ecc73 (Fix error-prone fill_directory() API; make it
only return matches, 2020-04-01).  Adding the author to the Cc.  (Sorry,
Elijah, I recall your frustration with dir.c from a previous ls-files
issue that I reported [1]).

[1] https://lore.kernel.org/git/CABPp-BFG3FkTkC=L1v97LUksndkOmCN8ZhNJh5eoNdquE7v9DA@mail.gmail.com/

