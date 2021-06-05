Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBD6C4743C
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEB8613E7
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 02:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFECNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 22:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFECNA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 22:13:00 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB0EC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 19:11:05 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id l6-20020a3770060000b02902fa5329f2b4so7784852qkc.18
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 19:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YI9NnP7rwcju0iLZFUIzFJGrORPIzYcr88YwUErjxj0=;
        b=JNpkmTvDgvvHzwHWS3CfaBYTBNizDcP8K1p6oTCu5BkdHPKLNWWhjh16YBYoZrkEM6
         AZXvzSRLkpuG4KmJLKTy5cUrWWl7SEyh6H7Uu7QOspwWOAZkbl9xoTP/86Op8Tb7hRLQ
         LUt6Zm6dCyobXfHMmwlDaWyOHxBmpGajwaD0PdUTq2ExL3RCA43yqDLPUuDbP0ArBjDY
         V5Ha5WhGBw5IRIwbphyys2wyb7eFaa+mjdheicvhcZGS1mNshB6w64TN7gb70xCPeQPS
         ve9XxHHw0oUiE4AOXgKoHzabdNBr/i0fp8MpCYhQo1bS+xUIKhNAEMhOkSqcEw7mrp77
         P6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YI9NnP7rwcju0iLZFUIzFJGrORPIzYcr88YwUErjxj0=;
        b=huC8Bbzzw4iIL4aj0OdyLpXTuj2BYfFWElPo5efXcmXCKSYu1vkHxXxj01mGjGAe9O
         CIzzMmvnKEw0YL+0YigHcl8HDE+rBHolcYqrmbdRTiKwT9XnHWqhp/urJqYLCiAcebqi
         wKfXrtVB1s2vErNigNMuor/46Nlq+Lwpu8XzlMMmOyjbqDk5LnFvykWjJy9Ay98FlyLW
         WbB+wULQBUIp3XcQQGFAZ1n2hUlq2xNAdnIQTJjNC0Si3edH/ZZJLy7wZQzfvePold71
         ihETGjl7navWL+VI/O5rpKheJuLClgGk43poKQIdTsbm4FaH9AFLOKFYjNs/gaDpH+rU
         4mIA==
X-Gm-Message-State: AOAM532i1OYDx69wmzFR1kFaEsk0h4uUJp06fmLNA4Y/5EYZW83Ak/6x
        jAv2x8BAzyA/4sEMD7QUV5K5cAG5kceF/r1FxUgX
X-Google-Smtp-Source: ABdhPJyCykquhB4nb8DVl4yKwNmlOrkWByeoAXvaVChWaoH2vdiN+5Mf8bt0eGzq5+F4m2DrvaiqXLLA+ZyKvJNFD+nO
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:10e9:: with SMTP id
 q9mr7517569qvt.45.1622859064838; Fri, 04 Jun 2021 19:11:04 -0700 (PDT)
Date:   Fri,  4 Jun 2021 19:11:03 -0700
In-Reply-To: <YLqaWm9NOmtENT2J@nand.local>
Message-Id: <20210605021103.609217-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YLqaWm9NOmtENT2J@nand.local>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +static void object_info(const char *gitdir, const char *oid_hex)
> > +{
> > +	struct repository r;
> > +	struct object_id oid;
> > +	unsigned long size;
> > +	struct object_info oi = {.sizep = &size};
> > +	const char *p;
> > +
> > +	if (repo_init(&r, gitdir, NULL))
> > +		die("could not init repo");
> > +	if (parse_oid_hex(oid_hex, &oid, &p))
> > +		die("could not parse oid");
> > +	if (oid_object_info_extended(&r, &oid, &oi, 0))
> > +		die("could not obtain object info");
> > +	printf("%d\n", (int) size);
> > +}
> 
> Hmm. Is there a reason that the same couldn't be implemented by calling "git
> cat-file -s" from the partial clone?

I don't think "git cat-file" (when run in the superproject) by itself
can access an object from a submodule. "git -C name_of_submodule
cat-file $HASH" would access that object, but I specifically want to
test oid_object_info_extended() on a repo that is not the_repository
(which would not work with -C, because the_repository would then be the
submodule).

> > +test_expect_success 'lazy-fetch when accessing object not in the_repository' '
> > +	rm -rf full partial.git &&
> > +	test_create_repo full &&
> > +	printf 12345 >full/file.txt &&
> > +	git -C full add file.txt &&
> > +	git -C full commit -m "first commit" &&
> 
> This is a stylistic nit, but I think using test_commit is better here
> for a non-superficial reason. My guess is that you wanted to avoid
> specifying a message and file (which are required positional arguments
> to test_commit before you can specify the contents). But I think there
> are two good reasons to use test_commit here:
> 
>   - It saves three lines of test script here.
>   - You don't have to make the expected size a magic number (i.e.,
>     because you knew ahead of time that the contents was "12345").
> 
> I probably would have expected this test to end with:
> 
>   git -C full cat-file -s $FILE_HASH >expect &&
>   git -C partial.git cat-file -s $FILE_HASH >actual &&
>   test_cmp expect actual
> 
> which reads more clearly to me (although I think the much more important
> test is that $FILE_HASH doesn't show up in the output of the rev-list
> --missing=print that is run in the partial clone).

That makes sense.

> > +	test_config -C full uploadpack.allowfilter 1 &&
> > +	test_config -C full uploadpack.allowanysha1inwant 1 &&
> > +	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
> > +	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
> 
> This works for me, although I wouldn't have been sad to see the
> sub-shell contain "git -C full rev-parse HEAD:file.txt" instead.

I'll do this too.

> > +	# Sanity check that the file is missing
> > +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
> > +	grep "[?]$FILE_HASH" out &&
> > +
> > +	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
> 
> Coming back to my point about the utility of the partial-clone helper,
> could this be replaced by saying just OUT="$(git -C partial.git cat-file
> -s "$FILE_HASH")" instead?
> 
> Thanks,
> Taylor

Same answer as above - I specifically want to test accessing (and
thereby lazy-fetching) an object when the object is not in
the_repository. I'll add some documentation to explain what it does and
that it's equivalent to using "git -C repo cat-file -s", except that
this specifically tests another code path.
