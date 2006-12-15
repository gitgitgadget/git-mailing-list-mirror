X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 13:55:11 -0800
Message-ID: <7v64ccomdc.fsf@assigned-by-dhcp.cox.net>
References: <200612132200.41420.andyparkins@gmail.com>
	<20061213225627.GC32568@spearce.org>
	<200612140908.36952.andyparkins@gmail.com>
	<7vodq695ha.fsf@assigned-by-dhcp.cox.net>
	<fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
	<Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
	<Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
	<Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<fcaeb9bf0612150726o40527552l8b3564ddcc3adb94@mail.gmail.com>
	<Pine.LNX.4.63.0612152115000.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612152117390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:56:21 +0000 (UTC)
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34563>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL2R-0006er-2m for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965199AbWLOVzY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWLOVzU
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:20 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44909 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965199AbWLOVzN (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215512.KNTA29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vP1V0161kojtg0000000; Fri, 15 Dec 2006
 16:55:24 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 15 Dec 2006, Johannes Schindelin wrote:
>
>> On Fri, 15 Dec 2006, Nguyen Thai Ngoc Duy wrote:
>> 
>> > About adding index support to git-show, yes it's really messy. index
>> > doesn't have tree objects.
>> 
>> Insofar, it is not messy: git-show only shows _objects_. For example, "git 
>> show :README" works as expected if you have a file called "README" in the 
>> index...
>
> Note: this is not completely true. The index contains cache_trees...

Let's not go there.

I was reviewing the list of plumbing in Documentation/git.txt
last night, and I think ls-files is the only command that user
may still want to use from the command line every day.

I originally thought that it would only be after a conflicted
merge, always with -u option, but some people seem to find that
"ls-files --others" and friends are useful (I never use that
myself) and if so what it does really in the realm of Porcelain.

I haven't formed a firm opinion on this yet, but possibilities
are:

 * we reclassify ls-files as a Porcelain-ish (but do not change
   its UI nor defaults at all); we might want to give a shorter
   alias to the command, though, if we go this route.

 * we give '--list' option to 'git show' and in such a case,
   lack of objects does not default to HEAD -- when no object is
   given it internally diverts to cmd_ls_files() instead;

 * we add 'git ls' command to give Porcelain-ish access to
   ls-tree and ls-files.

