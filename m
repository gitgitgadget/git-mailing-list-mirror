Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970E920281
	for <e@80x24.org>; Tue, 12 Sep 2017 22:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbdILW64 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 18:58:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38170 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdILW6x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 18:58:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id p37so6883573wrb.5
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 15:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1XxaxKJP3XXVla0RINeZOe4on7lhzk15Xg8QWuKLBY=;
        b=TZ1Ji05GKongFBRp6pleDoS/hW0m8FBSvqwO+TSDcPGD8fWfjJbSHkqPBiQ6OJ6piS
         KMS6OfzKB+GADEtDVxn3jyYYiGfusqgWkzDQYZS5wO6drxD2q592ab0tEY7qDaCy9toO
         /ICs3WUXi+knJpSvps8ybAeX8DW3Xxbk51T1+EHfuwik3VR8PMAbJoYwY4Xzk6kIZJ8M
         0nMGLyjlkBfFnuTy2XyfnlZmCb0TPCDgsXuZNvGSuMq47xB1mxbCQf11y8zUhfNUyfFH
         kLiV4v0Pm43d4p+RtU+WZ8rYuC7L4eUy9vBT4FluV3Ha2tQT282wtEbAOz1h2qZ3jBnA
         Ahgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1XxaxKJP3XXVla0RINeZOe4on7lhzk15Xg8QWuKLBY=;
        b=rKvs1D8fJOuFi6Ai3lHbXrJ+7YJ7dGtlIludW2U6N0u8b+fDcTFLhD3tgzgb3GW6MT
         8aA7y2Jt3Xn5Q7ZebxHDq3ebqho/C7oclO9W/xOkQn0o+c9qp4GMKPwTs5v7bVOLct1Y
         JHLFfZwoggELXImsdewm5Vn/IhPw/puNN6FaKn/dcwzCSiazCQGkVzyGxMEhvr7F24fn
         zS0AW057aAACRnIZ2LFdMIYmHNcwysJy1Ms9Cn1uEitS6M+EBSlOfRmMIwwhl3yupc5q
         U7xdxHoaW2IS/2xi5v2zHxCLjLr3V6fzW7YgaGFwd2hNXQ6CG+wofyGqeRAksRXlp1Kt
         SQjw==
X-Gm-Message-State: AHPjjUjOOYph4xIvfpBRB13d8wuWa8upMYp3Ou3QeamwUo14vdCGbmqJ
        X96oVnTSGPjyhw==
X-Google-Smtp-Source: ADKCNb6tAYhaif4KGdjwL8N08N7n0W6K+eDZbXq6uEFqIzKuyFKqz+VFmUFiRs7iMGDEC7PbfxlzOw==
X-Received: by 10.223.133.65 with SMTP id 59mr14810007wrh.233.1505257132453;
        Tue, 12 Sep 2017 15:58:52 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k52sm16499266wrf.62.2017.09.12.15.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Sep 2017 15:58:51 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC v2] refs: strip out not allowed flags from ref_transaction_update
Date:   Tue, 12 Sep 2017 23:59:21 +0100
Message-Id: <20170912225921.27705-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
References: <CAMy9T_ED1KBqkE9GCHrOrt0frnYAx1vka7Xx1DrXmjJBNNKahw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Callers are only allowed to pass certain flags into
ref_transaction_update, other flags are internal to it.  To prevent
mistakes from the callers, strip the internal only flags out before
continuing.

This was noticed because of a compiler warning gcc 7.1.1 issued about
passing a NULL parameter as second parameter to memcpy (through
hashcpy):

In file included from refs.c:5:0:
refs.c: In function ‘ref_transaction_verify’:
cache.h:948:2: error: argument 2 null where non-null expected [-Werror=nonnull]
  memcpy(sha_dst, sha_src, GIT_SHA1_RAWSZ);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from git-compat-util.h:165:0,
                 from cache.h:4,
                 from refs.c:5:
/usr/include/string.h:43:14: note: in a call to function ‘memcpy’ declared here
 extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
              ^~~~~~

The call to hascpy in ref_transaction_add_update is protected by the
passed in flags, but as we only add flags there, gcc notices
REF_HAVE_NEW or REF_HAVE_OLD flags could be passed in from the outside,
which would potentially result in passing in NULL as second parameter to
memcpy.

Fix both the compiler warning, and make the interface safer for its
users by stripping the internal flags out.

Suggested-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

> This might be a nice change to have anyway, to isolate
> `ref_transaction_update()` from mistakes by its callers. For that
> matter, one might want to be even more selective about what bits are
> allowed in the `flags` argument to `ref_transaction_update()`'s
> callers:
>
> >         flags &= REF_ALLOWED_FLAGS; /* value would need to be determined */

Here's my attempt at doing this.

The odd flag out as the flag that's advertised as internal but can't
stripped out is REF_ISPRUNING.  REF_ISPRUNING is passed in as argument
to 'ref_transaction_delete()' in 'prune_ref()'.

Maybe this flag should be public, or maybe I'm missing something here?
Having only this internal flags as part of the allowed flags feels a
bit ugly, but I'm also unfamiliar with the refs code, hence the RFC.
If someone has more suggestions they would be very welcome :)

 refs.c | 2 ++
 refs.h | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/refs.c b/refs.c
index ba22f4acef..fad61be1da 100644
--- a/refs.c
+++ b/refs.c
@@ -921,6 +921,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
+	flags &= REF_TRANSACTION_UPDATE_ALLOWED_FLAGS;
+
 	flags |= (new_sha1 ? REF_HAVE_NEW : 0) | (old_sha1 ? REF_HAVE_OLD : 0);
 
 	ref_transaction_add_update(transaction, refname, flags,
diff --git a/refs.h b/refs.h
index 6daa78eb50..4d75c207e1 100644
--- a/refs.h
+++ b/refs.h
@@ -354,6 +354,14 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags);
 #define REF_NODEREF	0x01
 #define REF_FORCE_CREATE_REFLOG 0x40
 
+/*
+ * Flags that can be passed in to ref_transaction_update
+ */
+#define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
+	REF_ISPRUNING |                      \
+	REF_FORCE_CREATE_REFLOG |            \
+	REF_NODEREF
+
 /*
  * Setup reflog before using. Fill in err and return -1 on failure.
  */
-- 
2.14.1.480.gb18f417b89

