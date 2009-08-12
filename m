From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] Fix for Repository.stripWorkDir when using partial paths
Date: Wed, 12 Aug 2009 21:47:52 +0200
Message-ID: <200908122147.52530.robin.rosenberg.lists@dewire.com>
References: <4A821167.6030107@writeme.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam W. Hawks" <awhawks@writeme.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJnn-0002fV-7w
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbZHLTrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbZHLTrx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:47:53 -0400
Received: from mail.dewire.com ([83.140.172.130]:26709 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbZHLTrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:47:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F0A0C1434E8A;
	Wed, 12 Aug 2009 21:47:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 42R1V9Mxhnvn; Wed, 12 Aug 2009 21:47:53 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6E6D580267A;
	Wed, 12 Aug 2009 21:47:53 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <4A821167.6030107@writeme.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125736>

onsdag 12 augusti 2009 02:48:39 skrev "Adam W. Hawks" <awhawks@writeme.com>:
> 
> From ef993e633cdcb1dddda5e71db1b62306df7ce83f Mon Sep 17 00:00:00 2001
> Date: Tue, 11 Aug 2009 20:02:56 -0400
> 
> When you call stripWorkDir with a relative path
> you can get a string out of bounds error.
> 
> This change fixes that problem by using the absolute paths
> of the file instead of its relative name.
> 
> Signed-off-by: Adam W. Hawks <awhawks@writeme.com>
> ---
>  .../src/org/spearce/jgit/lib/Repository.java       |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
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

Why not convert both paths? A trickier issue is that getAbsolutePath is very slow when
the path is not absolute. I don't think we will always need to normalize in order to
fix this. A few unit tests to show the cases solved would help.

-- robin
