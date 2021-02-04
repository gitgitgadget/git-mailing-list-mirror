Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25584C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 15:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF70F64F78
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 15:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbhBDPrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 10:47:36 -0500
Received: from joooj.vinc17.net ([155.133.131.76]:58150 "EHLO joooj.vinc17.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237485AbhBDPi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 10:38:56 -0500
Received: from smtp-zira.vinc17.net (128.119.75.86.rev.sfr.net [86.75.119.128])
        by joooj.vinc17.net (Postfix) with ESMTPSA id E4265304;
        Thu,  4 Feb 2021 16:38:12 +0100 (CET)
Received: by zira.vinc17.org (Postfix, from userid 1000)
        id 98937C20303; Thu,  4 Feb 2021 16:38:12 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:38:12 +0100
From:   Vincent Lefevre <vincent@vinc17.net>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git fails with a broken pipe when one quits the pager
Message-ID: <20210204153812.GI148009@zira.vinc17.org>
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144857.GB24560@zira.vinc17.org>
 <87a6snokrr.fsf@evledraar.gmail.com>
 <20210203152634.GA22673@joooj.vinc17.net>
 <87v9b8d6zx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9b8d6zx.fsf@evledraar.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.0.5+101 (ab6d0dc5) vl-132933 (2021-01-27)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-02-04 01:14:10 +0100, Ævar Arnfjörð Bjarmason wrote:
> Have you reported this as a bug to zsh?

I repeat: there is no bug in zsh. It is my choice to output the
exit status when it is non-zero because I want to know when the
command I've typed fails. This is useful in practice. Ignoring the
specific value 141 (corresponding to SIGPIPE) is not a solution
because it can be a real failure with some utilities. BTW, the
association with a signal like SIGPIPE is just a convention; apart
from that, 141 is a non-zero status like others (in particular
with programs that have not been written for POSIX).

For instance, in any shell:

$ sh -c "echo foo; exit 141"
foo
$ echo $?
141

while no broken pipe is involved here. How would you differentiate
such a failure from a broken pipe?

> I also tested "hg log", it behaves the same way, although interestingly
> they cast SIGPIPE to 255 in their exit code.

I get 141, like with git:

$ hg log
$ echo $?
141

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / AriC project (LIP, ENS-Lyon)
