From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 16:30:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271626410.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <Pine.LNX.4.63.0702280059050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCiR-0001uk-7j
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXB1Aak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbXB1Aak
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:30:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59484 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007AbXB1Aaj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:30:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S0UEhB024231
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 16:30:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S0UDPH001441;
	Tue, 27 Feb 2007 16:30:14 -0800
In-Reply-To: <Pine.LNX.4.63.0702280059050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.446 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40861>



On Wed, 28 Feb 2007, Johannes Schindelin wrote:
> 
> 	$ git show v1.5.0..v1.5.0.1
> 
> is _identical_ to
> 
> 	$ git show v1.5.0 v1.5.0.1

No, it's not.

Try it.

For one thing, the ".." format makes no sense with something that 
doesn't actually walk the range (it _does_ make sense for "diff", because 
while it doesn't "walk the range", it does show the _result_ of walking 
that the range - "diff" really is special, since by definition it's about 
end-poits).

For another, "git show" actually uses "cmd_log_walk()" for showing 
commits, which in turn uses get_revision(), which in turn will _ignore_ 
any commit that you've marked uninteresting.

So it will *not* show the commit that is v1.5.0.

So I agree with Ted: "git show" as it is now is not logical with commit 
ranges. I sent out a patch that I think at least makes it sensible, 
although I'm not claiming that it's necessarily the only way to handle it.

		Linus
