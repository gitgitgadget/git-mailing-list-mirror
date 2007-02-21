From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 13:11:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211306520.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org>
 <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
 <20070221210045.GB26525@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 22:12:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJylW-0000VD-Ky
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 22:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423118AbXBUVMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 16:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423114AbXBUVMi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 16:12:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48714 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423118AbXBUVMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 16:12:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LLBnhB005476
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 13:11:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LLBmVe026321;
	Wed, 21 Feb 2007 13:11:49 -0800
In-Reply-To: <20070221210045.GB26525@spearce.org>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40326>



On Wed, 21 Feb 2007, Shawn O. Pearce wrote:
> 
> One idea Junio and I kicked around on #git a short while ago
> was to arrange for a pipe between the current Git process
> and git-fast-import, where the pipe was used from within
> write_sha1_file() rather than creating the loose object.

The probnlem there is that most conversion scripts that use 
"write_sha1_file()" will want to *read* that file later. If 
git-fast-import hasn't generated the pack yet (because it's still waiting 
for more data), that will not work at all.

So then you basically force the conversion script to keep remembering all 
the old object data (using something like pretend_sha1_file), or you limit 
it to things that just always re-write the whole object and never need any 
old object references that they might have written.

A lot of conversions tend to be incremental, ie they will depend on the 
data they converted previously.

			Linus
