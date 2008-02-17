From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 00:20:29 +0000
Message-ID: <20080217002029.GA504@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 01:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQXHQ-0007xw-He
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 01:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYBQAUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 19:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbYBQAUk
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 19:20:40 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:57168 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYBQAUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 19:20:39 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JQXGm-0005Bx-R1; Sun, 17 Feb 2008 00:20:36 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1H0KTbq001066;
	Sun, 17 Feb 2008 00:20:29 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1H0KTJQ001065;
	Sun, 17 Feb 2008 00:20:29 GMT
Content-Disposition: inline
In-Reply-To: <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 554911c67655d9e04deac9d4e09032f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74085>

On Sat, Feb 16, 2008 at 11:37:31PM +0100, Steffen Prohaska wrote:
> 
> On Feb 16, 2008, at 7:53 PM, Charles Bailey wrote:
> 
> >Currently git mergetool is restricted to a set of commands defined
> >in the script. You can subvert the mergetool.<tool>.path to force
> >git mergetool to use a different command, but if you have a command
> >whose invocation syntax does not match one of the current tools then
> >you would have to write a wrapper script for it.
> >
> >[...]
> >
> >This is a preliminary patch which aims to make it easier to use
> >a.n.other 3-way merge tool with git-mergetool without either hacking
> >the source or writing a wrapper script for the tool.
> 
> Why not just add the tools you have in mind to git mergetool?  If
> everyone did that eventually we would have direct support for a
> rather long list of tools.  This would be the easiest solution
> for the end user: He could just choose the preferred tool and use
> it.  The invocation of each merge tool would be coded in
> mergetool.  The exact command line could be fine tuned and would
> be reviewed by other git developers.
> 

I have to disagree with this approach. I didn't actually have these
tools in mind when I wrote the patch, I searched around for tools that
I've used in the past and tools that I know that other people use. I
had in mine the questions that I'd want to be able to answer when
people ask me about git. It's not that the list will be large, it's
that it will never be complete because there will always be tools that
aren't globally available.

When I'm asked "can I use xyz visual merge tool" with git there will
always be some xyz for which the tool isn't yet in the list. It's a
lot more difficult to sell "patch the tool, submit the patch so it
doesn't get lost in the next upgrade of git, oh and support the patch
so that it does get integrated" than it is to sell "take the command
line format, massage it and put it in your system/global config".

> If you just integrated these tools directly I could use them
> right away instead of first reading the documentation of the
> custom mechanism and then looking up how to configure the right
> command line for the tool I want to use.  If the tools were
> directly integrated I could for example just say "git mergetool
> --tool=p4".
> 
> That does not mean I am opposed to adding a mechanism for
> handling custom tools.  But easier for the end user would be
> if the tools were directly integrated.
> 
> 		Steffen

Sure, it's nice when the tool you want is already integrated but the
list is never going to be perfect. This patch was designed to support
the fallback position: OK, my tool isn't natively supported, how
easily can I get it working?

I don't believe that git installs a system config by default, but one
idea I had was to rip out all of the native tools support in git
mergetool and replace it with a list of predefined custom tools
configs. This would put all merge tools on an equal footing and should
make extra tool support patches simpler and easier to integrate. This
doesn't have any legs without a system default config, though.

Charles.
