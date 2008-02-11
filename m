From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Add "--dirstat" for some directory statistics
Date: Mon, 11 Feb 2008 13:41:14 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802111338270.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802111230200.2920@woody.linux-foundation.org> <alpine.LSU.1.00.0802112122300.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 23:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOgo9-00010M-IT
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 23:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbYBKWGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 17:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbYBKWGu
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 17:06:50 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39452 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755243AbYBKWGt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 17:06:49 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BLqWnI030999
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Feb 2008 14:04:36 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1BLfERO001746;
	Mon, 11 Feb 2008 13:41:34 -0800
In-Reply-To: <alpine.LSU.1.00.0802112122300.3870@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.731 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73593>



On Mon, 11 Feb 2008, Johannes Schindelin wrote:
> 
> Certainly you meant 0x0040 for DIRSTAT, n'est-ce pas?

Yeah, yeah.

> Also, are you sure that you do not want to make the minimal percentage 
> configurable, maybe with --dirstat[=<min-percent>]?  I mean, sometimes 
> even 0.01% is worth showing.

Well, maybe, maybe not. But yeah, at least in whole percentages. Here is a 
simple patch to fix that cut-and-past'o and add a configurable (but still 
whole-percentage-point) thing.

		Linus

---
 diff.c |    2 +-
 diff.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index da91bdd..81948e7 100644
--- a/diff.c
+++ b/diff.c
@@ -2273,7 +2273,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (!strcmp(arg, "--dirstat"))
+	else if (opt_arg(arg, 'X', "dirstat", &options->dirstat_percent))
 		options->output_format |= DIFF_FORMAT_DIRSTAT;
 	else if (!strcmp(arg, "--check"))
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
diff --git a/diff.h b/diff.h
index 3181263..9da6601 100644
--- a/diff.h
+++ b/diff.h
@@ -30,7 +30,7 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 #define DIFF_FORMAT_SUMMARY	0x0008
 #define DIFF_FORMAT_PATCH	0x0010
 #define DIFF_FORMAT_SHORTSTAT	0x0020
-#define DIFF_FORMAT_DIRSTAT	0x0020
+#define DIFF_FORMAT_DIRSTAT	0x0040
 
 /* These override all above */
 #define DIFF_FORMAT_NAME	0x0100
