From: Matthias Kestenholz <lists@irregular.ch>
Subject: Bug in git log
Date: Tue, 2 May 2006 09:51:22 +0200
Message-ID: <20060502075122.GA8203@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Tue May 02 09:51:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FapfO-0002F4-JH
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWEBHvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWEBHvY
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:51:24 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:2155 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S932426AbWEBHvY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 03:51:24 -0400
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Tue, 2 May 2006 09:51:22 +0200
Received: from spinlock.ch ([129.132.210.207]) by xfe1.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Tue, 2 May 2006 09:51:22 +0200
Received: (nullmailer pid 8424 invoked by uid 1000);
	Tue, 02 May 2006 07:51:22 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.16-rc6 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 02 May 2006 07:51:22.0572 (UTC) FILETIME=[349F00C0:01C66DBD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19406>

Hello list,

I found a bug in the new builtin git log which I am unable to fix
myself.

Inside your git source directory, do:

First bug using old whatchanged script (not builtin version)

$ ./git-whatchanged.sh -- unresolve.c
fatal: ambiguous argument 'unresolve.c': unknown revision or
filename
Use '--' to separate filenames from revisions

$ ./git-whatchanged.sh -- -- unresolve.c
[...] gives the expected output

$ git log -- unresolve.c
$ git log -- -- unresolve.c
$ git whatchanged -- unresolve.c

both give no output.

I checked the argument parsing stage and everything seemed sane (the
second double-dash was not necessary anymore)

However, the following works as expected:

$ git log -- git-log.sh

It seems that the problem shows only if there was no commit
modifying the asked-for file. unresolve.c is introduced in commit
ec167793d84ba7b765e1eb71b0257ce7baca2d26 and removed in the
subsequent commit 2bd452d3b9f62ecc3406307cd6a5553856d21ff2 and is
never modified.

/Matthias


-- 
:wq
