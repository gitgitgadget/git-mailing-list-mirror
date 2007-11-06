From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-merge ignore specific files
Date: Tue, 06 Nov 2007 13:53:21 +0100
Message-ID: <473063C1.7070607@op5.se>
References: <174134.11501.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 13:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpNwE-0005Pu-Fz
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 13:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbXKFMxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 07:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbXKFMxc
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 07:53:32 -0500
Received: from mail.op5.se ([193.201.96.20]:58146 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbXKFMxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 07:53:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5CEC01730759;
	Tue,  6 Nov 2007 13:53:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W-qWcBJFtwYe; Tue,  6 Nov 2007 13:53:00 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 8E72C1730754;
	Tue,  6 Nov 2007 13:52:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <174134.11501.qm@web55007.mail.re4.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63672>

Bill Priest wrote:
> All,
>   I have two branches that are slightly different and
> most changes "belong" in both.  There are a handful of
> files/directories that are disparate.  Is there any
> way in git to tell it not to merge these files?  Kind
> of like .gitignore but for merges.
>   In addition I'd like a way to specify to git-merge
> to leave all merged files unrecorded in the index. 
> Then as I go through each file making sure that the
> merge "makes sense" (not that git did the right thing;
> but that I want the changes in both branches) that I
> add the change to the index.
>   I'm sure that I'm probably using git "incorrectly"
> and I welcome suggestions for modifying my workflow to
> a git style.
> 
> Any and all suggestions greatly appreciated,
> 


At a cursory glance at the sources, it looks as if you should be able to
get what you want with pretty small modifications to builtin-read-tree.c
and git-merge.sh.

Specifically, 'git read-tree' (which does the heavy lifting during merges)
takes --exclude-per-directory as an argument. You want to teach 'git merge'
to do the same and pass that argument along to 'git read-tree'. Then it's
just a matter of maintaining two sets of .gitignore files, one of which
you'd probably want to call .mergeignore (or something) and make sure you
don't forget to pass that option when you merge (although I assume you'd
notice if you'd forgotten it during conflict resolution).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
