From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 2/2] repack: retain the return value of pack-objects
Date: Thu, 29 Aug 2013 22:39:34 +0200
Message-ID: <1377808774-12505-3-git-send-email-stefanbeller@googlemail.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 29 22:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF90V-0000ay-7g
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab3H2Ujp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 16:39:45 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:35518 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994Ab3H2Ujn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 16:39:43 -0400
Received: by mail-ee0-f51.google.com with SMTP id c1so497846eek.10
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=90TLPEZ7slW7EwtaDIzcVPEkzfCyta2ObiqE7SVWfxs=;
        b=Buf+3TC23FtYfKGdy+WlP4L4H36P74JtRR12fmIGlKqNDkt9IHukQVNN0IhaWyFlXA
         38FXLvGi+9itIXTX5pqF77itkYUDDWdJ8Wbs9Gbj8Y2aj+WQ8rFixn60erbXoMprPcKT
         TzW5xqyNNXFkm+cCBwjz6FR8J9FcZxWo2d3XJuHzPegPESMX/7MAiU5+qxtybjbM4+G+
         PKYwAstOkXdwG5HQeYd6jOX8VvfbOPvXdxCWORF5BqDK/htwS5Su2yOwyApJjFkyshiw
         DAEfmRF3Pvn6Yvs3VJoj5g6CateP42NTOJR2gq4HSY+LQ9WgJsSV5srqBPsxuc1xAW8P
         AZYg==
X-Received: by 10.15.94.201 with SMTP id bb49mr6851166eeb.23.1377808782009;
        Thu, 29 Aug 2013 13:39:42 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id x47sm49167620eea.16.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 13:39:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233356>

During the review process of the previous commit (repack: rewrite the
shell script in C), Johannes Sixt proposed to retain any exit codes from
the sub-process, which makes it probably more obvious in case of failure.

As the commit before should behave as close to the original shell
script, the proposed change is put in this extra commit.
The infrastructure however was already setup in the previous commit.
(Having a local 'ret' variable)

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0cc823d..2fb3b91 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -229,7 +229,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 
 	ret = start_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 
 	nr_packs = 0;
 	out = xfdopen(cmd.out, "r");
@@ -242,7 +242,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	fclose(out);
 	ret = finish_command(&cmd);
 	if (ret)
-		return 1;
+		return ret;
 	argv_array_clear(&cmd_args);
 
 	if (!nr_packs && !quiet)
-- 
1.8.4
