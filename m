From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Sat, 14 Nov 2015 14:35:01 +0100
Message-ID: <20151114133501.GI16219@inner.h.apk.li>
References: <20150316142026.GJ7847@inner.h.apk.li> <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com> <20150316184040.GA8902@inner.h.apk.li> <20150317024005.GA26313@peff.net> <xmqqd248p4o9.fsf@gitster.dls.corp.google.com> <20150317054759.GA16860@peff.net> <20151113152915.GC16219@inner.h.apk.li> <20151114000118.GB18260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Nov 14 14:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxazQ-0005mp-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 14:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbbKNNfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2015 08:35:18 -0500
Received: from continuum.iocl.org ([217.140.74.2]:39603 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbKNNfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2015 08:35:17 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tAEDZ1L09535;
	Sat, 14 Nov 2015 14:35:01 +0100
Content-Disposition: inline
In-Reply-To: <20151114000118.GB18260@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281306>

On Fri, 13 Nov 2015 19:01:18 +0000, Jeff King wrote:
...
>   2. But for a little more work, pushing the is_git_directory() check
>      out to the call-sites gives us probably saner semantics overall.

Oops, now I get it[1]: You mean replacing resolve_gitlink_ref usages
with is_git_directory, like:

diff --git a/dir.c b/dir.c
index d2a8f06..7765dc6 100644
--- a/dir.c
+++ b/dir.c
@@ -1375,8 +1375,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
 			break;
 		if (!(dir->flags & DIR_NO_GITLINKS)) {
-			unsigned char sha1[20];
-			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
+			if (is_git_directory(dirname))
 				return path_untracked;
 		}
 		return path_recurse;

That, I like. If it is correct.

Andreas

[1] After reading the introduction of is_git_directory, 0179ca7a62.

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
