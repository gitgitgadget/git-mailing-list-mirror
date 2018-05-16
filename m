Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBDA1F406
	for <e@80x24.org>; Wed, 16 May 2018 23:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeEPXAF (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 19:00:05 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:37145 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbeEPXAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 19:00:01 -0400
Received: by mail-it0-f74.google.com with SMTP id o8-v6so5249694itf.2
        for <git@vger.kernel.org>; Wed, 16 May 2018 16:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=gdx0Dac8FQhR+NeMeuOq0ZbMe3Mp/XNZKDCl9PO0vSc=;
        b=QlSJzSrzvev0nQFLmeGmai4vpAguER0anHATNh8jbxZgfw//fUprrb5LedF36CG0Ee
         gYqMefKnE59oyu97vgfKTBfcd6MQs9/oWHqSbZtZZj3fxOvbbFEV7uMQGzKsRTs3N05g
         ni3hLpjyCbrt5usBGWb3QFq7q9jgFNouf7YUVAHiE00+74NUyfGi5YBvUB51XInlFS8T
         MkMi/tXW5kE9pEKzx45st+7lhGx3FQvMIg7Z1K/QtHe0akQ9Fo/EJ/+fx9vWpCJ1zHik
         Vw9oB99SEoeNR/K0CpW/HLm4Kl2J2jwT/rzND0EUnv6nTPiyrrZs6d4Rw7zBIqjnvzPN
         OZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=gdx0Dac8FQhR+NeMeuOq0ZbMe3Mp/XNZKDCl9PO0vSc=;
        b=ge6GM1oBbLFbyAGwvROM2oWVjhV++lbFA/sj92voJf+fcKl1oVvznDb9TUix7Suxfr
         YCbJMSuEYd01DFaLDyCJ1QFYIJmerhPGMw7EtUnNP0wyb09iRFSmIrX4ewKCTUh63Gif
         2Ferdc+CjyhC+N1FhBvTkI17M6BP1dhuhFYbbRs4qt5MebY6J6zjvdcy6z3gtCb7wXnJ
         njcDxf5OQZvQ+Kp8CYQ7piMWRTJL79GljUh5SwTJoUdLrzjBiq/+8EXAscKYQK1pTp/T
         uCl2ozr+60ChzfuFcqfgX4IJJ4MgqzasgKOtTV2/RgfRNv51QPINjv8pn0v8z1E/jCjm
         zbGA==
X-Gm-Message-State: ALKqPwds+1crLYEZRrXbzvsxBhg0bbOGZRvb1g6T2Ppi5MV3H0TDPl7I
        TO/KehfNQBzfthb/fR8jfYNGnuqvoJXTP2huv6icuAwkpzaiUzTN3FxGH+sLIZ7OHW0nMAcTFxX
        OwqtBaMP8c0gaTp+zENRp4qM5vVq2kgG2J79iJSy6neW54Q7W3McTdngQ+g==
X-Google-Smtp-Source: AB8JxZoPzpi4U2IGrD30QvgvcWIapnQOIgR1mm3PFLoiAmZSSdCSBAGnaFxX2ZXDi3EJv++nuuKsJNnOHzo=
MIME-Version: 1.0
X-Received: by 2002:a24:ac52:: with SMTP id m18-v6mr207948iti.38.1526511600941;
 Wed, 16 May 2018 16:00:00 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:22 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-36-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 35/36] remote: convert check_push_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'check_push_refs()' to take a 'struct refspec' as a parameter
instead of an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c    | 14 +++++---------
 remote.h    |  2 +-
 transport.c |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 0046d4e28..0d1a3d07f 100644
--- a/remote.c
+++ b/remote.c
@@ -1255,24 +1255,20 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  * but we can catch some errors early before even talking to the
  * remote side.
  */
-int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
+int check_push_refs(struct ref *src, struct refspec *rs)
 {
-	struct refspec refspec = REFSPEC_INIT_PUSH;
 	int ret = 0;
 	int i;
 
-	refspec_appendn(&refspec, refspec_names, nr_refspec);
-
-	for (i = 0; i < refspec.nr; i++) {
-		struct refspec_item *rs = &refspec.items[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *item = &rs->items[i];
 
-		if (rs->pattern || rs->matching)
+		if (item->pattern || item->matching)
 			continue;
 
-		ret |= match_explicit_lhs(src, rs, NULL, NULL);
+		ret |= match_explicit_lhs(src, item, NULL, NULL);
 	}
 
-	refspec_clear(&refspec);
 	return ret;
 }
 
diff --git a/remote.h b/remote.h
index 74c557457..62a656659 100644
--- a/remote.h
+++ b/remote.h
@@ -161,7 +161,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
 int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
-int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
+int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
diff --git a/transport.c b/transport.c
index 24a97d9e8..e32bc320c 100644
--- a/transport.c
+++ b/transport.c
@@ -1090,7 +1090,7 @@ int transport_push(struct transport *transport,
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
-		if (check_push_refs(local_refs, rs->raw_nr, rs->raw) < 0)
+		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
 
 		for (i = 0; i < rs->nr; i++) {
-- 
2.17.0.441.gb46fe60e1d-goog

