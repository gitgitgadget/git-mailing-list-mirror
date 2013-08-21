From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [RFC PATCHv6 2/2] repack: retain the return value of pack-objects
Date: Wed, 21 Aug 2013 19:28:16 +0200
Message-ID: <1377106096-28195-2-git-send-email-stefanbeller@googlemail.com>
References: <5214F816.3010303@googlemail.com>
 <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, mackyle@gmail.com, j6t@kdbg.org
X-From: git-owner@vger.kernel.org Wed Aug 21 19:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCCCt-0005Kx-BA
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 19:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab3HUR2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 13:28:21 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:54063 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab3HUR2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 13:28:19 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so418529ead.35
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ip2ZuNENpeEJy31SN3THff2yFIAjhjMwn9u4aYoCtEI=;
        b=us2ye/MWcIDaCWNDg7+OciI/H+wneGIA28x7lkMGziaLmTgbjay21PbDRAiZ0ULUuJ
         FhTBb2z/1fwAnfbEtm1L2yKdtNa7t3Je6A2gR5GRNHoEUfrbq3osaMkOHgIJSbUUhWNO
         MZAa7G2ovLPjYZ7+YoAD2+PoHGGprmqeHn2yRltaKYaaiu9ZdAeC4VTfAx2/leI59X3f
         l9YZ/6SJx31X0fp+tB5LoFkv6iis/6PbyXxrULXbvrcI3DKlpQwVH9CvRQC9cRLS00Vj
         RQVhrrvIwyxRnjRdhpQOoFLdsN+XkiOEXheRU/r41n3LdEIfUZPIA1hen/k+otQ9CenM
         NNKg==
X-Received: by 10.15.107.132 with SMTP id cb4mr5100254eeb.54.1377106098201;
        Wed, 21 Aug 2013 10:28:18 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id p5sm11335083eeg.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 10:28:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.1.gc1ebd90
In-Reply-To: <1377106096-28195-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232709>

During the review process of the previous commit (repack: rewrite the
shell script in C), Johannes Sixt proposed to retain any exit codes from
the sub-process, which makes it probably more obvious in case of failure.

As the commit before should behave as close to the original shell
script, the proposed change is put in this extra commit.
The infrastructure however was already setup in the previous commit.
(Having a local 'ret' variable)

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index fb050c0..1f13e0d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -231,7 +231,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 
 	count_packs = 0;
 	out = xfdopen(cmd.out, "r");
@@ -245,7 +245,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 	argv_array_clear(&cmd_args);
 
 	if (!count_packs && !quiet)
-- 
1.8.4.rc3.1.gc1ebd90
