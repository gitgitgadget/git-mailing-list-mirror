Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 519412018B
	for <e@80x24.org>; Mon, 20 Jun 2016 17:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbcFTRj5 (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:39:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:57366 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753622AbcFTRj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:39:56 -0400
Received: (qmail 31886 invoked by uid 102); 20 Jun 2016 17:13:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 13:13:14 -0400
Received: (qmail 16451 invoked by uid 107); 20 Jun 2016 17:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Jun 2016 13:13:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jun 2016 13:13:12 -0400
Date:	Mon, 20 Jun 2016 13:13:12 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	gitster@pobox.com, git@vger.kernel.org, VADIME@il.ibm.com
Subject: Re: [PATCH] shallow clone to not imply shallow submodules
Message-ID: <20160620171312.GA1880@sigill.intra.peff.net>
References: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <1466441998-18896-1-git-send-email-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1466441998-18896-1-git-send-email-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 09:59:58AM -0700, Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> Hi Junio, Peff,
> 
> I thought about this patch squashed into  
> "clone: do not let --depth imply --shallow-submodules" will actually test
> for the regression.

Yep, it looks good to me.

> +test_expect_success 'shallow clone does not imply shallow submodule' '
> +	test_when_finished "rm -rf super_clone" &&
> +	git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
> +	(
> +		cd super_clone &&
> +		git log --oneline >lines &&
> +		test_line_count = 2 lines
> +	) &&
> +	(
> +		cd super_clone/sub &&
> +		git log --oneline >lines &&
> +		test_line_count = 3 lines
> +	)
> +'

This follows the style of the other tests, so it's the right thing here.
But as a style suggestion, I think:

  git -C super_clone/sub log --oneline >lines &&
  test_line_count = 3 lines

is nicer than the subshell. It's more succinct, and it saves a process.

-Peff
