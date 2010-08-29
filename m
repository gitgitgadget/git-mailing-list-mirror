From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 09/13] transport-helper: Use capname for gitdir capability too
Date: Sat, 28 Aug 2010 22:45:36 -0500
Message-ID: <1283053540-27042-10-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrO-0006pV-KB
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab0H2Dqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0H2Dqr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:47 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7Hzd8/609gUPj1UmyneK/C3cktTxt2rtTIQo6RskTDE=;
        b=uGKjWz1Q3XUMFWMb3z0E0GYkKOd7A7cl5YGVLYAGgNGdZJmO5ythcyM/O7piCScoUJ
         yi0VD8+wDJhSPhn3R80HqIq2ni8plV1mvhtmF8AbgqozzElwQ9z2+jI2QeZoMBicwvkI
         YhRj+kXSHXr3U21htbp/M1WNNIyfvLG3d98hw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LTSxtUjCH4+nzfW0rduQFvPhnLVeltSs+C/JHDrW/a2mpGhoE/UTl1kpD3eob96k+w
         GNenVuJPn1kOZ+GshOFPw6rJoVrGaeDP2ROezeYV4JeNrXN5zFZvImJEfGN8Yw2VqhfV
         5Mn7AeVEmvJD9kqTSZ1kVYhEZWIhbPLJrg6ts=
Received: by 10.231.39.196 with SMTP id h4mr3286035ibe.64.1283053607313;
        Sat, 28 Aug 2010 20:46:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154672>

Also properly use capname in the refspec capability.

Previously the gitdir and refspec capabilities could not be listed as
required or their parsing would break.

CC: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
CC: Daniel Barkalow <barkalow@iabervon.org>
---

  The first hunk was real silly and I should have caught it while
  reviewing the patch that introduced the required capabilities.

  I suspect the reason the second hunk wasn't caught is because the
  series that added 'gitdir' as capability, and the one that added
  required capabilities were done in parallel.

 transport-helper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 1294d10..82bdad3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -171,10 +171,10 @@ static struct child_process *get_helper(struct transport *transport)
 			ALLOC_GROW(refspecs,
 				   refspec_nr + 1,
 				   refspec_alloc);
-			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+			refspecs[refspec_nr++] = strdup(capname + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
-		} else if (!strcmp(buf.buf, "gitdir")) {
+		} else if (!strcmp(capname, "gitdir")) {
 			struct strbuf gitdir = STRBUF_INIT;
 			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
 			sendline(data, &gitdir);
-- 
1.7.2.1.240.g6a95c3
