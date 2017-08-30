Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21554208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbdH3G77 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 02:59:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34475 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdH3G76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 02:59:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id 63so4474062pgc.1
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVX2rdDC3T9Ue6/nJucqB8nJtm91Yfy0c7WTsYKg3Zc=;
        b=enOnTmbXmTiwswoL0qn3GHyo47FhETaCJwf+6orDW6gqOiOFnlDOyudcxpxqwC5jGv
         U7QAtw4knuaNHOpiGu9izjMYPi8+oVyPwUbhZxROW8s6I07EIVG6VmG0kK2yaZPtJMKU
         ISMNgOMcttsp76X0X1A2S/raluI9NAOKAvKCmwL0EkLuwLG+B2lXx/jdZ6PTUce7Rjqc
         VVg3wEZmxtD3HmAJsKWPb9s2Nyxh6IRMPziqj6xhyRd+IVxEIQ8g97tXJs2mN5bSvuZL
         1rL5RAiOo21pud0IqP+uSC7hTo8jdZwqClsrIex9SFDA9EB2IVdyxg09JAcFiI7o1b0r
         T8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVX2rdDC3T9Ue6/nJucqB8nJtm91Yfy0c7WTsYKg3Zc=;
        b=R+LYbv3BeUQnv0TOsUU/vr9+hmJx8EaU2VxjFq63RLz6NuL7XTBe0/OShyc+9KRBb5
         Fswg/aAFuNUm+WyGhj4gSDRU2gtSMtEBf7YsIlflsJgO9wv6kbX9hAAPH7dWgWS29k1+
         uv94n48CMFO8DtvSCGvdzWS3QUjiJQS5o0hWrNxhB5ZfZe/MlOXA4R5nDZ37kfAGEk2/
         jSlH3uLhjtXkIozIc6wD7w8oUx46SoRNei5fOVbj/9zouSY7Vk2TEvMyABEpZAedoHx5
         WFF6lp8YzRvdU813DRNByc5S1nE/q+Isg7ogrJWl+Pyt91ajDRu1TVUclDDbKUssvnBo
         Y5hw==
X-Gm-Message-State: AHYfb5gk3I4eelQTK+be9YUC7eJG7cRj5OxeILg3x5ZR8XUfn4X0LQCW
        Ob+uJXFie+ij3OOXAQE=
X-Received: by 10.98.6.69 with SMTP id 66mr592485pfg.279.1504076397848;
        Tue, 29 Aug 2017 23:59:57 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id o10sm7522295pgq.68.2017.08.29.23.59.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 23:59:57 -0700 (PDT)
Date:   Tue, 29 Aug 2017 23:59:55 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 12/39] sha1_file: add repository argument to open_sha1_file
Message-ID: <20170830065955.GM153983@aiede.mtv.corp.google.com>
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

From: Stefan Beller <sbeller@google.com>

Add a repository argument to allow the open_sha1_file caller to be
more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d3573cec62..893e37afec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -840,7 +840,9 @@ static int stat_sha1_file_the_repository(const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_sha1_file(const unsigned char *sha1, const char **path)
+#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
+static int open_sha1_file_the_repository(const unsigned char *sha1,
+					 const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
@@ -879,7 +881,7 @@ static void *map_sha1_file_1(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(sha1, &path);
+		fd = open_sha1_file(the_repository, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.14.1.581.gf28d330327

