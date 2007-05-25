From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 14:22:38 +0200
Organization: At home
Message-ID: <f36k4v$f7s$1@sea.gmane.org>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org> <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241315290.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 14:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrYkJ-0004Qg-Jn
	for gcvg-git@gmane.org; Fri, 25 May 2007 14:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbXEYMRo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 08:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbXEYMRo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 08:17:44 -0400
Received: from main.gmane.org ([80.91.229.2]:51537 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbXEYMRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 08:17:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrYjk-0003zm-LM
	for git@vger.kernel.org; Fri, 25 May 2007 14:17:40 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 14:17:40 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 14:17:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48363>

Johannes Schindelin wrote:
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
>> On Thu, May 24, 2007 at 12:31:33PM +0100, Johannes Schindelin wrote:
>>> On Thu, 24 May 2007, Sven Verdoolaege wrote:

>>>> OK... so what should git-update-server-info put in this file for submodules?
>>>> Or, equivalently, what should be the output of ls-remote?
>>>> 
>>>> Right now its a list of pairs of revs(sha1) and refs.
>>>> For submodules we want a connection between a submodule name
>>>> and one or more URLs where the submodule can be found.
>>>> How are you going to squeeze that into info/refs without confusing
>>>> older versions of git?
>>> 
>>> I wonder if the "ref^{blub}" syntax could be used for that: change "blub" 
>>> to the URL, or "sub:URL" or something.
>> 
>> Just to be clear, would it look like the following?
>> 
>> e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd     refs/heads/bernstein
>> c5c64e3fe48302f0c4581985f9c68d615f7bcb4e     refs/heads/master
>> 3fa7ded19a8da868d3af7c942f86358e6720f0c7     refs/heads/submodule
>> /home/sverdool/public_html/cloog.git cloog^{URL}
>> http://www.liacs.nl/~sverdool/cloog.git      cloog^{URL}
> 
> I was more thinking about something like this:
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7      refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}
> 
> But then, I haven't really thought about it deeply.

I was thinking about the following:

  ref: refs/heads/master        HEAD
  e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd      refs/heads/bernstein
  c5c64e3fe48302f0c4581985f9c68d615f7bcb4e      refs/heads/master
  3fa7ded19a8da868d3af7c942f86358e6720f0c7      refs/heads/master:submodule/path
  URL: /home/sverdool/public_html/cloog.git     refs/heads/master:submodule/path^{URL}
  URL: http://www.liacs.nl/~sverdool/cloog.git  refs/heads/master:submodule/path^{URL}

By the way, it would be nice if git-show-refs --deferefence used TAB
between sha1 and ref name, like in git-ls-remote / git-peek-remote,
otherwise I think git-show-refs output parsers would fail on [proposed]
"current branch" extension.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
