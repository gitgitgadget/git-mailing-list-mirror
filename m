From: Jeff King <peff@peff.net>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 12:50:40 -0500
Message-ID: <20120113175040.GC9373@sigill.intra.peff.net>
References: <loom.20120112T193624-86@post.gmane.org>
 <loom.20120113T181805-423@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yves Goergen <nospam.list@unclassified.de>
X-From: git-owner@vger.kernel.org Fri Jan 13 18:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RllH7-0004QF-Fh
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 18:50:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab2AMRuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 12:50:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36779
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917Ab2AMRun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 12:50:43 -0500
Received: (qmail 10985 invoked by uid 107); 13 Jan 2012 17:57:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jan 2012 12:57:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jan 2012 12:50:40 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120113T181805-423@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188521>

On Fri, Jan 13, 2012 at 05:37:38PM +0000, Yves Goergen wrote:

> After asking several people who didn't believe me,
> after all I could pass all checks to ensure that
> the file in question really is tracked, despite the error
> message telling it is not. (The file has a history, it is
> part of the branch,
> git status behaves as expected when I rename it, and so on.)

Whether a file in the working tree is tracked or not does not have to do
with the history, but rather with whether it is mentioned in the index.

Does the file appear in "git ls-files"?

It sounds like you are perhaps making changes in the working tree and
index, and then trying to checkout/merge on top of that. In that case
"git status" would report the file as renamed, but it's possible the
file is still in the working tree. From git's perspective the file is no
longer tracked, but the operations you are requesting would overwrite
the new contents (and git is being safe by refusing to do so).

Generally you don't want to merge with uncommitted changes like this.
You would want to commit them and then do your merge.

But even if you do commit, the question still remains: if you have
committed the removal of this file, then why is it still there? Is
something else creating it after you have deleted it?

-Peff
