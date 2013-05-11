From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sat, 11 May 2013 18:57:02 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1305111846160.8213@s15462909.onlinehome-server.info>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk> <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com> <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 12 01:57:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbJfJ-0003US-9t
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 01:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598Ab3EKX5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 19:57:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:54687 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab3EKX5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 19:57:07 -0400
Received: from mailout-de.gmx.net ([10.1.76.34]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MKfbV-1UZwcJ2glD-0021Ue for
 <git@vger.kernel.org>; Sun, 12 May 2013 01:57:04 +0200
Received: (qmail invoked by alias); 11 May 2013 23:57:04 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp034) with SMTP; 12 May 2013 01:57:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F0epV75xFEVb6SHiSscTvqCl0OQfrUjbSwQOKmy
	bzbmAMGWM3tSXh
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224021>

Hi John & Linus,

On Sat, 11 May 2013, Linus Torvalds wrote:

> [...] I really think caching patch ID's should be something people
> should be aware of is fundamentally wrong, even if it might work.

Given the incredible performance win, I would say it is still worth
looking into.

If you store also a hash of Git version and diff options (may even be the
hash of the raw bytes of the diff options if you do not plan to share the
ref between machines) with the patch ID, you can make it safe.

That hash would be generated at patch_id init time and
load_cached_patch_id() would check this hash in addition to the return
value of get_sha1() (and ignore the note if the version/diff options
differ).

If you are following git.git slavishly, maybe hashing just the major/minor
Git version would be in order to avoid frequent regeneration of identical
patch IDs.

> And quite frankly, if you do rebases etc so much that you think patch
> ID's are so important that they need to be cached, you may be doing
> odd/wrong things.

AFAICT John actually gave a very valid scenario that validates his use
case: git-gui patches are best tested in the git.git scenario but have to
be contributed via git-gui.git. It's not John's fault that this typically
requires a lot of rebasing between vastly divergent histories.

John, do you think you can incorporate that "finger-print" of the patch ID
generation and store it in the same note?

Ciao,
Johannes
