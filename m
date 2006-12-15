X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] A unique way to express "all" (vs "add vs "update") ?
Date: Fri, 15 Dec 2006 13:09:14 +0100
Message-ID: <4582906A.7020204@op5.se>
References: <elu1cn$k3$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 12:09:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <elu1cn$k3$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34499>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvBsP-0007jX-CH for gcvg-git@gmane.org; Fri, 15 Dec
 2006 13:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752034AbWLOMJR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 07:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWLOMJR
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 07:09:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51536 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752034AbWLOMJQ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 07:09:16 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id D3A746BCBC; Fri, 15 Dec 2006 13:09:14 +0100 (CET)
To: t2a2e9z8ncbs9qg@brefemail.com
Sender: git-owner@vger.kernel.org

Jerome Lovy wrote:
> Hi,
> 
> While I am very happy with the refactorings undertaken with regard to
> "git add/git commit" (both for UI and documentation), I am still a
> little confused by the different ways I seem to find to express the idea
> "I want to add (sort of) all file contents".
> 
> To be more specific, I find the following in the current documentation:
> 
> git add <dir>
>     "adds content from all files under <dir>  directory and its
>     subdirectories."
>     (as interpreted from the "EXAMPLES" section of the git-add
>     man-page)
>     (BTW, could this <dir> usage be documented in the SYNOPSIS and
>     DESCRIPTION sections (admittedly at a 2nd rank after the
>     currently documented usage)  as well as in the EXAMPLES ?
>     Besides this reference sections would probably include the
>     <dir>/<regexp> usage that I've not mentioned here for the sake
>     of simplicity.)
>     
>     Moreover, the tutorial documents the typical usage "git add ."
> 
> git commit -a|--all
>     "automatically stage files that have been modified and deleted,
>     but new files you have not told git about are not affected."
> 
> Granted, the latter semantics for "all" is not exactly the same as the
> former. Nonetheless, I think it would be very nice to only have to 
> memorize one way to express "all".
> 

But the former isn't "all"; It's a specific directory, although "." 
happens to *look* like "all", you can run "git add ." in a subdirectory 
inside the repository and it won't mean "all" anymore. Likewise, you can 
say "git commit ." from a subdirectory and have it commit all changes to 
all tracked files under that directory.

> To this end, I would be very happy with the following:
> (X-mas is coming soon, isn't it ;-)  )
> 
> git add <dir>
>     same semantics
> 
> git commit -a|--add <files>
>     "adds content from the specified files before committing
>     (files that are already tracked have their current content
>     staged)"
> 
> git commit -a|--add <dir>
>     "adds content from all files under <dir>  directory and its
>     subdirectories before committing"
>     (once again, for simplification of my explanations, I omit the
>     <dir>/<regexp> usage here)
> 
> git commit -u|--update <dir>
>     "automatically stage files that have been modified and deleted
>     under <dir>  directory and its subdirectories, but new files you
>     have not told git about are not affected."
>     (once again, for simplification of my explanations, I omit the
>     <dir>/<regexp> usage here)
> 

But this isn't "commit" at all. It's "git add".

>     (This would allow the typical usage "git commit -u ." which is
>     barely longer than the current "git commit -a")
> 
> For interface completeness, "git commit -u|--update <files>" could also
> exist but would probably be of no use.
> 
> To sum up, "all" would be consistently expressed with the <dir> syntax.
> "git commit -a" would not mean "--all" anymore. Lastly, a distinction
> would be made between "--add" and "--update":
> - "git commit -add" would have the same semantics as "git add"

This is bollocks. git commit should commit things. We'll be in some 
serious trouble if "git commit -a" stops working the way it has and 
starts just adding things to index.

> - "git commit --update" on the other hand would only affect the files
>   already tracked
>

I fail to see what you're after with the changes propsed in this mail.
Is there a use-case you've encountered where you wanted to do something 
that wasn't possible, or easy enough, that made you post this?

Unless it's a very, very good reason I most urgently think we're better 
off keeping the current "git commit -a" behaviour.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
