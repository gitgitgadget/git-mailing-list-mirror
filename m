From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 16:51:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511231645100.13959@g5.osdl.org>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com> <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Carl Baldwin <cnb@fc.hp.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 01:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef5RD-0006wC-QO
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 01:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbVKXA6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbVKXA6H
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 19:58:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030552AbVKXA6E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 19:58:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAO0pSnO022261
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 23 Nov 2005 16:51:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAO0pRfb002153;
	Wed, 23 Nov 2005 16:51:28 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511240038001.11106@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12667>



On Thu, 24 Nov 2005, Johannes Schindelin wrote:
> 
> On Wed, 23 Nov 2005, Junio C Hamano wrote:
> 
> > 	$ ssh machine 'git clone '`hostname`:`pwd`' /path/to/new/repository'
> 
> Obviously, this only works if the other side can connect to this side via 
> ssh. Hmm. Firewalls? Disabled sshd? `hostname` not reliably returning a 
> valid address for the remote side?

Well, you could also just script it and just do

	ssh machine 'mkdir -p /path/to/new/repository ;
		cd /path/to/new/repo;
		git-init-db'
	git push --all machine:/path/to/new/repository
	ssh machine 'cd /path/to/new/repo ; git checkout'

(and yes, we could obviously make this a "git-create-repo" command, and 
then you could do

	git-send-pack --exec=git-create-repo \
		machine:/path/to/new/repository
		$(git-rev-parse --all)

or something like that).

		Linus
