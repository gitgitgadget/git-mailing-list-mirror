From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] git-p4: avoid syncing duplicate changes
Date: Thu, 5 Feb 2009 16:24:51 +0100
Message-ID: <200902051624.51636.simon@lst.de>
References: <20090128164540.GA2137@padd.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 16:26:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV67y-0005gG-Qu
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 16:26:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648AbZBEPZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 10:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757642AbZBEPZG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 10:25:06 -0500
Received: from verein.lst.de ([213.95.11.210]:44462 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757640AbZBEPZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 10:25:05 -0500
Received: from rhea.localnet ([62.70.27.104])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id n15FOxIF026365
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Feb 2009 16:24:59 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27-9-generic; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090128164540.GA2137@padd.com>
Content-Disposition: inline
X-Spam-Score: -0.001 () BAYES_44
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108570>

On Wednesday 28 January 2009 Pete Wyckoff, wrote:
> When a particular changeset affects multiple depot paths, it
> will appear multiple times in the output of "p4 changes".
> Filter out the duplicates to avoid the extra empty commits that
> this would otherwise create.
> 
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  contrib/fast-import/git-p4 |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index a85a7b2..63c8eca 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -444,8 +444,9 @@ def p4ChangesForPaths(depotPaths, changeRange):
>  
>      changes = []
>      for line in output:
> -        changeNum = line.split(" ")[1]
> -        changes.append(int(changeNum))
> +	changeNum = int(line.split(" ")[1])
> +	if changeNum not in changes:
> +	    changes.append(changeNum)

Hmm, isn't this a potentially quadratic operation?

I agree about the problem in general though.

Simon
