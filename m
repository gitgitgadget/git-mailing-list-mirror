X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 11:52:13 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612021144520.3476@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612020036.08826.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0612011540010.3695@woody.osdl.org> <200612021232.08699.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 2 Dec 2006 19:52:38 +0000 (UTC)
Cc: sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Waitz <tali@admingilde.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612021232.08699.Josef.Weidendorfer@gmx.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33036>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqauU-0007ql-KA for gcvg-git@gmane.org; Sat, 02 Dec
 2006 20:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759476AbWLBTw1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 14:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759479AbWLBTw1
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 14:52:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37796 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1759476AbWLBTw1 (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 14:52:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB2JqEjQ020368
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sat, 2
 Dec 2006 11:52:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB2JqDif027322; Sat, 2 Dec
 2006 11:52:13 -0800
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org



On Sat, 2 Dec 2006, Josef Weidendorfer wrote:
> > 
> > The only _true_ namespace would be the SHA1 of the commit (and maybe allow 
> > a pointer to a tag too, but the namespace ends up being the same).
> 
> I am not so sure about this.
> Perhaps we want the namespace to be more than the space of commit ids.

I don't think it would be wrong at all to have a "link object" type, and 
have the "link" tree entry actually point to that "link object" instead of 
pointing directly to the commit in the submodule.

And yes, that extra indirection would allow for more flexibility (the 
"link object" can contain comments about the particular version used, 
pointers to where you can get it - whether human-readable or strictly 
meant for automation - etc etc).

So I agree with Andy Parkins' comment about the link object allowing not 
only extended namespaces, but also allowing a certain amount of 
flexibility (ie there's some built-in extensibility and ability to perhaps 
add future fields if there's a new object type).

I just want the naming of the links themselves to use all the same SHA1 
hashes etc, so that you always have a very explicit, and very trustworthy 
version - and never end up in the situation that you know which repository 
you want at that position, but you don't know exactly which commit in that 
repo was supposed to be checked out with that particular version of the 
super-module.

