From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 14:39:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071428110.8424@woody.linux-foundation.org>
References: <20070206023111.GB9222@spearce.org> <200702060928.54440.andyparkins@gmail.com>
 <Pine.LNX.4.64.0702060836180.8424@woody.linux-foundation.org>
 <20070206164441.GA4949@spearce.org> <200702070117.l171HGxr023213@laptop13.inf.utfsm.cl>
 <Pine.LNX.4.64.0702061832020.8424@woody.linux-foundation.org>
 <20070207055352.GB7138@spearce.org> <200702072218.l17MIeSD005420@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Wed Feb 07 23:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEvRr-0001mO-ME
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 23:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbXBGWj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 17:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161471AbXBGWj1
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 17:39:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:42235 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161467AbXBGWj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 17:39:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17Md3dD022578
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 14:39:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17Md2Jt029533;
	Wed, 7 Feb 2007 14:39:03 -0800
In-Reply-To: <200702072218.l17MIeSD005420@laptop13.inf.utfsm.cl>
X-Spam-Status: No, hits=-0.446 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38985>



On Wed, 7 Feb 2007, Horst H. von Brand wrote:
> 
> Say what? If I use the "raw" format with UTC offset, the offset is just
> ignored then?

The offset that git maintaines is basically always ignored by git except 
for pure printout purposes.

For example, when you traverse commits, git normally picks the next 
reachable commit to show by using the date. The UTC offset has no effect 
on anything.

In fact, when we parse a commit, we don't even *parse* the timezone info. 
Look in commit.c: parse_commit_date. The timezone really doesn't even 
exist as far as any "real" git operation is concerned. It's just saved 
away, and it's _shown_ in "git log", but it has no real meaning apart from 
that.

So git very much only works on UTC time internally, and the only thing 
that actually matters in a string like "1234567890 -0700" is the first 
part. The "-0700" is _literally_ just a comment that is only ever even 
parsed by "pretty_print_commit()".

Btw, CVS doesn't have any TZ info at all, so CVS also internally always 
saves in UTC. It then tends to print out logs in whatever timezone you 
happen to be in at the time of printout, afaik. 

		Linus
