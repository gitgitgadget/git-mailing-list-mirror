From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Advice on strategy for "temporary" commits
Date: Thu, 8 Mar 2007 11:32:39 -0500
Message-ID: <20070308163239.GH22713@fieldses.org>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 17:32:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPLXE-0001yR-0U
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 17:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXCHQcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 11:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbXCHQcE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 11:32:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:45543 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490AbXCHQcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 11:32:03 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HPLXj-0001Od-Ee; Thu, 08 Mar 2007 11:32:39 -0500
Content-Disposition: inline
In-Reply-To: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41754>

On Thu, Mar 08, 2007 at 02:39:46PM +0000, David Tweed wrote:
> Hi,
> 
> I've been working with my system taking automatic
> hourly git snapshots of (filtered portions of) my home
> directory for a couple of months. Being able to look
> back to what files looked like mid-afternoon yesterday,
> or on 18 Nov, is proving modestly useful. However,
> I'm thinking about adding "temporary" commits every
> ten minutes which then get discarded after 5 hours-ish
> (in addition to the long-term archival hourly commits).
> This is motivated by the desire to have finer granularity
> for testing/bisecting short-term regressions but not having
> ridiculously fine-grained changes clogging up the
> archive long-term. (I'm aware that with the commits
> being primarily taken on a timed basis I'll have more
> non-compiling changes than is usual in a repository, so
> that this may not turn out to be useful in practice.)
> 
> Looking through the git docs, it looks like the most
> natural way of doing this is to make the 10-min commits
> (via cron & tagging them under a special tag "temporary
> commits only" directory) and then use
> 
> git-rebase --onto start-tag end-tag branch
> 
> every so often (via cron again) to chop the older
> temporary commits between start-tag and end-tag
> out of the database.

You don't want to run git-rebase out of a cron job, because it may
require human interaction.

The simplest thing might be to make the temporary commits onto a
separate branch, and throw that branch away periodically.

--b.
