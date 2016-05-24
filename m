From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 06/49] builtin/apply: move 'options' variable into cmd_apply()
Date: Tue, 24 May 2016 10:10:43 +0200
Message-ID: <20160524081126.16973-7-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:12:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Rc-0000fN-PF
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbcEXIMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35875 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbcEXIL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id q62so3635157wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=//aCk9ZfNrcOIlttgknL0wRNNIhN+W+QI5fJWMZdUx0=;
        b=ERXKfSJsUH518iJnhcIT79et1p7j+PeixHfe/cpsEWbIq5DtMg2KkcHV38hfttL7oa
         JQ+75zvpmPBi5hjs9ycOonU6h6625JVsJfaQqMKUCYCH8NX80eV1KFLDBQQsyFn51gmd
         NCSOS82biytKd2V9gYUsQbLotweHGXGlXT13rI7ZByHRNLZkuybeKDtURo2kXTXi4orx
         L+wqTp57B/q7yKoF5e3aaIPbEgk80hsNl0siGhCllQDDqUm1HXiqxLpw0Tdkt/Vb6sjf
         D0SDoAiLkAyvWvNPB/x+Z4QByLU/NpDm1hLM9GArAw7bZsP5DmKTFWw6d35ygCgsA5Ka
         FLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=//aCk9ZfNrcOIlttgknL0wRNNIhN+W+QI5fJWMZdUx0=;
        b=T3RktaYzyHh07qMC+SuOAHuUNKCgupurtm0SSW63GTPo2aP3H5BNbJa0cAUSPN3Qer
         zwCCGqSltuzYg0z9vhNqKG0CWsbLY1+iEU4qeSNAAqDcoRxj2TPb+cORBex96RSjVUHD
         TSL+cpZnK+XRM6Q/2aMri2YWzcGJH8sU61Np5NDbjVOjK7ArGw3gZohW64b0NDYQhkA9
         YkeNKOv0wP6YCaer7soB4VwSyF7nHS+IzVWxtmw3XcmftFAd48sU+qH6b6aegQWWj0UQ
         c0nZcUen45rpvPyKPZCJ91NBvIQB/e6GwS8iEwB0gQaKWovD4vXadG2oz3lEa0jSLKrQ
         uUCg==
X-Gm-Message-State: AOPr4FXGYRwmvBW4OhW3/tp6I3NsBuvsN6lOoivSX3uuZBK4oQIrLjXqYnx4U3oeNo8dyA==
X-Received: by 10.28.230.137 with SMTP id e9mr22809961wmi.0.1464077514533;
        Tue, 24 May 2016 01:11:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:53 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295427>

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
2.8.3.443.gaeee61e
