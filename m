From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 01/16] stringlist: add from_space_separated_string
Date: Mon,  1 Jun 2015 17:02:03 -0700
Message-ID: <1433203338-27493-2-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfH-0000iX-7l
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbFBACg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:36 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35966 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbbFBACc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:32 -0400
Received: by igbpi8 with SMTP id pi8so74553811igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rl45c8dM3EShTytLt/9lqYPWY1GXZPqMBA6KKeiYbBo=;
        b=H1R/KAVPedh+D1NrV8TsZZjMCfHEbGGO1MqXg3w+BqXZHBX6ykidgLEjyLXgpdL2L4
         NHQKexFFV38YwiBtARjlhn7g/eSJTMqMOawY6pLXzpWeEUn0SCTTZCs66Psn0e/tmsmh
         a2UeWQA+8mhFX3Ji6wyE8jvEHzUihabm2UnIie3H7D0Ny45QugGDEyY39iUL5IJYLF21
         vLh4c0iwPlZ0t74v0gniQnOAUeRleZKXG/d/1Kj2LOoANBxeKlHz4/9dVPlSBEOhzjBg
         2J6oZMzhos4jetFdVRSN5qE6PRxFkNqdVu4iJKuoTF1r7oU5ES6iO5DClqCPeGsKsIJJ
         UYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rl45c8dM3EShTytLt/9lqYPWY1GXZPqMBA6KKeiYbBo=;
        b=esBVKYzb8o7wI27naCanH/gimIQ20HO56+OYuqQEO0ej/xoigDrTZkFFMj1X12kwQZ
         I5i8c6+TOItCqa8VSIyPjWBKhYvZ5nOV3kP9Pa+rxZCndN+rbmthxXQCpZ7Qv6MKre+5
         ksW7tAV8QHExRHnPaBDhxUufhcPAvLLV5QamNpSlwAcdmZPDGi0vk4lb+Zl9aFhSVU7C
         NOMKf0HATXuk8ltmpiGSMPcIBfhfFlHRpgRKgB6lhpSxx7O/WA70ttDwRaSsqdt0HzRs
         +XojcImva/8F7Oc6ZTRHdbUORQfBAKAFK6ZDTTgkrfIFYN9P8p80NWXjjosetN9NKOjp
         4W6w==
X-Gm-Message-State: ALoCoQnu40PVTIcqxPCPvt4p447VX5Gxqg7zd0n9DMUijJEn1Nh1DbhgQlag7u7c7pQe24NwJHt7
X-Received: by 10.43.173.70 with SMTP id ob6mr31930007icc.45.1433203352153;
        Mon, 01 Jun 2015 17:02:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id i4sm9098042igm.2.2015.06.01.17.02.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:31 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270489>

This function parses a space separated string into a string list.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 string-list.c | 12 ++++++++++++
 string-list.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/string-list.c b/string-list.c
index 2a32a3f..f71384f 100644
--- a/string-list.c
+++ b/string-list.c
@@ -7,6 +7,18 @@ void string_list_init(struct string_list *list, int strdup_strings)
 	list->strdup_strings = strdup_strings;
 }
 
+void from_space_separated_string(struct string_list *list, char *line)
+{
+	char *save_ptr;
+	const char delimiters[] = " \t\n";
+	const char *token = strtok_r(line, delimiters, &save_ptr);
+
+	while (token) {
+		string_list_append(list, xstrdup(token));
+		token = strtok_r(NULL, delimiters, &save_ptr);
+	}
+}
+
 /* if there is no exact match, point to the index where the entry could be
  * inserted */
 static int get_entry_index(const struct string_list *list, const char *string,
diff --git a/string-list.h b/string-list.h
index d3809a1..88c18e9 100644
--- a/string-list.h
+++ b/string-list.h
@@ -19,6 +19,7 @@ struct string_list {
 #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
 
 void string_list_init(struct string_list *list, int strdup_strings);
+void from_space_separated_string(struct string_list *list, char *line);
 
 void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
-- 
2.4.1.345.gab207b6.dirty
