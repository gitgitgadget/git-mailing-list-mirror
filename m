Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14701F453
	for <e@80x24.org>; Thu,  1 Nov 2018 03:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeKAMNv (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 08:13:51 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:45041 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeKAMNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 08:13:51 -0400
Received: by mail-wr1-f48.google.com with SMTP id d17-v6so18319460wre.11
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 20:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLXUi42CflH1XrIOMTJKddNo94ZM++YcUoiPOPnty1Q=;
        b=EIbyAmY2XU+p6/fGUiEUvSV+O4xK2yuOLbHzWY0XQdajY8TuZjz7xW4NJZyQEg/pJb
         fp9JNFfKeZWxFJnf+4+ZdVoCFN3ODHU0Z9kQ80Mkf3lkklN56lxnQSAosCIoO7bA3O/9
         S6cdVyX2WVhg7yaLv6SgDSAIaurhLEAdpJbZ19MpkBWWHP4ZowekVbsbTN/f7ktirOFI
         6qTcvT4EqIcGzEtCD+uhzzKdmCEdTGBMxXuoilBRl5hh5dJrcgyVh7G/v9DAKGgZNq7Z
         UUYRF7MJCT7OMzllSvhAFhsD7nPpy+BipqiRQkqC4yNh80GEiQjsjZr0510VMdGVftPH
         tz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=sLXUi42CflH1XrIOMTJKddNo94ZM++YcUoiPOPnty1Q=;
        b=RMoKZfLkrgv6Ek8jBJT7WVjMLudFakucWSdwbwsS99xanSNmS1z4z0CjVf49TuNzQ+
         2I0EikbuwVrv0+Qp3qUe1Wy9edtzaSo0OgnGmyN4z4pG/DZANXoVvP5ItgG4Z+ahtux4
         tws4i1EQciYlpcn9STORA811pHsZBbg3wNatpoN4i8FjGN8ns/nsPvlN4yYEqM5fS5q/
         f6dwCW1xyXN+4FhZtclyqg9KKunlQwGWU1cERKDiWSZgzJ8zWYhW3bf4qxxHZVoxP73G
         KC96LJJq4/keqrmz6pkgfvJhoxAxlkPXRhJ18RdImEEI70FcuW0VjK94BSETx/Mep59e
         eA2w==
X-Gm-Message-State: AGRZ1gJkAS45SHSE8YN/nkTOzXokkN88QIHMNCt685+E7IiDGextU7Cv
        w13uwgzy2w+O9/y+wX4ZV+Gi34l7y8o=
X-Google-Smtp-Source: AJdET5cBetQXVhmjASgPfya0KYMtolx8o35GPoI+ta/954jtCQ8Ry0zdDjhqSNob7MnpSA6n3orB0w==
X-Received: by 2002:a5d:664e:: with SMTP id f14-v6mr5156634wrw.218.1541041967384;
        Wed, 31 Oct 2018 20:12:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l70-v6sm51129183wma.0.2018.10.31.20.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 20:12:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4fixed 2/5] am: improve author-script error reporting
Date:   Thu,  1 Nov 2018 12:12:44 +0900
Message-Id: <20181101031245.185587-1-gitster@pobox.com>
X-Mailer: git-send-email 2.19.1-708-g4ede3d42df
In-Reply-To: <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
References: <xmqq7ehxv6v0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If there are errors in a user edited author-script there was no
indication of what was wrong. This commit adds some specific error messages
depending on the problem. It also relaxes the requirement that the
variables appear in a specific order in the file to match the behavior
of 'rebase --interactive'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c | 49 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f7f28a9dc..ffca4479d7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -270,8 +270,11 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 		struct string_list_item *item;
 		char *np;
 		char *cp = strchr(buf, '=');
-		if (!cp)
-			return -1;
+		if (!cp) {
+			np = strchrnul(buf, '\n');
+			return error(_("unable to parse '%.*s'"),
+				     (int) (np - buf), buf);
+		}
 		np = strchrnul(cp, '\n');
 		*cp++ = '\0';
 		item = string_list_append(list, buf);
@@ -280,7 +283,8 @@ static int parse_key_value_squoted(char *buf, struct string_list *list)
 		*np = '\0';
 		cp = sq_dequote(cp);
 		if (!cp)
-			return -1;
+			return error(_("unable to dequote value of '%s'"),
+				     item->string);
 		item->util = xstrdup(cp);
 	}
 	return 0;
@@ -308,6 +312,7 @@ static int read_author_script(struct am_state *state)
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list kv = STRING_LIST_INIT_DUP;
 	int retval = -1; /* assume failure */
+	int i, name_i = -2, email_i = -2, date_i = -2, err = 0;
 	int fd;
 
 	assert(!state->author_name);
@@ -326,14 +331,38 @@ static int read_author_script(struct am_state *state)
 	if (parse_key_value_squoted(buf.buf, &kv))
 		goto finish;
 
-	if (kv.nr != 3 ||
-	    strcmp(kv.items[0].string, "GIT_AUTHOR_NAME") ||
-	    strcmp(kv.items[1].string, "GIT_AUTHOR_EMAIL") ||
-	    strcmp(kv.items[2].string, "GIT_AUTHOR_DATE"))
+	for (i = 0; i < kv.nr; i++) {
+		if (!strcmp(kv.items[i].string, "GIT_AUTHOR_NAME")) {
+			if (name_i != -2)
+				name_i = error(_("'GIT_AUTHOR_NAME' already given"));
+			else
+				name_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_EMAIL")) {
+			if (email_i != -2)
+				email_i = error(_("'GIT_AUTHOR_EMAIL' already given"));
+			else
+				email_i = i;
+		} else if (!strcmp(kv.items[i].string, "GIT_AUTHOR_DATE")) {
+			if (date_i != -2)
+				date_i = error(_("'GIT_AUTHOR_DATE' already given"));
+			else
+				date_i = i;
+		} else {
+			err = error(_("unknown variable '%s'"),
+				    kv.items[i].string);
+		}
+	}
+	if (name_i == -2)
+		error(_("missing 'GIT_AUTHOR_NAME'"));
+	if (email_i == -2)
+		error(_("missing 'GIT_AUTHOR_EMAIL'"));
+	if (date_i == -2)
+		error(_("missing 'GIT_AUTHOR_DATE'"));
+	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	state->author_name = kv.items[0].util;
-	state->author_email = kv.items[1].util;
-	state->author_date = kv.items[2].util;
+	state->author_name = kv.items[name_i].util;
+	state->author_email = kv.items[email_i].util;
+	state->author_date = kv.items[date_i].util;
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
-- 
2.19.1-708-g4ede3d42df

