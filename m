From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to check repository/working tree status from a script
Date: Tue, 19 May 2009 09:18:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905190915050.3301@localhost.localdomain>
References: <20090519143537.GA23505@torres.zugschlus.de> <alpine.LSU.2.00.0905191630120.23478@hermes-2.csi.cam.ac.uk> <20090519160031.GB23505@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Tue May 19 18:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6S1j-0007GF-EN
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 18:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060AbZESQSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 12:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZESQSl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 12:18:41 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54743 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752781AbZESQSk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 12:18:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JGID6p017037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 May 2009 09:18:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JGICMg004042;
	Tue, 19 May 2009 09:18:12 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090519160031.GB23505@torres.zugschlus.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119544>



On Tue, 19 May 2009, Marc Haber wrote:
> 
> On Tue, May 19, 2009 at 04:34:47PM +0100, Tony Finch wrote:
> > On Tue, 19 May 2009, Marc Haber wrote:
> > > I would like to check in a script whether there (a) are uncommitted
> > > changes (as in "working tree differs from local repository")
> > 
> > # check working tree is not different from the index
> > git diff --quiet
> > # check that the index is not different from the head
> > git diff --quiet --cached
> 
> $ git diff --quiet; echo $?
> 0
> $ git diff --quiet --cached; echo $?
> 0
> $ touch keks
> $ git diff --quiet; echo $?
> 0
> $ git diff --quiet --cached; echo $?
> 0
> $
> 
> Am I missing something?

If "keks" is already something you know about, then 'touch' wouldn't have 
changed it, so diff won't show it.

And if what you want to know about is whether there are _new_ files you 
might want to check, then you need a third check: 'git ls-files'. You 
won't see it in the error code, but you can do

	others=$(git ls-files -o --exclude-standard)

and then check it 'others' is empty or not.

			Linus
