From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 6/9] hash-object: Replace stdin parsing OPT_BOOLEAN by OPT_COUNTUP
Date: Sat,  3 Aug 2013 13:51:23 +0200
Message-ID: <1375530686-2309-7-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:51:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aN4-0005cc-Lz
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab3HCLvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:21 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:41524 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3HCLvR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:17 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so768558eek.40
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=aSdFyx7XvLlnx4TVFh69iuP6EMxogl2wnTgXFglRE30=;
        b=nXEVmmMaFicZFFjlvpXeMrTReIZVX68wn88c8lK1bMlKVcNqNeLihaEG7cP+EngOHM
         2NAECajpiDN8AXaLiPBj8E8hM5tdX8GT7vVR0aSnwr6BT6fnUJh00Pp8ObJX1ialjmY5
         2lWu/XbdsoOvekZAUNVMENIIcROudj+IbbpycqHtrTKs0D0I0oWd0FfwbxKU/8+neA1n
         Co/lnpPsxr6b0hoXSux5uYON3QugBg3iQ53PIxmU8PBuY25T5TKieUmSwLS9By6ROU8+
         F5TDJnfaWwbA1GFrCWcO45d0Ap1UkCjZ7Rvk9vkeKjNfVFT357KEZRmT4jDtXfFIFT1y
         KbgA==
X-Received: by 10.14.101.13 with SMTP id a13mr9330911eeg.86.1375530675856;
        Sat, 03 Aug 2013 04:51:15 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n5sm18883792eed.9.2013.08.03.04.51.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231584>

This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27). hash-object is a plumbing layer command, so better
not change the input/output behavior for now.

Unfortunately we have these lines relying on the count up mechanism of
OPT_BOOLEAN:

	if (hashstdin > 1)
		errstr = "Multiple --stdin arguments are not supported";

Maybe later, when the plumbing is refined (git 2.0?), we can drop that
error message and replace the OPT_COUNTUP by OPT_BOOL.

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
1.8.4.rc0.16.g7fca822.dirty
