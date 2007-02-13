From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH 3/3] diffstat generation in hooks--update was passing  
 "^baserev" to git-diff-tree
Date: Tue, 13 Feb 2007 18:16:26 +0100
Organization: eudaptics software gmbh
Message-ID: <45D1F26A.28FEADD8@eudaptics.com>
References: <200702131424.21665.andyparkins@gmail.com> <45D1DB57.65433549@eudaptics.com> <200702131632.37401.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:14:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1Em-0001YV-Fm
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXBMROh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbXBMROh
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:14:37 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:18931 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbXBMROg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:14:36 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8B81A546; Tue, 13 Feb 2007 18:14:32 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39545>

Andy Parkins wrote:
> > You still need to derive a merge-base, but only to detect the forced
> > update and to format the message. Then you should use --not $baserev
> > instead of ^$baserev just in case there is more than one merge-base.
> 
> Are you suggesting something like this?
> 
> git-rev-parse --not --all $baserev | git-rev-list --stdin --pretty $newrev
> 
> Which would start showing from $newrev but would exclude all baserevs and all
> existing branches.

You are using ^$baserev in two instances.

(1) in a for loop which obviously is intended as a table of contents
(revs plus rev-type (can this be anything else than 'commit'?)). Here
you should use

git-rev-list $newrev --not $baserev

(2) later to print the log messages for all new revs. Here you use just
this:

git-rev-list --pretty $oldrev..$newrev


Then the diffstat:

git-diff-tree --no-color --stat -M -C --find-copies-harder \
  $oldrev $newrev

This reflects the modifications of the revisions that have just been
listed *only* in the fast-forward case. But even in the forced update
case it tells how the old tree transformed into the new tree, and for
this reason nothing more complicated is needed, IMO.

-- Hannes
