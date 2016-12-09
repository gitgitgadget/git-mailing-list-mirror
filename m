Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5FA71FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 14:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932214AbcLIOLd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 09:11:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:54175 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbcLIOLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 09:11:32 -0500
Received: (qmail 31301 invoked by uid 109); 9 Dec 2016 14:11:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 14:11:32 +0000
Received: (qmail 18475 invoked by uid 111); 9 Dec 2016 14:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Dec 2016 09:12:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2016 09:11:30 -0500
Date:   Fri, 9 Dec 2016 09:11:30 -0500
From:   Jeff King <peff@peff.net>
To:     Ariel <asgit@dsgml.com>
Cc:     git@vger.kernel.org
Subject: Re: git add -p with new file
Message-ID: <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 08:18:59PM -0500, Ariel wrote:

> If you do git add -p new_file it says:
> 
> No changes.
> 
> Which is a rather confusing message. I would expect it to show me the
> content of the file in patch form, in the normal way that -p works, let me
> edit it, etc.
> 
> (Note: I am aware I can do -N first, but when I specifically enter the name
> of a new file I feel it should figure out what I mean.)

Keep in mind that the argument to "git add -p" is not a filename, but a
"pathspec" that can match many files. What should:

  git init
  mkdir subdir
  for i in one two; do echo $i >subdir/$i; done
  git add -p subdir

do?  Or for that matter, "git add -p ."? It's contrary to the rest of
git-add for specifying pathspecs to actually make things _more_
inclusive rather than less.

So I don't think triggering the change of behavior based on the presence
of a pathspec makes sense.

Historically "add -p" has been more like "add -u" in updating tracked
files. We have "-A" for "update everything _and_ new files". It doesn't
seem unreasonable to me to have a variant of "-p" that is similar.

I don't think that variant should just be "add -N everything, and then
run add -p". As Duy points out, the patch for a new file is just one big
block. But the decision of "do I want to start tracking this untracked
file" is potentially an interesting one.

-Peff
