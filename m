From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 02/12] grep: break down an "if" stmt in preparation for next changes
Date: Sun, 14 Feb 2016 18:49:46 +0700
Message-ID: <1455450596-11904-3-git-send-email-pclouds@gmail.com>
References: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 14 12:51:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUvDQ-0001LX-AJ
	for gcvg-git-2@plane.gmane.org; Sun, 14 Feb 2016 12:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbcBNLvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2016 06:51:39 -0500
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36492 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbcBNLvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2016 06:51:16 -0500
Received: by mail-pa0-f65.google.com with SMTP id gc2so45498pab.3
        for <git@vger.kernel.org>; Sun, 14 Feb 2016 03:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2e//lJrvqr1dlC2h0uRCaBAsq76VWSWH8PHkhU0H9/8=;
        b=SKRE/OsiFkQjqUB7krd+79IrPKx012NCw/7/QE0w3zpa+OEEzaEMljuCliYRlRSaJj
         cUL7PCLJ/7eDmrSzjTFxFEmccpc60J79uXMiWXLTUa0yWHllmd/cMQHjpZL8ZkoQVfjN
         qFaJRyGHFD/G5fNtqKg8VZlqMa06tuYoDybcX6+q2IB3lLP6cp2dVkSEGT9AWP1I9yD0
         uXLTBNM/SwapSiHBwRkWlvw9Q9S2sjZrux9kzsoVhVT32nH+Nnc4vNoTmi6bmaRV0jKf
         yX4hW9Je3H18ttPUx27wW9ZFTkfs6XyWV01niIw/FXcjMPOBugL+YJU3T2VYr5rOFOhy
         Hsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2e//lJrvqr1dlC2h0uRCaBAsq76VWSWH8PHkhU0H9/8=;
        b=b44ksgchasIUKqc6pf4blYfIMYvw8xrcUQHiBWp9j5usKtS0fRtoapPd1YHlzJqIP6
         Ghi4P6T4+ZU4bapZTaTMbwCSOhC0FubAYpU/NUKVU8BmznYsNW2I9YphYnLq9ViojHcA
         vsxx3yY2T9lEGW9gqhxt15rTswpnA+ppsrc20QED7fITADOs5WlLwvsk6A2Dt4wyGYFs
         pKJzX5C05ZG+buFSESO/f0MbZKh8bZ15Dg6j2pExtEZTBzieSShS4bQHaFpaQ2tDX1Bb
         6/kdwBNP/LrfsYBuABVwn6KISwog6qTJKIUQHKSDcn8buipKOIYqzzdFwPdsVCNb7tHQ
         vSPg==
X-Gm-Message-State: AG10YORT3Ww7NfMo64s6RAnI81up2jClzSdBoCBt+OLCt4M7vu0hDXEG06aHKNXOQmRH3g==
X-Received: by 10.66.63.67 with SMTP id e3mr15240926pas.141.1455450675754;
        Sun, 14 Feb 2016 03:51:15 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id e79sm31287212pfb.76.2016.02.14.03.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Feb 2016 03:51:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Feb 2016 18:51:36 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455450596-11904-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286136>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 7b2b96a..609f218 100644
--- a/grep.c
+++ b/grep.c
@@ -403,7 +403,9 @@ static void compile_regexp(struct grep_pat *p, stru=
ct grep_opt *opt)
 	p->word_regexp =3D opt->word_regexp;
 	p->ignore_case =3D opt->ignore_case;
=20
-	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed) {
+		p->fixed =3D 1;
+	} else if (is_fixed(p->pattern, p->patternlen))
 		p->fixed =3D 1;
 	else
 		p->fixed =3D 0;
--=20
2.7.0.377.g4cd97dd
