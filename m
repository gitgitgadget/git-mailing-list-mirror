From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 17:12:09 +0100
Message-ID: <20130407161209.GG2222@serenity.lan>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org>
 <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org>
 <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 18:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOsCf-0007vV-K3
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 18:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933989Ab3DGQMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 12:12:21 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55776 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717Ab3DGQMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 12:12:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 19ACDCDA5B0;
	Sun,  7 Apr 2013 17:12:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id suip8F8GAFQT; Sun,  7 Apr 2013 17:12:18 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 378B6CDA57C;
	Sun,  7 Apr 2013 17:12:11 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220322>

On Sun, Apr 07, 2013 at 09:21:44PM +0530, Ramkumar Ramachandra wrote:
> I suspect you're overtly worried about the fallout of such a
> disruptive change.  If so, you could've just said: "Ram, I like the
> idea.  But what breakages do you estimate we'll have to deal with?"
> instead of attacking the idea and repeatedly questioning its purpose.
> So, I'll make a rough guess based on the first iteration I intend to
> get merged:
> 
> - Not all the git submodule subcommands will work. add/ status/ init/
> deinit are easy to rewrite, but stuff like --recursive and foreach
> might be slightly problematic as I already pointed out earlier.  We'll
> have to code depending on how far you think the first iteration should
> go.  After a few iterations, we can make 'git submodule' just print
> "This command is deprecated.  Please read `man gitsubmodules`."
> 
> - All existing repositories with submodules will not be supported.  My
> plan to deal with this: Have git-core code detect commit objects
> in-tree and disable things like diff.  As soon as the user executes
> the first 'git submodule' command, remove all existing submodules,
> along with .gitmodules and re-add them as link objects.  Then print a
> message saying: "We've just migrated your submodules to the new
> format.  Please commit this."

Meaning that every repository using submodules need to have a flag day
when all of the people using it switch to the new Git version at once?

How happy do you expect users to be if they have to remember to use
different Git version to work on different repositories because some
have switched and some haven't?

>From a user's point of view, the current submodule support mostly works
very well.  Yes there are some annoyances ("you are not at the top
level") and some more advanced features require a bit too much work
(moving a submodule) but in normal usage it works very well in my
experience.

I think you need a much better argument than "it makes the
implementation more beautiful" to convince users that a flag day is
necessary.

> That's really it.  It's certainly not earth-shattering breakage;

For most users, the migration you've outlined above is exactly that.

Even looking just at commits sent to this list, I've seen users on
versions of Git from 1.7.10 to builds from next/pu in just the last
week.  Coordinating a flag day for even a slightly popular repository is
going to cause a lot of pain.
