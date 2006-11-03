X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multiple branches or  multiple repositories
Date: Thu, 2 Nov 2006 23:11:53 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611022301380.25218@g5.osdl.org>
References: <eie7ae$ib6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 3 Nov 2006 07:12:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <eie7ae$ib6$1@sea.gmane.org>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30790>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GftDb-0001i7-PC for gcvg-git@gmane.org; Fri, 03 Nov
 2006 08:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753159AbWKCHL4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 02:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753178AbWKCHL4
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 02:11:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9628 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753159AbWKCHL4 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 02:11:56 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA37BsoZ009608
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 2
 Nov 2006 23:11:54 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA37BrM3012152; Thu, 2 Nov
 2006 23:11:54 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Fri, 3 Nov 2006, Han-Wen Nienhuys wrote:
> 
> We're in the process of converting the LilyPond CVS repository at
> savannah.gnu.org to GIT.  One of the questions we need to deal with, is how
> handle modules.
> 
> There seem to be two approaches:
> 
>  - for each module, create a separate git repository.  Inside the repository,
>    each subproject has its own branching
> 
>  - put each module as a separate branch in a shared repository.
> 
> I think the first option is the most natural one, but are there any issues,
> besides namespace pollution to the second option?

There are no real issues either way, and perhaps more importantly, it's 
not even something you have to decide on day one.

You can easily do it one way or the other, and either
 - switch around as needed
 - or even _mix_ the two approaches where it makes sense.

For example, it may be entirely sensible to have the common "distribution 
points" use a single shared repository that contains all modules as 
separate branches within the same repository.

But even though such a central distribution point repository is set up 
that way, individual developers may well decide that they are happier 
having separate repositories for different modules. The two approaches are 
not mutually incompatible, and you can fetch data and push it back out 
between both different kinds of repositories.

The namespace pollution - especially of tags - is indeed likely to be the 
worst issue. If you expect to have many independent modules in the same 
repository, you obviously shouldn't use tag-names like the Linux kernel 
uses (ie "v2.6.18"), since those would not be unambiguous in such a shared 
repo. 

(The same is true of branches too, but perhaps less so if only because 
people are _already_ using different branch names between different 
repositories, and we have good support for translating a local branch 
name "X" into a remote branch name "Y" when transferring data between the 
two. In contrast, tagnames are kind of expected to be "shared")

But if you're ok with always just naming tags "modulename/release-1.2.3" 
or similar, you shouldn't really have any issues either way. And most 
importantly, if you do decide to go one way, and then later figure out 
that it would have been easier the other way, you can just switch between 
the two models, exactly because mixing them isn't really a problem.

