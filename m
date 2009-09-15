From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGit 04/19] added utility that generates the contents of the objects/info/packs file as a string from a list of PackFiles
Date: Tue, 15 Sep 2009 17:35:58 +0200
Message-ID: <200909151735.58992.robin.rosenberg.lists@dewire.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com> <1252867475-858-4-git-send-email-mr.gaffo@gmail.com> <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "mike.gaffney" <mike.gaffney@asolutions.com>
To: mr.gaffo@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 15 17:36:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mna4l-0003Kk-2R
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 17:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbZIOPgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 11:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbZIOPgA
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 11:36:00 -0400
Received: from mail.dewire.com ([83.140.172.130]:9954 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754715AbZIOPf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 11:35:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BF03E1481DBB;
	Tue, 15 Sep 2009 17:36:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8RnuDx9k4kq; Tue, 15 Sep 2009 17:36:01 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.9])
	by dewire.com (Postfix) with ESMTP id 28ECD9E4A6A;
	Tue, 15 Sep 2009 17:36:01 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <1252867475-858-5-git-send-email-mr.gaffo@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128571>

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
> new file mode 100644
> index 0000000..3dd0418
> --- /dev/null
> +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PacksFileContentsCreator.java
> @@ -0,0 +1,21 @@
> +package org.spearce.jgit.lib;
> +
> +import java.util.List;
> +
> +public class PacksFileContentsCreator {
> +
> +	private List<PackFile> packs;
> +
> +	public PacksFileContentsCreator(List<PackFile> packs) {
We want good javadocs for (at least) all public and protected methods and 
classes. (We enforce this for Eclipse users). If we had similar configuration files
for, perhaps netbeans we might have those too. (not finished thinking about that
proposition...)

> +		this.packs = packs;
> +	}
> +	
> +	public String toString(){

Don't overload toString. Let it be useful for debug like purposes. With this style we cannot
make it useful since the application depends on its exact behaviour. You may define
a toString anyway that does the exact same thing, but please provide a specific method for 
assisting with the formatting of the file. A writeTo(OutputStream) is a useful interface in general.

> +		StringBuilder builder = new StringBuilder();
> +		for (PackFile packFile : packs) {
> +			builder.append("P ").append(packFile.getPackFile().getName()).append('\r');

At least my git formats the file with \n as line terminator, so I think JGit should too.. 
Git ends the file with an extra \n, though I'm not sure it's relevant.

> +		}
> +		return builder.toString();
> +	}

The name is somewhat confusing as the s is hard to spot. The suggestion InfoPacksFileGenerator
perhaps. It's a bit uglier by easier not to mix with generation of pack files.

-- robin
