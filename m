X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 08:49:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612010844380.3695@woody.osdl.org>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com>
 <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de>
 <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de>
 <20061201133558.GU18810@admingilde.org> <45703174.8000609@op5.se>
 <20061201134610.GW18810@admingilde.org> <457041AD.4010601@op5.se>
 <20061201150045.GZ18810@admingilde.org> <45705A94.2070509@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 16:51:15 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, sf <sf@b-i-t.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <45705A94.2070509@op5.se>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32944>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBbB-0002od-Du for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031600AbWLAQud (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031607AbWLAQuc
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:50:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60316 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031600AbWLAQub (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:50:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB1GnLjQ017786
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Fri, 1
 Dec 2006 08:49:24 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB1GnKL0018738; Fri, 1 Dec
 2006 08:49:21 -0800
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org



On Fri, 1 Dec 2006, Andreas Ericsson wrote:

> Martin Waitz wrote:
> > 
> > But if the supermodule contains changes to the submodule, you still
> > have to change the submodule.  And this implies changing the submodule
> > HEAD or some branch.
> > 
> 
> Not really. I fail to see why HEAD needs to be changed so long as the commit
> is in the submodule's odb.

Right. A commit in the supermodule should _not_ imply a commit in the 
submodule.

Maybe I should take a look at the code, but it sounds like people are 
still trying to "mix" submodules too much. 

Think of it this way: one common use for submodules is really to just 
(occasionally) track somebody elses code. The submodule should be a 
totally pristine copy from somebody else (ie it might be the "intel driver 
for X.org" submodule, maintained within intel), and the supermodule just 
refers to it indirectly (ie the supermodule might be the "Fedora Core X 
group" which contains all the different drivers from different people).

So anything that mixes super-modules and sub-modules too much will always 
break this kind of model.

A supermodule can never "contain changes" to a submodule. A supermodule 
would always just point to the submodule, and not have any changes 
what-so-ever of its own. The submodule is self-sufficient, and always 
contains all its _own_ changes.

