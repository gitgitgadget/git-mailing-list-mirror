From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 10:29:06 +0200
Message-ID: <20070624082906.GB2467@steel.home>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jun 24 10:29:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2NTE-0007Wt-QP
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 10:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbXFXI3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbXFXI3K
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 04:29:10 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:28441 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbXFXI3J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 04:29:09 -0400
Received: from tigra.home (Fad95.f.strato-dslnet.de [195.4.173.149])
	by post.webmailer.de (mrclete mo6) (RZmta 7.5)
	with ESMTP id z023f9j5O5Wua2 ; Sun, 24 Jun 2007 10:29:06 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9C812277BD;
	Sun, 24 Jun 2007 10:29:06 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E6F53C164; Sun, 24 Jun 2007 10:29:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11826268772950-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyClFly0M=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50778>

Steffen Prohaska, Sat, Jun 23, 2007 21:27:57 +0200:
> +for commit in $(git-rev-list --reverse $from..$to)
> +do
> +    echo "rewriting commit $commit..."
> +    git-diff-tree -r $commit | grep ^: | cut -b 9-15,57-97,100- |
> +    while read mode sha path 
> +    do
> +        echo " $mode $sha $path"
> +        git-update-index --add --cacheinfo $mode $sha $path
> +    done

Why not just read-tree for every commit? It is not like you're
modifying the repository in any way, just changing parenthood. That'd
solve the problem with deletions.
So it should be enough to read-tree the repo state for each and every
source commit into the index (and you can just use a temporary index
file for that, see GIT_INDEX_FILE). Than just commit the index.
