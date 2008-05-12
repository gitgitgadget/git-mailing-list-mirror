From: Ingo Molnar <mingo@elte.hu>
Subject: [user confusion] git-config error messages
Date: Mon, 12 May 2008 16:16:37 +0200
Message-ID: <20080512141636.GA29590@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 16:17:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvYqQ-0003N4-00
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 16:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbYELOQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 10:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYELOQs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 10:16:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51885 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbYELOQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 10:16:47 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1JvYpS-0000li-3o
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Mon, 12 May 2008 16:16:44 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id BB15C3E21DB; Mon, 12 May 2008 16:16:34 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81866>


ok, i thought i'd share this stupid little episode of user error.
I wanted to enable git-rerere:

 $ git-config --add rerere.enabled true
 could not lock config file

 #
 # Hm, do remember this option incorrectly? And what lock file?
 #

 $ git-config --add rerere.enabled=1
 key does not contain a section: --add

 #
 # What section? What key?
 #

 $ git-config --add rerere.enabled=true
 key does not contain a section: --add

 #
 # Huh? Ok, lets try strace:
 #

 $ strace -f git-config --add rerere.enabled true 2>&1 | grep \\.lock
 open(".git/config.lock", O_RDWR|O_CREAT|O_EXCL|O_LARGEFILE, 0666) = -1 ENOENT (No such file or directory)

 #
 # Ah, stupid me! I forgot to cd into the Git repository and it tries to 
 # access .git. And i wanted the --global option anyway. So the Git 
 # error messages led me on the completely wrong path.
 #
