From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 31/48] builtin/apply: move 'has_include' global into 'struct apply_state'
Date: Wed,  9 Mar 2016 18:48:59 +0100
Message-ID: <1457545756-20616-32-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:53:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiIw-00006C-Up
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbcCIRxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:53:38 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37183 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933746AbcCIRxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:53:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id p65so81825529wmp.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hD0nPK5vCzf5DUOfmfEK/1BJ56wD0dP4EUI+os6Xu3U=;
        b=DSMuEPpqmcwgF7RChlH5oizkVeroXw2yLAvUKk2nM5/QEfof/zKcrJ97Q51Aoki8Tu
         jgh3sjVMMzdkdk6DRi4pI72j8omvny6pelGx5qWxuD8xJBaQVDsH7UJvEVzjVCubSwp8
         0d37+Yihq3IZCWAAP/Nt16P2SGvDtjlbFd6akoNGi6/aTYtkjdS3ICaFeURbmPT4NzxT
         ZBVcs6I5GIwvNwNnVFfo/v2lfL7ti500sxL8T64js4kkatoIUuk6keV/AA+hAPV/7VOM
         O3UUNu6HKvjak7jPI7nvWQd0xBq+LPvgEQHf0trlsiktPzD4T4fcFh7ZFv12akRoNQI+
         jUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hD0nPK5vCzf5DUOfmfEK/1BJ56wD0dP4EUI+os6Xu3U=;
        b=ZdQ7MKKZwFhNQa82BRY2hNsTNElJtmb0pUt2lHxFQLGPv4mc9BrPkwDItNutQsylBg
         SG1yqOkDQww5zTQ5xjUeXaR+SBPMskz8F6UswlUWBcTrGXHbAMEjJSQCnVseJqROmaDY
         5eiKNHjQ+GDu1XOOtZQFSkJzLcvijVmxbLD+qae4cYtbdImu+d1tNJ8+YkfYYANmF3AE
         LkBtzgczHpPbL0tvq8muVs71KrKC/nrBcTX4VAHVZ5I/ZeW+yRuEBzonMkDqLrLkUc5F
         JZey3mtXFTvGDdM3CCED1nsZlqlJI5ZkSIGTg77GOloLsHIQIBb93h83e4EgN1zV4tIs
         6eDw==
X-Gm-Message-State: AD7BkJK99yc5ulQ/xYw1C9CgVOoUktVk241QTFssE02EKbz3H8uo9/aZOHWsjs8WGDW4uA==
X-Received: by 10.28.10.149 with SMTP id 143mr25733448wmk.38.1457546002919;
        Wed, 09 Mar 2016 09:53:22 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:53:22 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288519>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 186e451..fa2940d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -73,6 +73,7 @@ struct apply_state {
 	const char *patch_input_file;
 
 	struct string_list limit_by_name;
+	int has_include;
 };
 
 static int p_value = 1;
@@ -1981,7 +1982,6 @@ static void prefix_patch(struct apply_state *state, struct patch *p)
  * include/exclude
  */
 
-static int has_include;
 static void add_name_limit(struct apply_state *state,
 			   const char *name,
 			   int exclude)
@@ -2017,7 +2017,7 @@ static int use_patch(struct apply_state *state, struct patch *p)
 	 * not used.  Otherwise, we saw bunch of exclude rules (or none)
 	 * and such a path is used.
 	 */
-	return !has_include;
+	return !state->has_include;
 }
 
 
@@ -4547,7 +4547,7 @@ static int option_parse_include(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	add_name_limit(state, arg, 0);
-	has_include = 1;
+	state->has_include = 1;
 	return 0;
 }
 
-- 
2.8.0.rc1.49.gca61272
