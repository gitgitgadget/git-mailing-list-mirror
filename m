From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: preventing a push
Date: Tue, 18 Dec 2007 08:32:55 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712180819480.21557@woody.linux-foundation.org>
References: <4767BDD8.9080404@melosgmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:33:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fNj-0005cS-Dw
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbXLRQc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 11:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbXLRQc7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:32:59 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45699 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714AbXLRQc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 11:32:59 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIGWtl9023670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 08:32:56 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIGWtev011457;
	Tue, 18 Dec 2007 08:32:55 -0800
In-Reply-To: <4767BDD8.9080404@melosgmbh.de>
X-Spam-Status: No, hits=-2.713 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68775>



On Tue, 18 Dec 2007, Christoph Duelli wrote:
>
> Is there a (recommended?) way to prevent accidental pushing (or pulling) from
> one repository into another (like the level command from bk days)?

I used BK for years, never knew about any level thing. I assume that was 
some way to introduce an "ordering" between repositories, where you could 
only push/pull in a controlled manner?

There's no obvious way to do exactly that, but the hooks git has may or 
may not be ok. For example, if you want to disallow pushing into some 
repository entirely (because you _only_ expect people to pull into it), 
you should be able to just make a "pre-receive" hook that always returns 
false. See Documentation/hooks.txt.

NOTE! There is no way to figure out what the pushing repository status is, 
which is why I say there is no way to do a "level"-equivalent thing 
(assuming I guessed what "level" does from the name). However, depending 
on how you allow people to access the machine, the hook obviously can look 
at things like $USER or other environment variables (ie you could make it 
look at what machine the user connected from etc).

But nothing really ever identifies the source repository (on a "git 
level") for a push: as far as git is concerned, all repositories are 
equal, and your hooks would invariably have to use non-git knowledge to 
figure out whether some operation should be allowed or not.

		Linus
