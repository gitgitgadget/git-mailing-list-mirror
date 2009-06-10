From: Reto Glauser <linux@blinkeye.ch>
Subject: [BUG] git cvsexportcommit -W
Date: Wed, 10 Jun 2009 16:38:58 +0200
Message-ID: <ea9100509a9a5e21b9dc193cd34f812b@blinkeye.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEP3R-0003Gu-QV
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbZFJOpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757000AbZFJOpT
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:45:19 -0400
Received: from mail.blinkeye.ch ([78.46.102.7]:38393 "EHLO mail.blinkeye.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756700AbZFJOpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 10:45:19 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jun 2009 10:45:18 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.blinkeye.ch (Postfix) with ESMTP id 1B3A1818D0
	for <git@vger.kernel.org>; Wed, 10 Jun 2009 16:38:59 +0200 (CEST)
Received: from blinkeye.ch (blinkeye.ch [78.46.102.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.blinkeye.ch (Postfix) with ESMTPSA id 05C6A818CF
	for <git@vger.kernel.org>; Wed, 10 Jun 2009 16:38:59 +0200 (CEST)
X-Sender: linux@blinkeye.ch
User-Agent: RoundCube Webmail/0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121282>

I followed a tutorial about bi-directional git-cvs usage:

http://blogs.frugalware.org/vmiklos/2008/06/14/new_in_git_1_5_6_git_cvsexportcommit_w?blog=7&c=1&page=1&more=1&title=new_in_git_1_5_6_git_cvsexportcommit_w&tb=1&pb=1&disp=single

The new git cvsexportcommit option '-W' allows to use the same directory
for a CSV checkout and git checkout. But it doesn't work with the
autocommit feature '-c':

# git cvsexportcommit -v -W -c -p -u 65f12da
Resetting to 88de7d44a6d6343077645fb43b63e3f2907d6fdd
Applying to CVS commit 65f12da1b98c5a3546356a8c42b6aff005531cd7 from parent
88de7d44a6d6343077645fb43b63e3f2907d6fdd
Checking if patch will apply
Applying
Patch applied successfully. Adding new files and directories to CVS
Commit to CVS
Patch title (first comment line): add content to file4
Autocommit
  cvs commit -F .msg 'file4'
Committed successfully to CVS
HEAD is now at 65f12da... add content to file4

Now, even though everything looks OK, the CVS is not up-to-date. Removing
the autocommit feature (-c) reveals the problem:

# git cvsexportcommit -v -W -p -u 65f12da
Resetting to 88de7d44a6d6343077645fb43b63e3f2907d6fdd
Applying to CVS commit 65f12da1b98c5a3546356a8c42b6aff005531cd7 from parent
88de7d44a6d6343077645fb43b63e3f2907d6fdd
Checking if patch will apply
Applying
Patch applied successfully. Adding new files and directories to CVS
Commit to CVS
Patch title (first comment line): add content to file4
Ready for you to commit, just run:

   cvs commit -F .msg 'file4'
HEAD is now at 65f12da... add content to file4

Now, 

# cvs commit -F .msg 'file4'

doesn't do anything (but return value is 0).

You need to use '-f' to force the update:

# cvs commit -f -F .msg 'file4'
/tmp/CVS/project1/file4,v  <--  file4
new revision: 1.2; previous revision: 1.1

I'm using git-1.6.3.1.
