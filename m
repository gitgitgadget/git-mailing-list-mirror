From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Tue, 16 Oct 2007 20:29:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710162019150.26902@woody.linux-foundation.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
 <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
 <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
 <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <B01BBB60-6231-4AF6-9A64-10374464E442@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 17 05:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhzbP-0000Hi-Py
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 05:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936358AbXJQD3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 23:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936350AbXJQD3J
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 23:29:09 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33772 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935824AbXJQD3F (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 23:29:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9H3T2Qe016542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Oct 2007 20:29:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9H3T24U031942;
	Tue, 16 Oct 2007 20:29:02 -0700
In-Reply-To: <B01BBB60-6231-4AF6-9A64-10374464E442@mit.edu>
X-Spam-Status: No, hits=-2.668 required=5 tests=AWL,BAYES_00,OSDL_NIGERIAN_GOLD
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61324>



On Tue, 16 Oct 2007, Michael Witten wrote:
> 
> On 16 Oct 2007, at 8:45:51 PM, Linus Torvalds wrote:
> 
> > And is it really so unreasonable to just say "8-character tabs are the
> > gold standard"?
> 
> It's unreasonable not to list that anywhere.

Heh.

I was sure we had a "CodingStyle", but it turns out that no, we don't, and 
yes, the 8-tab assumption is implicit in (a) the kernel rules (which git 
started out following for obvious reasons, and which *does* have 
documentation making this very explicit indeed) and (b) those few places 
where you can actually see it in the result.

So maybe it should be made explicit. You can see the effect right now by 
doing

	git grep -1 '	 ' *.c

(again, that regex is a "tab+space", although it's not obvious) and then 
looking for places where we line up things in ways that simply wouldn't 
have worked if it wasn't a 8-wide tab, ie things like

	...
	check_all_attr = xrealloc(check_all_attr,
				  sizeof(*check_all_attr) * attr_nr);
	..
	read_tree_recursive(args->tree, args->base, plen, 0,
			    args->pathspec, write_zip_entry);
	..

where the arguments wouldn't line up for anything but 8-char-wide tabs.

(But the code is certainly *readable* with other tab sizes, so it's not 
like this makes it impossible to work if somebody has a 4-space tab, it 
just means that such people can get odd effects - but they may not even 
realize that others see things line up!)

		Linus
