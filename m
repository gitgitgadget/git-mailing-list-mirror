From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/6] worktree: avoid 0{40}, too many zeroes, hard to read
Date: Sun, 22 May 2016 16:33:55 +0700
Message-ID: <20160522093356.22389-6-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4Pmi-0001U2-9o
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbcEVJex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35987 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcEVJev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id g132so15751751pfb.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sx9msf4bJ3Je+/e9lGN2Ef9PagWRB/VfZLlVE0gnIfc=;
        b=dBOYb4Q6lBdRk1SAm+6T2xQqa/OYtuJFybpfqcPYjvG5YL/sCr7REXueBsSwzTpvTL
         vEoEtQjm+yrlCQ78h4VfiA5D6QGbKlfR3Aa3mHAf4LxbYK2/1FDQyGL391rHAAtTtm85
         pOikBOJhOOxKTb2umJExt9S6ApCghExPMkk16tj17xBCqelRoe9mqKA1KlQdBA6ydmi1
         Hr+tAe0QrduoGiH/EBa3kYaxAjwjMPd3AoecSh1ZMG0M6eTzSwXqN/mlQzhaXGSdiUrX
         d12qcf6rH0nuzlQJXMT7/SeD1kM6hwadaaOeNdtfxFB4+QReflUnbca+enkutEjJwsMT
         tjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sx9msf4bJ3Je+/e9lGN2Ef9PagWRB/VfZLlVE0gnIfc=;
        b=K7C5Iw28BNuHDyZyWQyHTFX82XlCa8aiWKAPZLNhGFYX4FALdkhW9I2P9izHknPxA8
         MansRzUy1FefLgUOtcjh9OtstSd19ZSGah63joHZ2Pr5DUtBGw41a1MOJVJ7LBpjDTzA
         BeHms0ZgJwfm7hQ88Ym7Ucvfa7iOx5q3htWfQ9CL+8ISkocETe8q/5POeG/i+KEEujyB
         pUTdzAu9ElrzcE8GU3k7o+PrpvpQvLLPCjiFpRVFQSzH9HJ5Hyc75+9lCqeV5VKIPGqF
         STnjgG0pmNtHcBt9cW0EAkRIRAXObo2zdNTE8/TsMhzv5jAQnvY0VVRuJRlpntPkUiOc
         PpOg==
X-Gm-Message-State: AOPr4FWWClq9AUY6SNQRkwsFra0HgVOX0jF+1IW9iIjVzbgKUoUDCl7HjwJmuj0EaRzzfg==
X-Received: by 10.98.86.24 with SMTP id k24mr18598027pfb.87.1463909690344;
        Sun, 22 May 2016 02:34:50 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 132sm1060604pfc.52.2016.05.22.02.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:49 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:45 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295265>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/worktree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index aaee0e2..b53f802 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -262,7 +262,7 @@ static int add_worktree(const char *path, const cha=
r *refname,
 	 */
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, "0000000000000000000000000000000000000000");
+	write_file(sb.buf, sha1_to_hex(null_sha1));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, "../..");
--=20
2.8.2.524.g6ff3d78
