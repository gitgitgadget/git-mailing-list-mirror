From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 19:28:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704111917130.4061@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
 <461D6432.90205@vilain.net> <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
 <461D6858.4090007@vilain.net> <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
 <7vslb6mnva.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704111850240.4061@woody.linux-foundation.org>
 <7vy7kyl5br.fsf@assigned-by-dhcp.cox.net> <7vmz1el51o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbp2g-0002Ht-Np
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbXDLC2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbXDLC2G
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:28:06 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42116 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161481AbXDLC2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:28:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3C2S1VZ031061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Apr 2007 19:28:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3C2S0sl020836;
	Wed, 11 Apr 2007 19:28:00 -0700
In-Reply-To: <7vmz1el51o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44313>



On Wed, 11 Apr 2007, Junio C Hamano wrote:
> 
> Ah, forget about this.  The HEAD, which is in the tree of the
> higher-level project, is a ref.  Silly me.

Well, not entirely "silly you".

If you do a "git reset" in the superproject, that will obviously have to 
rewrite the heads in the subproject.

I do suspect that we should always enable reflogs for the subprojects, so 
that pruning is safe even for these kinds of situations, but that 
doesn't resolve all issues.

For example: to manage *cloning* of the extra stuff, you might actually 
want to have externally visible refs, and while I suspect the main 
solution will always be to just do good maintenance (ie "don't do 'git 
bisect' and _never_ rewrite history in the main superproject!!"), I don't 
think it's out of the question to add other safety nets too..

So for example, while I'm not sure it's necessary, I don't think it would 
be *wrong* if we might eventually end up having *other* safety features 
like adding a totally separate "refs/superprojects/xyzzy" ref structure. 

Or something like that.. Just to make the refs more visible both 
externally and internally, and to make it much harder to make stupid 
mistakes without realizing it.

I suspect a lot of this will depend on just how many mistakes people make. 
I don't think we've so far had a single problem with alternates files, 
re-basing, and people then pruning away objects used by other repositories 
by mistake, so maybe people really don't make those kinds of mistakes.

So maybe we don't need any extra safety nets at all. But who knows..

		Linus
