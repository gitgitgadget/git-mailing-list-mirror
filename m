From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v2 4/4] pretty printing: extend %G? to include 'N' and 'U'
Date: Sat, 23 Mar 2013 02:57:50 +0100
Message-ID: <514D0C1E.9080908@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 23 02:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJDiy-0004pW-6X
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 02:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423111Ab3CWB56 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 21:57:58 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:29630 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423088Ab3CWB5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 21:57:52 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-2) with esmtp 
	id 1UJDiQ-0006Do-J8; Sat, 23 Mar 2013 02:57:51 +0100
Received: from [192.168.0.103] (cable-124-189.zeelandnet.nl [82.176.124.189])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id AB4E111402;
	Sat, 23 Mar 2013 02:57:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218872>

Expand %G? in pretty format strings to 'N' in case of no GPG signature
and 'U' in case of a good but untrusted GPG signature in addition to
the previous 'G'ood and 'B'ad. This eases writing anyting parsing
git-log output.

Signed-off-by: Sebastian G=F6tte <jaseg@physik-pool.tu-berlin.de>
---
 Documentation/pretty-formats.txt | 3 ++-
 pretty.c                         | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 105f18a..69bd77a 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -131,7 +131,8 @@ The placeholders are:
 - '%B': raw body (unwrapped subject and body)
 - '%N': commit notes
 - '%GG': raw verification message from GPG for a signed commit
-- '%G?': show either "G" for Good or "B" for Bad for a signed commit
+- '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" f=
or a good,
+  untrusted signature and "N" for no signature
 - '%GS': show the name of the signer for a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
 - '%gd': shortened reflog selector, e.g., `stash@{1}`
diff --git a/pretty.c b/pretty.c
index 0547df1..875a1db 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1136,6 +1136,8 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 			switch (c->signature.check_result) {
 			case 'G':
 			case 'B':
+			case 'U':
+			case 'N':
 				strbuf_addch(sb, c->signature.check_result);
 			}
 			break;
--=20
1.8.1.5
