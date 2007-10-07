From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-push [--all] and tags
Date: Sat, 6 Oct 2007 18:26:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710061814310.23684@woody.linux-foundation.org>
References: <20071006160506.GA28238@lapse.madduck.net>
 <47083035.7070904@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:53:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeKvN-0000jc-Ti
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 03:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbXJGB1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 21:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbXJGB1H
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 21:27:07 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57714 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752223AbXJGB1G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2007 21:27:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l971QkVE030022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 6 Oct 2007 18:26:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l971Qj7a018128;
	Sat, 6 Oct 2007 18:26:46 -0700
In-Reply-To: <47083035.7070904@vilain.net>
X-Spam-Status: No, hits=-2.74 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60165>



On Sun, 7 Oct 2007, Sam Vilain wrote:
>
> Think is, pushing tags is considered to be something that needs to be
> done very explicitly; the convention, after all, is that published tags
> are forever.  Whereas branches change all the time.  So, pushing tags
> should require an extra flag.

Well, I agrewe with Martin, and I think you missed his point.

Sure, pushing tags should require you to say so explicitly, but right now 
you cannot (for example) push *both* the common branches *and* tags 
easily.

You can do

	git push

to push common branches, and you can do

	git push --tags

to push tags, but there's no way to say "push both the common branches 
_and_ all tags".

(And the same is true of "--all" and "--tags").

So I do think Martin is right. I think we should:

 - make sure that "--all --tags" DTRT, namely send all branches and all 
   tags. Right now they are actually very similar things (one works on 
   "refs/heads", while the other works on "refs/tags"), but they are 
   implemented using *totally* different logic, and they don't work 
   together.

 - I think it would be a good idea to implement a "--shared" flag, which 
   is the current default behavior when there are no command line flags, 
   and there are no listed branches to push in the config file. That would 
   allow doing "git push --shared --tags" to update shared branches _and_ 
   tags, but it would probably *also* make it easier to explain the 
   default behaviour of "git push", by making the behavior more explicit.

   (IOW, you can introduce the notion of "--shared updates all branches 
   that exists both locally and remotely under the same names" separately 
   early on as a command line option, and then later just explain that if 
   there is nothing else telling git what to push, it will default to 
   that shared branch behavior)

Hmm? I do agree with "git push" as it now stands has a lot of warts, 
although I don't really agree with the people who want to change the 
default behavior.

			Linus
