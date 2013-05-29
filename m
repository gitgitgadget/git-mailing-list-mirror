From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Merge conflicts with version numbers in release branches
Date: Wed, 29 May 2013 11:09:08 +0200 (CEST)
Message-ID: <1346886189.4154.1369818548437.JavaMail.root@vnc.biz>
References: <201304071749.10912.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed May 29 11:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhcNg-0001FI-6L
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 11:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245Ab3E2JJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 05:09:11 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:23288 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965039Ab3E2JJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 05:09:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 39DA8DC01F2;
	Wed, 29 May 2013 11:09:09 +0200 (CEST)
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 84b-JuTLIrLg; Wed, 29 May 2013 11:09:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 9A87EDC01F4;
	Wed, 29 May 2013 11:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FGarOt9T3pWF; Wed, 29 May 2013 11:09:08 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 80488DC01F2;
	Wed, 29 May 2013 11:09:08 +0200 (CEST)
In-Reply-To: <201304071749.10912.thomas@koch.ro>
X-Originating-IP: [172.17.1.118]
X-Mailer: Zimbra 8.0.3_GA_5664 (ZimbraWebClient - GC25 (Linux)/8.0.3_GA_5664)
Thread-Topic: Merge conflicts with version numbers in release branches
Thread-Index: N9SCAPfhBu+BPfjj3rCFPXZfVUZqQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225781>

Thomas Koch wrote:

> it's a common problem[1,2,3] in Maven (Java) projects and probably in other
> environments too: You have the version number of your project written in the
> pom.xml. When one merges changes upwards from the maint branche to master,
> the
> version numbers in maint and master are different and cause a merge conflict.

My advice: dont merge directly, but rebase to latest master. Maybe even rebase
incrementally (eg. "git rebase master~100 && git rebase master~99 && ...).
This heavily reduces the chance of conflicts that need to be resolved manually.

I'm a big fan of topic branches. For example, we have some bug #1234 in
the maintenance release. Fork off at latest maint, lets call the branch
1234_somewhat. Now do your bugfixing, testing, etc. When thats done, rebase
on latest maint (in case maint moved further) and merge it into maint.
Now rebase the 1234_somewhat branch onto master, do tests etc and finally
merge into it. (note: all merges here will be fast-forward, IOW: pure 
append operations).

Of course, all of this wont make the conflicts on the version number change
go away magically, but at least it will be more clear while resolving it.
If you always do the version number changes in some separate commit, which
has some specially formatted message (eg. 'Release: 1.2.4') you could 
hack some some little filter-branch magic, which automatically kicks off
these commits before rebasing.
