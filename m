Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E7A208CD
	for <e@80x24.org>; Wed, 30 Aug 2017 07:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdH3HQK (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 03:16:10 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34906 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdH3HQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 03:16:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id r133so4499193pgr.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLbYnUkmgqogufcuuLs9aDx+4ETWabMTYrgGIXEYVZY=;
        b=veg6CcPUTlLMta1WMGg4XWHw1bxR4xT16LVHtwek3e+fIbW2JKWjga++d7dapQb4/I
         i580RFl8hAZbs3/UWbsvJl+s/wcrTkPp5oRcj+veJDoBDgzhGi82M+oXmQrKhMBsCnDO
         0dYZa6FNh/QqKaE9xLkGS3D7dJ2Gy06s7abor1KGnoyqADw4/5VWcX3Eg2mjWa2d6oWD
         8ZMSy5zOXT+beiOUW2rpQi9EbfICEyLQrT1/WKTaBZkOXF7z8Zhi7cpMJ0qSzOaGQBIx
         yKt/wWlF8xC6fOo//yNymMZDfUf7mSq5lTX9RV+G17RNTL25FYxZJNEguecUkKeQFwDb
         dxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLbYnUkmgqogufcuuLs9aDx+4ETWabMTYrgGIXEYVZY=;
        b=uangT/8CcAJe9rNeqjygapby4Y5lfpWI6zILCKX+WGeTJ7DE0yVqnDI79ferMJ06B3
         YwfPbrkRfpv2Fs1jeIycB844zwCav/y12csBorb9juIxWZ8OEQfcATE8/k5B0qjwiAKV
         CbNXpBiuweX3SoHzAfmNaJmj9kSq46dRt7uHg3jt4DnPxQhR6MvSpjD59QhT9/jB+h7p
         8Ja0R3rBh1i6D8OWBoNCF/P8B1hgnO9n0DErpqw6NzW0/CtzoUllSTf2o06GDk9lmuaP
         siBB7aQfX9YNNBAXkW2P6etldBQTEEFK/onK+1uo8B6z+5Vpv0D/kybOCJ9PknZxUCU4
         HMYA==
X-Gm-Message-State: AHYfb5igEuPhSC0wrjzRNRmQvn7/HPU3cmjHM/8FKomq5BN8fb/1+hdA
        +HueIhZyl6S8GiJLmP4=
X-Received: by 10.98.13.65 with SMTP id v62mr678303pfi.98.1504077368439;
        Wed, 30 Aug 2017 00:16:08 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5042:50b1:56af:6f3d])
        by smtp.gmail.com with ESMTPSA id v11sm7683373pgo.39.2017.08.30.00.16.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 00:16:07 -0700 (PDT)
Date:   Wed, 30 Aug 2017 00:16:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 36/39] pack: allow open_sha1_file to handle arbitrary
 repositories
Message-ID: <20170830071606.GK153983@aiede.mtv.corp.google.com>
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
 sha1_file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 282ed7bd1b..930705f59b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -846,22 +846,21 @@ static int stat_sha1_file(struct repository *r, const unsigned char *sha1,
  * Like stat_sha1_file(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-#define open_sha1_file(r, s, p) open_sha1_file_##r(s, p)
-static int open_sha1_file_the_repository(const unsigned char *sha1,
-					 const char **path)
+static int open_sha1_file(struct repository *r,
+			  const unsigned char *sha1, const char **path)
 {
 	int fd;
 	struct alternate_object_database *alt;
 	int most_interesting_errno;
 
-	*path = sha1_file_name(the_repository, sha1);
+	*path = sha1_file_name(r, sha1);
 	fd = git_open(*path);
 	if (fd >= 0)
 		return fd;
 	most_interesting_errno = errno;
 
-	prepare_alt_odb(the_repository);
-	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next) {
+	prepare_alt_odb(r);
+	for (alt = r->objects.alt_odb_list; alt; alt = alt->next) {
 		*path = alt_sha1_path(alt, sha1);
 		fd = git_open(*path);
 		if (fd >= 0)
-- 
2.14.1.581.gf28d330327

