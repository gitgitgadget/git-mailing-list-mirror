From: Bill Lear <rael@zopyra.com>
Subject: Re: Projects within projects
Date: Thu, 29 Oct 2009 13:33:51 -0600
Message-ID: <19177.60959.457301.349805@lisa.zopyra.com>
References: <ab1d51700910291140ncd80027j4ee9a30637d7bc40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nick Colgan <nick.colgan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 20:34:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3al6-0004FS-U1
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 20:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615AbZJ2Td6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756608AbZJ2Td6
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 15:33:58 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:38228
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbZJ2Td6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 15:33:58 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9TJY1M15207;
	Thu, 29 Oct 2009 13:34:01 -0600
In-Reply-To: <ab1d51700910291140ncd80027j4ee9a30637d7bc40@mail.gmail.com>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131647>

On Thursday, October 29, 2009 at 14:40:36 (-0400) Nick Colgan writes:
>I'm currently working on a project made up of parts that could each be
>considered a project in itself. I plan on using redmine or trac to
>manage the project. Now I'm trying to figure out how to manage the
>repo(s) for the project.
>
>These are the current options I have in mind:
>
>1. Create a separate repository for each sub-project and manage each
>separately in redmine (separate bug tracker, wiki, etc.)
>
>2. Create a single repository with a subdirectory for each sub-project.
>
>3. Use git submodules or subversion externals to combine options 1 and 2
>by creating a separate repo for each sub-project, then creating a master
>repo with subdirectory for each sub-project that imports from their
>respective repositories.
>
>What's the best way to handle this situation? Are git submodules and/or
>svn externals sufficiently capable of dealing with this?

Let me give you an example of #3.  I write a fair amount in C++ and
have written a reasonably sophisticated makefile system to allow me to
create a new directory in a project, put files in it, link in a master
makefile, cd into the directory and type 'make' and have things build
without me having to edit the makefile --- I don't want to write
makefile rules, etc., I want to write C++ (fill in the blank here).
It basically relies on naming conventions, but it suits me perfectly.
If I name a file test_*.cc or t_*.cc, or tc_*.cc, it is a unit test,
if I name it m_*.cc, or main_*.cc, it is a main program.  Library
inter-dependencies are easy to set up in a central way, blah blah blah
--- the details are not terribly important.

In any case, I created a new project to work on some "real-time"
financial trading algorithms.  I did this by creating a new repository
into which I added a src directory, under which were several other
directories of source code.  At the top level of the new repo, I added
a git submodule 'mk' that contains my makefile system.  I then linked
the master makefile to my source directory makefile and was off
compiling easily.

In this case, I do absolutely reuse my makefile system across multiple
projects.  It is 100% orthogonal, and I have so far found it to be
very useful to use git submodules.

I imagine also if you are building software that is 100% orthogonal
that you would like to reuse in many projects, git submobules is the
way to go.

I read the Git Submodule Tutorial on the Git Wiki and found myself
able to use submodules very easily after that.


bill
