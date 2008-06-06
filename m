From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 19/23] Added WorkTree class which can be constructed over Repository.
Date: Fri, 6 Jun 2008 02:23:07 +0200
Message-ID: <200806060223.07384.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <1211574872-23676-20-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 02:27:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4PnT-0001g6-QT
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 02:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbYFFA0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 20:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754438AbYFFA0A
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 20:26:00 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18869 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbYFFAZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 20:25:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 200031434DD0;
	Fri,  6 Jun 2008 02:25:56 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNW27V-i2dXg; Fri,  6 Jun 2008 02:25:55 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 30C361434DCE;
	Fri,  6 Jun 2008 02:25:55 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211574872-23676-20-git-send-email-florianskarten@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84012>

fredagen den 23 maj 2008 22.34.28 skrev Florian Koeberle:
> ---
>  .../src/org/spearce/jgit/lib/Repository.java       |   57 +++++++++++++++++
>  .../src/org/spearce/jgit/lib/WorkTree.java         |   67 ++++++++++++++++++++
>  2 files changed, 124 insertions(+), 0 deletions(-)
>  create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java
> 
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> +	public Commit setupHEADRef(final String remoteBranch, final String branch)
> +			throws IOException {
> +		Commit mapCommit = mapCommit(remoteBranch);
> +		String refName = Constants.HEADS_PREFIX + "/" + branch;
> +		LockFile masterRef = lockRef(refName);
> +		try {
> +			masterRef.write(mapCommit.getCommitId());
> +			masterRef.commit();
> +		} finally {
> +			masterRef.unlock();
> +		}
> +		writeSymref(Constants.HEAD, refName);
> +		return mapCommit;
> +	}
Shouldn't someone be calling this?

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java b/org.spearce.jgit/src/org/spearce/jgit/lib/WorkTree.java
> +	/**
> +	 * Closes the git repository of this project.
> +	 */
> +	public void closeRepository() {
> +		repository.close();
> +	}

This is redundant. Very few callers need it and those can just as well
call getRepsitory().close() anyway.
