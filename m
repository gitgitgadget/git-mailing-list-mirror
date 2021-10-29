Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B33C4332F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E9060234
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhJ2Hvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:51:51 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33976 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232322AbhJ2Hv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 03:51:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D24461F953;
        Fri, 29 Oct 2021 07:48:57 +0000 (UTC)
Date:   Fri, 29 Oct 2021 07:48:57 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] tests: disable fsync everywhere
Message-ID: <20211029074857.GA9214@dcvr>
References: <20211028002102.19384-1-e@80x24.org>
 <YXq1g4Zwfq8gJEoC@coredump.intra.peff.net>
 <20211028182824.GA1307@dcvr>
 <xmqqilxhq774.fsf@gitster.g>
 <20211029001552.GA29647@dcvr>
 <xmqqy26cl1zd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy26cl1zd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > v2 changes:
> > * s/GIT_FSYNC/GIT_TEST_FSYNC/
> > * disable fsync by default for tests, reduces setup for newcomers
> > * fix style nit noted by Eric Sunshine
> 
> https://github.com/git/git/runs/4043532265?check_suite_focus=true#step:5:70

Fwiw, I couldn't view that (not sure if it's from lack of JS
or lack of GH account).  Either way it's accessibility problem.

> Seems to be dying in "git svn" tests somehow.

Easy repro+fix, though.  I only tested my final patch with NO_SVN_TESTS :x
Can you squash this in or do you want a reroll?

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index df5a87a151..6ce2e283c8 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2274,7 +2274,7 @@ sub use_fsync {
 	if (!defined($_use_fsync)) {
 		my $x = $ENV{GIT_TEST_FSYNC};
 		if (defined $x) {
-			my $v = command_oneline('git', '-c', "test.fsync=$x",
+			my $v = command_oneline('-c', "test.fsync=$x",
 					qw(config --type=bool test.fsync));
 			$_use_fsync = defined($v) ? ($v eq "true\n") : 1;
 		}
