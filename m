From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] submodule init: Write submodule registration to stderr
Date: Fri, 22 Jan 2016 16:31:39 -0800
Message-ID: <1453509103-16470-2-git-send-email-sbeller@google.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de,
	jrnieder@gmail.com, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 23 01:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMm7T-0006fU-Ra
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jan 2016 01:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbcAWAbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 19:31:52 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36689 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616AbcAWAbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 19:31:49 -0500
Received: by mail-pa0-f53.google.com with SMTP id yy13so49276130pab.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2016 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lpCY8xwrSkNb0CvReuafgPHuf8lt/VZTWQmROn+jXxY=;
        b=cOiJDUXycZ4zmgDcRWTIaGScnPXAnlh0Ac2T+dTG2/XoCGPAx0wgnJkbRY+V25sxQ3
         GXAOY4ME+OvbYtgPYS7mpDzmFZwx29kdQFB/a6VR5agHdxmvVM/QozzI2hvyX3qllClu
         0QWCEN01Tj4gJ3BGjylQ0QL49Wzp06tmyQhndCx7C75Rmglmopykoiv2rRsVwph6WvUV
         FD32PU1ZoU/rm5r7FDo2ysmJ/Zr9Gcsad4Ff/m9HmLojbLy7d5rY94B43BKZnMq9u6Bg
         HcTNn9jA11Bhj4vdEZHyF+vHHS6d5/naNiiI4jhs1y8KtoohykFbP4n5s1FegkMLNZr0
         uBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lpCY8xwrSkNb0CvReuafgPHuf8lt/VZTWQmROn+jXxY=;
        b=HYHGzpnT9iTxSR1VerZI0Qc7PEdUp4O4dUacxMGVNi4cjg/UKtkNxvx4M8D7fq7r95
         RT3kJzOX8HnQ2R/WECkdDn1E8KChkRdfQwX/xsyULygz4jmXN3siCp687llf/OvjjDYr
         3khlglU8xZr98j2wk1CUY4yKKNg3Wu5YZa195pab7VujAffoMQ1OlGhzH4FDS/szCCqn
         5FYenm8qzYHyPxa86vdeDv4shlx9i8ghj0SujDbzSCMtFXiqzkyUQzDQCzCjmSinevNa
         cfofs8FTnufop6KEV5Dvn0oFeBYaoJp6qalw0hSn40IPj4WGq+CoZ9/vgwkfEw++jTH3
         K0Hw==
X-Gm-Message-State: AG10YOT16tSfYURlIlfQjtl2tS4V/o+jVOlgor7vlJMIae1gXhf7myxwf1ZP+RZo2mSpVrfA
X-Received: by 10.66.100.228 with SMTP id fb4mr8475685pab.84.1453509108850;
        Fri, 22 Jan 2016 16:31:48 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:add1:48d1:6b77:ed16])
        by smtp.gmail.com with ESMTPSA id p70sm12150815pfi.96.2016.01.22.16.31.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Jan 2016 16:31:48 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.42.g77a36b9.dirty
In-Reply-To: <1453509103-16470-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284611>

The registration of the submodule will be reported to stderr, as that is
consistent with the rest of progress reporting within Git.

This helps us in a later patch when we want to reuse the
init_submodule function in update_clone whose stdout will be piped
to shell which reads parameters off stdout in a very specific way.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c9b0c05..05c18a3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -267,7 +267,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 			die(_("Failed to register url for submodule path '%s'"),
 			    displaypath);
 		if (!quiet)
-			printf(_("Submodule '%s' (%s) registered for path '%s'\n"),
+			fprintf(stderr, _("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 		free(url);
 	}
-- 
2.7.0.rc0.42.g77a36b9.dirty
