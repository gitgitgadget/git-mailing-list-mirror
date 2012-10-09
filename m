From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] wildmatch: fix case-insensitive matching
Date: Tue,  9 Oct 2012 10:09:04 +0700
Message-ID: <1349752147-13314-6-git-send-email-pclouds@gmail.com>
References: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 05:09:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQCk-0006Cq-9o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755Ab2JIDJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2012 23:09:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53735 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2JIDJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:09:46 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4603957pbb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TUsdt6gP56omb4TyYi6G/AAcy1D3GTH/hEOJiYHMTaE=;
        b=TmHP6d5r7FDxxhhj8nnw2wYQ60SSClVtK6SSMwMpmLykCgm4dFi8kvm8lcQcOLzHGv
         KDT5+9ROBCV+zMgU16sy3ASewI7WaNwAtTEdhDJk0LVF75yunw0G9xqdrM/8iK4PGZF9
         n26hYnS9gSPw4yqDiMz+2NvtAPhXNzWFO5CA5R38jPVnc/N0hzWJmd31HZ3vcdDl9kHV
         1wgED3vr7pYdQA6QoYOsk4J3UBgp+KWRRvaOcvb4rpavYULVyNnUa03P6WhAPx16lLJg
         F3D6MuDdRU7yAf/txpx7adyc3UHEwy4TpPdqC34zw9J87LSHmwwF1vkBdGhI5D8BzotC
         FqeQ==
Received: by 10.68.200.39 with SMTP id jp7mr59095305pbc.160.1349752186624;
        Mon, 08 Oct 2012 20:09:46 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id h10sm11804603pav.28.2012.10.08.20.09.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 20:09:45 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 09 Oct 2012 10:09:40 +0700
X-Mailer: git-send-email 1.8.0.rc0.29.g1fdd78f
In-Reply-To: <1349752147-13314-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207292>

dowild() does case insensitive matching by lower-casing the text. That
means lower case letters in patterns imply case-insensitive matching,
but upper case means exact matching.

We do not want that subtlety. Lower case pattern too so iwildmatch()
always does what we expect it to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wildmatch.c b/wildmatch.c
index 2382873..fdb8cb1 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -72,6 +72,8 @@ static int dowild(const uchar *p, const uchar *text, =
int force_lower_case)
 		return ABORT_ALL;
 	if (force_lower_case && ISUPPER(t_ch))
 	    t_ch =3D tolower(t_ch);
+	if (force_lower_case && ISUPPER(p_ch))
+	    p_ch =3D tolower(p_ch);
 	switch (p_ch) {
 	  case '\\':
 	    /* Literal match with following character.  Note that the test
--=20
1.8.0.rc0.29.g1fdd78f
