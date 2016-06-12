From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/27] upload-pack: make check_non_tip() clean things up on error
Date: Sun, 12 Jun 2016 17:53:51 +0700
Message-ID: <20160612105409.22156-10-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC33K-0003Pb-SB
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbcFLKze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:34 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34615 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcFLKzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:31 -0400
Received: by mail-pa0-f68.google.com with SMTP id ug1so8416009pab.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yf+Ji0ZhcA/YW0FJOP5MpIly7cfPZvaALtROgp2sjtw=;
        b=zi/aINfEQtsb/hnCqq1PCqzs1G94VkT5ZASDNroYlAT9tEO2gco2LIKACrsCSRANKq
         w6eg+u2j7bnWQeJbThP+kmEbuv8cRZgS3JenqP1PpWpzFvf2RBljGrSy0ZfyAcGql5Ft
         NurMaLssEG9Tbd3S+eIzbev+q6bQ9oK/Ftxi7a1cwesXvRP/f8WURiGzvFibPeFS9zTZ
         VvJZ3rgnI9KO/XCZ1mCnAYsOHN00IDlWYts2EiUnlKfdlx4+xlgbhIiQraQ2EaWAMbAq
         zHYWDq8RP8iDdhxKUhbWtJUAFIFeCZm9+FvUv5c7Mnexz4onKvSHnKkTdsQoZ/wG2w36
         v+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yf+Ji0ZhcA/YW0FJOP5MpIly7cfPZvaALtROgp2sjtw=;
        b=WA23mQVl62P3rhNV/Q1T3oprfWBS5NN9Jn+xcOQG+yBErPVhd5o6a3Hbt/UI4FlJ8O
         3zZFXLkDfHIAFRl4kVYVazeUP2KIyKqKqdzVk43uKqRnbHItC0ZjkINXpL8gAJjGAyns
         Tj+TG20+EnLi36cKcQFh7167HQDo/y9dr9HfQ0kJJScwrx/0Y32cTRNtStmc8xybmZKy
         ZzJfSPsRtL7rlF0CmnnDWZ7f4CWVv4+e+vIj8Xep22DnO/tsqu76rfTuIHz6xKzSXxUR
         iZzFq8thMp+BQOdl8LRuuXVTThr4EpVeFx8gSaa24kwJ7voK2GHtiwbtc3CDNgwNnahe
         Q0TQ==
X-Gm-Message-State: ALyK8tKUpd+BNbQK7UaHHQXZKyd3GBLszL2Cu1XH9Ge/c5QvrQW2fEL5+9rxUaKzCWo9qw==
X-Received: by 10.66.132.103 with SMTP id ot7mr14949087pab.60.1465728930167;
        Sun, 12 Jun 2016 03:55:30 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id t24sm25595374pfj.75.2016.06.12.03.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:29 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:25 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297116>

On error check_non_tip() will die and not closing file descriptors is n=
o
big deal. The next patch will split the majority of this function out
for reuse in other cases, where die() may not be the only outcome. Same
story for popping SIGPIPE out of the signal chain. So let's make sure w=
e
clean things up properly first.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 8f4d7f4..7ce97ec 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -475,16 +475,16 @@ static void check_non_tip(void)
 	cmd.in =3D -1;
 	cmd.out =3D -1;
=20
-	if (start_command(&cmd))
-		goto error;
-
 	/*
-	 * If rev-list --stdin encounters an unknown commit, it
-	 * terminates, which will cause SIGPIPE in the write loop
+	 * If the next rev-list --stdin encounters an unknown commit,
+	 * it terminates, which will cause SIGPIPE in the write loop
 	 * below.
 	 */
 	sigchain_push(SIGPIPE, SIG_IGN);
=20
+	if (start_command(&cmd))
+		goto error;
+
 	namebuf[0] =3D '^';
 	namebuf[41] =3D '\n';
 	for (i =3D get_max_object_index(); 0 < i; ) {
@@ -507,8 +507,7 @@ static void check_non_tip(void)
 			goto error;
 	}
 	close(cmd.in);
-
-	sigchain_pop(SIGPIPE);
+	cmd.in =3D -1;
=20
 	/*
 	 * The commits out of the rev-list are not ancestors of
@@ -518,6 +517,7 @@ static void check_non_tip(void)
 	if (i)
 		goto error;
 	close(cmd.out);
+	cmd.out =3D -1;
=20
 	/*
 	 * rev-list may have died by encountering a bad commit
@@ -527,10 +527,19 @@ static void check_non_tip(void)
 	if (finish_command(&cmd))
 		goto error;
=20
+	sigchain_pop(SIGPIPE);
+
 	/* All the non-tip ones are ancestors of what we advertised */
 	return;
=20
 error:
+	sigchain_pop(SIGPIPE);
+
+	if (cmd.in >=3D 0)
+		close(cmd.in);
+	if (cmd.out >=3D 0)
+		close(cmd.out);
+
 	/* Pick one of them (we know there at least is one) */
 	for (i =3D 0; i < want_obj.nr; i++) {
 		o =3D want_obj.objects[i].item;
--=20
2.8.2.524.g6ff3d78
