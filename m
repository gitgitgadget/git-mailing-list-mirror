From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2/GSoC 2/4] path.c: implement xdg_runtime_dir()
Date: Thu, 17 Mar 2016 14:13:11 -0400
Message-ID: <20160317181311.GB23669@sigill.intra.peff.net>
References: <1458233326-7735-1-git-send-email-huiyiqun@gmail.com>
 <1458233326-7735-2-git-send-email-huiyiqun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, pickfire@riseup.net
To: Hui Yiqun <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 19:13:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agcQA-0006oN-Jj
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 19:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936359AbcCQSNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 14:13:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:33531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932875AbcCQSNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 14:13:14 -0400
Received: (qmail 17012 invoked by uid 102); 17 Mar 2016 18:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 14:13:13 -0400
Received: (qmail 2892 invoked by uid 107); 17 Mar 2016 18:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 14:13:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2016 14:13:11 -0400
Content-Disposition: inline
In-Reply-To: <1458233326-7735-2-git-send-email-huiyiqun@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289137>

On Fri, Mar 18, 2016 at 12:48:44AM +0800, Hui Yiqun wrote:

> this function does the following:
> 
> 1. if $XDG_RUNTIME_DIR is non-empty, `$XDG_RUNTIME_DIR/git` is used in next
> step, otherwise `/tmp/git-$uid` is taken.
> 2. ensure that above directory does exist. what's more, it must has correct
> permission and ownership.
> 3. a newly allocated string consisting of the path of above directory and
> $filename is returned.
> 
> Under following situation, NULL will be returned:
> + the directory mentioned in step 1 exists but have wrong permission or
> ownership.
> + the directory or its parent cannot be created.
> 
> Notice:
> 
> + the caller is responsible for deallocating the returned string.

I see a lot of "what" in your commit message (and in the other ones in
this series), but not a lot of "why".

We can see the "what" from the diff already (though it is certainly OK
to point out tricky parts). But you probably want to explain the
motivation for things, alternatives considered, etc, like:

  - why is using $XDG_RUNTIME_DIR a good thing?

  - why did you choose to fall back to /tmp (as opposed to, say,
    returning NULL and letting the caller handle it)

  - what is the purpose of the ownership/permission rules? You link to
    the XDG spec in an in-code comment, but IMHO that kind of motivation
    probably makes more sense in the commit message.

-Peff
