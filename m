From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Mon, 23 Jul 2007 15:31:46 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707231527050.3607@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
 <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org>
 <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
 <20070719105105.GA4929@moonlight.home> <86zm1sbpeh.fsf@lola.quinscape.zz>
 <20070719123214.GB4929@moonlight.home> <863azka7d4.fsf@lola.quinscape.zz>
 <87ps2inab5.fsf@hades.wkstn.nix> <85y7h6dewp.fsf@lola.goethe.zz>
 <87lkd6n62i.fsf@hades.wkstn.nix> <85k5sqdavo.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Nix <nix@esperi.org.uk>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6SG-0007F5-0f
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177AbXGWWch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756072AbXGWWch
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:32:37 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33337 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755957AbXGWWcg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 18:32:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NMVqHq026477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 15:31:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NMVlnM015417;
	Mon, 23 Jul 2007 15:31:47 -0700
In-Reply-To: <85k5sqdavo.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-3.221 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53494>



On Tue, 24 Jul 2007, David Kastrup wrote:

> Nix <nix@esperi.org.uk> writes:
> 
> > It's true that git won't natively have any knowledge of that data,
> > but Linus has fairly effectively shown that it shouldn't have any
> > such knowledge and doesn't need it.
> 
> Last time I looked, git tracked the executable bit.

Actually, originally it tracked the whole mode word.

It was a total disaster. People who had different umasks etc got mode 
clashes all the time, and you ended up having silly and unnecessary 
conflicts.

The same would be true (to an even higher degree) if we tracked owner and 
group information etc.

So practically speaking, you want to track the *minimal* possible state, 
not the maximal one. 

This is one of those "in theory" vs "in practice" things. In *theory*, it 
would be nice for an SCM to track everything that is known about a file. 
In *practice*, that sucks.

So this does mean that if you want to explicitly track certain things 
(ownership and more complete file permissions, or ACL's, or "resource 
forks", or any number of other things that a file *could* have on various 
systems), you end up havign to track them in something else than git, or 
you end up having to track them as a separate "metadata file".

One such metadata file is, for example, the ".gitattributes" file. It 
*could* be used to contain things like path-based rules for ownership, 
not just things like whether to check out with CRLF etc.

			Linus
