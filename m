From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 7/9] Add a job to refresh projects when the index
	changes.
Date: Fri, 11 Jul 2008 04:33:17 +0000
Message-ID: <20080711043317.GD32633@spearce.org>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-2-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-3-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-4-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-5-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-6-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-7-git-send-email-robin.rosenberg@dewire.com> <1215729651-26781-8-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 06:34:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHAKn-0002Dm-52
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 06:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbYGKEdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 00:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbYGKEdS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 00:33:18 -0400
Received: from george.spearce.org ([209.20.77.23]:48764 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbYGKEdR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 00:33:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4736038222; Fri, 11 Jul 2008 04:33:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215729651-26781-8-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88080>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> +
> +	static class RIRefresh extends Job implements RepositoryListener {
...
> +			while (projectsToScan.size() > 0) {
> +				IProject p;
> +				synchronized (projectsToScan) {
> +					if (projectsToScan.size() == 0) {
> +					}
> +					p = projectsToScan.iterator().next();

This is going to throw some sort of no such element exception when
you call next when projectsToScan is empty.  You are missing a
break inside of the if test that is meant to guard against this.

> +					projectsToScan.remove(p);
> +				}

You have gone to the trouble of allocating the Iterator to obtain
the next item, you should also just use it to do the deletion of
the next item.  Its quicker to let the Iterator do the remove as
it already has the pointer to the proper element position.

-- 
Shawn.
