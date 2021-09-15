Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FD2C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD344611C7
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 22:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhIOWej (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 18:34:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57470 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbhIOWeh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 18:34:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1EDDCE83BC;
        Wed, 15 Sep 2021 18:33:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=hMJhSJr9+R3E4lCk8Qz2F/2sx8CAnzZyN+SZDWrH8pQ=; b=igkP
        vfcxxVCgZAtjAMiYck3Q/vmYK4Ub+qthvBAo24zZ8r4Ugr+eNGuS2x5s1RgGjrnw
        K7biDEcrAnAF2sYmO4fRw5fd0V9JCxtOTkkFeJkiFYY9bZpuKvDhRFos9DjyqDnD
        oZM7yiKUMcB2EnwSVkrjOQIcMX6k2RZ2F3rIGOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16E35E83BB;
        Wed, 15 Sep 2021 18:33:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87ED3E83B8;
        Wed, 15 Sep 2021 18:33:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/2] (experimental) diff --quote-path-with-sp
Date:   Wed, 15 Sep 2021 15:33:14 -0700
Message-Id: <20210915223316.1653443-1-gitster@pobox.com>
X-Mailer: git-send-email 2.33.0-649-gd4f4107c2b
MIME-Version: 1.0
X-Pobox-Relay-ID: EC28D222-1674-11EC-8BB2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Long time ago, we had a discussion with GNU patch/diff maintainer
and agreed that pathnames with certain "difficult" bytes needs to be
quoted to ensure the resulting patch is machine parseable in an
unambiguous way [*1*].  Recently, we saw a report that found that
GNU patch is unhappy with our diff output for a path with SP in it
[*2*].

With this experimental option, the beginning part of the patch
output will have pathnames with SP in them enclosed inside a pair of
double quotes, like so:

	diff --git "a/A Name" "b/A Name"
	--- "a/A Name"
	+++ "b/A Name"

We have always done this enclosing inside dq when the pathname had
an even more difficult byte (like LF, double quotes, and HT), so we
know Git tools can handle such a patch output just fine already.

 *1* https://lore.kernel.org/git/87ek6s0w34.fsf@penguin.cs.ucla.edu/
 *2* https://lore.kernel.org/git/YR9Iaj%2FFqAyCMade@tilde.club/


Junio C Hamano (2):
  diff: simplify quote_two()
  diff: --quote-path-with-sp

 Documentation/diff-options.txt |  5 +++++
 diff.c                         | 26 ++++++++++----------------
 diff.h                         |  1 +
 quote.c                        | 23 ++++++++++++++++++-----
 quote.h                        |  3 ++-
 t/t3902-quoted.sh              | 24 +++++++++++++++++++++++-
 6 files changed, 59 insertions(+), 23 deletions(-)

--=20
2.33.0-649-gd4f4107c2b

