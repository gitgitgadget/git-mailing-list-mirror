From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 10:05:50 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806241001140.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <7vzlpbeksn.fsf@gitster.siamese.dyndns.org> <20080624082447.GB24357@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBC0y-0000yD-78
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbYFXRIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756150AbYFXRIK
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:08:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51732 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591AbYFXRII (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 13:08:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OH5p1a017970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jun 2008 10:05:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5OH5obL029178;
	Tue, 24 Jun 2008 10:05:50 -0700
In-Reply-To: <20080624082447.GB24357@artemis.madism.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.851 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86087>



On Tue, 24 Jun 2008, Pierre Habouzit wrote:
> 
>   Actually this doesn't work because it may point into the strbuf that
> will be invalidated later. Our sole option here is to leak some memory I
> fear.

I think leaking memory is ok (it's obviously going to be bounded by the 
size of the arguments you pass into a program), but I also think you can 
just change the option strings in place.

Yeah, I know - it's impolite, and we even marked things "const char", but 
"const" in C is just a politeness thing, we can just choose to have a 
function with a big comment that changes the string anyway. We'll have to 
make sure that the few places that actually create argument strings by 
hand (ie not from the ones supplied by a real "execve()") not do them so 
that they need splitting (but no current ones would need to, obviously, 
since splitting the argumens isn't even supported yet).

Or, if people hate that, just leak a few malloc'ed areas. That's arguably 
the more straightforward way.

			Linus
