From: James Y Knight <jknight@itasoftware.com>
Subject: Re: [PATCH 1/2] git-svn: Fix the commit-url config to be the base url, just like the url config
Date: Mon, 4 Apr 2011 18:16:04 -0400
Message-ID: <F8E6CFA4-79F6-41AC-8266-09B3B46C8520@itasoftware.com>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu> <1301944148-7950-2-git-send-email-asedeno@mit.edu> <20110404215227.GA4224@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?iso-8859-1?Q?Alejandro_R=2E_Sede=F1o?= <asedeno@mit.edu>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 00:25:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6sDG-0004ee-36
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755936Ab1DDWZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 18:25:01 -0400
Received: from mx1.itasoftware.com ([63.115.78.20]:40103 "EHLO
	mx1.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab1DDWY5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 18:24:57 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Apr 2011 18:24:57 EDT
Received: from ita4mta2.internal.itasoftware.com (ita4mta2.internal.itasoftware.com [10.4.52.168])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.itasoftware.com (Postfix) with ESMTP id 4609A256D42;
	Mon,  4 Apr 2011 18:16:06 -0400 (EDT)
Received: from ita4zimproxy1.internal.itasoftware.com (lb1.dc4nat140.dc4.internal.itasoftware.com [10.4.199.140])
	by ita4mta2.internal.itasoftware.com (Postfix) with ESMTP id 24B0319D8031;
	Mon,  4 Apr 2011 18:16:06 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ita4zimproxy1.internal.itasoftware.com (Postfix) with ESMTP id 1E169BBC004;
	Mon,  4 Apr 2011 18:16:06 -0400 (EDT)
X-Virus-Scanned: amavisd-new at ita4zimproxy1.internal.itasoftware.com
Received: from ita4zimproxy1.internal.itasoftware.com ([127.0.0.1])
	by localhost (ita4zimproxy1.internal.itasoftware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRFx-BSR8yEh; Mon,  4 Apr 2011 18:16:05 -0400 (EDT)
Received: from jknight-lap.corp.itasoftware.com (lb1.dc4nat136.dc4.internal.itasoftware.com [10.4.199.136])
	by ita4zimproxy1.internal.itasoftware.com (Postfix) with ESMTPSA id DDF7CBBC003;
	Mon,  4 Apr 2011 18:16:05 -0400 (EDT)
In-Reply-To: <20110404215227.GA4224@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1082)
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: jknight@itasoftware.com
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170844>

On Apr 4, 2011, at 5:52 PM, Eric Wong wrote:
> $_commit_url is a user-specified parameter from the --commit-url switch.
> If they want to override it it's the user's perogative.  It's not the
> default and not commonly used.

In .git/config:

[svn-remote "svn"]
        url = http://hostname/svnrepo/
        commiturl = svn+ssh://hostname/svnrepo
        branches = branches/*:refs/remotes/origin/*
        fetch = trunk:refs/remotes/origin/master

The commiturl configuration is necessary so that the canonical URL is the http:// url (which can be used for read-only access), but if you want to commit, you have to use svn+ssh. This is a fairly common way of setting up access to an svn repository, so I'm surprised to be the first one to hit this issue.

Without the patch, you need:
        commiturl = svn+ssh://hostname/svnrepo/trunk
which of course then doesn't allow you to commit to other branches.

James