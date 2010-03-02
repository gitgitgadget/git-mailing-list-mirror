From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 6/7] remote-curl: use http_fetch_ref() instead of walker wrapper
Date: Tue,  2 Mar 2010 18:49:30 +0800
Message-ID: <1267526971-5552-7-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg8-0003k4-60
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681Ab0CBKuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:50:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55210 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab0CBKuC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:50:02 -0500
Received: by mail-gy0-f174.google.com with SMTP id 20so34198gyh.19
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wzLci8NQEZck/GbSjZ+jCGF8fegwdPKOQTUc7c1OpBo=;
        b=RP9zoUwyjCu7jD52O/xG5+xmE23yz+738FmT/eJ3DpXRx2WJXVcuOmbKoQIR3+MGF6
         Jo+tFwCqzad5KXQ5KPWZ//9Ux+XYNFcK4BuA5bsxFMP79ZVQETrB6JZjISW9mhVjPR5p
         O+yF81vpcs1bpRDdhr0h/rRUBfzosxotFaywM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pl41+hCN+gyKVFbb5qEC7oJ73aK6j/LaNDGd7AYEhsNluVERgjM66RgSP/lfNMtmDF
         KVXqQzEyZtEqnMxOYRQSI+Hg/7u+0SxOnBCGtueGPM3yNVoqRdukfl5g3X1zWubJUpjr
         lx+xUCBY0hdK/ytKzUq7akehLVU7hFiUF2GZI=
Received: by 10.101.189.30 with SMTP id r30mr252914anp.70.1267527000583;
        Tue, 02 Mar 2010 02:50:00 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:50:00 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141382>

The http-walker implementation of walker->fetch_ref() doesn't do
anything special compared to http_fetch_ref() anyway.

Remove init_walker() invocation before fetching the ref, since we aren't
using the walker wrapper and don't need a walker instance anymore.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 remote-curl.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 1e13fb5..5ace99e 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -250,9 +250,8 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		i++;
 	}
 
-	init_walker();
 	ref = alloc_ref("HEAD");
-	if (!walker->fetch_ref(walker, ref) &&
+	if (!http_fetch_ref(url, ref) &&
 	    !resolve_remote_symref(ref, refs)) {
 		ref->next = refs;
 		refs = ref;
-- 
1.7.0.26.gbfa16
