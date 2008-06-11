From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: To graft or not to graft... (Re: Recovering from repository
 corruption)
Date: Wed, 11 Jun 2008 16:39:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806111635200.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <m3abhtp42o.fsf@localhost.localdomain> <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com> <200806102159.02875.jnareb@gmail.com> <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org> <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com> <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org> <20080611232126.GA9054@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:41:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Zw1-0002XZ-V6
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbYFKXkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbYFKXkD
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:40:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40821 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753529AbYFKXkC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jun 2008 19:40:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BNdjT0024823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jun 2008 16:39:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5BNdiD4023685;
	Wed, 11 Jun 2008 16:39:44 -0700
In-Reply-To: <20080611232126.GA9054@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.371 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84686>



On Thu, 12 Jun 2008, Stephen R. van den Berg wrote:
>
> As I understood it from the few shreds of documentation that actually
> mention the grafts file, the grafts file is *not* being cloned.
> Therefore, my assumption was that cloning a repository that has a grafts
> file gives an identical result to cloning the same repository *without*
> the grafts file present.

That would probably be the right behaviour, but no - all our commit 
walkers honor the grafts file.

Including the ones used for creating pack-files and thus a clone.

> As I understand it now, the cloning process actually peeks at the grafts
> file while cloning, and then doesn't copy it.  This results in a rather
> confusingly corrupt clone.

Yes. The grafts-file was a mistake, but it's just barely useful to some 
people that it's stayed alive. Sadly, those "some people" don't tend to 
care enough about the problems it can cause.

> I suggest two things:
> a. That during the cloning process, the grafts file is completely
>    disregarded in any case at first.

Yes.

And (a'): git-fsck and repacking should just consider it to be an 
_additional_ source of parenthood rather than a _replacement_ source.

> b. Preferably the grafts file is copied as well (after cloning).  I
>    never really understood why the file is not being copied in the first
>    place (anyone care to explain that?).

The grafts file isn't part of the object stream and refs, and clones (and 
fetches) very much just copy the object database.

		Linus
