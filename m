X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT - releases workflow
Date: Tue, 12 Dec 2006 18:43:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612121831570.3535@woody.osdl.org>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 02:49:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:49:30 EST
In-Reply-To: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34179>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuKBp-0001h7-US for gcvg-git@gmane.org; Wed, 13 Dec
 2006 03:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932465AbWLMCtc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 21:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWLMCtb
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 21:49:31 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43212 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932465AbWLMCtb
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 21:49:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBD2h8ID003819
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 12
 Dec 2006 18:43:09 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBD2h8VF025431; Tue, 12 Dec
 2006 18:43:08 -0800
To: Sean Kelley <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org



On Tue, 12 Dec 2006, Sean Kelley wrote:
>
> I was wondering if anyone could share ideas on how best to use GIT to
> handle releases for those working with a remote GIT repository?  Do
> you create a branch and push it to the remote?  Thus you have a new
> branch referencing the particular release?

I don't think there is a "right" model, but at least _one_ model is what 
the kernel uses:
 - the actual "release" is just tagged
 - any release development (ie "maintenance") is literally done in a 
   totally separate repository, both from a development standpoint _and_ 
   an actual release management standpoint.

This may sound strange, but it actually has what I consider to be huge 
advantages:

 - it fits very well in the "distributed" mental model

 - it makes the separation of "maintenance" and "development" very very 
   clear. It's clear at all levels that the two are not the same thing, 
   don't have the same goals, and often not done by even the same groups, 
   or even by same management.

I think the second point is actually important.

At the same time, the distributed model of git means that if you want to 
mix the two trees, you easily can: you just fetch from the two independent 
release trees into the same repository. So the fact that they are 
maintained completely independently doesn't mean that they can't be 
joined, it just means that there's a clear separation at all levels.

Also note how _different_ releases may well end up having _separate_ 
repositories. So it's not that there is "one repository for development, 
and one repository for maintenance". It's literally "one repository for 
_each_ release maintenance".

Now, I think this kind of "separate repository for release maintenance 
trees" is actually a great model, and I think it can make perfect sense in 
various commercial/proprietary settings too (ie I know from experience 
that you tend to often have separate groups and very different rules for 
maintenance, so having the separate repository really does make sense).

But at the same time, for a smaller project, it obviously does NOT make 
sense. Git itself, for example, just has a "maint" branch, and does 
everything with the same maintainer, and in the same repository. Within 
something like git, that makes sense, because there just isn't a separate 
"stable tree maintainer", and trying to enforce that kind of thing would 
just be insane anyway within the setting of git.

So in some settings, you might just have a branch for each stable release, 
or as in the case of git, just a single branch for "maintenance", just 
because nobody is going to maintain older releases really at all (that 
might change with time, of course, but I think it's a pretty common 
pattern for smaller projects).

In short: I don't think there is "one correct way" to do these things.

