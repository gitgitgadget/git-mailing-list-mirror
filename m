From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can't commit files that have been git add'ed because "fatal: you need to resolve your current index first"
Date: Wed, 28 Nov 2007 17:55:10 +0100
Message-ID: <200711281755.10828.jnareb@gmail.com>
References: <251604.8861.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Priest <priestwilliaml@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQCO-0006bx-2d
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760766AbXK1QzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 11:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757713AbXK1QzW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:55:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:29264 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756655AbXK1QzV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 11:55:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1467443nfb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=rJsZB2SBkQ2QISrUqg+YW3FH9GZ/WD0SZObArpqYNYw=;
        b=K8dneE/yn+Kx4dcXjYvSQfRGbPhHFoZVZjTXz8MmVhkjE54NAY7czxLVcn8K2h2F8utuQ3RMkIeIAg52HoW/Dx96Lrxqv81PtNlCDjsGJLwc+rgog04qWpLfgawPYciGRr6CxaUS9xyZ0/JlyCh9MbxJirrpJ7qwh77dIzQTgvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k5Ir4GaM7J2UgXlD+lSC3GBAdAuRU4172v1kJfRDBqxVq/NLiHseND53oTs5jWGQ/xGUWaaBeS69WE+Lm1v7x8N7vngmHvz3JkxCzU/JvCAC2qV8u14Ot7VsjqfjA+Z0KVkxCoUToH9AhW/z42r/4HeR2Oh+bjAaUjZu/n6CqMA=
Received: by 10.86.1.1 with SMTP id 1mr5164433fga.1196268915677;
        Wed, 28 Nov 2007 08:55:15 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.215.156])
        by mx.google.com with ESMTPS id e11sm2772919fga.2007.11.28.08.55.12
        (version=SSLv3 cipher=OTHER);
        Wed, 28 Nov 2007 08:55:13 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <251604.8861.qm@web55007.mail.re4.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66380>

Please do not toppost, and try not to break quoted lines, please.
Thanks in advance.

On Wed, 28 Nov 2007, Bill Priest wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> Bill Priest wrote:
>> 
>>>   I merged from one branch to another and had lots of
>>> conflicts.  I've resolved a set of files from the
>>> conflicts (in a directory) and did a git-add on this
>>> set of files.  I wasn't able to commit these files. 
>>> On IRC I was told that all files must be resolved
>>> before I can commit any of them.  This seems pretty
>>> limiting.  Why is a commit after a merge all or
>>> nothing; I thought that git  figured out merges and
>>> such by the differences between files??
>> 
>> You have to resolve _conflicts_ only. The rest is
>> added
>> automatically. See git-status, git diff --merge,
>> git ls-files -u.

>    I understand that git requires this.  My question
> is   git enforcing policy or is there something
> "magic" about a commit after a merge.  What if I want
> to make an independent change and check it in on the
> same branch before I am finished with the merge? 

A little technical information about failed merge.

First, git tries to merge as mauch as it can automatically,
doing tree-level merge and trying three-way file-level merge
if necessary. Everything that merges cleanly is automatically
added to staging area.

For each file that has unresolved conflicts git adds to staging
are all (three) versions of file: original, from merged in
branch, and common ancestor version, as stages 1, 2, 3 (not
necessary in this order: see documentation). Additionally it
leaves partially merged file in working area with RCS-like
conflicts markes in it. (Note that default checking before
commits refuses to check in file with conflict markers; see
documentation how to force commit anyway).

Additionally git records the fact that it is in the midle of merge
by recording branch(es) merged in in .git/MERGE_HEAD.


To resolve conflicts you have to bring file to some version,
removing conflict markers, add this version using "git add",
then commit.


You can try to git-stash partially done merge; if it doesn't
work send us bugreport.

-- 
Jakub Narebski
Poland
