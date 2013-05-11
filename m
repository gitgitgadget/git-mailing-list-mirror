From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 22:49:00 +0100
Message-ID: <20130511214900.GF2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 11 23:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbHfH-0006X3-IG
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 23:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754517Ab3EKVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 17:49:11 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:41825 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277Ab3EKVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 17:49:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 23FB3198003;
	Sat, 11 May 2013 22:49:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pfndDNUT+hp; Sat, 11 May 2013 22:49:09 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 7987D606577;
	Sat, 11 May 2013 22:49:09 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 61BB1161E07A;
	Sat, 11 May 2013 22:49:09 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qtfHPhyrTxpl; Sat, 11 May 2013 22:49:09 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 1DA73161E340;
	Sat, 11 May 2013 22:49:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224014>

On Sat, May 11, 2013 at 02:10:01PM -0700, Linus Torvalds wrote:
> On Sat, May 11, 2013 at 12:54 PM, John Keeping <john@keeping.me.uk> wrote:
> > This adds a new configuration variable "patchid.cacheRef" which controls
> > whether (and where) patch IDs will be cached in a notes tree.
> 
> Patch ID's aren't stable wrt different diff options, so I think this
> is potentially a very bad idea.

Hmm... I hadn't realised that.  Looking a bit closer, it looks like
init_patch_ids sets up its own diffopts so its not affected by the
command line (except for pathspecs which would be easy to check for).
Of course that still means it can be affected by settings in the user's
configuration.

It's a pity that this can't be done since it gives a significant
performance improvement for some tasks that I perform relatively
frequently.  Is there a reason patch IDs couldn't be generated using
fixed diff options?  Since there's no way to control it from the command
line it seems surprising that the results of "log --cherry" might be
different based on what's in your config.

That could go either way I suppose - is it useful to be able to change
patch IDs based on command line arguments or is it wrong that as we add
persistent diff settings to the configuration we've been silently
changing the behaviour of "git patch-id" and "git cherry".
