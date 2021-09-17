Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D3C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14343610D1
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 17:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhIQRdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 13:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhIQRdh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 13:33:37 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F3C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 10:32:15 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id q14so11106378ils.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 10:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EApCY58fQ94nk/pyGzXQBClmQQgZUTbj1B2kZlmSg4U=;
        b=HXNh/Q7TGy5EOoPUyoOzaUNwHb8aVHVJ3sLrhCHcQcrV/jZwNnNw02Sg0W3DI6Quy3
         /jAqc8GJLpXKq27PBbZktazmox7Cxyf+r2+Y3iqD/Rp5nJbWXTuQihER3p95lXM6XdGr
         Qd9ZmUZmUmfIWn70Hpx858GwHWyUUKe3fHe4dziQWQVcvVybf/8E/WSfFjGhcr8Jgla+
         g74gcmhX/oWjwI4B8EdAsVkxLy0gVmvYGI28qSnuX7tkXYWyvoWZukibPRqRgy+E4UlG
         OTjgZUvjJNLst5BVQvI/Cx0JdADJilYB090Tmda7fR//+yt5dw9qR8xUvD841HWkMrym
         aMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EApCY58fQ94nk/pyGzXQBClmQQgZUTbj1B2kZlmSg4U=;
        b=b+YscBXiZRF5ky8XJnvGuiMkVGDE3i8MOUSQrVM6IQC7qhkYJSF9U+pWl+kxXUo9lc
         8KW1y3JBOuSnzPIjBHvMadiHTyUchSFmTtWl5kHdBce4AJy+cE0SkSCWEbX0ZkitSI7+
         lsWGJAwftfV3kNb67eULKHu2fM/VU69xK3HzJMSjqdpO8z4waLApC91kL8wiSZWORL79
         gy/F4lCA5U1aG2YHomj21718+4+D7twI5nxRyKeB4PZghL6mWCHmDQcZAB89LxCvdH8d
         vPUtzIiu0XrsZ/DwIMkfQLilT6Xd1dlUOdXxq5LgztrwJ9PBzHNwvmWw25n07y5pl1vt
         PaRQ==
X-Gm-Message-State: AOAM533bFohvry35k30dpdLIcChyMqblGsaCkkn1A1+U2G/iFxs2igl6
        g+PS4XxhzE5YP3617NTfkeSDV8QNYkeHwZeH
X-Google-Smtp-Source: ABdhPJwpF5rGPxm4a5VDIkkvWEj//J7giqkhqXIMYnhmqCqpu2Z7dNj8rhIRLC1T1YRZp6XXRPyV1A==
X-Received: by 2002:a92:dc85:: with SMTP id c5mr8796210iln.104.1631899934667;
        Fri, 17 Sep 2021 10:32:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm3707129iog.47.2021.09.17.10.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:32:14 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:32:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 4/4] t5326: test propagating hashcache values
Message-ID: <YUTRHaHDjCaxmQyY@nand.local>
References: <cover.1631049462.git.me@ttaylorr.com>
 <acf3ec60cb6f151a9f121d242f38fef6711cced4.1631049462.git.me@ttaylorr.com>
 <87zgsnj0q0.fsf@evledraar.gmail.com>
 <YTggYXtyS/AW4JRF@nand.local>
 <87y27veeyj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y27veeyj.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 10:56:09AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> It seems the need for this "rm -fr repo" dance instead of just relying
> >> on test_when_finished "rm -rf repo" is because of a 3x tests in a
> >> function in tb/multi-pack-bitmaps that should probably be combined into
> >> one, i.e. they share the same logical "repo" setup.
> >
> > Yeah. There's definitely room for clean-up there if we want to have each
> > of the tests operate on the same repo. I have always found sharing a
> > repo between tests difficult to reason about, since we have to assume
> > that any --run parameters could be passed in.
> >
> > So I have tended to err on the side of creating and throwing away a new
> > repo per test, but I understand that's somewhat atypical for Git's
> > tests.
>
> Just in an effort to make myself clear here, because between your note
> in https://lore.kernel.org/git/YUOds4kcHRgMk5nC@nand.local/ and
> re-reading my mail here I can barely understand what I meant here :)

Thanks for clarifying; if I could summarize I would say that this
discussion got started since a new test I added starts with:

    rm -fr repo &&
    git init repo &&
    test_when_finished "rm -fr repo"

where the first rm is designed to clean any state left behind from the
split-up tests added in c51f5a6437c.

I understand your suggestion, and I even think that it may be worth
doing, but I'm not sure that I buy that any such cleanup is related to
this series for any reason other than "you happened to add a new test in
this file which extended the pattern".

So let's pursue the cleanup, but outside of this series (and maybe once
the dust has settled more generally on the MIDX bitmaps topics to avoid
having the maintainer deal with any conflicts).

> Or, you can also just not re-use the "repo" name, which is what I did in
> the fsck tests at
> https://lore.kernel.org/git/patch-v6-01.22-ebe89f65354-20210907T104559Z-avarab@gmail.com/;
> then you don't even need test_when_finished "rm -rf[ ...]".

TBH, I think that this is the most appealing thing to do. It's easy and
doesn't require us to think too hard about test_expect_setup or
sub-tests or anything like that where I'm not sure the complexity is
warranted.

I would probably do something like this:

--- >8 ---

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index ec4aa89f63..11845f67ae 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -132,12 +132,12 @@ test_expect_success 'clone with bitmaps enabled' '
 bitmap_reuse_tests() {
 	from=$1
 	to=$2
+	repo="bitmap-reuse-$from-$to"

 	test_expect_success "setup pack reuse tests ($from -> $to)" '
-		rm -fr repo &&
-		git init repo &&
+		git init $repo &&
 		(
-			cd repo &&
+			cd $repo &&
 			test_commit_bulk 16 &&
 			git tag old-tip &&

@@ -154,7 +154,7 @@ bitmap_reuse_tests() {

 	test_expect_success "build bitmap from existing ($from -> $to)" '
 		(
-			cd repo &&
+			cd $repo &&
 			test_commit_bulk --id=further 16 &&
 			git tag new-tip &&

@@ -170,7 +170,7 @@ bitmap_reuse_tests() {

 	test_expect_success "verify resulting bitmaps ($from -> $to)" '
 		(
-			cd repo &&
+			cd $repo &&
 			git for-each-ref &&
 			git rev-list --test-bitmap refs/tags/old-tip &&
 			git rev-list --test-bitmap refs/tags/new-tip
@@ -183,7 +183,6 @@ bitmap_reuse_tests 'MIDX' 'pack'
 bitmap_reuse_tests 'MIDX' 'MIDX'

 test_expect_success 'missing object closure fails gracefully' '
-	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
 	(
@@ -217,7 +216,6 @@ test_expect_success 'setup partial bitmaps' '
 basic_bitmap_tests HEAD~

 test_expect_success 'removing a MIDX clears stale bitmaps' '
-	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
 	(
@@ -284,7 +282,6 @@ test_expect_success 'pack.preferBitmapTips' '
 '

 test_expect_success 'hash-cache values are propagated from pack bitmaps' '
-	rm -fr repo &&
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
 	(
