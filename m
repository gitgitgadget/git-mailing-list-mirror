From: Anders Waldenborg <anders@0x63.nu>
Subject: Re: What about allowing multiple hooks?
Date: Thu, 22 Jan 2009 10:57:02 +0100
Message-ID: <497842EE.8000400@0x63.nu>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost> <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org> <4977872E.70901@0x63.nu> <alpine.DEB.1.00.0901212206430.3586@pacific.mpi-cbg.de> <497793E5.7090107@0x63.nu> <alpine.DEB.1.00.0901212247510.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexander Potashev <aspotashev@gmail.com>,
	Marc Weber <marco-oweber@gmx.de>,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 10:59:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPwL3-0003z4-9F
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 10:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755007AbZAVJ5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 04:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZAVJ5k
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 04:57:40 -0500
Received: from phlox.netintact.se ([217.73.97.18]:53273 "EHLO
	phlox.netintact.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZAVJ5j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 04:57:39 -0500
Received: by phlox.netintact.se (Postfix, from userid 56643)
	id 0E96DDE05AA; Thu, 22 Jan 2009 10:57:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on phlox
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=5.0 tests=none autolearn=failed 
	version=3.1.7-deb
Received: from hoth.proceranetworks.com (hoth.proceranetworks.com [194.153.91.41])
	by phlox.netintact.se (Postfix) with ESMTP id 8B220DE0596;
	Thu, 22 Jan 2009 10:57:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by hoth.proceranetworks.com (Postfix) with ESMTP id 41D3C45F0005;
	Thu, 22 Jan 2009 10:57:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at hoth.proceranetworks.com
Received: from hoth.proceranetworks.com ([127.0.0.1])
	by localhost (hoth.proceranetworks.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U9fmdrYxALW5; Thu, 22 Jan 2009 10:57:32 +0100 (CET)
Received: from [10.13.37.146] (81-233-4-40-no34.tbcn.telia.com [81.233.4.40])
	by hoth.proceranetworks.com (Postfix) with ESMTP id 9AAF045F0003;
	Thu, 22 Jan 2009 10:57:32 +0100 (CET)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <alpine.DEB.1.00.0901212247510.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106737>

Johannes Schindelin wrote:
>> So, the thing I initially wanted to solve was "multiple instances" of 
>> the same hook.
> 
> And why not use a shell function for that?
> 
> -- snip --
> buildbot () {
> 	echo "Who is so evil and puts a bot into a post-receive hook?" >&2
> 	echo "This function would connect to $* if it were building a bot."
> }
> 
> buildbot www.google.com
> buildbot www.kernel.org
> -- snap --

That is basically what I started with except that it looked like this:

-- 8< --
#!/bin/sh
/opt/git-triggers/buildbot-sendchange.py 192.168.9.99:9989
/opt/git-triggers/buildbot-sendchange.py 192.168.9.99:9988
/opt/git-triggers/send-mail
/opt/git-triggers/irc-notification
-- 8< --

At that point it thought "hey this looks like a configuration file, 
shouldn't a repository's config live in $GIT_DIR/config?".


We will continue use this config based approach on our site[*] until git 
has something better. For us it wins over shellscript-as-configuration 
for two reasons: 1) git config is easier to script  2) it allows us to 
define site wide triggers in /etc/gitconfig

[*] (our site is medium sized I guess, ~100 repos when all are converted 
to git)

  anders
