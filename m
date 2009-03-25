From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 17:11:40 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903241703290.3032@localhost.localdomain>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain> <49C94B02.5010604@mycircuit.org> <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain> <20090324193506.0962b28e@tupile.poochiereds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter <vmail@mycircuit.org>,
	Git Mailing List <git@vger.kernel.org>,
	Steve French <sfrench@us.ibm.com>
To: Jeff Layton <jlayton@redhat.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:16:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGn3-0008H7-LC
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755718AbZCYAOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbZCYAOn
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:14:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54433 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754039AbZCYAOm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 20:14:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2P0BeR1026859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2009 17:12:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2P0Bef4025844;
	Tue, 24 Mar 2009 17:11:40 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20090324193506.0962b28e@tupile.poochiereds.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114521>



On Tue, 24 Mar 2009, Jeff Layton wrote:
> 
> Yes. That's probably the right thing to do here. This is looks like a
> regression that I introduced some time ago in
> cea218054ad277d6c126890213afde07b4eb1602. Before that delta we always
> flushed all the data before doing any setattr. After that delta, we
> just did it on size changes. In a later commit, Steve fixed it so that
> it got done on ATTR_MTIME too.

Ahh. Yes. You do need to flush on at least ATTR_MODE and ATTR_UID/GID 
changes too.

> I wonder though whether that's sufficient. If we're changing ownership
> for instance, will we hit the same issue? Maybe the safest approach is
> just to go back to flushing on any setattr call.
> 
> Steve, thoughts?

Is there anything relevant left to be sufficient reason to make it 
conditional? Once you're doing it on MODE/SIZE/UID/GID/MTIME changes, that 
pretty much will cover all set_attr calls. 

			Linus
