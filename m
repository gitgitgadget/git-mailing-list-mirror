From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] Propose author and committer in the commit dialog
Date: Fri, 6 Feb 2009 07:38:49 -0800
Message-ID: <20090206153849.GN26880@spearce.org>
References: <498C2BE5.3010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 16:40:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSoS-00010B-UB
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZBFPiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbZBFPiu
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:38:50 -0500
Received: from george.spearce.org ([209.20.77.23]:38978 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbZBFPit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:38:49 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3520738210; Fri,  6 Feb 2009 15:38:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <498C2BE5.3010602@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108739>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
> index bc5479a..8438683 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
> @@ -57,16 +57,6 @@
>  
>  	private final int tzOffset;
>  
> -	private static String getHostName() {
> -		try {
> -			java.net.InetAddress addr = java.net.InetAddress.getLocalHost();
> -			String hostname = addr.getCanonicalHostName();
> -			return hostname;
> -		} catch (java.net.UnknownHostException e) {
> -			return "localhost";
> -		}
> -	}
> -
>  	/**
>  	 * Creates new PersonIdent from config info in repository, with current time
>  	 * 
> @@ -74,14 +64,8 @@ private static String getHostName() {
>  	 */
>  	public PersonIdent(final Repository repo) {
>  		RepositoryConfig config = repo.getConfig();
> -		String username = config.getString("user", null, "name");
> -		if (username == null)
> -			username = System.getProperty("user.name");
> -
> -		String email = config.getString("user", null, "email");
> -		if (email == null)
> -			email = System.getProperty("user.name") + "@" + getHostName();
> -
> +		String username = config.getAuthorName();
> +		String email = config.getAuthorEmail();
>  		name = username;
>  		emailAddress = email;
>  		when = System.currentTimeMillis();

Heh.  I meant to write this patch myself yesterday but got
sidetracked and forgot.  Thanks.

Its unrelated to the other changes you were making.  Please submit
it as its own patch.

Aren't the local "username" and "email" variables now redundant?
Can't we just assign directly to the fields in the object?

Also, I think you should be using getCommitter{Name,Email} here
by default.  Sometimes people override the GIT_AUTHOR_* variables
in order to apply patches from others, but they almost never set the
GIT_COMMITTER_* variables.  We're using this constructor to create an
identity for use in commit objects, tag objects, or for the reflog.
All three prefer the committer name over the author name.

-- 
Shawn.
