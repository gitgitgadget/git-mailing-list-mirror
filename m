From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 07/11] dir: add remove_untracked_cache()
Date: Wed, 20 Jan 2016 10:59:40 +0100
Message-ID: <1453283984-8979-8-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpew-0007wT-7j
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929AbcATKG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:29 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34864 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758217AbcATKGS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:18 -0500
Received: by mail-wm0-f43.google.com with SMTP id r129so124172810wmr.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rsqkoBdPOCsyw559v2vh2h/5iUPOMCqPIlckVJ5Xj04=;
        b=fbpbbDiH4Hpywk00vcCbilSYyI8iRKnOcdQn0AoMz73pPIZp5tm5iRpDvI4oGS/aTf
         4dkbIbZWFPi3gJniw+7n3cKTL/BywFjy3pTeFMPE6sq49zyVDGb1JzxsxoZwFMoUa9yl
         3byk2a3NzjsrKD3bfBh4WqbZ9kzUbcaRD3JSJCBTNriIhrIe6C3LAmLzAK+QXdVnUJIx
         C50sImKn4BimGt+XGUOQU6sb/om83/ZBYbiPDwfniLh3xs3+4MxpocG1274n+MY+O8Am
         1673EGvECODzr0I74GnuuJggLPDkg2Viz7EpUACBPed3vACSkPZS68Y2xC+EtVRILyF4
         Eu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rsqkoBdPOCsyw559v2vh2h/5iUPOMCqPIlckVJ5Xj04=;
        b=Uh6sr74diVImiOjNHQz85QrikfUXxW+Y1BeESJ6r1n4R8V1MAbDE2uEZJOfmJCHBdR
         hWAIMYQNJbfiXZezIM3fuc7yhEk/qVO23BtNVf1T0J52mTvVs3HtSEiPrn/4udUbWh6m
         mi8BdQM9KO7+LzngX8RRXNbPr2DdoFzaLITlA+wMOxHoM8SBRfSH9StyWZNxkCuNYLEL
         5n6BIHpR3WV0kWMA1kTtMp1GowD52EZ9an/Ph5INird2LB3OaFl3yWkmjJ7BA/nHusD/
         Uiip/O6snJbGYEh3mjfenI8Sd1NumpQy5KnZ1cgr1bF1RYN1RoqXmhVNllKIJdbsHUSM
         IudA==
X-Gm-Message-State: ALoCoQlZ1HK09/aMH21UwRBA3lWKVfqv8rd8OsJbdYU49QwgDIGx8zy0JpRGNydl2mki6OWEc1A7vMX1V7DFxeDF6gkG0+f2Kw==
X-Received: by 10.194.175.104 with SMTP id bz8mr33197696wjc.8.1453284377384;
        Wed, 20 Jan 2016 02:06:17 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:16 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284442>

Factor out code into remove_untracked_cache(), which will be used
in a later commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 6 +-----
 dir.c                  | 9 +++++++++
 dir.h                  | 1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f8630c..d90154c 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1126,11 +1126,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 	} else if (untracked_cache == UC_DISABLE) {
-		if (the_index.untracked) {
-			free_untracked_cache(the_index.untracked);
-			the_index.untracked = NULL;
-			the_index.cache_changed |= UNTRACKED_CHANGED;
-		}
+		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
 	}
 
diff --git a/dir.c b/dir.c
index 31eae37..0d069c9 100644
--- a/dir.c
+++ b/dir.c
@@ -1956,6 +1956,15 @@ void add_untracked_cache(struct index_state *istate)
 	istate->cache_changed |= UNTRACKED_CHANGED;
 }
 
+void remove_untracked_cache(struct index_state *istate)
+{
+	if (istate->untracked) {
+		free_untracked_cache(istate->untracked);
+		istate->untracked = NULL;
+		istate->cache_changed |= UNTRACKED_CHANGED;
+	}
+}
+
 static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
 						      int base_len,
 						      const struct pathspec *pathspec)
diff --git a/dir.h b/dir.h
index cfd3636..a3dacdb 100644
--- a/dir.h
+++ b/dir.h
@@ -309,4 +309,5 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
 void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(struct index_state *istate);
+void remove_untracked_cache(struct index_state *istate);
 #endif
-- 
2.7.0.36.g6be5eef
