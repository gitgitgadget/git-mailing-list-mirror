From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 19:01:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111854160.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102004.08329.andyparkins@gmail.com> <Pine.LNX.4.64.0704101219280.6730@woody.linux-foundation.org>
 <7vwt0kugmy.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101325580.6730@woody.linux-foundation.org>
 <461D798B.3040008@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbodL-0006RK-SE
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbXDLCB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161470AbXDLCB5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:01:57 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41759 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161467AbXDLCB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:01:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C21nVZ030419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 19:01:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C21m3l020379;
	Wed, 11 Apr 2007 19:01:49 -0700
In-Reply-To: <461D798B.3040008@vilain.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44308>



[ Dang. Power failure in the middle of writing emails. Can't remember 
  which one was lost. Am rewriting some of this reply in abbreviated form.  ]

On Thu, 12 Apr 2007, Sam Vilain wrote:
>
> Linus Torvalds wrote:
> > So there's a very real issue where a repository with submodules still 
> > "works", even with a .gitmodules file that is totally scrogged and doesn't 
> > have the right information (yet), it's just that it may simply not be able 
> > to do all the operations because it cannot figure out where to pull 
> > missing subproject data from etc..
> >   
> 
> Whoa... "missing" subproject data?

Absolutely. Not just subproject data. The whole subproject is often 
missing.

If I fetch the KDE superproject, I generally do *not* want every single 
subproject. In fact, I'd likely just want one or two subprojects.

The notion that all subprojects are populated is a *bug*. I would 
personally refuse to use such a setup. Even CVS can handle that just fine, 
we certainly don't want to be worse than CVS here.

If you just track a project, it's quite common to only check out the "src" 
module, and *not* fetch things like the "validation" or "test" module if 
you're just following along. 

Or you might fetch the "kdebase" module, but that sure doesn't mean that 
you want all the other ones (kdevelop source code? full kdelibs sources? 
If I'm only interested in kwin and some other random app? No thanks!).

> Surely, unless you're doing lightweight/shallow clones, if you have a
> gitlink you've also got the dependent repository? Otherwise the
> reachability rule will be broken.

The reachability rule *must* be breakable. That's why fsck currently 
doesn't care AT ALL.

It's much better to break that rule than to even check it! I'd rather 
leave fsck like it is now, than to *ever* fix it, if the "fix" involves 
"you have to always fetch all submodules to shut fsck up".

		Linus
