From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Sun, 15 Apr 2007 13:51:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
 <200704152051.35639.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBht-0006NO-D1
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbXDOUwS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbXDOUwS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:52:18 -0400
Received: from smtp.osdl.org ([65.172.181.24]:35979 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbXDOUwR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:52:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FKphIs025274
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 13:51:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FKpg1A020156;
	Sun, 15 Apr 2007 13:51:42 -0700
In-Reply-To: <200704152051.35639.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44524>



On Sun, 15 Apr 2007, Andy Parkins wrote:
> 
> You're right that it can cause problems, but it is certainly not the 
> case that there are no valid uses for it.

I'm sorry, but you're just wrong.

There are no valid uses for it in the working tree. Full stop.

There are valid uses to tag sources with some revision information WHEN IT 
LEAVES THE REVISION CONTROLLED ENVIRONMENT, but not one second before 
that.

> I keep diagrams for a project in SVG format in the repository, this 
> works very well because SVG is so nicely ASCII.  In the title block of 
> the diagram I put "$Id$", then in subversion, after checking in and 
> updating it got expanded to
> 
>  $Id: diagram.svg 148 2002-07-28 21:30:43Z andyp $
> 
> Now, I print out that diagram and pin it to my wall - sometimes copies 
> of it are given to others.  I do this on a regular basis.

And is there *any* reason why you don't just do that as an "export" 
option, when it's very clear that people won't send diffs that include it 
and that will cause all the endless problems that keyword expansion 
causes?

Why would you ever have the pain and suffering of using it within the 
source control issue? Especially since you would be a *lot* better off 
using just an export script that can do a lot better than CVS/SVN keyword 
expansion could ever do (ie you can add all sorts of more relevant 
information than just a date and user name!)

> Please explain to me why that is not a valid use.

It's not a valid use because there are many SO MUCH BETTER WAYS to get the 
same thing, that have none of the downsides of keyword expansion?

Your argument is akin to saying that "Why isn't it a valid use to replace 
the steering wheel in my car with a mouth-operated joystick under the 
passenger side seat?"

Sure, you *can* steer a car by mouthing at it while having your head under 
the passenger side seat, and your butt sticking out through the moonroof 
("We could add a periscope so that I can see where I'm going!")

But that's not an argument *for* doing it, when there are ways that are 
obviously much better, and don't _need_ the periscope!

See?

The fact that you *can* do something is not a valid argument for it being 
a valid use. You *can* do stupid things, but if you can get to the same 
end result by not doing stupid things, wouldn't you prefer that instead?

Here's a small makefile snippet for you:


	%.prt: %.svg
		sed 's/\$$Id\$$/\$$ $(shell git log --pretty=format:"%h: %s (%an)" --abbrev-commit -1 file.svg) \$$/g' < $< > $@

which would need some work (it doesn't quote things right - in reality 
you'd write a simple script to do this properly).

See? No need for a periscope, and your butt can be toasty warm too if you 
just add a seat heater option...

		Linus
