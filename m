From: Pete Harlan <pchpublic88@gmail.com>
Subject: [PATCH] config --global --edit: generate correct .gitconfig template
Date: Wed,  6 May 2015 10:41:17 -0700
Message-ID: <1430934077-20724-1-git-send-email-pchpublic88@gmail.com>
Cc: Pete Harlan <pchpublic88@gmail.com>
To: git@vger.kernel.org, Matthieu.Moy@imag.fr
X-From: git-owner@vger.kernel.org Wed May 06 19:43:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3Lo-0002px-LD
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbEFRnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:43:05 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36825 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbEFRnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:43:03 -0400
Received: by pabsx10 with SMTP id sx10so15531273pab.3
        for <git@vger.kernel.org>; Wed, 06 May 2015 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ShEv+f2voSiDfYkABxAog1WJhvPfP9DAybJZO+C+4zA=;
        b=tsaGtblT4k7VRK9dZHWiVSMm3SeOX6YNs1i7dvv/fKwya0m5rmsuwuS/eXQTsO7zEH
         OvgH9Dbc3QoTbr0OolBN7o5VdU53c29EhGXFM58Hea5uPzKNPpqjdoT+cMK5On1nQqjb
         TD52Iq0FfWucvZlLtqANrNdP3txosv8bKXgOAV4qH6WfaHFywQ91qkfcTJy4ZzCUEtbL
         j1DqWJmeZXzhFrlHa/E/7Vd3SsrjOyKFed91m0SjFXty3QQaXqDMkRUfUCL59g0mmAUb
         0hdqzZr+RFISly54+V8NYj0Gxk3fJ7dVlnX6fXbNqX1qMOO0S7VjcqQnHlnS+r3Y0oI6
         H6Bg==
X-Received: by 10.66.196.163 with SMTP id in3mr63116356pac.70.1430934183351;
        Wed, 06 May 2015 10:43:03 -0700 (PDT)
Received: from petedev.local ([199.87.14.15])
        by mx.google.com with ESMTPSA id ry9sm2510290pab.2.2015.05.06.10.43.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2015 10:43:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268474>

When the user asks to edit an empty .gitconfig file, we learned to
generate a default version in 9830534e (config --global --edit: create
a template file if needed, 2014-07-25), but the generated config
mistakenly set core.user and core.email instead of user.name and
user.email.  Fix this.

Signed-off-by: Pete Harlan <pchpublic88@gmail.com>
---

I ran up against this yesterday and it is easy enough to fix, but I
don't have time right now to write tests for it.

 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index d32c532..bfd3016 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -455,9 +455,9 @@ static char *default_user_config(void)
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf,
 		    _("# This is Git's per-user configuration file.\n"
-		      "[core]\n"
+		      "[user]\n"
 		      "# Please adapt and uncomment the following lines:\n"
-		      "#	user = %s\n"
+		      "#	name = %s\n"
 		      "#	email = %s\n"),
 		    ident_default_name(),
 		    ident_default_email());
-- 
2.4.0.rc3
