From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 10:02:50 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801170958550.14959@woody.linux-foundation.org>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com> <20080117151725.GC2816@coredump.intra.peff.net> <alpine.LFD.1.00.0801170849070.14959@woody.linux-foundation.org>
 <alpine.LSU.1.00.0801171748520.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Mike <fromlists@talkingspider.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 19:04:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZ6O-0004jQ-7z
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 19:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYAQSED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 13:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYAQSEC
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 13:04:02 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36858 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751667AbYAQSEA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 13:04:00 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HI2pbo018186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 10:02:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HI2oxI005098;
	Thu, 17 Jan 2008 10:02:50 -0800
In-Reply-To: <alpine.LSU.1.00.0801171748520.5731@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70886>



On Thu, 17 Jan 2008, Johannes Schindelin wrote:
>
> > Ok, here's the ugliest idea *ever*:
> 
> Okay, you won.

"I would like to thank the Academy for giving me this honor. I couldn't 
 have done this without my parents, my teachers in high school, and the 
 girl next-door.."

> > +		attr_len = getxattr(".", "user.git-dir", git_dir, sizeof(git_dir)-1);
> > +		if (attr_len > 0) {
> > +			git_dir[attr_len] = 0;
> > +			if (is_git_directory(git_dir)) {
> > +				setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
> > +				break;
> 
> What's this break all about?

Without the break, it will consider it a failure, and try to go up the 
directory structure ("..") to find the next thing.

In other words, that "break" is exactly the same break as the one just a 
few lines earlier:

                if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
                        break;

ie if we found a good git directory, we want to use it.

		Linus
