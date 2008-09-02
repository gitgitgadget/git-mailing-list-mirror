From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/2] Add utilities for figuring out repositories
	for selected resources
Date: Tue, 2 Sep 2008 08:03:23 -0700
Message-ID: <20080902150323.GC28704@spearce.org>
References: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com> <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 17:04:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaXQl-0003KU-N0
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 17:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYIBPDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 11:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbYIBPDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 11:03:25 -0400
Received: from george.spearce.org ([209.20.77.23]:58978 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYIBPDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 11:03:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EE60938375; Tue,  2 Sep 2008 15:03:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1220175524-1523-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94678>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> We want to go from selected resources to repositories and back
> to any resource in those repositories
...
> +	protected Repository[] getRepositoriesFor(final IProject[] projects) {
> +		Set<Repository> ret = new HashSet<Repository>();
> +		for (IProject project : projects) {
> +			RepositoryMapping repositoryMapping = RepositoryMapping.getMapping(project);
> +			if (repositoryMapping == null)
> +				return new Repository[0];
> +			ret.add(repositoryMapping.getRepository());
> +		}

Hmm.  So if any one of the selected projects doesn't have a Git
repository at its top level we just plain fail and pretend none of
them have a Git repository?  That doesn't seem right to me.  We
should just skip that project and move to another project.

But I also wonder if that really makes sense when a project could
have a linked resource under it that points to the repository's
working directory.  In such cases we want operations on that project
to potentially impact the inner repository as maybe the project
repository does not have a repository itself.  IOW I'm questioning
the idea of getRepositoriesFor(getProjectsForSelectedResources()).

-- 
Shawn.
