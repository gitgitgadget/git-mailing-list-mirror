Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989721F462
	for <e@80x24.org>; Thu, 23 May 2019 15:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbfEWPEX (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 11:04:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62245 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfEWPEX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 11:04:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1755113C6C4;
        Thu, 23 May 2019 11:04:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=mVj2I1ARkbeZ4jRROBxU2bo2S98=; b=wkOLsWC
        7T1zl+ZO0l3cJu5GANSxQnUKfTLWcSgZmjU9bXpljb0aWp5PgAOKgv6W3AsVXiK9
        cmlh9+gkAec2D/ZVUWrTtP5OPP5XWthVim5cilPjeN6jQ0GuYAYUXWwjCwSDYBBq
        WkhvVqVxQUOh9Qj3d/UYCiNTATqr7I1kGerU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=ewDgYKIf4CHidoirhr91+3OlczIZCRZer
        fMFeszxhTNY4qcvZardPCvYh4zTMftNmMls4CO1il49uxwHrko6MQicBhiqV3Tw3
        CW1YuvyowiNpl2SrBadlr4e/AO6CgdKl1WKR3HQe+phumrJvgGNMpy/9wUQUuOAc
        ZPtG3CtGRc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E7F113C6C3;
        Thu, 23 May 2019 11:04:19 -0400 (EDT)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71AA313C6C2;
        Thu, 23 May 2019 11:04:18 -0400 (EDT)
Date:   Thu, 23 May 2019 11:04:16 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git-packagers@googlegroups.com
Subject: New diff test failures on s390x architecture (was: [ANNOUNCE] Git
 v2.22.0-rc1)
Message-ID: <20190523150416.GL3654@pobox.com>
References: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36la24t1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 09C35892-7D6C-11E9-8E0A-72EEE64BB12D-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[-cc: lkml, +cc: Duy as author of a good number of
diff-related commits in 2.22.0 :) ]

Hi,

While running the 2.22.0-rc1 tests on Fedora, I hit a few
new test failures since 2.21.0 -- but only on the s390x
architecture.

I haven't had time to dig into these the past few days, so I
thought I would send what I do have in case the problem is
obvious to someone else.  I think all of the failing tests
are due to `git diff` commands.

Test Summary Report
-------------------
t4017-diff-retval.sh                             (Wstat: 256 Tests: 24 Failed: 1)
  Failed test:  2
  Non-zero exit status: 1
t4015-diff-whitespace.sh                         (Wstat: 256 Tests: 83 Failed: 11)
  Failed tests:  2-7, 9, 11, 52-53, 79
  Non-zero exit status: 1
t4035-diff-quiet.sh                              (Wstat: 256 Tests: 22 Failed: 4)
  Failed tests:  17-20
  Non-zero exit status: 1
t4040-whitespace-status.sh                       (Wstat: 256 Tests: 11 Failed: 4)
  Failed tests:  3, 5, 7, 9
  Non-zero exit status: 1
t4038-diff-combined.sh                           (Wstat: 256 Tests: 24 Failed: 3)
  Failed tests:  10-12
  Non-zero exit status: 1
t4050-diff-histogram.sh                          (Wstat: 256 Tests: 3 Failed: 1)
  Failed test:  1
  Non-zero exit status: 1
t4061-diff-indent.sh                             (Wstat: 256 Tests: 33 Failed: 19)
  Failed tests:  2-4, 8, 12, 14, 18, 20-21, 24-33
  Non-zero exit status: 1
t4065-diff-anchored.sh                           (Wstat: 256 Tests: 7 Failed: 1)
  Failed test:  6
  Non-zero exit status: 1
t4253-am-keep-cr-dos.sh                          (Wstat: 256 Tests: 7 Failed: 1)
  Failed test:  7
  Non-zero exit status: 1

The test output from '-x --verbose-log' is quite verbose and
the issues are often in whitespace/end-of-line which might
be mangled by some MTA/MUA.  So the output is at:

    https://tmz.fedorapeople.org/git-2.22.0-rc1-s390x-failures (327K)

I don't have direct access to these s390x builders.  I may
be able to arrange shell access (or even reproduce this with
qemu's s390x emulation).

Before I go further down that road, I wanted to see if this
output might be enough to point to the problem.  If not, I
can run the failing tests with the --debug option and save
the trash directory (unless I can get more direct access to
the s390x builder to be able to bisect).

I rebuilt git-2.21.0 on the same s390x builder successfully,
so I don't think this issue is a bug in another of the
packages in the current Fedora tree.  But it's certainly
possible that git-2.22.0-rc1 is just tickling a real bug in
some other tool/library on s390x.

Thanks for any help in narrowing this down.

-- 
Todd
