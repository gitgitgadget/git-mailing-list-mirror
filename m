From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Question about --tree-filter
Date: Wed, 04 Feb 2009 17:37:11 +0100
Message-ID: <4989C437.4070401@viscovery.net>
References: <loom.20090204T155824-858@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 18:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUlKS-0003t4-BY
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 18:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbZBDRM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 12:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753702AbZBDRM5
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 12:12:57 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57026 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbZBDRM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 12:12:57 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LUlJ0-0004Ot-OA; Wed, 04 Feb 2009 18:12:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F294C6D9; Wed,  4 Feb 2009 17:37:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <loom.20090204T155824-858@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108396>

Sergio Callegari schrieb:
> in working with the "rezip" filter for the efficient git management of
> openoffice, zip and docx files, I am encountering the following problem.
> 
> Suppose that you have an existing repository and that you want to convert it
> into a repository using the rezip filters: git filter-branch should be the tool
> to do the conversion.
> 
> Initially I believed that once set up the appropriate .git/config filter entries
> and a .git/info/attributes file tying the filter to the appropriate file types,
> it would have been enough to
> 
> git filter-branch --tree-filter true tag-name-filter cat
> 
> to do the conversion.
> This is also what I suggested in my original post about the rezip script.
> 
> Unfortunately, this does not seem to work as expected.  Not all files get
> rewritten as filtered blobs.

Before the tree-filter runs, the files are checked out (and smudged by
rezip). But they are marked as unchanged (because they were checked out
moments ago). Since your tree-filter doesn't do anything, no new blobs are
added to the index, and none of your files are cleaned by rezip.

I think your brute-force tree-filter should be

   rm -f "$GIT_INDEX_FILE"

assuming that a .gitattributes file is already in all revisions.

-- Hannes
