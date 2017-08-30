Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BCC208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdH3HQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:16:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38114 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdH3HQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:16:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id r187so3813724pfr.5
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6aSiT0Iq5C8j3DKza13a078msY+6LSpWlvviKmM6Ao=;
        b=BGRRXv4FeVcL58hOG17ObvQztvAuxZDZ78bV2/h8pejgGeubBdOF4xfFpaYdSJSHGZ
         /8H73H3C7IXvVGnUFp4ZwPfY5j/tbj001B6vyiB8wRHrTKac15wRk9s4cmhQ62cbHPFx
         9GC4HV8M7XAMLMmE3OY/kceflv0UtYfzGSCqkapN+Q2chdEs04VnWaBA2zjzMOW6FcTB
         AUDdNE72ADDdCKd0efl3Zh6V+ne1Wg1sDjh4ta3D1gIxQE1+c0lZ1aOHNYnOhOyGajmi
         uRzccwg89BapijGyQvjeaTK/eCqM6h2gLaTIUl413nTeaJlv7TW2JqFSJJce1jOLxkG2
         I43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6aSiT0Iq5C8j3DKza13a078msY+6LSpWlvviKmM6Ao=;
        b=Mchu3/a5hqWQhZi/ifCdK83IImPKc8LJ5KJc9GL40goVs60xEC7VMrbVu0btF7fsdJ
         Oojc8WKmF73La4htJG+UXZlu0Fpn95EbBjXNLwncRRkCXNlgkpHtWYnAmCuc5gYehvza
         aMhOgbLILPpAqBFq6ZkyaTWuyh1u4kqycfg9LOFEpCg89+btKKyqgBsySrpqq1H//nmQ
         HRB5ciOdlh2HsseSFae5GhkS1inI3df2ByZvZYg4DnHsvhARhxp1vvgU1ZTxjE3RCNX0
         UacBBwEwCHVOuzsrO1o4ablxgnSz7M8Gnlufgj648jB5ISt+4KEt5mGEdDa1Hv/e80yc
         v8Hw==
X-Gm-Message-State: AHYfb5i/XaS1eEUt+TQlAaHCYc5S5XCQCRVvfzBx3WEckoqCQUK8dh6j
        B2FdRFiZ6DnvcMs4at8=
X-Received: by 10.98.198.12 with SMTP id m12mr698552pfg.46.1504077418374;
        Wed, 30 Aug 2017 00:16:58 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id i72sm8178873pfi.124.2017.08.30.00.16.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:16:57 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:16:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 38/39] pack: allow map_sha1_file to handle arbitrary
 repositories
Message-ID: <20170830071656.GM153983@aiede.mtv.corp.google.com>
References: <20170830064634.GA153983@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830064634.GA153983@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 object-store.h | 3 +--
 sha1_file.c    | 5 +++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-store.h b/object-store.h
index fe2187fd65..57b8d89738 100644
--- a/object-store.h
+++ b/object-store.h
@@ -61,8 +61,7 @@ struct packed_git {
  * is overwritten each time the function is called.
  */
 extern const char *sha1_file_name(struct repository *r, const unsigned char *sha1);
-#define map_sha1_file(r, s, sz) map_sha1_file_##r(s, sz)
-extern void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size);
+extern void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
 extern void prepare_alt_odb(struct repository *r);
 
diff --git a/sha1_file.c b/sha1_file.c
index 7fc5ebf2af..dc3c0b07ea 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -904,9 +904,10 @@ static void *map_sha1_file_1(struct repository *r, const char *path,
 	return map;
 }
 
-void *map_sha1_file_the_repository(const unsigned char *sha1, unsigned long *size)
+void *map_sha1_file(struct repository *r,
+		    const unsigned char *sha1, unsigned long *size)
 {
-	return map_sha1_file_1(the_repository, NULL, sha1, size);
+	return map_sha1_file_1(r, NULL, sha1, size);
 }
 
 static int unpack_sha1_short_header(git_zstream *stream,
-- 
2.14.1.581.gf28d330327

