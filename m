From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v4 08/19] unpack-trees(): carry skip-worktree bit over in merged_entry()
Date: Thu, 20 Aug 2009 20:47:02 +0700
Message-ID: <1250776033-12395-9-git-send-email-pclouds@gmail.com>
References: <1250776033-12395-1-git-send-email-pclouds@gmail.com>
 <1250776033-12395-2-git-send-email-pclouds@gmail.com>
 <1250776033-12395-3-git-send-email-pclouds@gmail.com>
 <1250776033-12395-4-git-send-email-pclouds@gmail.com>
 <1250776033-12395-5-git-send-email-pclouds@gmail.com>
 <1250776033-12395-6-git-send-email-pclouds@gmail.com>
 <1250776033-12395-7-git-send-email-pclouds@gmail.com>
 <1250776033-12395-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 20 15:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me81G-0007ZS-SR
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 15:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665AbZHTNsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 09:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754663AbZHTNsF
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 09:48:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:44339 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZHTNsE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 09:48:04 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1591323rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=S+qgzbJikx4/PbIiMCug1AoIljn+i6BW67Ni+FaDUkg=;
        b=GtIjEC13dS+QM+PkSbx9D8nsg8UUZIkZxaPzFpXF1nC+RD066r8OSjzT4+2yVjVQDC
         yRnr+r1t78bIpiV7hvHGvMLls45WDIzf/5VP8vhCjfj6tRIHC2DVpwSGuYG5FrxWPwf9
         YwJAoXKVBiMHg17sGidnGes6Uq5jg3GRhVHqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=TndEb0x9pf0ZjgV+NVUQetjtR9wtqGaxKQHWKPfZ80DnOvtVbmn/e5UrQlqmn+IMgy
         dUpqb0Fii1psfdxiUV+281FpuEYY5ON+RJcmY8EKVTxCs3DMFRlk83p5tKULp+uWri0N
         yjinIGBck0IkPsZway95jwrN7iPAwCDg5SzgU=
Received: by 10.141.45.16 with SMTP id x16mr4457220rvj.118.1250776086364;
        Thu, 20 Aug 2009 06:48:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.241.222])
        by mx.google.com with ESMTPS id b39sm12529017rvf.40.2009.08.20.06.48.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 06:48:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 20 Aug 2009 20:47:59 +0700
X-Mailer: git-send-email 1.6.3.GIT
In-Reply-To: <1250776033-12395-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126630>

In this code path, we would remove "old" and replace it with "merge".
"old" may have skip-worktree bit, so re-add it to "merge".

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 3eda263..dc6d74a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -680,6 +680,8 @@ static int merged_entry(struct cache_entry *merge, =
struct cache_entry *old,
 		} else {
 			if (verify_uptodate(old, o))
 				return -1;
+			if (ce_skip_worktree(old))
+				update |=3D CE_SKIP_WORKTREE;
 			invalidate_ce_path(old, o);
 		}
 	}
--=20
1.6.3.GIT
