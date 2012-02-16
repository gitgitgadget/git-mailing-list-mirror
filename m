From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 03:01:02 -0500
Message-ID: <20120216080102.GA11793@sigill.intra.peff.net>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:01:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwH8-0006kQ-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755336Ab2BPIBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:01:06 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38549
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab2BPIBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:01:04 -0500
Received: (qmail 27845 invoked by uid 107); 16 Feb 2012 08:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:08:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:01:02 -0500
Content-Disposition: inline
In-Reply-To: <20120214220953.GC24802@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190875>

On Tue, Feb 14, 2012 at 05:09:53PM -0500, Jeff King wrote:

> > Hmm, I thought t1305 covered "config --list", and ... oops, it makes sure
> > the output contains the inclusion.
> 
> Yes. It should include it (and does correctly) when not using any
> per-file options, but does not correctly turn it off for the per-file
> case (because we bail to regular git_config instead of custom lookup
> code).
> 
> > > Do you want to revert and re-do to make master pretty, or should I just
> > > build on top?
> > 
> > Do you mean 'next'?
> 
> I meant "revert from next and re-reroll, so that when the re-roll gets
> merged to master, the result there will look pretty".

The fix for this is pretty straightforward. However, I took the
opportunity to do some cleanup and fix some minor bugs while I was in
the area, and ended up with quite a big series.

I prepared this on top of what you have queued in jk/config-include.
However, all of the cleanup is semantically independent of the topic
(though there are a few minor textual conflicts). If I were re-rolling,
I would put it all at the front, then squash patch 8 into my prior
"implement config includes" patch.

The patches are:

  [1/8]: t1300: add missing &&-chaining

Obvious cleanup.

  [2/8]: config: copy the return value of prefix_filename

Very minor bug.

  [3/8]: config: teach git_config_set_multivar_in_file a default path
  [4/8]: config: teach git_config_rename_section a file argument
  [5/8]: config: provide a version of git_config with more options
  [6/8]: config: stop using config_exclusive_filename
  [7/8]: config: eliminate config_exclusive_filename

This is all cleanup which makes config_exclusive_filename go away. It's
not strictly necessary for this series, but it's something I've been
wanting to clean up for a while. And it does fix a few minor bugs (see
patch 6/8). And the refactoring in 5/8 lays the groundwork for 8/8.

  [8/8]: config: do not respect includes for single-file --list

The actual fix for the regression in my config-include patch.

-Peff
