From: Martin Mares <mj@ucw.cz>
Subject: diff --stat when chmoding binary files
Date: Mon, 15 Aug 2011 10:50:49 +0200
Message-ID: <mj+md-20110815.084527.10358.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-2?Q?Tom=E1=B9_Male=E8ek?= <malecektomas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 10:56:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qssy7-0007Su-7O
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 10:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752861Ab1HOI4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 04:56:14 -0400
Received: from jabberwock.ucw.cz ([89.250.246.4]:59107 "EHLO jabberwock.ucw.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab1HOI4N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 04:56:13 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Aug 2011 04:56:13 EDT
Received: from albireo.ucw.cz (albireo.ucw.cz [89.239.2.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "albireo.ucw.cz", Issuer "ucw.cz" (verified OK))
	by jabberwock.ucw.cz (Postfix) with ESMTPS id 633ED33BCC
	for <git@vger.kernel.org>; Mon, 15 Aug 2011 10:50:51 +0200 (CEST)
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id DF9C311017F; Mon, 15 Aug 2011 10:50:49 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179361>

Hello, world!\n

I have discovered somewhat surprising behavior of `git diff --stat'
on files, which are not modified except for their executable bits.
When the file is binary, it is listed in the diffstat, otherwise
it is not.

For example:

| mj@albireo:/tmp$ mkdir gt
| mj@albireo:/tmp$ cd gt
| mj@albireo:/tmp/gt$ git init
| Initialized empty Git repository in /tmp/gt/.git/
| mj@albireo:/tmp/gt$ echo abcdef >a
| mj@albireo:/tmp/gt$ dd if=/dev/zero of=b bs=1024 count=1
| 1+0 records in
| 1+0 records out
| 1024 bytes (1.0 kB) copied, 7.3243e-05 s, 14.0 MB/s
| mj@albireo:/tmp/gt$ git add *
| mj@albireo:/tmp/gt$ git commit -m 'adding'
| [master (root-commit) 295d5f9] adding
|  2 files changed, 1 insertions(+), 0 deletions(-)
|  create mode 100644 a
|  create mode 100644 b
| mj@albireo:/tmp/gt$ chmod 755 *
| mj@albireo:/tmp/gt$ git add *
| mj@albireo:/tmp/gt$ git commit -m 'chmoding'
| [master 61c251b] chmoding
|  1 files changed, 0 insertions(+), 0 deletions(-)
|  mode change 100644 => 100755 a
|  mode change 100644 => 100755 b
| mj@albireo:/tmp/gt$ git diff HEAD^
| diff --git a/a b/a
| old mode 100644
| new mode 100755
| diff --git a/b b/b
| old mode 100644
| new mode 100755
| mj@albireo:/tmp/gt$ git diff --stat HEAD^
|  b |  Bin 1024 -> 1024 bytes
|  1 files changed, 0 insertions(+), 0 deletions(-)

This happens in git-1.7.6 and in several older versions as well.

Am I missing something or is it a bug?

				Have a nice fortnight
-- 
Martin `MJ' Mares                          <mj@ucw.cz>   http://mj.ucw.cz/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Q: Who invented the first airplane that did not fly?  A: The Wrong Brothers.
