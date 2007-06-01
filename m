From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Let .git/config specify the url for submodules
Date: Fri, 01 Jun 2007 12:55:50 -0700
Message-ID: <7vfy5bzby1.fsf@assigned-by-dhcp.cox.net>
References: <1180385483418-git-send-email-hjemli@gmail.com>
	<8c5c35580705301717h4e9b127fr21ee19764f8ec288@mail.gmail.com>
	<20070601085705.GT955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010225p7c34c3ceu8bbfb9996388d673@mail.gmail.com>
	<20070601093554.GV955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010745l76fc5410l21f2e3f385693ad9@mail.gmail.com>
	<20070601145104.GY955MdfPADPa@greensroom.kotnet.org>
	<8c5c35580706010856s390b1157p3ea0d28cb2074cae@mail.gmail.com>
	<alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 21:56:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuDED-0003gp-04
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 21:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762103AbXFATzw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 15:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762080AbXFATzw
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 15:55:52 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45748 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762103AbXFATzv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 15:55:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601195552.LLOJ5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 1 Jun 2007 15:55:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Kvq1X00U1kojtg0000000; Fri, 01 Jun 2007 15:55:51 -0400
In-Reply-To: <alpine.LFD.0.98.0706010919360.3957@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 1 Jun 2007 09:29:58 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48879>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 1 Jun 2007, Lars Hjemli wrote:
> ...
> Ack. I think the natural thing for a lot of cases is the trivial "module 
> name == path" case, so having to have
>
> 	[path "kernel"]
> 		module = kernel
>
> for that case just sounds unnecessary.
>
> That said, I wonder if it wouldn't be more natural to do things the other 
> way around, because quite often a "module" (under CVS conventions) is a 
> *set* of directories, so with that in mind, it might be better to have the 
> mapping be something like this:
>
> 	[module "infrastructure"]
> 		submodule = lib
> 		submodule = build
>
> 	[submodule "lib"]
> 		url = git://xyzzy/lib-1.2.3
>
> 	[submodule "build"]
> 		url = git://xyzzy/build-0.61
>
> and make the rule be:
>  - submodules are named by their paths (ie "path == submodule")
>  - a module is a set of such submodules/paths
>  - if no "module" is defined, the default is to just use the 
>    path/submodule name

I take that if you do want to name a submodule differently from
its (currently in-tree) path, you would do something like...

	[submodule "xyzzylib"]
        	path = lib
                url = git://xyzzy/lib-1.2.3

> IOW, in the above case, we have *three* modules:
>
>  - module "infrastructure", that is the union of submodules/paths "lib" 
>    and "build"
>  - module "lib" (== submodule/path "lib")
>  - module "build" (== submodule/path "build")
>
> and when you do a 
>
> 	git submodule checkout infrastructure
>
> it would be basically equivalent to
>
> 	git submodule checkout lib
> 	git submodule checkout build

Sounds very sensible.
