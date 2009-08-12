From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] Fix for Repository.stripWorkDir when using
	partial paths
Date: Wed, 12 Aug 2009 07:29:18 -0700
Message-ID: <20090812142918.GB1033@spearce.org>
References: <4A821167.6030107@writeme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Adam W. Hawks" <awhawks@writeme.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:29:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbEpP-000833-IJ
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 16:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZHLO3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 10:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbZHLO3R
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 10:29:17 -0400
Received: from george.spearce.org ([209.20.77.23]:39341 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbZHLO3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 10:29:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2331E381FD; Wed, 12 Aug 2009 14:29:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A821167.6030107@writeme.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125700>

"Adam W. Hawks" <awhawks@writeme.com> wrote:
> When you call stripWorkDir with a relative path
> you can get a string out of bounds error.
> 
> This change fixes that problem by using the absolute paths
> of the file instead of its relative name.

Except it made the existing test suite fail, badly.  I'm counting
7 errors and 28 test failures as a result of applying this patch.
 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> index 468cf4c..a68817b 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> @@ -1036,7 +1036,7 @@ public static boolean isValidRefName(final String refName) {
>  	 * @return normalized repository relative path
>  	 */
>  	public static String stripWorkDir(File wd, File f) {
> -		String relName = f.getPath().substring(wd.getPath().length() + 1);
> +		String relName = f.getAbsolutePath().substring(wd.getPath().length() + 1);
>  		relName = relName.replace(File.separatorChar, '/');
>  		return relName;
>  	}

-- 
Shawn.
