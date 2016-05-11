From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 06/94] builtin/apply: move 'options' variable into cmd_apply()
Date: Wed, 11 May 2016 15:16:17 +0200
Message-ID: <20160511131745.2914-7-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:18:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U2Q-0001rb-6W
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751882AbcEKNSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:18:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35098 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbcEKNSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:18:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id e201so9399472wme.2
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ieFX870MI9Zf1GAuLKl59etfYddJtexAAQmUleUKvOo=;
        b=zSX3GmfsvbJzfA2khrFBc1yqrmBuzOYJXHpxCXJh3ZIyXQg/BJ3GsxEJ74kGvxakzK
         oqhje50bqj8/J3qrmoSpWmYF3yHTP4O+ljDvCuLPCmWqDteq4YsAop9cLke+N/f1IEyi
         Y0BO/2ZXlIkMVW2c4gFgoPp/rewzTGZnUqbkU+7f9rsmAouW4d4C1mQjpZ+eLvB9zcvE
         o+9o0Xc0sTcoKmhLsUMzIDGysNnn+JWISenZfFF8Qw/VKgpQuOn2M/vBtdagG4HFRjrD
         kbhDlcS8tShOopMSIgKfQgxUQ12UGULAtOTQSRbx/cdd15uMiq6v2oRf8GixZTAQUyS+
         nWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ieFX870MI9Zf1GAuLKl59etfYddJtexAAQmUleUKvOo=;
        b=eJTXga/nnj6HLCE1LTiIECBpAnTjHZ2ElgTQ0z/txsFbLRJjcZvCcZnOWYjP0y0a5N
         id//FdNSzGzaBqFA6+pg3f1cXgosyqFsSgbu/p+5GIJXRfelz+tVB5S8GC4z5CRqwgBv
         k3BgCFiXrsWmPFs4ftsBuDrQeFKBMh9z52kRog5Jvs6OaxICSTp7izTtPe8gDrQ5cWXo
         qwkoDp8intHR+aG6DoK3yRtnaT7pCc0JHLAtx+p1+HxFXOLbxLsK3Zqig8OTLM4oXTZs
         G010KuUhP1stjy4EAZdC8K02q+b/Q18U45Nl3fvKvSotjF/VJwFG5Js0v08XzvHyNJqw
         R2Mw==
X-Gm-Message-State: AOPr4FU4QW4RnpDNbfJMHkvmG6Jp0uaCDWGJlQsNctck1Hv/V1xKHBmJDE+O8XO92chhpA==
X-Received: by 10.194.162.130 with SMTP id ya2mr3727952wjb.141.1462972718424;
        Wed, 11 May 2016 06:18:38 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:18:37 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294253>

The 'options' variable doesn't need to be static and global to the
file. It can be local to cmd_apply(), so let's move it there.

This will make it easier to libify the apply functionality.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7bab466..5a1d65a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -79,7 +79,6 @@ static enum ws_ignore {
 static const char *patch_input_file;
 static struct strbuf root = STRBUF_INIT;
 static int read_stdin = 1;
-static int options;
 
 static void parse_whitespace_option(const char *option)
 {
@@ -4517,6 +4516,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int errs = 0;
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
+	int options = 0;
 
 	const char *whitespace_option = NULL;
 
-- 
2.8.2.490.g3dabe57
