From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 15:50:08 -0700
Message-ID: <7vabeqi2n3.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
 <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
 <20080902210524.GB7757@leksak.fem-net>
 <0578A0F2-F90A-4555-9B34-726F26A1CDBB@ai.rug.nl> <g9kdn4$rgs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaeiZ-0005qR-H9
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYIBWuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbYIBWuR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:50:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439AbYIBWuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:50:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 668A65B74B;
	Tue,  2 Sep 2008 18:50:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 976555B747; Tue,  2 Sep 2008 18:50:10 -0400 (EDT)
In-Reply-To: <g9kdn4$rgs$1@ger.gmane.org> (Jakub Narebski's message of "Wed,
 03 Sep 2008 00:11:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 80F041FE-7941-11DD-B2DB-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94732>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps instead of poposed patch we should simply put empty lines
> to emphasize that we are on no branch:
>
>         # Please enter the commit message for your changes. Lines starting
>         # with '#' will be ignored, and an empty message aborts the commit.
>         #
>         # Not currently on any branch.
>         #
>         # Untracked files:
>         #   (use "git add <file>..." to include in what will be committed)

That sounds sensible, easy and safe enough.


 wt-status.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git i/wt-status.c w/wt-status.c
index 889e50f..97076e8 100644
--- i/wt-status.c
+++ w/wt-status.c
@@ -342,17 +342,17 @@ void wt_status_print(struct wt_status *s)
 
 	s->is_initial = get_sha1(s->reference, sha1) ? 1 : 0;
 	if (s->branch) {
-		const char *on_what = "On branch ";
-		const char *branch_name = s->branch;
-		if (!prefixcmp(branch_name, "refs/heads/"))
-			branch_name += 11;
-		else if (!strcmp(branch_name, "HEAD")) {
-			branch_name = "";
-			branch_color = color(WT_STATUS_NOBRANCH);
-			on_what = "Not currently on any branch.";
+		if (!prefixcmp(s->branch, "refs/heads/")) {
+			color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
+			color_fprintf_ln(s->fp, branch_color,
+					 "On branch %s", s->branch + 11);
+		} else if (!strcmp(s->branch, "HEAD")) {
+			color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
+			color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
+			color_fprintf_ln(s->fp, color(WT_STATUS_NOBRANCH),
+					 "Not currently on any branch.");
+			color_fprintf_ln(s->fp, color(WT_STATUS_HEADER), "#");
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER), "# ");
-		color_fprintf_ln(s->fp, branch_color, "%s%s", on_what, branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
