Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2161F855
	for <e@80x24.org>; Mon,  1 Aug 2016 21:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbcHAVS3 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 17:18:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:52861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752254AbcHAVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 17:18:28 -0400
Received: (qmail 18293 invoked by uid 102); 1 Aug 2016 21:18:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:18:28 -0400
Received: (qmail 18082 invoked by uid 107); 1 Aug 2016 21:18:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 17:18:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 17:18:25 -0400
Date:	Mon, 1 Aug 2016 17:18:25 -0400
From:	Jeff King <peff@peff.net>
To:	Dennis Putnam <dap1@bellsouth.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Recovering Folder from Git Restored Repo
Message-ID: <20160801211824.cmjhpvdlohla7cbk@sigill.intra.peff.net>
References: <84080bca-af5f-b957-460a-0a4a81f383e7@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84080bca-af5f-b957-460a-0a4a81f383e7@bellsouth.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 04:58:47PM -0400, Dennis Putnam wrote:

> I am in a bit of a pickle. I deleted a remote repo that had a folder
> that I belatedly realized I need. The deleted repo exists on a backup
> which I restored. How do I extract the needed folder from that restored
> repo. Not being a git expert I'm not sure what to do but I cannot find
> any recognizable sources. This is an 'ls' of the restored repo:
> 
> branches  config  description  HEAD  hooks  info  objects  ref

That's a "bare" repository, which has no matching working tree, just the
git data. The simplest thing may be to just clone it; the clone will
have a working tree:

  git clone /path/to/restored-repo tmp
  cd tmp

and then you can pick out whatever files you like.

You can also extract the data straight from the bare repository.  Try
"git ls-tree -r HEAD" to see the complete listing of files (replace HEAD
with the name of a specific branch if it was there). You can extract
individual files with "git show HEAD:path/to/file". Or you can generate
a tar or zip archive of a subtree like:

  git archive --format=zip HEAD:my-subdir >foo.zip

-Peff
