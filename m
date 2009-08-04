From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: Mon, 3 Aug 2009 23:30:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908032326440.3270@localhost.localdomain>
References: <20090804044842.6792.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 08:31:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYDYF-0003h8-Cp
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 08:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbZHDGbD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 02:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbZHDGbD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 02:31:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41885 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932427AbZHDGbC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 02:31:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n746UQiT020545
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 23:30:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n746UP2M014671;
	Mon, 3 Aug 2009 23:30:26 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090804044842.6792.qmail@science.horizon.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.467 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124756>



On Mon, 4 Aug 2009, George Spelvin wrote:
> 
> The actual goal of this effort is to address the dynamic linker startup
> time issues by removing the second-largest contributor after libcurl,
> namely openssl.  Optimizing the assembly code is just the fun part. ;-)

Now, I agree that it would be wonderful to get rid of the linker startup, 
but the startup costs of openssl are very low compared to the equivalent 
curl ones. So we can't lose _too_ much performance - especially for 
long-running jobs where startup costs really don't even matter - in the 
quest to get rid of those.

That said, your numbers are impressive. Improving fsck by 1.1-2.2% is very 
good. That means that you not only avodied the startup costs, you actually 
improved on the openssl code. So it's a win-win situation.

That said, it would be even better if the SHA1 code was also somewhat 
portable to other environments (it looks like your current patch is very 
GNU as specific), and if you had a solution for x86-64 too ;)

Yeah, I'm a whiny little b*tch, aren't I?

		Linus
