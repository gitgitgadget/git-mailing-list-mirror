From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] Add a --cover-letter option to format-patch
Date: Tue, 19 Feb 2008 20:36:41 -0800
Message-ID: <7vfxvodz1i.fsf@gitster.siamese.dyndns.org>
References: <cover.1203392527.git.barkalow@iabervon.org>
 <alpine.LNX.1.00.0802182254310.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 05:37:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRgiO-0004x1-PF
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 05:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068AbYBTEhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 23:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751889AbYBTEhL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 23:37:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbYBTEhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 23:37:10 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC80E800C;
	Tue, 19 Feb 2008 23:37:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 DDA4B8009; Tue, 19 Feb 2008 23:36:59 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74501>

Daniel Barkalow <barkalow@iabervon.org> writes:

> +	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
> ...
> diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
> new file mode 100644
> index 0000000..311e207
> --- /dev/null
> +++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
> @@ -0,0 +1,101 @@
> +$ git format-patch --stdout --cover-letter -n initial..master^
> +From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
> +From: C O Mitter <committer@example.com>
> +Date: Mon, 26 Jun 2006 00:05:00 +0000
> +Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
> +
> +
> +*** BLURB HERE ***
> +
> +A U Thor (2):
> +      Second
> +      Third

I still disagree with your earlier point on the extra blank line
here.

When we give commit log template, we do leave an extra blank line
before we start the template material "# Please enter ...", to
ease typing, but it is different.  The template material does
not have to be removed by the end-user, so giving a blank line
upfront and starting the editor at that line is a usability
improvement, compared to the case where there is none.

But this "*** BLURB HERE ***" needs to be removed when the user
edits the cover-letter, and I really do not see any reason to
have an extra blank line in front of it.

Incidentally, I strongly suspect that if you do not have that
extra blank line, we would not even need to have the [PATCH 4/5]
(which is a slight regression) in the series.

So how about this squashed in, with [PATCH 4/5] skipped?


 builtin-log.c                                      |    2 +-
 ...tch_--stdout_--cover-letter_-n_initial..master^ |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index e26c986..0b348eb 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -629,7 +629,7 @@ static void make_cover_letter(struct rev_info *rev,
 	const char *origin_sha1, *head_sha1;
 	const char *argv[7];
 	const char *subject_start = NULL;
-	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
+	const char *body = "*** SUBJECT HERE ***\n\n*** BLURB HERE ***\n";
 	const char *msg;
 	const char *extra_headers = rev->extra_headers;
 	struct strbuf sb;
diff --git a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
index 311e207..0151453 100644
--- a/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
+++ b/t/t4013/diff.format-patch_--stdout_--cover-letter_-n_initial..master^
@@ -4,7 +4,6 @@ From: C O Mitter <committer@example.com>
 Date: Mon, 26 Jun 2006 00:05:00 +0000
 Subject: [DIFFERENT_PREFIX 0/2] *** SUBJECT HERE ***
 
-
 *** BLURB HERE ***
 
 A U Thor (2):
