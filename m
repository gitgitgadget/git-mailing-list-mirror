From: Ville =?iso-8859-1?q?Skytt=E4?= <ville.skytta@iki.fi>
Subject: git init --bare --shared does not set group for some files/dirs
Date: Sun, 18 Jul 2010 13:14:41 +0300
Message-ID: <201007181314.41894.ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 18 12:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaR3B-00035j-E5
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 12:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab0GRKYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jul 2010 06:24:37 -0400
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40991 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0GRKYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 06:24:36 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Jul 2010 06:24:36 EDT
Received: from localhost (localhost [127.0.0.1])
	by filtteri2.pp.htv.fi (Postfix) with ESMTP id C4F268BBAC
	for <git@vger.kernel.org>; Sun, 18 Jul 2010 13:14:42 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
	with ESMTP id yn2EdNV8rhHQ for <git@vger.kernel.org>;
	Sun, 18 Jul 2010 13:14:42 +0300 (EEST)
Received: from viper.bobcat.mine.nu (cs181085020.pp.htv.fi [82.181.85.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id 841D75BC010
	for <git@vger.kernel.org>; Sun, 18 Jul 2010 13:14:42 +0300 (EEST)
User-Agent: KMail/1.13.5 (Linux/2.6.33.6-147.fc13.x86_64; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151204>

Hello,

git init --bare --shared does not set the group for some files.  See below; it 
did set g+s for all dirs, and did set the group for the root dir, config, 
HEAD, and objects, but failed to set group for branches, description, hooks, 
info, and refs.  I discussed/reproduced this on #git today with drizzd and was 
instructed to post here.

In particular, I hit a problem with this and the refs dir; members of the 
desired group (gituser in my example) can not write into it.  I can obviously 
fix this locally with chgrp, but for which files/dirs should the gituser group 
be set, and are there some files/dirs that it is intentionally not set?

# git --version
git version 1.7.1.1
# groupadd gituser
# mkdir foo
# chgrp gituser foo
# cd foo
# git init --bare --shared
Initialized empty shared Git repository in /tmp/foo/
# ls -ld . *
drwxrwsr-x 7 root gituser 4096 Jul 18 13:05 .
drwxrwsr-x 2 root root    4096 Jul 18 13:05 branches
-rw-rw-r-- 1 root gituser  126 Jul 18 13:05 config
-rw-rw-r-- 1 root root      73 Jul 18 13:05 description
-rw-rw-r-- 1 root gituser   23 Jul 18 13:05 HEAD
drwxrwsr-x 2 root root    4096 Jul 18 13:05 hooks
drwxrwsr-x 2 root root    4096 Jul 18 13:05 info
drwxrwsr-x 4 root gituser 4096 Jul 18 13:05 objects
drwxrwsr-x 4 root root    4096 Jul 18 13:05 refs
