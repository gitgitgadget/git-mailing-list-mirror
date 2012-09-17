From: Mischa POSLAWSKY <git@shiar.nl>
Subject: Re: [PATCH] git-jump: ignore (custom) prefix in diff mode
Date: Mon, 17 Sep 2012 05:01:43 +0200
Message-ID: <20120917030143.GA19986@pearl.mediadesign.nl>
References: <1347844915-4130-1-git-send-email-git@shiar.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 05:08:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDRhL-0000ko-VU
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 05:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab2IQDI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2012 23:08:27 -0400
Received: from pearl.mediadesign.nl ([195.177.242.41]:39971 "HELO
	pearl.mediadesign.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752403Ab2IQDI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 23:08:26 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2012 23:08:25 EDT
Received: (qmail 22699 invoked by uid 1007); 17 Sep 2012 05:01:43 +0200
Content-Disposition: inline
In-Reply-To: <1347844915-4130-1-git-send-email-git@shiar.nl>
User-Agent: Mutt 1.5.20 + Vim 7.2 (Debian 6.0.5 GNU/Linux 2.6.32.59)
X-URL: http://shiar.nl/
X-Accept-Language: nl, eo, en
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205639>

> diff --git contrib/git-jump/git-jump contrib/git-jump/git-jump
> index a33674e..dc90cd6 100755
> --- contrib/git-jump/git-jump
> +++ contrib/git-jump/git-jump

Apparently diff.noprefix also applies to git format-patch.  Even though
git am does explicitly support -p0, I would argue against diff options
creating non-standard patches.

-- >8 --
Subject: [PATCH/RFC] format-patch: force default file prefixes in diff

Override user configuration (eg. diff.noprefix) in patches intended for
external consumption to match the default prefixes expected by git-am.

Signed-off-by: Mischa POSLAWSKY <git@shiar.nl>
---
 builtin/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dff7921..91ded25 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1131,6 +1131,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.max_parents = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	rev.diffopt.a_prefix = "a/";
+	rev.diffopt.b_prefix = "b/";
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
-- 
1.7.12.166.ga54f379
