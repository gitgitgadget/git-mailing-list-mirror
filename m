From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv2 6/9] hash-object: Replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
Date: Wed, 31 Jul 2013 18:28:34 +0200
Message-ID: <1375288117-1576-7-git-send-email-stefanbeller@googlemail.com>
References: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZGp-00084w-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219Ab3GaQ2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:28:42 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:42865 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759951Ab3GaQ2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:28:36 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so467169eaj.26
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nZovwoPy7VGYo4k/gt3XNC0tBfzyTVfvQ33mxeVwTiU=;
        b=wNkAiX7D9JCNNDVraNCDxB+sh95CTQi+TXS8iGV9ii8fGM/Y8SRVc4/nUOlLWWeM1q
         Q03wQnlJHsAXB+9g6CycV09qjVbzp8doQ9ZRjq1u4bGY40NVvHCDoBXWXriHo52xD/YF
         OnhDCKtgDWxgChLXP6ofP4noPsQmG2MMn2l58Q+FaJmJI6nW7BdTptCXzYWGX2Jl61Yu
         qWX8xp5KmjBt2jBU5yb4xViiSMw6ADr2aIY5Y/7aCNmJts8HU1oRUxP8z8kBLTnxVYGh
         3hMUi2HVWHEAGvlzZfS6H7DlKynJn4QVs2un2LPvhfdDUqnKkLLsAalFQVE/LhIOEa4g
         N4/g==
X-Received: by 10.14.104.130 with SMTP id i2mr15607962eeg.120.1375288115171;
        Wed, 31 Jul 2013 09:28:35 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a4sm3767202eez.0.2013.07.31.09.28.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 09:28:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375288117-1576-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231424>

This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27). hash-object is a plumbing layer command, so better
not change the input/output behavior for now.

Unfortunately we have these lines relying on the count up mechanism of
OPT_BOOLEAN:

	if (hashstdin > 1)
		errstr = "Multiple --stdin arguments are not supported";

Maybe later, when the plumbing is refined (git 2.0?) we can drop that
errormessage and replace the OPT_COUNTUP by OPT_BOOL.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/hash-object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 4aea5bb..d7fcf4c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -71,7 +71,7 @@ static const char *vpath;
 static const struct option hash_object_options[] = {
 	OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
 	OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
-	OPT_BOOLEAN( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
+	OPT_COUNTUP( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
 	OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
 	OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 	OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
-- 
1.8.4.rc0.1.g8f6a3e5
