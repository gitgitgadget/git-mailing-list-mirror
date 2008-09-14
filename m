From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/16] grep: skip files that have not been checked out
Date: Sun, 14 Sep 2008 20:07:59 +0700
Message-ID: <1221397685-27715-11-git-send-email-pclouds@gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
 <1221397685-27715-2-git-send-email-pclouds@gmail.com>
 <1221397685-27715-3-git-send-email-pclouds@gmail.com>
 <1221397685-27715-4-git-send-email-pclouds@gmail.com>
 <1221397685-27715-5-git-send-email-pclouds@gmail.com>
 <1221397685-27715-6-git-send-email-pclouds@gmail.com>
 <1221397685-27715-7-git-send-email-pclouds@gmail.com>
 <1221397685-27715-8-git-send-email-pclouds@gmail.com>
 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 14 15:10:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KerNA-0005z2-PO
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 15:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbYINNJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Sep 2008 09:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbYINNJa
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 09:09:30 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:21050 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbYINNJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 09:09:29 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1590748wfd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Gg6xPkXoGr7xC5UU1VrFtE+EuxDGL13oBJ1SzNiqI/s=;
        b=Gck5rc4D/d1XXAQD6a+v3n+Xtn79ucNf3Frmarvbggg22jboI/CTQVxDPZlrLFtb6l
         2NGbknbaunBUwTV0jUBStSijKLqistfXSV07uFzL0T/v/qGfOYO5VRjc3sNxDTA60kHS
         F/+/j67ckXZZj/CnUVDiyL9DfR3+5I5Eux5xs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=krPmW6S5Q4JluOHvYKBuD8vfyemytC0POnCS9/JXN1hrQAblrh/ILY5uZBhZ3wDf6F
         zx7iqNC9ZPuqgjumZtcCDXwIBjW3N/65EECmjMK+FkOdAxPifqrulZATTRU4Qfm9OhYV
         +DYbGlypNdGTO1mr8bPYKw3RjLTHBvqE+lWOE=
Received: by 10.142.164.10 with SMTP id m10mr2267093wfe.60.1221397768841;
        Sun, 14 Sep 2008 06:09:28 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.40.147])
        by mx.google.com with ESMTPS id 30sm20046519wfd.1.2008.09.14.06.09.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 06:09:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 14 Sep 2008 20:09:21 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221397685-27715-10-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95837>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 3a51662..d5507d7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -343,6 +343,8 @@ static int external_grep(struct grep_opt *opt, cons=
t char **paths, int cached)
 			continue;
 		if (!pathspec_matches(paths, ce->name))
 			continue;
+		if (ce_no_checkout(ce))
+			continue;
 		name =3D ce->name;
 		if (name[0] =3D=3D '-') {
 			int len =3D ce_namelen(ce);
@@ -404,8 +406,11 @@ static int grep_cache(struct grep_opt *opt, const =
char **paths, int cached)
 				continue;
 			hit |=3D grep_sha1(opt, ce->sha1, ce->name, 0);
 		}
-		else
+		else {
+			if (ce_no_checkout(ce))
+				continue;
 			hit |=3D grep_file(opt, ce->name);
+		}
 		if (ce_stage(ce)) {
 			do {
 				nr++;
--=20
1.6.0.96.g2fad1.dirty
