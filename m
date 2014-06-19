From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 04:54:47 -0400
Message-ID: <20140619085447.GA1009@sigill.intra.peff.net>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <20140618191407.GX8557@google.com>
 <20140619080432.GB15698@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:54:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxY7V-0006pT-2d
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 10:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757610AbaFSIyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 04:54:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:47341 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757571AbaFSIyu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 04:54:50 -0400
Received: (qmail 10419 invoked by uid 102); 19 Jun 2014 08:54:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 19 Jun 2014 03:54:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2014 04:54:47 -0400
Content-Disposition: inline
In-Reply-To: <20140619080432.GB15698@hudson.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252103>

On Thu, Jun 19, 2014 at 01:04:32AM -0700, Jeremiah Mahler wrote:

> > After looking at the patches I suspect this should be a single patch.
> > That way it's bisectable, and the changes outside of read-cache.c are
> > small enough that it's not too much of a burden to review as a single
> > patch.
> > 
> That would be a pain to bisect if the partial application of the patch
> set left the system in a broken state.  Good suggestion.

One trick I use, especially when refactoring, is to use an interactive
rebase to test each commit in isolation, like:

  GIT_EDITOR='sed -i "/^pick .*/aexec make -j8 test"' git rebase -i

After picking each commit, that will run the tests on each one[1]. If it
fails, the rebase will pause. You can fix any problems, test to your
satisfaction, "commit --amend", and then "rebase --continue" to keep
going.

-Peff

[1] Of course it can be rather time-consuming for a large series. I
    often just compile-test at first, and then do a final "make test"
    pass when I think everything is right.
