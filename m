From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow monitor/unintersting objects to be null
Date: Wed, 6 May 2009 13:02:35 -0700
Message-ID: <20090506200235.GI30527@spearce.org>
References: <1241639836-6719-1-git-send-email-alex.blewitt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:03:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1nKT-0003oT-QW
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbZEFUCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755325AbZEFUCf
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:02:35 -0400
Received: from george.spearce.org ([209.20.77.23]:60995 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099AbZEFUCe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:02:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 13B6A381CE; Wed,  6 May 2009 20:02:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241639836-6719-1-git-send-email-alex.blewitt@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118377>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> ---
>  .../src/org/spearce/jgit/lib/PackWriter.java       |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> index ea63942..3d7004d 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackWriter.java
> @@ -230,8 +230,8 @@ public class PackWriter {
>  	public PackWriter(final Repository repo, final ProgressMonitor imonitor,
>  			final ProgressMonitor wmonitor) {
>  		this.db = repo;
> -		initMonitor = imonitor;
> -		writeMonitor = wmonitor;
> +		initMonitor = (imonitor == null ? new NullProgressMonitor() : imonitor);
> +		writeMonitor = (wmonitor == null ? new NullProgressMonitor() : wmonitor);

Can't we use NullProgressMonitor.INSTANCE instead?

Also the () around the ?: expression are unnecessary here and our
coding style tends not to include them.

> @@ -829,6 +829,7 @@ public class PackWriter {
>  			RevObject o = walker.parseAny(id);
>  			walker.markStart(o);
>  		}
> +		if (uninterestingObjects != null)
>  		for (ObjectId id : uninterestingObjects) {

Please fix the indentation of the other code to be properly under
the if, or change the variable to be non-final and assign it
an empty list if its null, so the for() runs but doesn't crash.
Or do that in the only caller, preparePack(Collection,Collection).

-- 
Shawn.
