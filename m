From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 11:20:46 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org> <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 20:28:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqm7-0007VB-2N
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbYFWS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbYFWS1Z
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:27:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35259 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755594AbYFWS1Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 14:27:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIPxv2025669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 11:26:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NIKkC2009724;
	Mon, 23 Jun 2008 11:20:47 -0700
In-Reply-To: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85898>



On Mon, 23 Jun 2008, Linus Torvalds wrote:
> 
> Umm. Helloo, reality.. There are actually very few options that take a 
> flag for their arguments. In particular, the option parsing we really 
> _care_ about (revision parsing - see builtin-blame.c which is exactly 
> where I wanted to convert things) very much DOES NOT.

Actually, I guess "--default" does, but if you try to mix that up with (a) 
a default head that starts with a dash and (b) git-blame, you're doing 
something pretty odd.

And yes, "-n" does too, but if you pass it negative numbers you get what 
you deserve.

The point being, we really _do_ have a real-life existing case for 
PARSE_OPT_CONTINUE_ON_UNKNOWN, which is hard to handle any other way. 
Currently you can literally do

	git blame --since=April -b Makefile

and while it's a totally made-up example, it's one I've picked to show 
exactly what does *not* work with my patch that started this whole thread.

And guess what you need to fix it?

If you guessed PARSE_OPT_CONTINUE_ON_UNKNOWN, you win a prize. 

		Linus
