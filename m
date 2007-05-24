From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 22:57:01 +0200
Message-ID: <20070524205701.GQ4489@pasky.or.cz>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <7viraixeme.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	skimo@liacs.nl, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 22:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKN9-0007HH-Ao
	for gcvg-git@gmane.org; Thu, 24 May 2007 22:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbXEXU5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbXEXU5G
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:57:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52570 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbXEXU5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:57:05 -0400
Received: (qmail 1988 invoked by uid 2001); 24 May 2007 22:57:01 +0200
Content-Disposition: inline
In-Reply-To: <7viraixeme.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48306>

On Thu, May 24, 2007 at 08:26:01PM CEST, Junio C Hamano wrote:
> How about doing something like this, instead?

These discussions are spread over so many posts (and especially threads)
that it's far beyond me to track it all - I hope I won't repeat
something already debunked.

>  (1) superproject .gitmodules (in-tree) and .git/config (local
>      repository) use the three-level naming in $gmane/47567.
>      Namely, (1a) .gitmodules says which subdirectory has a
>      checkout of what project, and names the project in
>      logical/abstract terms, not with a URL (e.g. "kernel26");
>      (1b) .gitmodules also associates a set of suggested URLs
>      for each of the logical/abstract project name; (1c)
>      .git/config records which project are of interest.

How do you deal with clashes in subproject names? Until now, several
independent projects might live happily in a single repository, this
breaks that. When merging disparate projects, you can resolve name
clashes in .gitmodules, but going back to one of the merged trunks just
won't work. It's ugly.

Now, we can just declare that we don't care about this case. This stance
wouldn't make me comfortable at all, but at least we should make it
clear that we know about this problem and the users are on their own
when it happens.

>  (2) In superproject .git/, we would have a bare repository for
>      each project used by the superproject.
> 
> 	.git/subproject/kernel26/{objects,refs,...}
> 
>      This is created by making a bare clone from the upstream
>      URL, decided by the user with the help from suggested URL
>      described in the superproject .gitmodules.
> 
>      The idea is to use this repository as a long-term
>      subproject state across branch switching.

When not using subproject aliases, you could just name this after some
normalized form of the URL (anything suitable up to an sha1sum of the
URL :).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
