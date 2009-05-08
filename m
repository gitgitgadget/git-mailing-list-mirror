From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error cloning from Git Repository
Date: Fri, 08 May 2009 09:50:30 +0200
Message-ID: <4A03E446.6050305@drmicha.warpmail.net>
References: <ece1079f0905072105k748d4debl3c899aec3539a185@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kanagesh radhakrishnan <rkanagesh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 09:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Krr-0005o2-R7
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760018AbZEHHuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760004AbZEHHuj
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:50:39 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:58308 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760158AbZEHHuh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 03:50:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7BB62341887;
	Fri,  8 May 2009 03:50:38 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 08 May 2009 03:50:38 -0400
X-Sasl-enc: dTHzGZ/KVewTCCc87PNYfm2z1TIdL2Fsg3lFTgQlM1qT 1241769038
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EAC563C06A;
	Fri,  8 May 2009 03:50:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090506 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <ece1079f0905072105k748d4debl3c899aec3539a185@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118579>

kanagesh radhakrishnan venit, vidit, dixit 08.05.2009 06:05:
> Hello All,
> 
> I am trying to setup a git repository and then publish it using
> git-daemon and inetd for other developers in the network to access the
> sources.
> 
> Server Setup
> -------------------
> Host system running on Fedora Core 8
> Git version 1.5.4.3
> 
> A summary of what I have done to setup the Git server is as follows:
> $ mkdir /home/kanagesh/test-repo
> $ cd test-repo
> $ vi test.c <insert text, save, quit>
> $ git-init-db
> $ git-config user.name kanagesh
> $ git-config user.email rkanagesh@gmail.com
> $ git-add test.c
> $ git-commit -a -m"Initial Commit"
> 
> # mkdir -p /var/cache/git

I assume you're doing a "cd /var/cache/git" before the next lines ;)

> # ln -s /home/kanagesh/test-repo/.git test-repo
> # ls -l
>    test-repo -> /home/kanagesh/test-repo/.git

Does "nobody" have access to /var/cache/git and /home/kanagesh/test-repo/?

> 
> xinetd has been setup to listen for git requests on port 9418 and
> spawn git-daemon.  This has been done by placing a config file named
> 'git' under /etc/xinetd.d.  The contents of the config file is as
> follows:
> 
> service git
> {
>        disable        = no
>        type            = UNLISTED
>        port             = 9418
>        socket_type = stream
>        wait             = no
>        user            = nobody
>        server          = /usr/local/bin/git-daemon
>        server_args     = --inetd --export-all
> --base-path=/var/cache/git --syslog --verbose
>        log_on_failure  += USERID
> }
> 
> 
> Clone from the Server
> -------------------------------
> When I attempt to clone the source from the Git server, I end up with
> the following error:
> 
> [kanagesh@localhost test]$ git-clone git://192.168.13.171/test-repo

What is the git version on the client?

> Initialized empty Git repository in /home/kanagesh/work/test/test-repo/.git/
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'git://192.168.13.171/test-repo' failed.
> 
> On checking the log messages in /var/log/messages, I see the following:
> 
> May  7 17:29:19 localhost xinetd[17108]: START: git pid=17128
> from=::ffff:192.168.13.171
> May  7 17:29:19 localhost git-daemon: [17128] Connection from
> 192.168.13.171:42360
> May  7 17:29:19 localhost git-daemon: [17128] Extended attributes (21
> bytes) exist <host=192.168.13.171>
> May  7 17:29:19 localhost git-daemon: [17128] Request upload-pack for
> '/test-repo'
> May  7 17:29:19 localhost xinetd[17108]: EXIT: git status=255
> pid=17128 duration=0(sec)
> 
> Can anyone tell me what I am doing incorrectly?  Any pointers on how
> to get a more verbose log from git-daemon would also be very helpful.
> 
> Thanks in advance.
> 
> Regards,
> Kanagesh
