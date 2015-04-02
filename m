From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] send-pack: unify error messages for unsupported capabilities
Date: Thu,  2 Apr 2015 19:28:48 +0200
Message-ID: <1427995728-8162-1-git-send-email-ralf.thielow@gmail.com>
Cc: matthias.ruester@gmail.com, Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 02 19:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdivJ-0005i4-Og
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 19:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbbDBR2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 13:28:53 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37047 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbbDBR2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 13:28:52 -0400
Received: by wiaa2 with SMTP id a2so113540134wia.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZjdvviQlM9mtnVB7TlH8sYfXgfjM5Ye80uZCYqJ69KE=;
        b=hSBkNy7cS+rjN0RNCeCaHFoFgV9v+0vYdeD/teGegzGasm6aty+rxBABJjvX71UO87
         6+zSfp2sGGf3GoL2JhnPVUE0Q/acf6NFPMZa/JO6uutowmlzhcrWcoCJvMF/LohmEQm5
         rChym+gHVcOy8fRBF86vRDKHEgZ4Z1+7XA3Dcl/nEy1jPJUlr5OmYnvVTrmp/Sxt3IgA
         tMjcdmQPAbFpH36anjXfFRxueO4FKjJlzED2Mbga76SRZmxvu7hSW+mMBBTWcKpOl1bH
         2JaKj1fza8QEnN+oxCLygJgj0qhBarh27NAzOMvZjpYmoeyEzBh3xnL7P+1y+fTTloEc
         4qiw==
X-Received: by 10.194.85.233 with SMTP id k9mr93149706wjz.31.1427995731786;
        Thu, 02 Apr 2015 10:28:51 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id w8sm8137814wja.4.2015.04.02.10.28.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 10:28:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.243.g0be2dd7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266651>

If --signed is not supported, the error message names the remote
"receiving end". If --atomic is not supported, the error message
names the remote "server". Unify the naming to "receiving end"
as we're in the context of "push".

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/send-pack.c b/send-pack.c
index 9d2b0c5..189bdde 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -356,21 +356,21 @@ int send_pack(struct send_pack_args *args,
 			die(_("the receiving end does not support --signed push"));
 		push_cert_nonce = xmemdupz(push_cert_nonce, len);
 	}
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
 			"Perhaps you should specify a branch such as 'master'.\n");
 		return 0;
 	}
 	if (args->atomic && !atomic_supported)
-		die(_("server does not support --atomic push"));
+		die(_("the receiving end does not support --atomic push"));
 
 	use_atomic = atomic_supported && args->atomic;
 
 	if (status_report)
 		strbuf_addstr(&cap_buf, " report-status");
 	if (use_sideband)
 		strbuf_addstr(&cap_buf, " side-band-64k");
 	if (quiet_supported && (args->quiet || !args->progress))
 		strbuf_addstr(&cap_buf, " quiet");
 	if (use_atomic)
-- 
2.4.0.rc0.243.g0be2dd7
