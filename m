From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 09:53:04 +0200
Message-ID: <49F958E0.8040808@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net>	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>	 <49F8C127.4000400@drmicha.warpmail.net> <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzR58-0007GN-1p
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 09:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837AbZD3HxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZD3HxO
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 03:53:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54217 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbZD3HxN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 03:53:13 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2832232AC63;
	Thu, 30 Apr 2009 03:53:13 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 30 Apr 2009 03:53:13 -0400
X-Sasl-enc: OGzB4/SUNXe9khhO38Ym0C7ndJoofT6CVHmKZWOnRpYE 1241077992
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4702E304C8;
	Thu, 30 Apr 2009 03:53:12 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117997>

Martin Langhoff venit, vidit, dixit 30.04.2009 09:18:
> On Wed, Apr 29, 2009 at 11:05 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> But I just re-read your original report, and there's some inconsistency:
>>
>> git-svn triggers cat-file's usage message which says "git-cat-file ...".
>> The dash indicates that it is a git cat-file before v1.6.0.1-13-g34baebc
>> (where the dash was removed), so it's definitely not the current maint
>> you think you are using.
>>
>> Do you have older ubuntu git packages installed in $PATH?
> 
> Bingo! Yes,
> 
> ~$ which git-cat-file
> /usr/bin/git-cat-file
> ~$ /usr/bin/git version
> git version 1.5.6.3
> 
> now that's really weird. git from ~/bin is using git-cat-file from
> /usr/bin instead of ~/libexec/git-core ... how is the libexec path set
> in the PATH during the execution of the script?
> 
> the funny thing is that Ubuntu wants to have git-core in place if
> you're rebuilding kernel packages. I don't need to rebuild my kernel
> anymore but I am sure this is an issue for others. What's the trick?
> Add the libexec/git-core to the PATH before /usr/bin? Should git
> internally append libexec/git-core earlier in the search path?
> 

I'm pretty sure that git will use the correct version, i.e. "git
cat-file -x" will give you the usage line for the recent version. Or
does "env|grep GIT" return anything which could misdirect git?

I think the question is more what git-svn does. It uses git's perl
bindings, and it may very well be the case that your current, locally
installed git uses the current git-svn which in turn picks up the wrong
Git.pm.

As far as I can see, the last explicit usage of "git-cat-file" (with
dash) was removed from git-svn.perl in v1.5.5.1-136-gffe256f which
equals v1.5.6-rc0~8^2~2 which should precede your older git, unless
Debian/Ubuntu did something funny. (Fedora followed the out-of-bin
decision for git-* only with a delay, e.g.) That's why I suspected a
perl path issue. But I'm not a perl guy, so I'm sorry I can't help
further than suggesting to uninstall the old git (deb version of
--no-deps) and check if that's helping.

Michael
