From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 14:21:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703101414380.10330@woody.linux-foundation.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org>
 <82B0999F-73E8-494E-8D66-FEEEDA25FB91@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 23:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ9wm-0001uE-AW
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 23:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbXCJWVg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 17:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbXCJWVg
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 17:21:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57658 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932166AbXCJWVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 17:21:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2AMLSo4027227
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Mar 2007 14:21:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2AMLR6m031683;
	Sat, 10 Mar 2007 14:21:28 -0800
In-Reply-To: <82B0999F-73E8-494E-8D66-FEEEDA25FB91@adacore.com>
X-Spam-Status: No, hits=-0.489 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41885>



On Sat, 10 Mar 2007, Geert Bosch wrote:
> 
> Larger packs might still be sent over the network, but they
> wouldn't have an index and could be constructed on the fly,
> without ever writing any multi-gigabyte files to disk.

I have to say, I think that's a good idea. Rather than supporting a 64-bit 
index, not generating big pack-files in general is probably a great idea.

For the streaming formats, we'd obviously generate arbitrarily large 
pack-files, but as you say, they never have an index at all, and the 
receiver always re-writes them *anyway* (ie we now always run 
"git-index-pack --fix-thin" on them), so we could just modify that 
"--fix-thin" logic to also split the pack when it reaches some arbitrary 
limit).

Some similar logic in git-pack-objects would mean that we'd never generate 
bigger packs in the first place..

It's not that 64-bit index file support is "wrong", but it does seem like 
it's not really necessary.

		Linus
