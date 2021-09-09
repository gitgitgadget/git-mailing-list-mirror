Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CF5C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7D161186
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbhIIDBN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:01:13 -0400
Received: from avasout07.plus.net ([84.93.230.235]:34222 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbhIIDBM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:01:12 -0400
Received: from [10.0.2.15] ([195.213.6.49])
        by smtp with ESMTPA
        id OAI9m3pVzdY2SOAIAmqH0I; Thu, 09 Sep 2021 04:00:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1631156402; bh=f0EcOwOFy+/KPsbaOJybbyLBZAqpyW8thCRTA/RQyjg=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=KaW3eV5dWAhe8F4ITkBUnlTWVay3TyIRi0lnuBzqwXNR2SXQl3Us07U5M1OHKCfOc
         99JRlT2apQk+/8cvbvGajhjp9QJPYe0kpFKv6VmWC3cQlE8f9pOqsv4TwykdIjCAA0
         yjcP2pf+oe6c7yVdWUTAn5JWdrWxzBdThiUqj40eVDG7mlvyxHCako9qcJquFBQOBY
         kiq7DOF7pwlF8Mqe5Qys0Zsd4l+3SWPhVYCKXw4rpAqjNCBGVfjQGn4KeRtzFhqIuH
         DOkTAZ8S9Y4AgjdVNTq6ymFHNfYiWM5h/N0MDrfNzikKxspyJB97CTk6D4/Ko7eGcr
         YYELRRxvVeMXQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NP5OB3yg c=1 sm=1 tr=0
 a=ng+ES6eBAmcw5j0aA4HDOQ==:117 a=ng+ES6eBAmcw5j0aA4HDOQ==:17
 a=IkcTkHD0fZMA:10 a=stkexhm8AAAA:8 a=__yGolY-nz7B_ldSFkcA:9 a=QEXdDO2ut3YA:10
 a=pIW3pCRaVxJDc-hWtpF8:22
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfyf5b74.fsf@gitster.g>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <c0c24993-77e2-51a1-c352-0399c59f1f94@ramsayjones.plus.com>
Date:   Thu, 9 Sep 2021 03:59:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP0OyreJ5129fkhLW6C7ScdJrZJqAmsaHI0Mxde48dC5T2jUYH7ASRGSKC3Rqo661M/+v4+/E2nljUjSe152WnxymAA03lQUCz/q5veVxK8NhqRhxrK7
 JQjEVZ9QVoIyGO8G0I1hOWBhOThYA6A+V9MNdQQzcx1wWHpJZ4JuasY7n/2e4eZWj2NlzvWLc5r+qg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 08/09/2021 16:38, Junio C Hamano wrote:

test t5319-multi-pack-index.sh on 'seen' has been failing for
several days, so I had a quick look tonight. This issue relates
to the following two topics:

> * jb/midx-revindex-fix (2021-08-23) 1 commit
>  - multi-pack-index: fix *.rev cleanups with --object-dir
> 
>  An implementation in "multi-pack-index write" that takes object
>  directory inconsistently used that and the object store of the
>  default repository, causing segfaults and possibly corrupting
>  repositories.
> 
>  On hold.
>  cf. <xmqqo89jbf49.fsf@gitster.g>
> 

...

> * tb/multi-pack-bitmaps (2021-09-01) 27 commits
>  - p5326: perf tests for MIDX bitmaps
>  - p5310: extract full and partial bitmap tests
>  - midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
>  - t7700: update to work with MIDX bitmap test knob
>  - t5319: don't write MIDX bitmaps in t5319
>  - t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
>  - t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
>  - t5326: test multi-pack bitmap behavior
>  - t/helper/test-read-midx.c: add --checksum mode
>  - t5310: move some tests to lib-bitmap.sh
>  - pack-bitmap: write multi-pack bitmaps
>  - pack-bitmap: read multi-pack bitmaps
>  - pack-bitmap.c: avoid redundant calls to try_partial_reuse
>  - pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
>  - pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
>  - pack-bitmap.c: introduce 'bitmap_num_objects()'
>  - midx: avoid opening multiple MIDXs when writing
>  - midx: close linked MIDXs, avoid leaking memory
>  - midx: infer preferred pack when not given one
>  - midx: reject empty `--preferred-pack`'s
>  - midx: clear auxiliary .rev after replacing the MIDX
>  - midx: fix `*.rev` cleanups with `--object-dir`
>  - midx: disallow running outside of a repository
>  - Documentation: describe MIDX-based bitmaps
>  - pack-bitmap-write.c: free existing bitmaps
>  - pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
>  - pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
> 
>  The reachability bitmap file used to be generated only for a single
>  pack, but now we've learned to generate bitmaps for history that
>  span across multiple packfiles.
> 
>  Will merge to 'next'.

The merge commit 24cade3ceb ("Merge branch 'jb/midx-revindex-fix' into seen",
2021-09-07) basically takes two versions of the same patch and keeps both
versions of the same test. The two patches are:

  - c575d4a2d9 ("multi-pack-index: fix *.rev cleanups with --object-dir",
    2021-08-23)
  - 426c00e454 ("midx: fix `*.rev` cleanups with `--object-dir`", 2021-08-31)

(the second patch is from the 'tb/multi-pack-bitmaps' branch).

The second patch even includes an acknowledgment of 'Original-patch-by:
Johannes Berg <johannes@sipsolutions.net>' (ie the first patch).

  $ ./t5319-multi-pack-index.sh -i -v
...
  expecting success of 5319.19 'multi-pack-index *.rev cleanup with --object-dir':
...
  ok 19 - multi-pack-index *.rev cleanup with --object-dir

  expecting success of 5319.20 'multi-pack-index *.rev cleanup with --object-dir':
...
  fatal: not a git repository (or any of the parent directories): .git
...
  $

The 'fatal' message is issued by a call to 'nongit git multi-pack-index ... write'
command, which implies that 'git multi-pack-index' dies when not run from
a repository. When the original patch was written, that command would not
have died, so somewhere between v2.33.0 and 'seen' (maybe as part of the
'tb/multi-pack-bitmaps' branch, I haven't looked), that was changed and
that test no longer works.

If I had to change that test to take account of that change in behaviour,
then it would look pretty much the same as the new test in Taylor's commit
(and which can now be seen as test #19 above).

So, a solution would be to simply drop 'jb/midx-revindex-fix', since it
has effectively been incorporated into Taylor's branch. You could also
go the other way around, drop commit 426c00e454 from Taylor's branch and
fix up the test in Johannes's patch ... :-P

Well, I only had a quick look so (hopefully) I haven't missed something
obvious!

ATB,
Ramsay Jones

