From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: efficient way to filter several branches with common history?
Date: Wed, 04 Jul 2007 10:37:31 +0200
Organization: eudaptics software gmbh
Message-ID: <468B5C4B.26F5E90B@eudaptics.com>
References: <652B0F85-D0E4-4BF0-8DFC-212B6C0650AF@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 10:37:18 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I60ML-0007Xg-1J
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 10:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187AbXGDIhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 04:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbXGDIhK
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 04:37:10 -0400
Received: from main.gmane.org ([80.91.229.2]:47773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080AbXGDIhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 04:37:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I60MA-0003yH-Mo
	for git@vger.kernel.org; Wed, 04 Jul 2007 10:37:02 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 10:37:02 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 10:37:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51582>

Steffen Prohaska wrote:
> 
> Is there an efficient way to filter several branches at once
> through git-filter-branch? Often several branches have a lot
> of common history. Therefore, I suspect it would be much more
> efficient to filter them with one call to git-filter-branch.
> For example how can I efficiently filter all origin/* branches
> to filtered/* branches?

That feature is not yet implemented.

In the meantime do it this way:

Make an octopus merge of the branches onto a new branch. (If you have
more than a dozen or so, you better make a hierarchy of octopusses.) You
don't need to resolve conflicts (you are not interested in the merge
result), or use -s ours to avoid them in the first place.
Then filter that new branch.
Then create new refs at the rewritten commits:

   $ git update-ref refs/filtered/b1 $id-of-rewritten-origin/b1
   $ ...

Use gitk to find the $ids-of-rewritten-origin/*

-- Hannes
