From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Notes on http-push
Date: Mon, 7 Nov 2005 19:34:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511071926240.14149@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Nov 07 19:36:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZBpH-0000SU-3u
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 19:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVKGSeg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 13:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVKGSeg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 13:34:36 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19863 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964907AbVKGSef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 13:34:35 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 839B213F186
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 19:34:34 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 65F67B50DB
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 19:34:34 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP id 4A186B50D9
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 19:34:34 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 31C1913F186
	for <git@vger.kernel.org>; Mon,  7 Nov 2005 19:34:34 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11275>

Hi,

two little things I noticed while playing around with http-push:

- if you init your test by git-clone'ing from a http repo, be sure to
	add a slash to the URL, else git-push will tell you erroneously
	that the server does not do DAV locking. (Probably http-push.c 
	should be fixed to add the slash when needed.)

- if you execute "git push origin", it does not do anything (correctly?),
	if there is no "Push:" line in .git/remotes/origin (which is the
	default after cloning). Try "git push origin master". (Probably
	http-push or git-push should say something about it, not
	just quit silently.)

If you want to play with it yourself: A minimal setup using Apache needs 
something like this in httpd.conf:

--- snip ---
<Location /gits>
  DAV on
  Deny From *
  Allow From 192.168.0.
</Location>

DAVLockDB "/usr/local/apache2/temp/DAV.lock"
--- snap ---

Make sure that your www user has write permissions on <HTDOCS>/gits and on 
the DAV lock.

Have fun,
Dscho
