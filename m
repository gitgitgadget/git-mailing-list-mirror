Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89ABC433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A6320715
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 11:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkdNqkNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgHYLLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHYLLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 07:11:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357EC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:11:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u25so142109lfm.10
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=v4LER6T7QOYys+GLxeHIkgFvVnuWpVyRtW3Xfw4eYx4=;
        b=SkdNqkNg/qNhP0iLgpLTPJA0IeX3jmFwtQuaCJvqZl6bK3myGUeo69GlrIhuiGpFN8
         Lj83Zq0u85ys5+DUxTrLptkUuFeoKm2WOX5yIScBLwzUYWAPe9QMBT/wPUomx92QICfT
         5jjE2LwzocIIOip+wQGTU5e0mz7QMMdhqAyxag3J0KlH/9Km0sYlw45fvXdvMp91dK4f
         OaKgH0+ZJ3H2mvyHAH6YBJ6xmo9rboTfARvNhH8wZgtWHYldkLyiS7TKxl7IxHI00pZA
         M0N8p3NzR0kmhIZ09/KWWdxlZ6vKzd005jcmzv+ZSP/433OFyJZBcNjvL5ZYW8WgGRJW
         o2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=v4LER6T7QOYys+GLxeHIkgFvVnuWpVyRtW3Xfw4eYx4=;
        b=Aetv6hU8HslUBOupZSbbCafmvoiCsaIX951hk2MSXPNLLZrnbdMd603MhDnoHGvXg1
         v/qXzdYpw3gyadhcG1vVcpFYK74rh4vqdHVsmWZVWPaWUH4IM5AI2imyQnPnXamrhzOy
         w552JS1bf3IcoqrwJ4hgW7pimTxy4RrtAJh60C8I1SlvtQExC/retUAPy2zmbrBm5IAM
         IDoAb8UVYzcCl/hYqGlMf08Ie8BEeu1QI0UXeWfrUlwnuejhBwaCyNGnQNTxcUREmT5S
         6cy2KK+MQHrLZoZbYb08S4MNoftCGDDTUyYVqrFbRnnHzmb0DfBSoBIDqx/DRr2xpNne
         ImgQ==
X-Gm-Message-State: AOAM533X+hiY0McARakOUZgKB+QAvkTogc8bYpTItvNLS9BkjzmdqIUm
        fVJYrIYm//bfY6atzxulSI3q57zd08iTUw==
X-Google-Smtp-Source: ABdhPJyWRZBT7HkkOfFRbV/kafTnYJihGgcsBR73BycDcr16NxnC1ezUsmtVypCDqfOgtUFtKHDQSw==
X-Received: by 2002:a19:c697:: with SMTP id w145mr2419416lff.26.1598353873403;
        Tue, 25 Aug 2020 04:11:13 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id r16sm2762952ljd.71.2020.08.25.04.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 04:11:12 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 03/11] commit-graph: consolidate fill_commit_graph_info
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <18d5864f81e89585cc94cd12eca166a9d8b929a5.1597509583.git.gitgitgadget@gmail.com>
        <857dtuo71v.fsf@gmail.com> <20200821041124.GA39355@Abhishek-Arch>
Date:   Tue, 25 Aug 2020 13:11:11 +0200
In-Reply-To: <20200821041124.GA39355@Abhishek-Arch> (Abhishek Kumar's message
        of "Fri, 21 Aug 2020 09:41:24 +0530")
Message-ID: <85mu2jc75c.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Wed, Aug 19, 2020 at 07:54:20PM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
>>>
>>> Both fill_commit_graph_info() and fill_commit_in_graph() parse
>>> information present in commit data chunk. Let's simplify the
>>> implementation by calling fill_commit_graph_info() within
>>> fill_commit_in_graph().
>>>
>>> The test 'generate tar with future mtime' creates a commit with commit
>>> time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
>>> generation number (within CDAT chunk) and has undefined behavior.
>>>
>>> The test used to pass
>>
>> Could you please tell us how does this test starts to fail without the
>> change to the test described there?  What is the error message, etc.?
>>
>
> Here's what I revised the commit message to:
>
> commit-graph: consolidate fill_commit_graph_info
>
> Both fill_commit_graph_info() and fill_commit_in_graph() parse
> information present in commit data chunk. Let's simplify the
> implementation by calling fill_commit_graph_info() within
> fill_commit_in_graph().

All right.

We might want to add here the information that we also move loading the
commit date from the commit-graph file from fill_commit_in_graph() down
the [new] call chain into fill_commit_graph_info().  The commit date
would be needed in fill_commit_graph_info() in the next commit to
compute corrected commit date out of corrected commit date offset, and
store it as generation number.


NOTE that this means that if we switch to storing 64-bit corrected
commit date directly in the commit-graph file, instead of storing 32-bit
offsets, neither this Move Statement Into Function Out of Caller
refactoring nor change to the 'generate tar with future mtime' test
would be necessary.

>
> The test 'generate tar with future mtime' creates a commit with commit
> time of (2 ^ 36 + 1) seconds since EPOCH. The CDAT chunk provides
> 34-bits for storing commiter date, thus committer time overflows into
> generation number (within CDAT chunk) and has undefined behavior.
>
> The test used to pass as fill_commit_graph_info() would not set struct
> member `date` of struct commit and loads committer date from the object
> database, generating a tar file with the expected mtime.

I guess that in the case of generating a tar file we would read the
commit out of 'object database', and then only add commit-graph specific
info with fill_commit_graph_info().  Possibly because we need more
information that commit-graph provides for a commit.

>
> However, with corrected commit date, we will load the committer date
> from CDAT chunk (truncated to lower 34-bits) to populate the generation
> number. Thus, fill_commit_graph_info() sets date and generates tar file
> with the truncated mtime and the test fails.
>
> Let's fix the test by setting a timestamp of (2 ^ 34 - 1) seconds, which
> will not be truncated.

Now I got interested why the value of (2 ^ 36 + 1) seconds since EPOCH
was used.

The commit that introduced the 'generate tar with future mtime' test,
namely e51217e15 (t5000: test tar files that overflow ustar headers,
30-06-2016), says:

	The ustar format only has room for 11 (or 12, depending on
	some implementations) octal digits for the size and mtime of
	each file. For values larger than this, we have to add pax
	extended headers to specify the real data, and git does not
	yet know how to do so.

	Before fixing that, let's start off with some test
	infrastructure [...]

The value of 2 ^ 36 equals 2 ^ 3*12 =3D (2 ^ 3) ^ 12 =3D 8 ^ 12.
So we need the value of (2 ^ 36 + 1) for this test do do its job.
Possibly the value of 8 ^ 11 + 1 =3D 2 ^ 33 + 1 would be enough
(if we skip testing "some implementations").

So I think to make this test more clear (for inquisitive minds) we
should set a timestamp of (2 ^ 33 + 1), not (2 ^ 34 - 1) seconds
since EPOCH.  Maybe even add a variant of this test that uses the
origial value of (2 ^ 36 + 1) seconds since EPOCH, but turns off
use of serialized commit-graph.

I'm sorry for not checking this earlier.

Best,
--=20
Jakub Nar=C4=99bski
