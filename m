From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 10/11] remote show: allow --prune=<pattern> options
Date: Wed,  4 Dec 2013 06:44:49 +0100
Message-ID: <1386135890-13954-11-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5HS-0003XK-II
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab3LDFpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:45:40 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63513 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751414Ab3LDFpf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:45:35 -0500
X-AuditID: 12074413-b7fc76d000002aba-bf-529ec17e835a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BB.44.10938.E71CE925; Wed,  4 Dec 2013 00:45:34 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAF016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:33 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqFt3cF6Qwdk5hhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ1x/csy1oI2vopJN84zNTCe
	5e5i5OSQEDCRmL14HTuELSZx4d56ti5GLg4hgcuMEnuvzmWBcM4zSaxf8ZARpIpNQFdiUU8z
	E4gtIiAu8fb4TKBuDg5mgQiJQ29LQMLCAo4SP3vPM4PYLAKqEqfmn2UFsXkFXCV2L9rIDLFM
	QaJzzX+wkZxA8Y7eJcwgY4QEXCTunXWawMi7gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGu
	uV5uZoleakrpJkZIoAjvYNx1Uu4QowAHoxIPbwLnvCAh1sSy4srcQ4ySHExKorz124FCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHhtyoByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakF
	qUUwWRkODiUJ3o0HgBoFi1LTUyvSMnNKENJMHJwgggtkAw/QhnUghbzFBYm5xZnpEEWnGBWl
	xHkngyQEQBIZpXlwA2Ax/YpRHOgfYd7DIFU8wHQA1/0KaDAT0GDzV7NABpckIqSkGhg5ek3Y
	tnnKpPzLUZboqPn86v7OW657/5Se+iccdvNX6Z7uwqeMC2c7L1GdfGbRzx+Jx3MV+gzv3rY6
	t2rPkR/+xx9y8Wx5m/2h56ot8x1/L1u7+uKwd3x/ZVzS8zt8fs8/cv3Se2afTJsv1291Jgo2
	Zs1J2ns58HOqQvbeRR/0Xgr2TD5jnR+ixFKckWioxVxUnAgAPk+ixsQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238754>

By default, show the remote-tracking references that could be pruned.
But if the user specifies --prune=<pattern>, then limit the output to
those matching pattern.  And if the user specified --no-prune, then do
not look for stale remote-tracking references at all.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-remote.txt | 6 ++++++
 builtin/remote.c             | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 9cbc986..dd48474 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -147,6 +147,12 @@ error.
 
 Gives some information about the remote <name>.
 +
+With `--prune`, display stale remote-tracking branches that no longer
+exist on the remote (this is the default).  With `--prune=<pattern>`,
+only report stale references whose names match <pattern> (this option
+can be used multiple times).  With `--no-prune`, do not report stale
+remote-tracking references at all.
++
 With `-n` option, the remote heads are not queried first with
 `git ls-remote <name>`; cached information is used instead.
 
diff --git a/builtin/remote.c b/builtin/remote.c
index e1d43e2..293d82d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1165,6 +1165,9 @@ static int show(int argc, const char **argv)
 	int no_query = 0, result = 0, query_flag = 0;
 	struct prune_option prune_option = PRUNE_OPTION_INIT;
 	struct option options[] = {
+		{ OPTION_CALLBACK, 0, "prune", &prune_option, N_("pattern"),
+			N_("show prunable remote-tracking branches (matching pattern, if specified)"),
+			PARSE_OPT_OPTARG, prune_option_parse },
 		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
-- 
1.8.4.3
