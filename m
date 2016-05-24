From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 07/49] builtin/apply: move 'read_stdin' global into cmd_apply()
Date: Tue, 24 May 2016 10:10:44 +0200
Message-ID: <20160524081126.16973-8-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Rk-0000iU-An
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbcEXIME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35118 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbcEXIL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id f75so3652512wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OYFldOgVeFqZezrtCrIw63QQO8ZD7ORq2W50wCoNDYw=;
        b=SHDuhoXFsWojl/lJsZYeHmGwmBit6el5vs0onuWONFw0WMKeVLavV0JPubhrOjFx5I
         rbyxkaMGnmPIf+c4D62mlX8z0RbR98yvboo1Vf6p+wtwtaR7qvrHRhnIYfL0dpGw2cmR
         k0xwXaDwqE5SMn7ewwFGSuqOpTNz/EVbnfmM6xfshcoG07A+zfXMVF/QbvrgDB8ptg9f
         OFc7No51diemSqtZfk5JWZgzmofRcSfTWIN+p9TawMQCodn8kF4WQ2lSQA4bBZkKMpkJ
         j4mV94TbYS7r0F97zn7QyXGrxp16VVFYHxxvCzCqiAJ4GcI3j4jTJq4me/yVFJlH0U9w
         W+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OYFldOgVeFqZezrtCrIw63QQO8ZD7ORq2W50wCoNDYw=;
        b=dsGXuxbtYOzKudVeVnyq2dQlGNiQ11r4oga7SEciBy2RAXg32syCdduu+a9w1J7Bag
         mG7DwIViVNyS/v4xQmVxawVEwqQdnqoo9tGpWuxXutGt+TCX/jYfO33dJ29VZDMKBYe6
         LCTMAR1J5453CUDhOs68G2APK9othp4kA80n6pN41EBPo7Bozc4RkAIBa47bemKAndtw
         znvdrnwJldctcwEFQu6HVcv99Ht1N0lXxYgTm5hLlArTeQrGeh7KXahkMFm9C/Ivvc6t
         MQq5vBCB06ZDxpUBxQ1PN3JvFTVzw4gtq1Z0ZRCnB0oYg2NRZrZi3czmLMMyAAACCm0T
         Sd8A==
X-Gm-Message-State: ALyK8tIUJu2p1V3oWCONwHAzTCFPp+GBp5Mbmfs/CR9RTB5llGqF2wMbBZJUKtvLJZwr3g==
X-Received: by 10.28.109.205 with SMTP id b74mr12053178wmi.84.1464077515762;
        Tue, 24 May 2016 01:11:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:55 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295431>

The 'read_stdin' variable doesn't need to be static and global to the
file. It can be local to cmd_apply(), so let's move it there.

This will make it easier to libify the apply functionality.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 5a1d65a..c911e4e 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -78,7 +78,6 @@ static enum ws_ignore {
 
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
-static int read_stdin = 1;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4517,6 +4516,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
+	int read_stdin = 1;
 
 	const char *whitespace_option = NULL;
 
-- 
2.8.3.443.gaeee61e
