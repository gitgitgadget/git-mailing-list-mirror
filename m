From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch
 directly
Date: Wed, 1 Mar 2006 08:24:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de>
 <20060227184641.GA21684@hand.yhbt.net> <20060227185557.GA32142@delft.aura.cs.cmu.edu>
 <20060227192422.GB9518@hand.yhbt.net> <46a038f90602271625y6c7e9072u372b8dd3662e272c@mail.gmail.com>
 <Pine.LNX.4.64.0602271634410.22647@g5.osdl.org> <20060301065138.GC21684@hand.yhbt.net>
 <44056BF1.6000109@op5.se> <Pine.LNX.4.64.0603010745320.22647@g5.osdl.org>
 <4405C6BE.2000706@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 17:26:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEU8Z-0002GE-Ep
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 17:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCAQZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 11:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWCAQZK
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 11:25:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbWCAQZI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 11:25:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21GP2DZ011421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 08:25:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21GOvio005754;
	Wed, 1 Mar 2006 08:24:59 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4405C6BE.2000706@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16987>



On Wed, 1 Mar 2006, Andreas Ericsson wrote:
> 
> Personally I'm all for namespace separation. I'm assuming the script has the
> tracker-branch hardcoded anyway, so I don't really understand why it would be
> necessary to keep other refs in a separate directory and, if it *is*
> necessary, why that subdirectory can't be .git/refs/heads/svn.
> 
> Eric mentioned earlier that the tracking-branch can't be committed to (ever),
> so the user convenience for searching other directories should be nearly
> non-existant.

The thing about it being .git/refs/heads/svn/xyzzy is that then you can do

	git checkout svn/xyzzy

and start modifying it. Which is exactly against the point: the thing is 
_not_ a branch and you must _not_ commit to it.

It's much more like a tag: it's a pointer to the last point of an 
svn-import.

So I think it should either _be_ a tag (although Dscho worries about some 
broken porcelain being confused by tags changing) or it should be in a 
namespace all it's own. Not under .git/refs/heads/ at any point, because 
it is _not_ a head of development.

		Linus
