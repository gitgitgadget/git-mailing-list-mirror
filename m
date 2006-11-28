X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 08:08:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 16:10:02 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.160 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32543>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp5W8-00023B-Ug for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758698AbWK1QJG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 11:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758699AbWK1QJF
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:09:05 -0500
Received: from smtp.osdl.org ([65.172.181.25]:27037 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1758698AbWK1QJE (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 11:09:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASG8bix012324
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 08:08:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASG8aK4015256; Tue, 28 Nov
 2006 08:08:36 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Johannes Schindelin wrote:
> 
> On Tue, 28 Nov 2006, Jakub Narebski wrote:
> 
> > [... some reasons why git-annotate is not just your regular annotate ...]
> 
> You should also mention that git-annotate can follow code movements 
> through file renames.

.. and within the same file, and _copied_ from other files.

A good example of this is still just doing a

	git blame -C revision.c

because that "revision.c" file was created by splitting the old 
"rev-list.c" into two files (revision.c and rev-list.c). And the fact that 
"git blame" catches it and shows it in a very natural format is really 
quite nice.

(rev-list.c has since been renamed to "builtin-rev-list.c", so if you want 
to see the "other" side of the split, just do

	git blame -C builtin-rev-list.c

in order to realize how well git blame follows both renames _and_ pure 
data movement).

The reason this is a good example is simply the fact that it should 
totally silence anybody who still thinks that tracking file identities is 
a good thing. It explains well why tracking file identities is just 
_stupid_.

You simply couldn't have done that kind of split sanely with file identity 
tracking (well, that one only had a single copy, so you could argue that a 
file identity tracker with copies could have done it, but the fact is that 
(a) they never do and (b) "git blame" can equally well track stuff that 
comes from _multiple_ different "file iddentities").

Such a "multiple sources" case can actually be found by doing

	git blame -C tree-walk.c

which (correctly) figures out that the code comes from both merge-tree.c 
(the "entry compare/extract" functions)_and_ from sha1_name.c (the 
"find_tree_entry()" function). 

So yes, "git blame" is a _hell_ of a lot more powerful than anybody elses 
"annotate", as far as I know. I literally suspect that nobody else comes 
even close.

