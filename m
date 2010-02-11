From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --continue?
Date: Thu, 11 Feb 2010 16:19:37 -0500
Message-ID: <20100211211937.GA12752@coredump.intra.peff.net>
References: <fabb9a1e1002101237i60a0b2c5j6d1e52b33dacbaa2@mail.gmail.com>
 <20100210210419.GA7728@coredump.intra.peff.net>
 <20100210212408.GB7728@coredump.intra.peff.net>
 <7v63644uoq.fsf@alter.siamese.dyndns.org>
 <7vbpfw3f6t.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1002101423y79460afdn2bc31b117195ef42@mail.gmail.com>
 <7vpr4c200i.fsf@alter.siamese.dyndns.org>
 <20100211210445.GA8819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:19:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgRp-0006mV-ML
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:19:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab0BKVTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:19:37 -0500
Received: from peff.net ([208.65.91.99]:48496 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757111Ab0BKVTg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:19:36 -0500
Received: (qmail 22129 invoked by uid 107); 11 Feb 2010 21:19:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:19:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:19:37 -0500
Content-Disposition: inline
In-Reply-To: <20100211210445.GA8819@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139629>

On Thu, Feb 11, 2010 at 04:04:45PM -0500, Jeff King wrote:

> Series to follow:
> 
>   [1/4]: cherry-pick: rewrap advice message
>   [2/4]: cherry-pick: refactor commit parsing code
>   [3/4]: cherry-pick: format help message as strbuf
>   [4/4]: cherry-pick: show commit name instead of sha1

Actually, I think the message is still a bit ugly after this, so perhaps
this 5/4 would help:

-- >8 --
Subject: [PATCH] cherry-pick: prettify the advice message

It's hard to see the "how to commit" part of this message,
which users may want to cut and paste. On top of that,
having it in paragraph form means that a really long commit
name may cause ugly wrapping. Let's make it prettier, like:

  Automatic cherry-pick failed.  After resolving the conflicts,
  mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
  and commit the result with:

          git commit -c HEAD~23

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-revert.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index ad61249..eff5268 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -208,14 +208,16 @@ static char *help_msg(const char *name)
 
 	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
 		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
-		"and commit the result.");
+		"and commit the result");
 
 	if (action == CHERRY_PICK) {
-		strbuf_addf(&helpbuf,
-			"  When committing, use the option '-c %s'\n"
-			"to retain authorship and message.",
+		strbuf_addf(&helpbuf, " with: \n"
+			"\n"
+			"        git commit -c %s\n",
 			name);
 	}
+	else
+		strbuf_addch(&helpbuf, '.');
 	return strbuf_detach(&helpbuf, NULL);
 }
 
-- 
1.7.0.rc2.32.g190cd.dirty
