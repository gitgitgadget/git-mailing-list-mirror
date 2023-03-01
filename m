Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C480C678D4
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCAThU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCAThT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 14:37:19 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2764DE22
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 11:37:18 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8F5F183A2A;
        Wed,  1 Mar 2023 14:37:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=KJc4eNuOTeIpFFTIjikQPSCvdgGekRlrHdpgkxA
        o1A4=; b=Tk0/5rr0HEpek0sHiFo6Ss4PNV/0ErX7hMDShHWz0U48o+3tBRkbDgT
        0usk5GaiXgm9genChUOC12RveZnLnnoo7iyqbZslbnWuZvSPT9vS4Jlfs8jwh7/d
        ifG79Lbaomjn6ocW5ZqLeFhSz9Q2znyqSsdnTCQKWP7DadaSK3oE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1128183A29;
        Wed,  1 Mar 2023 14:37:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1571D183A28;
        Wed,  1 Mar 2023 14:37:14 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 1 Mar 2023 14:37:12 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: t3206-range-diff failures on non x86 arches (was: [ANNOUNCE] Git
 v2.40.0-rc1)
Message-ID: <Y/+paI8WGSmEbv/w@pobox.com>
References: <xmqqilfknzen.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilfknzen.fsf@gitster.g>
X-Pobox-Relay-ID: 779E82F2-B868-11ED-B9B6-2AEEC5D8090B-09356542!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> A release candidate Git v2.40.0-rc1 is now available for testing at
> the usual places.  It is comprised of 458 non-merge commits since
> v2.39.0, contributed by 78 people, 30 of which are new faces [*].

On Fedora, rc1 fails most tests in t3206-range-diff.sh on 3
of the 5 supported architectures: aarch64, ppc64le, and
s390x.  These tests succeed on i686 and x86_64.  They passed
on all arches with rc0.

Here's a snipptet from the test summary and a common failure
from the tests:

t3206-range-diff.sh                              (Wstat: 256 (exited 1) Tests: 42 Failed: 23)
  Failed tests:  2-4, 6, 8-19, 21-22, 32-34, 40, 42

+++ diff -u expect actual
--- expect	2023-03-01 18:23:20.689515509 +0000
+++ actual	2023-03-01 18:23:20.679515420 +0000
@@ -1,4 +1,4 @@
-1:  4de457d = 1:  35b9b25 s/5/A/
-2:  fccce22 = 2:  de345ab s/4/A/
-3:  147e64e = 3:  9af6654 s/11/B/
-4:  a63e992 = 4:  2901f77 s/12/B/
+1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:  35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/
+2:  fccce22f8c95220a7283f047ecc6f042a54ad902 = 2:  de345ab3de2b56a1e208e46197bb77829a6e1f3a s/4/A/
+3:  147e64ef5365f843f378dcfd60c4b8115146a35a = 3:  9af6654000a6c3235196f874c6fa58c970fcf233 s/11/B/
+4:  a63e992599e14e34a5664fe3f213fa8ad8977fe1 = 4:  2901f773f3f322646e189b37ffe99a47ad6d456a s/12/B/
error: last command exited with $?=1
not ok 2 - simple A..B A..C (unmodified)

I can share the full build log if it will help, though it's
rather large.  It includes the test-results and trash
directory, which can be extracted.  I've found that helpful
when I run into failures only on architectures for which I
don't have easy access.

Without bistecting, I'm guessing this is likely to be
related to this change?

>  * sscanf(3) used in "git symbolic-ref --short" implementation found
>    to be not working reliably on macOS in UTF-8 locales.  Rewrite the
>    code to avoid sscanf() altogether to work it around.
>    (merge 613bef56b8 jk/shorten-unambiguous-ref-wo-sscanf later to maint).

If it's not somewhat obvious to others, I can try to dig
more out of the build output later today.

-- 
Todd
