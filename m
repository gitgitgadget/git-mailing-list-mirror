From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-submodule command
Date: Fri, 25 May 2007 12:31:35 -0700
Message-ID: <7vodk8r97s.fsf@assigned-by-dhcp.cox.net>
References: <8c5c35580705250752k2021f02dv804d87da5c0d5da7@mail.gmail.com>
	<11801165433267-git-send-email-hjemli@gmail.com>
	<Pine.LNX.4.64.0705251924280.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 21:31:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrfVm-00059H-0y
	for gcvg-git@gmane.org; Fri, 25 May 2007 21:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbXEYTbh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 15:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbXEYTbh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 15:31:37 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:43857 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbXEYTbg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 15:31:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525193137.TJCE19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 25 May 2007 15:31:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3XXb1X00U1kojtg0000000; Fri, 25 May 2007 15:31:36 -0400
In-Reply-To: <Pine.LNX.4.64.0705251924280.4648@racer.site> (Johannes
	Schindelin's message of "Fri, 25 May 2007 19:41:38 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48401>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 25 May 2007, Lars Hjemli wrote:
>
>> Btw: testing this quickly becomes tedious, so I'll try to make a proper 
>> testscript later tonight.
>
> Very good.
>
>> +'git-submodule' [--init | --update | --cached] [--quiet] [--] [<path>...]
>
> I did not realize this earlier, but we seem to have more and more programs 
> where actions are specified without "--", i.e. "git-svn fetch", or 
> "git-bundle create".
>
> I actually like that, to separate actions from options. Hmm?

I think it is a sensible thing to do for this kind of "wrapper
of different functionalities related to one area".

>> +-i, --init::
>> +	Initialize the specified submodules, i.e. clone the git repository
>> +	specified in .gitmodules and checkout the sha1 specified in the
>> +	index.
>
> How about "Initialize the submodules...", and then another sentence "If 
> you do not want to initialize all submodules, you can specify the subset 
> to initialize"?


>> +FILES
>> +-----
>> +When cloning submodules, a .gitmodules file in the top-level directory
>> +of the containing work-tree is examined for the url of each submodule.
>> +The url is the value of the key module.$path.url.
>
> IIRC Junio talked about a name for overriding. But I think it would be 
> even better to to override by mapping the URLs from .gitmodules to the 
> locally-wanted URLs.
>
> Junio?

I really do not want that (mis)conception that .gitmodules
specify the default and .git/config the override.  I really
think we should use the .git/config as _the_ only authority to
get URL, but keyed with the three-level scheme, with URL in
.gitmodules used _solely_ as a hint when setting up the URL in
the .git/config file.

	cf. $gmane/47502, 47548, 47621

>> +When updating submodules, the same .gitmodules file is examined for a key
>> +named 'module.$path.branch'. If found, and if the named branch is currently 
>> +at the same revision as the commit-id in the containing repositories index, 
>> +the specified branch will be checked out in the submodule. If not found, or 
>> +if the branch isn't currently positioned at the wanted revision, a checkout
>> +of the wanted sha1 will happen in the submodule, leaving its HEAD detached.
>
> A very good description, and I think this is the only method to checkout 
> the submodule which makes sense. (Just maybe default the value of 
> module.<path>.branch to "master"?)

I suspect leaving the HEAD always detached if the superproject
tree names a concrete commit object name would be less confusing
and consistent.  When the name of the commit object in the
superproject tree and/or index is 0{40}, it would be a good
extension to use "whatever commit that happens to be at the tip
of this branch" taken from the .gitmodules file.
