From: Jeff King <peff@peff.net>
Subject: Re: Detecting redundant commits
Date: Mon, 4 Jan 2016 23:00:26 -0500
Message-ID: <20160105040026.GB22620@sigill.intra.peff.net>
References: <nngtwmtwd2q.fsf@lnx-dag.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 05 05:00:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGInR-0003bH-JS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 05:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcAEEAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 23:00:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:48674 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753887AbcAEEA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 23:00:29 -0500
Received: (qmail 19587 invoked by uid 102); 5 Jan 2016 04:00:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 23:00:29 -0500
Received: (qmail 8869 invoked by uid 107); 5 Jan 2016 04:00:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 23:00:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 23:00:26 -0500
Content-Disposition: inline
In-Reply-To: <nngtwmtwd2q.fsf@lnx-dag.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283345>

On Mon, Jan 04, 2016 at 09:59:09AM -0600, greened@obbligato.org wrote:

> I am attempting to teach cherry-pick to handle redundant commits
> gracefully (via a new --skip-redundant-commits option) instead of
> aborting.  However, I'm struggling a bit with how to check if the
> changes in a commit will become redundant when appied to the new HEAD.
> 
> I found diff_tree_sha1 which seems promising.  Am I on the right track?
> If not, what's the best way to determine whether a commit object is
> redundant with respect to HEAD?

Do you mean commits that are in the cherry-pick range but have matching
commits already in HEAD? For that, you'd want to use patch-ids.[ch], but
I think we already do.

Or do you mean commits that, when applied, we find turn out to have
empty changes (e.g., because we have a set of commits that have
different patch-ids, but do roughly the same thing)? I don't think you
can find that with a straight end-to-end diff. You have try to apply and
then look at the result. I think we already catch that case (see
--allow-empty), though I think the only options are "preserve" or
"abort", not "silently skip" (and it sounds like the latter is what you
would want).

Or am I missing the point completely? :)

-Peff
