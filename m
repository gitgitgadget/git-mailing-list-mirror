From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/4] dir.c: fix match_pathname()
Date: Mon, 15 Feb 2016 16:03:36 +0700
Message-ID: <1455527019-7787-2-git-send-email-pclouds@gmail.com>
References: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 10:03:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVF4H-00065h-V7
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 10:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbcBOJDf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 04:03:35 -0500
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36854 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752389AbcBOJD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 04:03:29 -0500
Received: by mail-pa0-f67.google.com with SMTP id y7so451260paa.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 01:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5klR3wULQ3wq7H7KEaVxFYx84xG9CNRhYTZWTw+67kQ=;
        b=0UtDf50Ul+Co3SKHAgdF/OpCGa+iVshSxwuYCNvHgDrLSOmqNGwlM4R3Xacnrr3ycn
         qrdE3u82vxXogu4qL6KVfxCgNlpeAQB0erwob6yEn0V1aUNbd0iAxuNUoWMna9ssHOd0
         8PFGNvoexDBq1umzFudUqNWwhqiKVTIhXEn0S2sZaDCEP7CIfXZz4Ronma54XKqb8Kc9
         /LO0D5EzCdPhIt6H9GmzD8hiU7nROsc1ozLd5KtKY8Uc17yVfosOF40qbzCyFc3VP6Yh
         eBl+HtC7YXCGGPw8iUZ3FcoL5V9l8cJgOr9ajEkvw8Bi+8ezq0/Dyfo7tcFj+rwjKaaz
         pECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5klR3wULQ3wq7H7KEaVxFYx84xG9CNRhYTZWTw+67kQ=;
        b=DnGTuVPWRbpPEuEN/jFYzO5WEh2Ebby2m+loAygBySIJtlbbnswuGA2PbV9L+MXY2+
         k5GLuPnqqEW8YL6UEcLJIKxMrbNkX1f5OF9ozJMN5Gspbug1Elpc6oGKl1zVaoh1U015
         zW3VousA6CQXPizSdG6ShqNI7m9st6fxc0O6ARcy+tn8MXiX0NDR/nmtiY8mhOZfK4gI
         AcIo/zRmSAVG96Wjf69t0kMRuS5Ejd7/pYKYEey7yZFctQnl0Lqr8LZpIzpJDsiak6bX
         nqZnrbrwv+AwBLzi1a78D56XZrEEKk1i1/h67rn6XKNdI4jInnSQSRrrz+YnxF/u2svY
         c+4Q==
X-Gm-Message-State: AG10YOQQ2Q5OlJGTGhGiQVkZfA+yT5AfOYV/TFmK67R2fPMwQW98783mQV/P68qjCaejBw==
X-Received: by 10.67.23.161 with SMTP id ib1mr20510450pad.156.1455527009189;
        Mon, 15 Feb 2016 01:03:29 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id x10sm36788166pas.37.2016.02.15.01.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 01:03:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 15 Feb 2016 16:03:50 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455527019-7787-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286186>

Given the pattern "1/2/3/4" and the path "1/2/3/4/f", the pattern
prefix is "1/2/3/4". We will compare and remove the prefix from both
pattern and path and come to this code

	/*
	 * If the whole pattern did not have a wildcard,
	 * then our prefix match is all we need; we
	 * do not need to call fnmatch at all.
	 */
	if (!patternlen && !namelen)
		return 1;

where patternlen is zero (full pattern consumed) and the remaining
path in "name" is "/f". We fail to realize it's matched in this case
and fall back to fnmatch(), which also fails to catch it. Fix it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f0b6d0a..bcaafac 100644
--- a/dir.c
+++ b/dir.c
@@ -878,7 +878,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (!patternlen && (!namelen || *name =3D=3D '/'))
 			return 1;
 	}
=20
--=20
2.7.0.377.g4cd97dd
