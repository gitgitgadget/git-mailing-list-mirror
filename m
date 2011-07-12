From: Jeff King <peff@peff.net>
Subject: Re: Tracking changes in git with a change number....
Date: Tue, 12 Jul 2011 01:50:08 -0400
Message-ID: <20110712055008.GC11644@sigill.intra.peff.net>
References: <C785F567A08DDE449FD4590C91E6AD13CB34BE@naeamillez01v.nadsusea.nads.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Rice, James M CIV NSWCDD, K73" <james.rice2@navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 12 07:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgVrO-0005pp-25
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 07:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890Ab1GLFuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 01:50:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43093
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295Ab1GLFuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 01:50:10 -0400
Received: (qmail 8903 invoked by uid 107); 12 Jul 2011 05:50:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 01:50:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 01:50:08 -0400
Content-Disposition: inline
In-Reply-To: <C785F567A08DDE449FD4590C91E6AD13CB34BE@naeamillez01v.nadsusea.nads.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176916>

On Mon, Jul 11, 2011 at 01:29:52PM -0400, Rice, James M CIV NSWCDD, K73 wrote:

> Restating the problem.  I wish for our developers to be able to
> reference multiple commits with one number, and then find those
> commits via that number.  And I don't mind scripting to accomplish
> this.  I know, that CR # can be put in the commit message, then I can
> grep and parse the log, that is the hard way.

There are two ways to approach this: tell the CM tool about some git
commits, or tell some git commits about the CR number.

For telling the CM tool about git commits, refer to them by their sha1
commit ids.  If the commits are sequential, you can refer to the
sequence by its endpoints. And then if you want to know which files were
touched, you can just diff the endpoints, like:

  $ git diff-tree --name-only $start $end

It's not a number, exactly, but it is a fixed size (two 40-byte commit
ids). Would that work in your CM tool?

If the commits aren't sequential, you can do something similar, but you
have a variable-length list of commit ids, and you get the set of
changed files like:

  $ for i in $commits; do
      git diff-tree --name-only $i |
      tail -n +2
    done | sort -u

If you want to do the reverse and tell git about CR numbers, then I
don't think you have much option besides putting them in the commit
message. Which means you'll need to grep to get them out. You can do
something like:

  $ git log --grep='CR#' --pretty=format: --name-only

-Peff
