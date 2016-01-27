From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 07/11] dir: add remove_untracked_cache()
Date: Wed, 27 Jan 2016 07:58:03 +0100
Message-ID: <1453877887-11586-8-git-send-email-chriscool@tuxfamily.org>
References: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:05:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOKAY-0003in-OR
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbcA0HER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:04:17 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37511 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbcA0HDw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:52 -0500
Received: by mail-wm0-f44.google.com with SMTP id n5so11509259wmn.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4RUhsSYHXJ1tMZ/DXfoOSqfu7FSlrK2uG7OWRIJLCgk=;
        b=Idxda6MRdnNZn1Auwa3R35freWmKG2va0V5S9W94AtLQHtsmb3iEHvvdp2hwtt3Q2J
         Da+HajLd74GJcPB6VeXbJvF+9OZTlmJrgo7tRlzoYm1ymSqESdBHzMnYHZyl0yDLKYXD
         Jc6Q6nkEaabve3i+SAt2o5K4tR6AJtfFDjU9pxYouv2sP8ADaluAtGg8SDP6mDStImFG
         ZXpeTizh71kc3AJqNq0QicGswT4U0Ly3DtyIJQUXoYHuVbmskY4kBQxfF9S3Jnwd5kFq
         ecv/gQ2ygc6v+Xe42VgIifgXUFUdAgtZXdroToeYYeqSVFkiAL7LLbi2St8MkTDmH2+A
         egsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4RUhsSYHXJ1tMZ/DXfoOSqfu7FSlrK2uG7OWRIJLCgk=;
        b=G+Q9LGTMdJ8RLINexcg56FzdQ/eO+efnHLt3UIR+lMw3S16RqlazpsOJY4IkZyrbuJ
         Ic+oBVefFvyHsJQ5qlrhVS9meD9kCI6v7p6+0aG3Uhg9+Rrhfc+RqWKAa2FwjA6KcAkv
         joFMMhSYNu9VoW/MdiVto2/w9v78mPEkq4itDADDdodLK5El8FhZjGjGAitrz2Wb6rvP
         xYoS2aQWU+afwzhNQ/d6jSEP96vLupjHl8qfYeSUqOD1q/Zpjl/RIyibDRZVQm4FKovc
         vMpvQwNUH8kZlf9YMW7rclnW8rlR8ZsMBTC2pI2YggLk+kiMptS2ppixGR/9w9Uvp2CY
         yldQ==
X-Gm-Message-State: AG10YOSImkTUgAkjSm2+UruAtnylRmfNcPHcoJvXbl4NL71yb6+yxWZpOcGpYeXIv6tviA==
X-Received: by 10.28.146.145 with SMTP id u139mr27476786wmd.81.1453878231052;
        Tue, 26 Jan 2016 23:03:51 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:49 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
In-Reply-To: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284886>

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
index 8646b18..f27b8b9 100644
--- a/dir.c
+++ b/dir.c
@@ -1882,6 +1882,15 @@ void add_untracked_cache(struct index_state *istate)
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
2.7.0.181.g07d31f8
