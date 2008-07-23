From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 11:12:11 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807231107450.4754@woody.linux-foundation.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann> <20080723140441.GA9537@elte.hu> <alpine.LFD.1.10.0807231100310.4754@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:13:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLiqC-0005wv-Gu
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbYGWSMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYGWSMb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:12:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50217 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753351AbYGWSMa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 14:12:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NICBLP026522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2008 11:12:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NICBQb004649;
	Wed, 23 Jul 2008 11:12:11 -0700
In-Reply-To: <alpine.LFD.1.10.0807231100310.4754@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.399 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89728>



On Wed, 23 Jul 2008, Linus Torvalds wrote:
> 
> But I'll look if there's a way to cut it down from 9s. I suspect it has to 
> traverse the whole history to make 100% sure that something isn't merged, 
> but even that should be faster than 9s.

Heh. It should be trivially doable _much_ faster, but the has_commit() 
logic really relies on re-doing the "in_merge_base()" thing over and over 
again (clearing the bits), instead of just populating the object list with 
a "already seen" bit and lettign that expand over time.

So using "git branch --no-merged" does avoid re-parsing the commits over 
and over again (which is a pretty big win), but the way the code is 
written it does end up traversing the commit list fully for every single 
branch. That's quite horrible.

Lars added to Cc list in the hope that he'll be embarrassed enough about 
the performance to try to fix it ;)

		Linus
