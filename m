From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Sun, 21 Sep 2008 06:42:38 -0400
Message-ID: <20080921104238.GA9217@sigill.intra.peff.net>
References: <4C04A26E-5829-4A39-AD89-F5A68E606AA3@ai.rug.nl> <1220634785-55543-1-git-send-email-pdebie@ai.rug.nl> <7vzlmkpltb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 12:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhMYB-0007ON-Qd
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 12:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbYIUKmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbYIUKml
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 06:42:41 -0400
Received: from peff.net ([208.65.91.99]:3392 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbYIUKml (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 06:42:41 -0400
Received: (qmail 29265 invoked by uid 111); 21 Sep 2008 10:42:39 -0000
Received: from c-75-75-5-148.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.5.148)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 21 Sep 2008 06:42:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Sep 2008 06:42:38 -0400
Content-Disposition: inline
In-Reply-To: <7vzlmkpltb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96389>

On Sat, Sep 06, 2008 at 10:27:44PM -0700, Junio C Hamano wrote:

> Given the recent "reminder" discussion, I suspect people without $PS1 set
> to show the current branch would like this, majority of others would be
> neutral, while some may actively hate it for cluttering the output even
> more.  But I also suspect the initial annoyance the third camp may feel
> will pass rather quickly after they get used to seeing these.

OK, I have lived with it for a little while, and I am still annoyed. ;)

My complaints are:

  1. It wastes more horizontal screen real estate, making it more likely
     that the line will wrap.

  2. In almost all of my projects (including git), I use the subject
     line convention of "subsystem: one line summary". So you end up
     with the visually confusing:

       Created commit abcd1234 on master: subsystem: one line summary

     which is even worse on a topic branch which is meaningful to the
     project:

       Created commit abcd1234 on widget: subwidget: one line summary

     which has literally left me scratching my head wondering why I put
     "widget" into the commit message.

Maybe it is better to simply break the line, which solves both problems.
Something like:

  Created commit abcd1234 on master:
   subsystem: do some stuff
   1 files changes, 1 insertions(+), 0 deletions(-)

Trivial patch is below.

---
diff --git a/builtin-commit.c b/builtin-commit.c
index 917f638..53dcde6 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -899,7 +899,7 @@ static char *get_commit_format_string(void)
 				strbuf_addch(&buf, *cp);
 		}
 	}
-	strbuf_addstr(&buf, ": %s");
+	strbuf_addstr(&buf, ":%n %s");
 
 	return strbuf_detach(&buf, NULL);
 }
