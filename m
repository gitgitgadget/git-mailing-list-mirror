From: Bill Lear <rael@zopyra.com>
Subject: Problem with post-receive hook
Date: Fri, 1 Feb 2008 13:01:11 -0600
Message-ID: <18339.27767.633833.374795@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 20:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL19K-0004Se-6m
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 20:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbYBATBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 14:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYBATBY
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 14:01:24 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61323 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbYBATBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 14:01:24 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m11J1NC18307;
	Fri, 1 Feb 2008 13:01:23 -0600
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72182>

I am having trouble getting the contributed post-receive hook to work,
which worked just fine the last time I tried it.  I am using the
latest code from the git repo directly and have also tried the 1.5.3.8
version.

I am running the git-daemon through xinetd, and it is configured
like so:

% cat /etc/xinetd.d/git-daemon
# description: The git server offers access to git repositories
service git
{
        disable         = no
        type            = UNLISTED
        port            = 9418
        socket_type     = stream
        wait            = no
        user            = rael
        server          = /opt/git/bin/git-daemon
        server_args     = --enable=receive-pack --verbose --syslog --inetd --export-all --base-path=/repos/git
        log_on_failure  += USERID
}

I have a test repo in /repos/git/fun, and I can clone it, and push
to it successfully.  I have configured the config file in /repos/git/fun
like so:

% cat /repos/git/fun/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        legacyheaders = false
        logallrefupdates = true
[repack]
        usedeltabaseoffset = true
[hooks]
        mailinglist = rael@zopyra.com

and have ensured that the hook /repos/git/config/fun/hooks/post-receive
is executable.

I have run it from the command line and it has printed out what I
expected it to, but for some reason when the git daemon gets a pack,
it does not seem to execute the hook.  I have looked through the git
daemon code in daemon.c, and the receive-pack code, and I see nothing
obvious that has changed since the last time I looked at it.

I have verified that the git daemon works to upload the packs (I push
changes, go somewhere else, clone and the changes are there; also, it
shows the upload in the syslog file /var/log/messages), and I'm just
at a loss.  The message file says, for example:

Feb  1 11:25:47 zopyra git-daemon: [31240] Connection from 192.168.10.23:41527
Feb  1 11:25:47 zopyra git-daemon: [31240] Extended attributes (12 bytes) exist <host=zopyra>
Feb  1 11:25:47 zopyra git-daemon: [31240] Request upload-pack for '/fun'
Feb  1 11:25:47 zopyra xinetd[2382]: EXIT: git status=0 pid=31240 duration=0(sec)

so, nothing seems amiss here.

Have I missed something really stupid?


Bill
