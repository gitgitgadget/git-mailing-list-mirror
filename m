From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cogito: cg-push doesn't push tags?
Date: Thu, 29 Dec 2005 14:08:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512291404240.3298@g5.osdl.org>
References: <43B45C39.8040501@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 23:09:12 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Es5xL-00078O-7W
	for gcvg-git@gmane.org; Thu, 29 Dec 2005 23:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbVL2WJE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Dec 2005 17:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVL2WJD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Dec 2005 17:09:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18894 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751028AbVL2WJB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2005 17:09:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBTM90DZ021138
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Dec 2005 14:09:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBTM8xcd023194;
	Thu, 29 Dec 2005 14:09:00 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43B45C39.8040501@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14107>



On Thu, 29 Dec 2005, H. Peter Anvin wrote:
>
> It seems that cg-push in cogito 0.16.2 doesn't push new tags when used over
> git+ssh transport?  Am I completely wet behind the ears, or is that a bug?

List the tags you want pushed. 

The git transport (whether over ssh or locally) will default to updating 
only _shared_ references. So any heads that you have updated it will 
update by default. But if you want to create a new branch or tag on the 
other end, you need to list it explicitly (and once you do, it won't do 
the default ones at all).

Now, "git fetch" has a "--tags" argument that is shorthand for "all tags", 
and I think we should add that to "git send-pack" too just because it's 
both a common operation _and_ it mirrors "git fetch". But in the meantime 
you can hack around it with something like

	git send-pack <destination> $(cd .git/refs/ ; echo tags/*)


which is a silly way to list all tags ;)

		Linus
