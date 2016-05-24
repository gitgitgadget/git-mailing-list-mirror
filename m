From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 31/49] builtin/apply: move 'has_include' global into 'struct apply_state'
Date: Tue, 24 May 2016 10:11:08 +0200
Message-ID: <20160524081126.16973-32-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue May 24 10:14:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Tj-0001WB-Tu
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741AbcEXIOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:14:06 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35705 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656AbcEXIM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:12:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id f75so3656524wmf.2
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+oqLkJTm8oH6q9JRGVPjz9XCjxLqLX5RWX9foYnlmw=;
        b=vnzzy36Eq4p4rXeKWC47/2s/nGsvvvK5JLddnwjmxmeif2h4xmQZ30YI5ZkhU8x55i
         us9OiwejxmLUD2eANGuc2pvVmpre/IWiD+9UDFhh5EysHN6qhIdTl63DsSAL1vl0Su9K
         Hy3+JmochpjJRPO5atTgLO57R/QpSjDiZAfHrudXbOQnnXbDKmv9Y617LKRZknaYvwTP
         WgQ8TNFl1MA9S8IJWqiYHRWdqbyb+JhaB8U/kUMuMwWlUohlYc4wxQ3+Ll0TBTMlBW64
         9GXdwmIRXeh6cjVQ3Cu1WKsPFNqi2DK1Rqz2wMMe3UbIep331KIFn32kgRftYrIKiqSp
         Dd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+oqLkJTm8oH6q9JRGVPjz9XCjxLqLX5RWX9foYnlmw=;
        b=IVrjHdNT/nP29LhLjZGpGv2O+SoZEsH93O3XkjsE5lkSB69lSI5GBkf386kTwr7Zvi
         s8r52SzynhgZi6tFXOxYTno8cvq4/LnQuIzEWFSESU+AgRV0NMJyLg3d/V/rEc3X8lrA
         VgKXqJNrwmpq9dUxYhSA21gHhyarnido1S+fg0CD9vLkXWL7bTk7HF2pEGJV8HzQrFut
         IzDulQRqK1jVYMF3vKQ+zc491JkRGHsH9x5zcIHjVep3Svluy5gGruTeLJo7HBui6H3y
         GKxpXmhFsO76g0uA77sFlMOdpbYCk0Ky9xdjdcLB4AVQKXE7Cx1997cRR8SkTcwkrTDj
         EZIQ==
X-Gm-Message-State: AOPr4FV7kCdB48A6UuAFJD6KHXAQ4aGtDqK1mU2egbcVv5/0l6QIcTLiGkka99kFHsgPyw==
X-Received: by 10.28.11.143 with SMTP id 137mr20297824wml.92.1464077547766;
        Tue, 24 May 2016 01:12:27 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:12:27 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295455>

To libify the apply functionality the 'has_include' variable should
not be static and global to the file. Let's move it into
'struct apply_state'.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 0e3de17..ebbc711 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -55,6 +55,7 @@ struct apply_state {
 
 	/* Exclude and include path parameters */
 	struct string_list limit_by_name;
+	int has_include;
 };
 
 static int newfd = -1;
@@ -1961,7 +1962,6 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static int has_include;
 static void add_name_limit(struct apply_state *state,
 			   const char *name,
 			   int exclude)
@@ -1997,7 +1997,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
 	 * and such a path is used.
 	 */
-	return !has_include;
+	return !state->has_include;
 }
 
 
@@ -4534,7 +4534,7 @@ static int option_parse_include(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
-	has_include = 1;
+	state->has_include = 1;
 	return 0;
 }
 
-- 
2.8.3.443.gaeee61e
