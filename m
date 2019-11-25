Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68330C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4897F20740
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 14:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfKYOQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 09:16:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:59934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727666AbfKYOQg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 09:16:36 -0500
Received: (qmail 26367 invoked by uid 109); 25 Nov 2019 14:16:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 14:16:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18890 invoked by uid 111); 25 Nov 2019 14:20:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 09:20:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 09:16:35 -0500
From:   Jeff King <peff@peff.net>
To:     Chen Bin <chenbin.sh@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: A new idea to extend git-blame
Message-ID: <20191125141635.GD494@sigill.intra.peff.net>
References: <87o8x06sbw.fsf@sydneypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o8x06sbw.fsf@sydneypc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 11:41:55PM +1100, Chen Bin wrote:

> The key algorithm is simple,
> 
> The algorithm only works for one line blame and the user must
> select text inside the line first.
> 
> Step 1, `git blame -L6,1 --porcelain -- hello.js` output,
> 
>     4f87408612e0dacfd89a1cd2515944e21cf68561 6 6 1
>     skip...
>     filename hello.js
>      doit({bad: 'destroy world', good: 'hello world', ...});
> 
> I got the commit id (1st column), the line number (2nd column),
> file name (hello.js) and the code line (last line).
> 
> Step 2, if the code line does not contain the selected text, the
>   recursive search stops
> 
> Step 3, or else use commit id, line number and file name to build
>   new git blame cli, like,
> 
> `git blame -L line-num,1 --porcelain 4f8740^ file-name`
> 
> Step 4, execute new git blame command and start from Step 1

This sounds a lot like how git-log's "-L" option works, which tries to
find the history of a line over many changes.

It's also similar to the "re-blame from parent" feature of many blame
viewers. There we have a human in the loop saying "no, this is not quite
the change I'm looking for; go back further".

-Peff
