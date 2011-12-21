From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 1/4] Fix an enum assignment issue spotted by Sun Studio
Date: Wed, 21 Dec 2011 01:18:19 +0000
Message-ID: <1324430302-22441-2-git-send-email-avarab@gmail.com>
References: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Jason Evans <jasone@canonware.com>,
	David Barr <david.barr@cordelta.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 02:18:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdApE-0001ST-Ja
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 02:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639Ab1LUBS3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 20:18:29 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52700 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab1LUBS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 20:18:28 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so7119243eek.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5ztYWcaM2GZMyXS5x7hJyX74oiw4KnTsLnsX8k9YRWI=;
        b=fUDuWFow7FXwSuG31yZHrAJWwLAoPhV3YwePGgTAetfYr0j9FW+AjM1w0/kM0vIUOy
         /+Sa+787RpUejlnmvweHFjyYS0QepfxPUnreBexxWBh9CroG+HH4dU8M36QyJfZc74TW
         CrXq/DqPMFY+0C7dSpgxkygYp4uEQALsNgUaQ=
Received: by 10.213.32.75 with SMTP id b11mr951795ebd.26.1324430308113;
        Tue, 20 Dec 2011 17:18:28 -0800 (PST)
Received: from w.nix.is (w.nix.is. [188.40.98.140])
        by mx.google.com with ESMTPS id z43sm14054237eef.7.2011.12.20.17.18.27
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 17:18:27 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1324430302-22441-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187541>

In builtin/fast-export.c we'd assign to variables of the
tag_of_filtered_mode enum type with constants defined for the
signed_tag_mode enum.

We'd get the intended value since both the value we were assigning
with and the one we actually wanted had the same positional within
their respective enums, but doing it this way makes no sense.

This issue was spotted by Sun Studio 12 Update 1:

    "builtin/fast-export.c", line 54: warning: enum type mismatch: op "=
=3D" (E_ENUM_TYPE_MISMATCH_OP)

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fast-export.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9836e6b..08fed98 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -25,7 +25,7 @@ static const char *fast_export_usage[] =3D {
=20
 static int progress;
 static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode =3D ABORT=
;
-static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode =3D ABORT;
+static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode =3D ERROR;
 static int fake_missing_tagger;
 static int use_done_feature;
 static int no_data;
@@ -51,7 +51,7 @@ static int parse_opt_tag_of_filtered_mode(const struc=
t option *opt,
 					  const char *arg, int unset)
 {
 	if (unset || !strcmp(arg, "abort"))
-		tag_of_filtered_mode =3D ABORT;
+		tag_of_filtered_mode =3D ERROR;
 	else if (!strcmp(arg, "drop"))
 		tag_of_filtered_mode =3D DROP;
 	else if (!strcmp(arg, "rewrite"))
--=20
1.7.7.3
