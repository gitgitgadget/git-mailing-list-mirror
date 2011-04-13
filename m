From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] whatchanged: always show the header
Date: Wed, 13 Apr 2011 14:10:44 +0200
Message-ID: <1302696644-21809-1-git-send-email-cmn@elego.de>
References: <20110413092620.GA3649@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 14:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9yuK-0004of-3j
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 14:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab1DMMKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 08:10:47 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:43389 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754775Ab1DMMKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 08:10:46 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id CD9894612C;
	Wed, 13 Apr 2011 14:10:31 +0200 (CEST)
Received: (nullmailer pid 21874 invoked by uid 1000);
	Wed, 13 Apr 2011 12:10:44 -0000
X-Mailer: git-send-email 1.7.4.2.437.g4fc7e.dirty
In-Reply-To: <20110413092620.GA3649@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171445>

If --quiet is passed and there is no patch output, log_tree_commit
will not print the log which is certainly not wanted.

Set the always_show_header option to fix this.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

With this, "--quiet" just means the same as "-s" by telling
log_tree_commit to output it. I still haven't completely understood
what the relationship between log_tree_commit, log_tree_diff and
log_tree_diff_flush is but AFAICS sometimes one function shows the log
and sometimes the other one shows it, which I guess has to do with the
QUICK option to diff.

I'm sending this now because it's a one-liner and is probably the
correct behaviour anyway, but a more general solution would be to
convert cmd_log_init to use the option parser and catch --quiet there,
maybe even making it mean the same as -s.

 builtin/log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1ce00ba..b24ca8a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -322,6 +322,7 @@ int cmd_whatchanged(int argc, const char **argv, co=
nst char *prefix)
 	init_revisions(&rev, prefix);
 	rev.diff =3D 1;
 	rev.simplify_history =3D 0;
+	rev.always_show_header =3D 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D "HEAD";
 	cmd_log_init(argc, argv, prefix, &rev, &opt);
--=20
1.7.4.2.437.g4fc7e.dirty
