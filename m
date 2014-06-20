From: Jeff King <peff@peff.net>
Subject: Re: search for equivalent commits by patch-id
Date: Fri, 20 Jun 2014 03:43:46 -0400
Message-ID: <20140620074346.GA3778@sigill.intra.peff.net>
References: <53A2D6E9.30341.4A8A1942@vicentiu.neagoe.ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: vicentiu.neagoe@ni.com
X-From: git-owner@vger.kernel.org Fri Jun 20 09:43:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxtUG-0003Fd-QO
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 09:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934742AbaFTHnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 03:43:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:48030 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934161AbaFTHns (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 03:43:48 -0400
Received: (qmail 13516 invoked by uid 102); 20 Jun 2014 07:43:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jun 2014 02:43:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jun 2014 03:43:46 -0400
Content-Disposition: inline
In-Reply-To: <53A2D6E9.30341.4A8A1942@vicentiu.neagoe.ni.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252217>

On Thu, Jun 19, 2014 at 03:26:17PM +0300, vicentiu.neagoe@ni.com wrote:

> Is there a way to find all equivalent commits by patch-id?
> 
> Something similar to:
> 
> git branch -a --commit <commit>
> 
> but instead of <commit> to search by patch-id.

There isn't a ready-made command to do so, but you can easily script it:

  git for-each-ref --format='%(refname)' refs/heads |
  while read ref; do
	echo "$(git diff-tree -p "$ref" | git patch-id) $ref"
  done |
  grep $PATCH_ID_YOU_ARE_LOOKING_FOR

If you want to look further back than the tips, you can feed the
branches to rev-list, and then patch-id each commit you find.

The more common way to use patch-ids is to look for commits that are in
one branch but not another. For that, try the "--cherry-pick" and
"--cherry-mark" options to "git log".

-Peff
