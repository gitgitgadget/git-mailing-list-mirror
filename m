From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 11/15] diff: ignore submodules excluded by groups
Date: Tue, 26 Apr 2016 13:50:29 -0700
Message-ID: <1461703833-10350-12-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9x4-0006iJ-1t
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbcDZUvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:51:03 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35797 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbcDZUvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:51:01 -0400
Received: by mail-pf0-f176.google.com with SMTP id n1so12602783pfn.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5WozHpwlhZF5SGR+tltJXpQeS/rc2k5o/+GDioyFwk=;
        b=EUwW9BDaITYGJphKa4N3mwcRHmPz2B4oK9lqA7RpYgljGLmaz+EASDWZomBoM08pY8
         LtF9mM9eXK7Vr0LhgJ2ECFlGVyyMiPOCVuBFbmrMSj1R4q3BxXbymLuwVwSH1jljmIGM
         Mw6+bBlNbxIhJhhjOVeh69v/F4foio5nKJat1qxBAG0yYVapBORKWUEGEtNEmOrzRj9w
         aEBVZGqOV2uV2dFmIEB0xJJSk7diBSq3IIPd9GT6IS294l+JrHui1FcpPmzxLi3fBugb
         QIDNZHCEXIXyYGJ0bL/eWGVCRPy485kXPGNo5JH3IQ9gOEH1pvE2l+ttocCykbKzoWiD
         dqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5WozHpwlhZF5SGR+tltJXpQeS/rc2k5o/+GDioyFwk=;
        b=UGMxVxpW6bNfqzNxOgejjiUIXdq92K74Bp6pU0vzsqbgOtrrjRckuDlpMcuWO61lm+
         pq3csRHTkFhk6pdelijpkjlwPJDn7skhebhWf7sNmvY24VnXMVFUs9jH9aaT7gTUNPgm
         UW9TVEZpOB2IagK4NI7l/2nFZzPmkJSkASAw1Kr7r4k/Xqzc4nrT961zY4hXgDz2tELf
         GOi4VRZ39noZQIx/ZV/glOEkRkO4k0mF8IvOOotu5Jyaxt8QEexy1ohwifhkxuTnp0eu
         CGHlpvTpVPZKtE/RhDAkb52/Vdqu/W1+lYEcUIw2EzKm6tIwLvM4GCf+kJKkbFkc2jlg
         OIjg==
X-Gm-Message-State: AOPr4FVNxamyerJ5Avj38p5LV2dLcHjJG6AdFyM7lrHFFWSrMZwis5HsqrYmCCNZeJRjf16+
X-Received: by 10.98.32.13 with SMTP id g13mr6605434pfg.130.1461703860142;
        Tue, 26 Apr 2016 13:51:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id to9sm690647pab.27.2016.04.26.13.50.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292675>

We do not need to do anything special to initialize the `submodule_groups`
pointer as the diff options setup will fill in 0 by default.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 3 +++
 diff.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 059123c..5808d8a 100644
--- a/diff.c
+++ b/diff.c
@@ -4921,10 +4921,13 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 {
 	int ignored = 0;
 	unsigned orig_flags = options->flags;
+	const struct submodule *sub = submodule_from_path(null_sha1, path);
 	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
 		set_diffopt_flags_from_submodule_config(options, path);
 	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
 		ignored = 1;
+	if (!submodule_in_group(options->submodule_groups, sub))
+		ignored = 1;
 	options->flags = orig_flags;
 	return ignored;
 }
diff --git a/diff.h b/diff.h
index e7d68ed..7d499fb 100644
--- a/diff.h
+++ b/diff.h
@@ -178,6 +178,7 @@ struct diff_options {
 	void *output_prefix_data;
 
 	int diff_path_counter;
+	struct string_list *submodule_groups;
 };
 
 enum color_diff {
-- 
2.8.0.41.g8d9aeb3
