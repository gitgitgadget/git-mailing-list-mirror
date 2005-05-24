From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 18:03:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org> <7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org> <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
 <87bcada447378d0173a3c5f165c70b38.ANY@taniwha.stupidest.org>
 <7vhdgt1ncz.fsf@assigned-by-dhcp.cox.net> <046ec1d00820537103092ed264f81f65.IBX@taniwha.stupidest.org>
 <7v64x91mfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Wedgwood <cw@f00f.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:17:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaO2U-0004O0-VE
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVEXBRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVEXBDF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:03:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:56986 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261309AbVEXBBN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 21:01:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O115jA003508
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 18:01:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O114BF031162;
	Mon, 23 May 2005 18:01:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64x91mfb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Junio C Hamano wrote:
> 
> Embedded spaces in path is _always_ safe.

For raw-diff yes, but since you'd normally end up using that name in the 
diff, it won't be safe any more. 

Imagine a name like "this is a file", and think about how the diff ends up 
looking:

	diff --git a/this is a file b/this is a file

and realize that that can't be parsed sanely by anybody who uses the diff.

And here '-z' doesn't help us, because we're basically screwed by the diff 
format (not our own decision).

So CVS uses "Index: " to help this somewhat, and we can get it right for
renames and copies (because we then output the name in a way that is at
least space and tab-safe, if not newline-safe). But basically, anything
that uses patches as a medium for passing information around should
_really_ avoid using spaces or tabs in filenames, and that's quite
independent of git ;/

		Linus
