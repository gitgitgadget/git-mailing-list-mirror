From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 5/5] Cache resolved ids in quickdiff document for
	faster update
Date: Sun, 5 Apr 2009 13:36:04 -0700
Message-ID: <20090405203604.GP23521@spearce.org>
References: <1238697991-12990-1-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-2-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-3-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-4-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-5-git-send-email-robin.rosenberg@dewire.com> <1238697991-12990-6-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZ69-0004GH-6R
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758026AbZDEUgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 16:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753881AbZDEUgI
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:36:08 -0400
Received: from george.spearce.org ([209.20.77.23]:52054 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZDEUgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 16:36:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A472E38211; Sun,  5 Apr 2009 20:36:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1238697991-12990-6-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115701>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> We do this by caching the commit, tree and blob ids and can then
> very quickly decide whether a change in baseline actually results in a
> changed version of the reference blob used for quickdiff.
...
> @@ -31,6 +34,11 @@
>  
>  class GitDocument extends Document implements RepositoryListener {
>  	private final IResource resource;
> +
> +	private AnyObjectId lastCommit;
> +	private AnyObjectId lastTree;
> +	private AnyObjectId lastBlob;

Should have been "ObjectId"; I amended the patch.

> +		Commit baselineCommit = repository.mapCommit(commitId);
> +		Tree baselineTree = baselineCommit.getTree();
> +		TreeEntry blobEntry = baselineTree.findBlobMember(gitPath);

Arrrgh.  We're still using Commit/Tree/TreeEntry to read file paths?

I'm applying this as-is, but we really need to start to transition
away from them.  I wanted to start deleting the mapCommit and its
friends from the Repository class.

-- 
Shawn.
