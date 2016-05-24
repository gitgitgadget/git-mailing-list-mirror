From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v9 1/3] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 25 May 2016 00:12:40 +0530
Message-ID: <20160524184242.7518-2-pranit.bauva@gmail.com>
References: <20160524184242.7518-1-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, gitster@pobox.com,
	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@gmail.com, sunshine@sunshineco.com,
	Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 20:46:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HLm-0004hJ-Oz
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbcEXSqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 14:46:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36108 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbcEXSqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 14:46:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id g132so2961810pfb.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 11:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Io2bJUC6V4Yn+RnWD62gVxocPYgf76kLJKneYY7zQmc=;
        b=X052ieyz5LrHntsUXi0FqxosNMTke/wOBC1sETt1u+0YDzBo3yIbcrZXee+c4uD+gU
         SLQWwUkUttwSICD8ejrBbPu37pA3JnVT9L9fsPoFg6Cde9QmupDgH51IelM2MdsrqgV+
         Ro6GibhCtnY/4/bgCFPyj7GytFF9zIptrfk7lUZVDjjFoKKZEB7iRaylcIVc5T6pouDz
         epj2PpOpHdgV3vSYclrhxK4idzsYcBkqYPBZkqdAzW3NVuSz96u3H1HetkDIR70EqMiR
         1jXKbegUFebQGX2h+lnHOhyndHwcfm29BvsPyO/JglT2S9jjwV3e1A71XZSc4ObczSP5
         AaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Io2bJUC6V4Yn+RnWD62gVxocPYgf76kLJKneYY7zQmc=;
        b=YoNEr5/dq+TKe7OEJzwXrR1ypQvUNr8fqUl62Iu0w0k/cZ23hV25vIkbdWkxbxv6dj
         UDzgfTwXTHuQqsSMUTcfVKsxRQC/oYvX1RV1Bd1SIhg034uUzvWXfmekMAaWeiOO3FZW
         JP8IWO+lWqJzm3LJ2AfAkKgP3GTTaj72i9xQI4EEouwOONY+xg2lOhTx3TrtdBaW62qX
         xWMqmYqbJa4g8eyD6dtroq1ocbFDQfwS++fqiqbeJ1i6JJ0lcQhUPoILnQ2VAdeThiay
         Bp2qUBO7gN5Veg0/XOY28NV/cWaDPDmTOoHs+K2IQvGJZwMKeJnCDbR7+PRSXqQbGKkv
         1Wcw==
X-Gm-Message-State: ALyK8tLI3GvhEjXpxxUHhiRm31RWsE8qkNvYR4d8YDt5KBFDE4qdR5ibd3fsjW4DvwGMpw==
X-Received: by 10.98.54.194 with SMTP id d185mr9207770pfa.34.1464115595756;
        Tue, 24 May 2016 11:46:35 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id u2sm6918859pan.45.2016.05.24.11.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 11:46:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160524184242.7518-1-pranit.bauva@gmail.com>
In-Reply-To: <20160524072124.2945-1-pranit.bauva@gmail.com>
References: <20160524072124.2945-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295517>

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..8111c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	enum { NEXT_ALL = 1 } cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &cmdmode,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (cmdmode) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", cmdmode);
+	}
+	return 0;
 }
-- 
2.8.3
