From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 01:21:34 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0901120057280.8369@vellum.laroia.net>
References: <200901120246.28364.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 10:23:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMJ0l-00031H-IM
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 10:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZALJVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 04:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZALJVn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 04:21:43 -0500
Received: from rose.makesad.us ([219.105.37.19]:55509 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbZALJVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 04:21:42 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id C0EABA010F;
	Mon, 12 Jan 2009 04:21:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id 477DF3A62BD;
	Mon, 12 Jan 2009 01:21:34 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <200901120246.28364.jnareb@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105311>

This is a little off-topic, but you CC:d the git list first. (-;

On Mon, 12 Jan 2009, Jakub Narebski wrote:

> The ISP I use (Telekomunikacja Polska S.A., aka TP) made some
> unannounced changes for ADSL service (Neostrada) which made it block
> repo.or.cz (and of course its aliases, including git.or.cz where git
> wiki resides). It blocks also gimp.org and some Polish IRC servers
> (irc.freenode.org on which #git resides works O.K.). People speculate
> that this blocking was based on MAPS (Mail Abuse Prevention System,
> which is SPAM backwards) lists to fight SPAM and/or to block botnets,
> and uses null routing (IP based) blocking. I have no idea why repo.or.cz
> is blocked: gimp.org is supposedly blocked because it hosts
> irc.gimp.org on the same IP. By block I mean that even ping doesn't
> work (no reply at all).

That's horrifying.

> I can access git wiki via one of many free HTTP proxies; currently I use
> http://www.4proxy.de so there are only slight problems there.
>
> The problems is with fetching (via git:// protocol) of forks of git
> repository on repo.or.cz, and pushing (via SSH) to a few of my git
> repositories hosted on repo.or.cz.
>
> Do you have any suggestions to bypass this block for git? I have access
> to Linux shell account (no root access, though) which doesn't have
> problems with repo.or.cz, so I think I could set up SSH tunnel: but
> how? And what to do with access via git:// - move to SSH too?

$ ssh -D 1080 user@host

In a a separate terminal:

$ cat > /tmp/tsocks.conf
# Here we have a config for tsocks that uses localhost:1080 as SOCKS5.
server = 127.0.0.1
# Server type defaults to 4 so we need to specify it as 5 for this one
server_type = 5
# The port defaults to 1080 but I've stated it here for clarity
server_port = 1080
^D
$ export TSOCKS_CONF_FILE=/tmp/tsocks.conf
$ tsocks lynx http://repo.or.cz/

You would need the 'tsocks' tool for your client system. Note that the 
remote system doesn't need any configuration this way. Just prefix any 
command-line operations that involve repo.or.cz with 'tsocks' and be sure 
to set TSOCKS_CONF_FILE. (On a Windows machine, use putty's graphical SSH 
client and FreeCap <http://www.freecap.ru/eng/>.

Once you have the 'ssh -D' tunnel running, you can use it in Firefox as a 
SOCKS proxy: host = localhost, port = 1080.

-- Asheesh.

-- 
Don't relax!  It's only your tension that's holding you together.
