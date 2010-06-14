From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] notes: Initialize variable to appease Sun Studio
Date: Mon, 14 Jun 2010 23:40:05 +0000
Message-ID: <1276558805-26573-1-git-send-email-avarab@gmail.com>
References: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 01:40:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOJGr-0003OA-Oq
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 01:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab0FNXkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 19:40:22 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48926 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0FNXkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 19:40:21 -0400
Received: by wwb18 with SMTP id 18so4340781wwb.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 16:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/KU2HDEQLWNy6Q8H/9pVBOKsBQcBIhrMmsef7QFYvLw=;
        b=gxpNMm16xIPz46kOTx0EM0na2AKtZuo4IizKgt9ZRgE/007SF/gn8umr9/2YPPh0fa
         PxcCzUdi8yGArxpkY8OfAAUpBgjQw796m8QVXQprXf6Jc+l5++/FUj93LVoTWXqLswrM
         GSbOU2K09K4u5YIx/xmfWDmdyBcioW2rxRi2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oqYpB2ZyXHrmZgdc+xuUiCpHqt27tJFlop/cZS43gAWMwLYQY+uFwOl0ag3qkcS/m7
         mx4BYM+aPTbsyxP6iAsOItgq0A7QEbicLPM2IHIap3p0HmWWRODeRASFRbmWA00Yoche
         7uImwX1DVC8sV48WnMBjudzUR6WqhLJaN6g+w=
Received: by 10.227.142.210 with SMTP id r18mr6369261wbu.81.1276558818067;
        Mon, 14 Jun 2010 16:40:18 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id y31sm40786515wby.4.2010.06.14.16.40.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 16:40:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <e0fbd6edc13d94a097e8e7e3649b9e669f9b4ee3.1268413246.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149147>

Sun Studio 12 Update 1 thinks that *t could be uninitialized,
ostensibly because it doesn't take rewrite_cmd into account in its
static analysis.

    builtin/notes.c: In function `notes_copy_from_stdin':
    builtin/notes.c:419: warning: 't' might be used uninitialized in th=
is function

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ba8fd17..648033c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -416,7 +416,7 @@ int notes_copy_from_stdin(int force, const char *re=
write_cmd)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	struct notes_rewrite_cfg *c =3D NULL;
-	struct notes_tree *t;
+	struct notes_tree *t =3D NULL;
 	int ret =3D 0;
=20
 	if (rewrite_cmd) {
--=20
1.7.1.251.g92a7
