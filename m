From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Wed, 16 Jul 2008 09:22:30 +0200
Message-ID: <200807160922.30275.johan@herland.net>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>
 <alpine.DEB.1.00.0807152255020.2990@eeepc-johanness>
 <7vod4yztf5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Geoffrey Irving <irving@naml.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 09:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ1Ma-0003js-7U
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 09:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbYGPHWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 03:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbYGPHWt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 03:22:49 -0400
Received: from smtp.getmail.no ([84.208.20.33]:37207 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769AbYGPHWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 03:22:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K4300B078HO8N00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Jul 2008 09:22:37 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4300KFU8HICB60@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Jul 2008 09:22:30 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K4300J3B8HIOB9L@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Wed, 16 Jul 2008 09:22:30 +0200 (CEST)
In-reply-to: <7vod4yztf5.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88650>

On Wednesday 16 July 2008, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > Okay, it seems like I never have time to review this, so I'll just
> >
> > take a few minutes to comment on some aspects:
> >> @@ -1094,6 +1104,8 @@ int cmd_cherry(int argc, const char **argv,
> >> const char *prefix)
> >>  	const char *limit = NULL;
> >>  	int verbose = 0;
> >>
> >> +	git_config(git_cherry_config, NULL);
> >> +
> >>  	if (argc > 1 && !strcmp(argv[1], "-v")) {
> >>  		verbose = 1;
> >>  		argc--;
> >
> > Is this really purely for cherry, and not at all for "log
> > --cherry-pick"? Maybe it should be "cache.patchIds" to begin with.
>
> What other things would we want caches for?

This should be fairly obvious:

- git-notes (uses sha1-to-sha1 cache for storing commit-to-note
  relationship)

- integrated bug trackers (uses sha1-to-sha1 cache for storing
  commit-to-bugreport (or similar) relationships)

- ...any other mechanism that want to quickly map from a git object to some
  associated data

There are probably plenty more ideas and use cases if people start looking.

AFAICS, each different use case would keep its cache in a separate file.

For local-repo-only caches the cache is kept within $GIT_DIR, and for shared 
caches (IF that makes sense in any of the use cases) the cache could be 
located in the working tree (either as a .git_foo file on relevant 
branches, or as a file on a separate domain-specific branch).


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
