From: Andrew Dranse <adranse@oanda.com>
Subject: Bug with git-submodule and IFS
Date: Wed, 8 Aug 2012 14:21:23 -0400 (EDT)
Message-ID: <1844267106.216233.1344450083762.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca>
References: <1496197024.216188.1344449732940.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 20:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzAtJ-0006vq-72
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 20:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372Ab2HHSVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 14:21:44 -0400
Received: from mx.scalarmail.ca ([98.158.95.75]:59883 "EHLO
	ironport-01.sms.scalar.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595Ab2HHSVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 14:21:43 -0400
Received: from unknown (HELO sms-zimbra-mta-01.sms.scalar.ca) ([192.168.32.56])
  by ironport-01.sms.scalar.ca with ESMTP; 08 Aug 2012 14:21:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sms-zimbra-mta-01.sms.scalar.ca (Postfix) with ESMTP id 06AE617F47
	for <git@vger.kernel.org>; Wed,  8 Aug 2012 14:21:24 -0400 (EDT)
Received: from sms-zimbra-mta-01.sms.scalar.ca ([127.0.0.1])
	by localhost (sms-zimbra-mta-01.sms.scalar.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DvB08CSnhaK4 for <git@vger.kernel.org>;
	Wed,  8 Aug 2012 14:21:23 -0400 (EDT)
Received: from sms-zimbra-message-store-03.sms.scalar.ca (unknown [172.17.19.202])
	by sms-zimbra-mta-01.sms.scalar.ca (Postfix) with ESMTP id D357917F45
	for <git@vger.kernel.org>; Wed,  8 Aug 2012 14:21:23 -0400 (EDT)
In-Reply-To: <1496197024.216188.1344449732940.JavaMail.root@sms-zimbra-message-store-03.sms.scalar.ca>
X-Originating-IP: [216.235.10.210]
X-Mailer: Zimbra 7.1.2_GA_3268 (ZimbraWebClient - SAF3 (Linux)/7.1.2_GA_3268)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203107>

Hi there,

I ran into an interesting bug with git submodules today.  It appears that if your IFS is not set to what git-submodule expects it to be (i.e. the standard IFS), it will break in a fun way.

Example:

$ git init
Initialized empty Git repository in /home/adranse/test/.git/
$ git submodule add github:/repos/perf
Cloning into 'perf'...
remote: Counting objects: 5744, done.
remote: Compressing objects: 100% (4627/4627), done.
remote: Total 5744 (delta 2400), reused 1579 (delta 343)
Receiving objects: 100% (5744/5744), 28.78 MiB | 4.56 MiB/s, done.
Resolving deltas: 100% (2400/2400), done.
$ export IFS="
> "
$ git submodule update --init --recursive
No submodule mapping found in .gitmodules for path ''
$ unset IFS
$ git submodule update --init --recursive
Submodule 'perf' () registered for path 'perf'

As a solution, I would suggest setting IFS to the expected value before calling the git-submodule shell script.

Thanks,

Andrew Dranse
OANDA Corporation
adranse@oanda.com
