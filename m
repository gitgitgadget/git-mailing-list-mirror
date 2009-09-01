From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2] status: list unmerged files last
Date: Tue, 1 Sep 2009 23:25:45 +0200
Message-ID: <200909012325.45739.j6t@kdbg.org>
References: <20090901145213.GB4194@debian.b2j> <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 23:25:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiarV-0006G7-TW
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 23:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbZIAVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755169AbZIAVZs
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 17:25:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56679 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbZIAVZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 17:25:48 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0D5BECDF8B;
	Tue,  1 Sep 2009 23:25:46 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D51AD435AE;
	Tue,  1 Sep 2009 23:25:45 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127559>

The list of unmerged files is considered rather important because after
a conflicted merge they need attention. Since the output of git status does
not go through the pager, the end of the output remains immediately visible
in the terminal window. By placing unmerge entries at the end of the list,
the user can see them immediately.

Moreover, keeping the unmerge entries at the top is inconvenient if a merge
touched many files, but only a few conflicted: After the conflicts were
resolved, the user will conduct a 'git add' command. In order to do that
with copy-and-paste, the user must scroll the terminal window up, and must
do so for each individual entry (because terminal windows commonly scroll
down automatically on the paste operation to make the cursor visible).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
On Dienstag, 1. September 2009, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > Moreover, keeping the unmerge entries at the top is inconvenient if a
> > merge touched many files, but only a few conflicted: After the conflicts
> > were resolved, the user will conduct a 'git add' command. In order to do
> > that with copy-and-paste, the user must scroll the terminal window up,
> > and must do so for each individual entry (because terminal windows
> > commonly scroll down automatically on the paste operation to make the
> > cursor visible).
>
> I actually was expecting that you would move this at the very bottom after
> untracked list for the above reason, and also because this part is only
> shown while running status (that was a good point you made in the previous
> message) and never in commit.

So you would not mind a more "drastic" change?

This version 2 can be regarded as a real improvement with the argument
above, whereas version 1 would only correct something of some
sort of regression, compared to v1.6.4.

(Originally I didn't dare to change too much and thought keeping staged
files together would make sense.)

-- Hannes

 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 3395456..60d8425 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -561,7 +561,6 @@ void wt_status_print(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
 	}
 
-	wt_status_print_unmerged(s);
 	wt_status_print_updated(s);
 	wt_status_print_changed(s);
 	if (s->submodule_summary)
@@ -570,6 +569,7 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_untracked(s);
 	else if (s->commitable)
 		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked 
files)\n");
+	wt_status_print_unmerged(s);
 
 	if (s->verbose)
 		wt_status_print_verbose(s);
-- 
1.6.4.2.280.gb16ab
