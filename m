From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/8] submodule config: Keep update strategy around
Date: Tue, 20 Oct 2015 15:43:49 -0700
Message-ID: <1445381030-23912-8-git-send-email-sbeller@google.com>
References: <1445381030-23912-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 00:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zofdy-00026B-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbbJTWoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:44:18 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36155 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754278AbbJTWoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:44:05 -0400
Received: by pacfv9 with SMTP id fv9so35147565pac.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zYXQfsvGxlmbhdIXw3aWwn51wMmsFGlL4jmBKrcBy6M=;
        b=WuwasSJp0SAEJw7ucwTpiDY0QxjLMOkNGPGtI9TnHd0iFWm+fNrfCFz9+y872MNH6n
         SntvBK7abn4JF7O2paIi3872mfrRK5pP4sNdjfi+6XxW5CO9xRKjDH+UtwOuWspmJ2Vy
         juSW0qds7Lg7zOK8pa6Ljxo59aL9IiSgpAtpNqS/uVkKMxq91HjIf4SIA+6BKgdtLCLE
         keDpZCL8Is/u16JsePp4fh0PpI9aUiTh1MlOiWvWx3oWKWKGYQgr1/+HBzqSfgp752Q3
         CF6ThmbFRdGsSyxv2/pbvQF0M9+X/EhpHu9KiPO/mF+oTlQZp12bnG5ScIQj+wvLYUoo
         CxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zYXQfsvGxlmbhdIXw3aWwn51wMmsFGlL4jmBKrcBy6M=;
        b=ZO8r56MiqgGVMjnb9IsDcSi4VJIS/mgnD+yEesOAZ6VRk4RzYk/WMzb43mOW1ykoDh
         izSz9FMjW4yUuSE6lueXGBI+CNObZAZCpSFP0hM4drzCF3xMqbAVDIL4vOX3RrWnQWs2
         jcxAy2GsUmCw2WuCcGHCbwbkwBSMmKifOg5L7ECpFOv3uAEyRKmdqOKVlX6gE3sDKoAm
         a8zU+4GdFFq34P32kHfP5i/DqIt7pYQ0UJX3UrxlessmsH+d2+gTx0r4+71XWqL0kitd
         +H2tUvhmPVwhuHhOfWD8Ahh7bqUvXTIztQqWJoLbXtcHqTdMrGwHkeS5Tjzo4AVyPJG6
         2r6w==
X-Gm-Message-State: ALoCoQkaGio1qcwWSGsTcuw/fylJHggwOcCs2vTP8xjcWWxGxjNzdSyMnZfjOnmbgkIfT4qyFAgU
X-Received: by 10.66.155.167 with SMTP id vx7mr6547368pab.127.1445381044696;
        Tue, 20 Oct 2015 15:44:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:95b6:4bcd:ddcd:b6a3])
        by smtp.gmail.com with ESMTPSA id dd4sm5596722pbb.52.2015.10.20.15.44.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Oct 2015 15:44:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.275.gbfc1651.dirty
In-Reply-To: <1445381030-23912-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279950>

We need the submodule update strategies in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This may conflict with origin/sb/submodule-config-parse, but only on a
syntactical level (this adds an else if {...} just after the refactoredd code).
There is no clash of functionality or semantics.

 submodule-config.c | 11 +++++++++++
 submodule-config.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 393de53..175bcbb 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -194,6 +194,7 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule->path = NULL;
 	submodule->url = NULL;
+	submodule->update = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -326,6 +327,16 @@ static int parse_config(const char *var, const char *value, void *data)
 		free((void *) submodule->url);
 		strbuf_addstr(&url, value);
 		submodule->url = strbuf_detach(&url, NULL);
+	} else if (!strcmp(item.buf, "update")) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->update != NULL)
+			warn_multiple_config(me->commit_sha1, submodule->name,
+					     "update");
+		else {
+			free((void *)submodule->update);
+			submodule->update = xstrdup(value);
+		}
 	}
 
 release_return:
diff --git a/submodule-config.h b/submodule-config.h
index 9061e4e..f9e2a29 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -14,6 +14,7 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
+	const char *update;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
-- 
2.5.0.275.gbfc1651.dirty
