Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F60C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 11:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjAIL30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 06:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbjAIL3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 06:29:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE118E12
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 03:29:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b17so1668007pld.7
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 03:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qltzbZUPf2gfkgMs8CX8cijRUQAObBJpgWfGN2sLoGI=;
        b=fEPzpEW7AeoYGNTVWH6+Omk5btLr47iv5BwsPVSnpsOpWuBTgUWF4Hfy4+yWKkJ7OH
         zVV671We3OVDYCqqdNYwxAWBXyoWYzKELhbVRrD9MMU6VWeNocZu3Q/NK4pswEYHHP9b
         VcfK5a3Egzkm85AcFn+kKes52/JuVBL8u8IzhAm1VVJmuLYwf0OpJ4J5CIYn9P58t/uE
         b2biB7IsVfqk5ofFiIFSSiv/uybUSxVyXXpRkNjKxdT7IOqPzrS0XGv/dY8Q7ePGyaTa
         JBC6FyBttBHCq2xLv+8PBwFGbrIAQj2Uk5AeVBGA4T3fDDMQ0P/78nC5j/wqrgWiHr3z
         usXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qltzbZUPf2gfkgMs8CX8cijRUQAObBJpgWfGN2sLoGI=;
        b=U/16tc71UoGexcpXWjNU9Wm2kLApP9wZ6Yd7e2PuYpD2V0MQWPwcp5I+xbOfDO+1Fm
         PPmcaKbOtL5XuPh2KDnWm1uOUev3nczkPfUDB5EBnF+7nKe0sYEZptxfiJRU2HUVli8m
         fozvZtQr/QxQGr/VSrN6kmMR8xSWxSaoJqr5+07BgwbsllZSRN8EQA70whSYntOI9ldP
         tXUpG7tCOcS2DXYnmyv9ukCBr6lLMMPYQ1vCojb7Sh5awxkIVXWEFjKEp0tCuzU+of8w
         tKVz2FmrL569TxeSt6iIGbsh/cZfnoUIsDQbZM6oLcV2whQfh3wYVkUp9Je8tXWt/nU0
         CoyA==
X-Gm-Message-State: AFqh2kolujGvZszSg413tqjoyosDjpTSrySjBtsgM3bWDbWJuxzveKzP
        oBPh22dwcNFLfUm2dOyWSGE=
X-Google-Smtp-Source: AMrXdXus6j+ESvt0vrnQh+U8pebvZ/yhEC5Dz0/PQ1pC9/Kw41mdwFkJ3zBhzGk0PiALPl3YWCn9JA==
X-Received: by 2002:a17:902:eb53:b0:193:2ff0:b665 with SMTP id i19-20020a170902eb5300b001932ff0b665mr3760985pli.15.1673263760126;
        Mon, 09 Jan 2023 03:29:20 -0800 (PST)
Received: from localhost ([103.156.58.205])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b00189b2b8dbedsm5858054plh.228.2023.01.09.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:29:19 -0800 (PST)
Date:   Mon, 9 Jan 2023 18:29:17 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org,
        plavarre@purestorage.com
Subject: [PATCH] fixup! date.c: allow ISO 8601 reduced precision times
Message-ID: <Y7v6jThT9GQ8Oav8@danh.dev>
References: <20221216033638.2582956-1-phil.hord@gmail.com>
 <xmqq359gnfhe.fsf@gitster.g>
 <CABURp0pWwfWO3msZ4U=_i3zkEDOq6+CUVT9Tb7KCjeBRK34Miw@mail.gmail.com>
 <CABURp0pqQFiM4+L0sRADTt-jmAsHcMMWLR6xa4NbqrziZjmdOQ@mail.gmail.com>
 <xmqqbkn8um9q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbkn8um9q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-09 17:48:01+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
> 
> > Do you have any suggestions about how I can better alleviate your
> > concerns?  I don't think there are real regressions here and I tried
> > to explain why.
> 
> Other than "including it in a released version and waiting for
> people to scream", I do not think there is.  The "next" branch was
> meant to be a test ground for these new features by letting
> volunteer users to use it in their everyday development, and the
> hope was that we can catch regressions by cooking risky topics
> longer than usual in there, but we haven't been very successful, I
> have to say.

While I think we shouldn't care much about ISO-8601, we should declare
that we're only conformed to RFC-3339 format instead.

Below fixup could limit the change to only ISO-8601 strings
I'm not entirely sure if this heuristics would break those people with
00:00:00.1234 timestamp or not (the added test cases shows that this
change doesn't break ISO-8601 parsing, but I don't know).

On top of Hord's patch + Junio's next, all tests pass.
----8<----

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 21 +++++++++++++--------
 t/t0006-date.sh |  3 ++-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/date.c b/date.c
index b011b9d6b3..19e6787aef 100644
--- a/date.c
+++ b/date.c
@@ -493,6 +493,12 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 		return 2;
 	}
 
+	/* ISO-8601 allows yyyymmDD'T'HHMMSS, with less precision */
+	if (*date == 'T' && isdigit(date[1])) {
+		tm->tm_hour = tm->tm_min = tm->tm_sec = 0;
+		return strlen("T");
+	}
+
 	/* BAD CRAP */
 	return skip_alpha(date);
 }
@@ -639,15 +645,14 @@ static inline int nodate(struct tm *tm)
 }
 
 /*
- * Have we filled in any part of the time yet?
- * We just do a binary 'and' to see if the sign bit
- * is set in all the values.
+ * Have we seen an ISO-8601-alike date, i.e. 20220101T0,
+ * In those special case, those fields have been set to 0
  */
-static inline int notime(struct tm *tm)
+static inline int maybeiso8601(struct tm *tm)
 {
-	return (tm->tm_hour &
-		tm->tm_min &
-		tm->tm_sec) < 0;
+	return tm->tm_hour == 0 &&
+		tm->tm_min == 0 &&
+		tm->tm_sec == 0;
 }
 
 /*
@@ -704,7 +709,7 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 	/* 4 digits, compact style of ISO-8601's time: HHMM */
 	/* 2 digits, compact style of ISO-8601's time: HH */
 	if (n == 8 || n == 6 ||
-		(!nodate(tm) && notime(tm) &&
+		(!nodate(tm) && maybeiso8601(tm) &&
 		(n == 4 || n == 2))) {
 		unsigned int num1 = num / 10000;
 		unsigned int num2 = (num % 10000) / 100;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 16fb0bf4bd..130207fc04 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -93,7 +93,8 @@ check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
 check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
 check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
 check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
-check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
+check_parse '20080214T000000.20' '2008-02-14 00:00:00 +0000'
+check_parse '20080214T00:00:00.20' '2008-02-14 00:00:00 +0000'
 check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'

-- 
Danh
