From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Mon, 13 May 2013 15:59:48 +0100
Message-ID: <20130513145948.GR2299@serenity.lan>
References: <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <7v1u9cx5pf.fsf@alter.siamese.dyndns.org>
 <20130512085934.GG2299@serenity.lan>
 <7v1u9bvo1m.fsf@alter.siamese.dyndns.org>
 <20130513075906.GP2299@serenity.lan>
 <7vzjvzoujq.fsf@alter.siamese.dyndns.org>
 <20130513140243.GQ2299@serenity.lan>
 <7v38tros3y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 17:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuEg-0004T4-By
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab3EMPAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:00:15 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:36790 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992Ab3EMPAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:00:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2E8DDCDA5B8;
	Mon, 13 May 2013 16:00:12 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N+1zhuWjzNQi; Mon, 13 May 2013 15:59:58 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id D66E2CDA629;
	Mon, 13 May 2013 15:59:51 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38tros3y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224164>

On Mon, May 13, 2013 at 07:46:09AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Mon, May 13, 2013 at 06:53:29AM -0700, Junio C Hamano wrote:
> >> John Keeping <john@keeping.me.uk> writes:
> >> 
> >> > The caching layer could also introduce false positives though, which is
> >> > more serious.  If you cache patch IDs with a pathspec restriction ...
> >> 
> >> What?  What business does patch-id have with pathspec-limited diff
> >> generation?  You do not rebase or cherry-pick with pathspec, so
> >> unless you are populating the patch-id cache at a wrong point (like,
> >> say whenevern "git show $commit" is run), I am not sure why pathspec
> >> limit becomes even an issue.
> >
> > revision.c::cherry_pick_list() sets the pathspec to what was specified
> > in the revision options.  It's done that since commit 36d56de (Fix
> > --cherry-pick with given paths, 2007-07-10) and t6007 tests that it
> > works.
> 
> Then the caching should be automatically turned off when pathspec is
> given.

That was my first thought, but since we can be affected by other diff
options set in the user's config as well it ended up being simpler to
include it in the options hash and use that.

This has the advantage that you get the benefit of the cache if you run
"git log --cherry-mark" with the same paths more than once.  In my
testing the cache is beneficial as soon as you examine more than one
similar range (e.g. master...feature-A and then master...feature-B).
