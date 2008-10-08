From: Imre Deak <imre.deak@gmail.com>
Subject: [PATCH] builtin-apply: fix typo leading to stack corruption
Date: Thu, 9 Oct 2008 00:24:16 +0300
Message-ID: <48ee0b28.04eb300a.03f6.fffffe21@mx.google.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 15:48:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Knvrh-0000NN-HQ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 15:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955AbYJINqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 09:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758957AbYJINqV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 09:46:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:48033 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759955AbYJINqU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 09:46:20 -0400
Received: by nf-out-0910.google.com with SMTP id d3so14415nfc.21
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:date:subject
         :message-id;
        bh=kh4tQkj+YqmIIuhJNmT8oEMLEjvCfrinwpejxS0Q7zo=;
        b=dLWQn7AL+4MU8HPuEYk9Qrkb7MlpGnAmYllQhSjHpq5P7mVeKXuEJTyZGIRKC8FcKB
         Jad0trGCrgmxqKxSN9qszSTXBpXWCYXOIkZ31g8GAeIl7aQlYlvqc/LrJWYWgocwouuu
         KmlyY8llPHLvNUxpPIXAIYfR4W2BEWlttYKrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:date:subject:message-id;
        b=dc2Qm5nLGnNZSIBE8VUlpEa9H2zNQo5XFP4EJO7FcEIsUboEVrHOB9kjd20SWbtcaM
         ndop3Y/mCywfy53uX183jlEpffaoiRlFG1yC4uEEY1UrM7DaRr4995KpBPsxFCEzpWrF
         PQC4XPb99EVQPfbHcrTXBUbkd5GFW/S+r0iNc=
Received: by 10.210.46.4 with SMTP id t4mr102524ebt.152.1223559977150;
        Thu, 09 Oct 2008 06:46:17 -0700 (PDT)
Received: from localhost (www.teleca.fi [212.213.55.210])
        by mx.google.com with ESMTPS id i4sm44608120nfh.1.2008.10.09.06.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Oct 2008 06:46:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97850>

This typo led to stack corruption for lines > 1024 if whitespace fixing
is in effect.

Signed-off-by: Imre Deak <imre.deak@gmail.com>

---
 builtin-apply.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 20bef1f..720dc7f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1696,7 +1696,7 @@ static int match_fragment(struct image *img,
 		fixlen = ws_fix_copy(buf, orig, oldlen, ws_rule, NULL);
 
 		/* Try fixing the line in the target */
-		if (sizeof(tgtfixbuf) < tgtlen)
+		if (sizeof(tgtfixbuf) > tgtlen)
 			tgtfix = tgtfixbuf;
 		else
 			tgtfix = xmalloc(tgtlen);
-- 
1.6.0.2.308.g754c
