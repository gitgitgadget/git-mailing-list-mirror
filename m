Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6469DC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EED206D9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 21:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDUVGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:06:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:35006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725850AbgDUVGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 17:06:01 -0400
Received: (qmail 29647 invoked by uid 109); 21 Apr 2020 21:06:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 21 Apr 2020 21:06:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19027 invoked by uid 111); 21 Apr 2020 21:17:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Apr 2020 17:17:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Apr 2020 17:05:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: One failed self test on Debian HURD
Message-ID: <20200421210559.GA3510074@coredump.intra.peff.net>
References: <CAH8yC8kOT3Ur9AEyNEHynxvhkr5W0WOD1V8rgp-L5tM6a2zWhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kOT3Ur9AEyNEHynxvhkr5W0WOD1V8rgp-L5tM6a2zWhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 04:56:56PM -0400, Jeffrey Walton wrote:

> Debian HURD is catching a self test failure. It looks like its been
> seen on both 2.25 and 2.26. The report below is for Git 2.26.2.
> 
> Also see https://buildd.debian.org/status/fetch.php?pkg=git&arch=hurd-i386&ver=1%3A2.26.2-1&stamp=1587409938

That log shows the error in:

  expecting success of 1308.23 'proper error on directory "files"': 
        echo "Error (-1) reading configuration file a-directory." >expect &&
        mkdir a-directory &&
        test_expect_code 2 test-tool config configset_get_value foo.bar a-directory 2>output &&
        grep "^warning:" output &&
        grep "^Error" output >actual &&
        test_cmp expect actual
  test_expect_code: command exited with 128, we wanted 2 test-tool config configset_get_value foo.bar a-directory

Perhaps HURD needs the FREAD_READS_DIRECTORIES Makefile knob set?

-Peff
