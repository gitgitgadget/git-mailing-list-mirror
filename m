From: Nick <oinksocket@letterboxes.org>
Subject: avoiding anonymous commits from root/shared accounts
Date: Mon, 10 May 2010 18:05:17 +0100
Message-ID: <4BE83CCD.2090505@letterboxes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 10 19:04:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBWPS-0000hO-FA
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 19:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755710Ab0EJREp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 13:04:45 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:46711 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713Ab0EJREp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 13:04:45 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1OBWPL-0003IJ-Qg
	for git@vger.kernel.org; Mon, 10 May 2010 18:04:43 +0100
User-Agent: Thunderbird 2.0.0.24 (X11/20100317)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146827>

Hi,

I have a question about what is probably an unusual use-case, where git is being
used from the root account, or an account shared by various committers.


I'm setting up a shared git repository, currently accessed via plain ssh to the
server in question. The code has been inherited, and is migrated from CVS.

The code is a sysadmin tool designed to set up a new server and keep its
configuration synchronised to one of several templates thereafter. Typically, it
is checked out in /root on a freshly installed server, and "make all" is run as
root to configure the services, set up user accounts, etc.

>From then on you pull updates from the repository, run "make all", and the
machine is reconfigured, services restarted, etc. as necessary.

The problem is maintenance of this code.  In the past, fixes might be made on
any server, then pushed back into the repository to be replicated everywhere.
There are several users, each of whom might commit changes to this tool.  When
it was in CVS, a common account was used to allow commits from anyone and
anywhere - and as a result nothing can be attributed to anyone.



I want to avoid these anonymous commits from now on.  The trouble is, I'm not
sure the best way to, as there is no guarantee any accounts but root will exist,
and if they do, some of these are shared accounts various people can log in as.
(This may or may not be advisable, but for now that's the way it works)

I also don't want to make it easy for the maintainers to do the right thing,
they will already be re-adjusting to git.  For that reason, just mandating that
everyone sets $GIT_AUTHOR_NAME etc. manually on log-in isn't very satisfactory.

The best idea I've come across seems to be some sort of wrapper for git, which
if no $GIT_USER_* is defined, can use $SUDO_USER and/or `who am i` to identify
the original log-in account, and sets $GIT_AUTHOR_NAME etc. - else if it can't
do this, it refuses to commit.  Or perhaps it would be a script which spawns a
shell with the right environment to invoke git commands from, after successfully
determining the identity.


But before I investigate this avenue any further, I wonder is there any prior
art addressing this sort of situation, using git?

Thanks

Nick
