From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@dwim.me>
Subject: [PATCH] Disown ssh+git and git+ssh
Date: Mon, 15 Feb 2016 15:29:06 +0100
Message-ID: <1455546546-65710-1-git-send-email-cmn@dwim.me>
References: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 15:29:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVK9K-0004Rd-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 15:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbcBOO3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 09:29:09 -0500
Received: from hessy.dwim.me ([78.47.67.53]:43407 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753323AbcBOO3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 09:29:08 -0500
Received: from cmartin.tk (unknown [IPv6:2001:6f8:900:8cd0:922b:34ff:fe1c:e3e4])
	by hessy.dwim.me (Postfix) with ESMTPA id 02D5A803A9;
	Mon, 15 Feb 2016 15:29:06 +0100 (CET)
Received: (nullmailer pid 65752 invoked by uid 1000);
	Mon, 15 Feb 2016 14:29:06 -0000
X-Mailer: git-send-email 2.7.0
In-Reply-To: <xmqq7fi8s4dx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286207>

These were silly from the beginning, but we have to support them for
compatibility. That doesn't mean we have to show them in the
documentation. These were already left out of the main list, but a
reference in the main manpage was left, so remove that.

Also add a note to discourage their use if anybody goes looking for the=
m
in the source code.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>
---

I've updated the wording, so we talk about different ways of spelling
ssh rather than talking about schemes.

 Documentation/git.txt | 2 +-
 connect.c             | 4 ++++
 transport.c           | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index d987ad2..2f90635 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1122,7 +1122,7 @@ of clones and fetches.
 	    connection (or proxy, if configured)
=20
 	  - `ssh`: git over ssh (including `host:path` syntax,
-	    `git+ssh://`, etc).
+	    `ssh://`, etc).
=20
 	  - `rsync`: git over rsync
=20
diff --git a/connect.c b/connect.c
index fd7ffe1..d3eaa0e 100644
--- a/connect.c
+++ b/connect.c
@@ -267,6 +267,10 @@ static enum protocol get_protocol(const char *name=
)
 		return PROTO_SSH;
 	if (!strcmp(name, "git"))
 		return PROTO_GIT;
+	/*
+	 * These ways to spell the ssh transport remain supported for
+	 * compat but are undocumented and their use is discouraged
+	 */
 	if (!strcmp(name, "git+ssh"))
 		return PROTO_SSH;
 	if (!strcmp(name, "ssh+git"))
diff --git a/transport.c b/transport.c
index 9ae7184..ed61e72 100644
--- a/transport.c
+++ b/transport.c
@@ -1002,6 +1002,10 @@ struct transport *transport_get(struct remote *r=
emote, const char *url)
 		|| starts_with(url, "file://")
 		|| starts_with(url, "git://")
 		|| starts_with(url, "ssh://")
+		/*
+		 * These ways to spell the ssh transport remain supported for
+		 * compat but are undocumented and their use is discouraged
+		 */
 		|| starts_with(url, "git+ssh://")
 		|| starts_with(url, "ssh+git://")) {
 		/*
--=20
2.7.0
