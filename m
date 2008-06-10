From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 14:09:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>  <m3abhtp42o.fsf@localhost.localdomain>  <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com>  <200806102159.02875.jnareb@gmail.com>  <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
  <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org> <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Denis Bueno <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6B72-0004Qp-Gn
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 23:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYFJVJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754341AbYFJVJq
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 17:09:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43371 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754019AbYFJVJp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 17:09:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AL9hBi012812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 14:09:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5AL9gOe029454;
	Tue, 10 Jun 2008 14:09:43 -0700
In-Reply-To: <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.382 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84547>



On Tue, 10 Jun 2008, Denis Bueno wrote:
> >
> > Hmm. Scary. That should *not* have been successful with a corrupt repo.
> >
> > Unless you have done a .grafts file to hide the corruption, or something
> > like that?
> 
> I intended to do that, yes, and I think I was successful.

Ahh, ok. Yes, we should probably re-think our 'grafts' file thing, or at 
least not document it, because it's actually a wondeful way to just cause 
more corruption by hiding things (ie if you clone a repo with a grafts 
file, the result will now have neither the grafts file _nor_ the state 
that was hidden by it, so the result is guaranteed to be corrupt).

But that explains why your clone worked, and why the resulting repo had 
different corruption - it avoided the original corruption, but because of 
the grafts file it avoided it by just not having those commits at all..

> I do have bunches of personal information in the repo, unfortunately.
> The particular *file* involved in the corruption, however, is fine for
> all to view.  Is that useful?

No, almost all the interest is basically in how the whole repo ties 
together. The individual corrupt files may be interesting, though, ie from 
your original report:

    error: 320bd6e82267b71dd2ca7043ea3f61dbbca16109: object corrupt or missing
    error: 4d0be2816d5eea5ae2b40990235e2225c1715927: object corrupt or missing

then *if* you have the files

	.git/objects/32/0bd6e82267b71dd2ca7043ea3f61dbbca16109
	.git/objects/4d/0be2816d5eea5ae2b40990235e2225c1715927

then those two files are interesting in themselves (most likely they are 
not there at all, or are zero-sized, but if you have them, please post 
them).

And as this was a result of a real filesystem crash, it *is* possible that 
you have something in the /lost+found directory for that filesystem. If 
so, those missing files may be found there.

		Linus
