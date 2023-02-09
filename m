Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66F3C636D6
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBIQqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBIQqY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:46:24 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ABC5D1FE
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:46:23 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b5so3460746plz.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yb7g2LPXpbyuLShQEPL0rWfOnMk7eB6qYnPJc3orDAM=;
        b=gkOG49MFojqejkR5xsu7mJLzCznx5PQSEj1ci09ACfVMgqriOfFWY5obI5qgqS1mdW
         9Zdp4638on9h0c/2fSErx1Rv4/Mfbn/lEU44p1sZ79IuA1NU6FPRk9BMTGfQc8QzX0E5
         beP4YeQfIlP8jbPO0X10yKuqAuLGaPiWhKxmx2/Hy4YMe8cWVDVRCl/S85l1N96+NUby
         6XM1r39XVMm1ViGJnjeSvoS4l0HYBiy6NW3Yen2hkVsZ0LlNj0wRAOrHe8vaGoDsdBjG
         MwaDgl1NR/4zCb2shv4t9eReihzXJ1A/vRGSzgSdFCuv/hvzLzi70v/rPN5V549I0SuF
         6uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb7g2LPXpbyuLShQEPL0rWfOnMk7eB6qYnPJc3orDAM=;
        b=SW0B3YoUOoLddRyIBIRi9b9vg5T/Qt/1V/yCwFYAqYit1lRr24SlgepDe+70OJLiy8
         WBJyHl8xZYI4uSaCWKTmztP0fpG5BwKPuDsqXErzq8meunDSd5dNMfiVXMsA3VBtqWQd
         ANgnl0dbRJNOr2Be56kSvzWRYSffe9zPQvyzemKboqD7aJykuGLbulxBybC4pxZZDgnd
         OJnxyxeyqGsRpJY6kQaHZLN7rJeC6m0axNjNHU0Sr3e0DN8qwlJESVmR1RkytsWxlQzX
         y/x0SCxJU+9QaxI6o6Bg7uX4so0IJqFz5FA54WZBLEnn7cVNba1rH5fUp9ShUd3/7TGC
         bZqw==
X-Gm-Message-State: AO0yUKVDAmenk+J7Xe+hGPRqxFhTMSV1X3tENSgwF0K23IT9Hro8gUXz
        z9HX9FeL12g3EX6+Z4Gd3s60Ja5UIwE=
X-Google-Smtp-Source: AK7set+02sqOmGmVrdpExkbQwKZHduWtCo8HpDRAnBxOYCGh6qyomVk8rFCfW5RdIFaas0lQ9T4a+g==
X-Received: by 2002:a17:90a:6002:b0:230:b0e3:9cad with SMTP id y2-20020a17090a600200b00230b0e39cadmr4847830pji.23.1675961182250;
        Thu, 09 Feb 2023 08:46:22 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:20dd:94a9:fa14:fe37:b9ef])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b0019900a6de6dsm1735686pll.88.2023.02.09.08.46.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 09 Feb 2023 08:46:21 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     git@vger.kernel.org
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [GSoC][PATCH] {apply,alias}: convert pre-processor macros to enums
Date:   Thu,  9 Feb 2023 22:15:52 +0530
Message-Id: <20230209164552.8971-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Groups related #define macros into enums in apply.c and alias.c .
The changed #define macros are related constants, so it makes sense to group them.
This also makes debugging easier, as modern debuggers can identify enum constants and list them accordingly.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>

vinayakdsci (1):
  Change #define to enum in apply.c and alias.c

 alias.c | 12 +++++++++---
 apply.c | 19 +++++++++++++++----
 2 files changed, 24 insertions(+), 7 deletions(-)


diff --git a/alias.c b/alias.c
index 00abde0817..61ef2c0c54 100644
--- a/alias.c
+++ b/alias.c
@@ -44,9 +44,15 @@ void list_aliases(struct string_list *list)
 	read_early_config(config_alias_cb, &data);
 }
 
-#define SPLIT_CMDLINE_BAD_ENDING 1
-#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
-#define SPLIT_CMDLINE_ARGC_OVERFLOW 3
+/* #define SPLIT_CMDLINE_BAD_ENDING 1 */
+/* #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2 */
+/* #define SPLIT_CMDLINE_ARGC_OVERFLOW 3 */
+enum split_cmdline_error {
+	SPLIT_CMDLINE_BAD_ENDING = 1,
+	SPLIT_CMDLINE_UNCLOSED_QUOTE,
+	SPLIT_CMDLINE_ARGC_OVERFLOW
+};
+
 static const char *split_cmdline_errors[] = {
 	N_("cmdline ends with \\"),
 	N_("unclosed quote"),
diff --git a/apply.c b/apply.c
index 5eec433583..1e9cf2f4f2 100644
--- a/apply.c
+++ b/apply.c
@@ -205,8 +205,13 @@ struct fragment {
  * or deflated "literal".
  */
 #define binary_patch_method leading
-#define BINARY_DELTA_DEFLATED	1
-#define BINARY_LITERAL_DEFLATED 2
+/* #define BINARY_DELTA_DEFLATED   1 */
+/* #define BINARY_LITERAL_DEFLATED 2 */
+
+enum binary_type_deflated {
+	BINARY_DELTA_DEFLATED = 1,
+	BINARY_LITERAL_DEFLATED
+};
 
 static void free_fragment_list(struct fragment *list)
 {
@@ -918,8 +923,14 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
  * their names against any previous information, just
  * to make sure..
  */
-#define DIFF_OLD_NAME 0
-#define DIFF_NEW_NAME 1
+
+/* #define DIFF_OLD_NAME 0 */
+/* #define DIFF_NEW_NAME 1 */
+
+enum diff_name {
+	DIFF_OLD_NAME = 0,
+	DIFF_NEW_NAME
+};
 
 static int gitdiff_verify_name(struct gitdiff_data *state,
 			       const char *line,
-- 
2.39.1


