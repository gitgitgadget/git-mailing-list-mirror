From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] checkout -d: explicitly detach HEAD even when switching
 to the tip of a branch
Date: Tue, 3 Apr 2007 18:55:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031850240.6730@woody.linux-foundation.org>
References: <7vr6r879zp.fsf@assigned-by-dhcp.cox.net> <euk8ps$vu1$1@sea.gmane.org>
 <200703311455.l2VEtHO5021300@localhost.localdomain> <7vtzvxt2v3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Xavier Maillard <zedek@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 03:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYuiW-0002Wx-6r
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 03:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966273AbXDDBzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 21:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966275AbXDDBzP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 21:55:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52754 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966273AbXDDBzN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 21:55:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l341t4PD030972
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 18:55:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l341t3GT009445;
	Tue, 3 Apr 2007 18:55:04 -0700
In-Reply-To: <7vtzvxt2v3.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.452 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43703>



On Tue, 3 Apr 2007, Junio C Hamano wrote:
> 
> Could anybody remind me why we have the "new != old" check here?

Afaik, it's just so that you can do

	git checkout -f

without having it complain. And I think it just comes from the earlier:

	[ -z "$new" ] && new=$old && new_name="$old_name"

that we did - ie without that it would incorrectly just overwrite the 
current working tree with the new commit, but not actually do the "git 
reset" part.

So without that check, the way things used to work (*before* detached 
heads), if you were to have done

	git checkout <some-random-head>

it would have screwed up the current branch horribly.

With detached heads, I don't think it's needed.

		Linus
