From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to migrate folders using svn:externals exclusively (no actual
  data inside folder) to git submodules?
Date: Fri, 14 May 2010 21:17:39 +0200
Message-ID: <4BEDA1D3.3050203@drmicha.warpmail.net>
References: <AANLkTikJNSPKPDdpYEYVJogPq22LyOr0s3QxEF7wZO1Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jensen Somers <jensen.somers@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 21:18:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OD0PF-0000gv-Vf
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 21:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab0ENTSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 15:18:33 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41047 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451Ab0ENTRr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 May 2010 15:17:47 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 84BB8F6B46;
	Fri, 14 May 2010 15:17:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 May 2010 15:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JSOTrzDKcG3taZILlll6BB2P61Y=; b=gNXwHaF4ZcZ1Rxe59Z/jsLoRktCWinMh+ifgiYW1uLTscnBJZg5I5fqulBsxxy8YnAOD2qICWZ6TAbTj5a/hc4lNM9cxMf2PJ/110w8RvEX1uomsutRoa+wYtul4mNLd7wau6jXb71RIITsGI9tbimpjZMJQnYvT2p3e2ANAvos=
X-Sasl-enc: 66q17YF8TSZO5wJLCse2lPjg6aIigLafsKPjqlV2li2f 1273864655
Received: from localhost.localdomain (p5485982A.dip0.t-ipconnect.de [84.133.152.42])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AC4814C311A;
	Fri, 14 May 2010 15:17:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <AANLkTikJNSPKPDdpYEYVJogPq22LyOr0s3QxEF7wZO1Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147114>

Jensen Somers venit, vidit, dixit 14.05.2010 20:53:
> Hello,
> 
> Having used Git a couple of times on some open source projects I am
> beginning to be more and more convinced of the power and benefit it
> has over subversion. One of the major benefits for me is the
> possibility to create local branches - and thus work on several things
> at the same time - without interfering with the actual master
> repository or to have 10 different /trunk folders on my hard drive.
> 
> Where I work we currently use subversion but I am looking into
> migrating everything to Git. There is one thing that is not very clear
> to me though and I hope somebody could shine some light on the matter.
> 
> Our current repository is set up as follows:
> /
> + /Modules
> + + /ModuleA
> + + /ModuleB
> + + /ModuleC
> + /Applications
> + + /ApplicationA
> + + /ApplicationB
> + /Views
> + + /ViewApplicationA
> + + /ViewApplicationB
> 

When I switched from svn to git, the first thing I needed to do was to
"think small": Don't use one big repo for vaguely related things - use
many small ones. You see, in git it's so simple to create one, it
doesn't even hurt!

I don't think Views, Applications and Modules belong in the same repo here.

> ViewApplicationA and ViewApplicationB are empty folders which use the
> svn:externals property to include all required folders. For
> ViewApplicationA this would for example be ApplicationA, ModuleA and
> ModuleC, for ViewApplicationB this would be ApplicationB, ModuleB and
> ModuleC. Using the views the developers are able to checkout only
> what's needed for the given project they work on.
> And this is where Git confuses me. As an alternative for svn:externals
> I stumbled upon Git submodules but I am not entirely sure they allow
> me to do the same thing. Can I create a sub folder on my root Git
> repository and let developers check out only that folder or do I need
> to create a separate repository per view and reference another
> repository (holding all actual data) as a submodule? And can I
> actually do that on the server? Most examples I found talk about
> cloning another repository as a submodule, but all of them seem to do
> it locally, and not on the server and I don't want to bother every
> developer doing all that every time he decides to start fresh.

Are your Modules interrelated, are your Applications interrelated enough
so that it makes sense you have branches ModuleX in a repo Modules etc.?
If not you may just have one repo per Module and per Application.

Views are a candidate for submodules referencing the Application and
Module repos they need.

Michael
