From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v7 5/5] pretty printing: extend %G? to include 'N' and 'U'
Date: Sun, 31 Mar 2013 16:34:34 +0200
Message-ID: <5158497A.1080403@physik.tu-berlin.de>
References: <20130331133332.GD2286@serenity.lan> <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, trast@inf.ethz.ch, john@keeping.me.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 16:35:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJM4-0008Ha-8p
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab3CaOfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:35:01 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:42848 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135Ab3CaOfA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:35:00 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1UMJLT-00011w-Bf; Sun, 31 Mar 2013 16:34:59 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id B666511403;
	Sun, 31 Mar 2013 16:34:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <cover.1364738348.git.jaseg@physik-pool.tu-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219626>

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
index 2939655..afac703 100644
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
 - '%GK': show the key used to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}`
diff --git a/pretty.c b/pretty.c
index cf84d3a..840c41f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1135,6 +1135,8 @@ static size_t format_commit_one(struct strbuf *sb=
, const char *placeholder,
 			switch (c->signature_check.result) {
 			case 'G':
 			case 'B':
+			case 'U':
+			case 'N':
 				strbuf_addch(sb, c->signature_check.result);
 			}
 			break;
--=20
1.8.1.5
