From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-check-ref-format returns 1 for valid branch names
Date: Thu, 22 Mar 2007 14:03:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703221358420.6730@woody.linux-foundation.org>
References: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
 <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, git <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 22:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUUSP-0001mK-Cc
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 22:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934234AbXCVVEP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934241AbXCVVEP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 17:04:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:51455 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934234AbXCVVEN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 17:04:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2ML3gG9020280
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 14:03:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2ML3faB030314;
	Thu, 22 Mar 2007 14:03:41 -0700
In-Reply-To: <7vejnht3x2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42881>



On Thu, 22 Mar 2007, Junio C Hamano wrote:

> "Nikolai Weibull" <now@bitwi.se> writes:
> 
> > I'm obviously doing something wrong, but in git 1.5.0.4
> >
> > % git check-ref-format abc
> > % echo $?
> > 1
> >
> > What am I missing here?
> 
> If you are trying to see if abc is a valid branch name, try refs/heads/abc.

.. and before anybody wonders why it wants the "fully qualified" name, 
it's because "abc" on its own is ambiguous. Is it a _tag_ called "abc", or 
a branch, or what? That explains why - if you really want to verify a 
ref-name, you need to give the full name..

On the other hand, if you don't care, and you just want "is this a valid 
commit name", use

	sha1=$(git rev-parse --verify "$name"^0) || exit

or similar. It won't care if "name" is ambiguous or not, it will just try 
to parse it as a revision expression (with the "^0" there to force a tag 
to be converted to a commit-name, or force an error if the SHA1 is not a 
valid commit).

			Linus
