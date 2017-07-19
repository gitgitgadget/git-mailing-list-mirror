Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF91B20288
	for <e@80x24.org>; Wed, 19 Jul 2017 18:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbdGSSUB (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jul 2017 14:20:01 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:38697 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbdGSSUA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2017 14:20:00 -0400
Received: by mail-pg0-f54.google.com with SMTP id s4so3542365pgr.5
        for <git@vger.kernel.org>; Wed, 19 Jul 2017 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Rc8oP5EZZAW2y1cbgiHl8kuleDmNiqhQASmSyXxJZw=;
        b=mzH14+LQweA7qUBQY/R54s2RjL15+icolCRoJAXoU2Yzi0+yTRyTrb8/WgCGMzsmZB
         MhZ3OWPa/fnM3mOIgACjXk1QSYSDU1Lq6oyEPybG4FrHgipqavOIqZWCXyN0NPxgBrYO
         iGJQHBU0BOJRsrdm+YdRgQMnDfh6V+fWvDnPp2reqcgQWip66Jy9nWxjxS3cFALDqdtf
         Cs0Ttv7braRculS/5wq2ytcltXWw5P4p2g/ZF7eJoSRMG12+bLs18lw7J85i7XSzJuIh
         butSD2/k5FIq2oMsIPzL+UHIGk0U4ZgwK4veh1rmomTnavahFR43jCMivLpszK+CWZD+
         y0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Rc8oP5EZZAW2y1cbgiHl8kuleDmNiqhQASmSyXxJZw=;
        b=ZSiIFoktyCijB9xn3dbZ/6ohWdGxDRSW0vJOTsRK/V35F29b10C85t2XYJc0r8Td6c
         vHmL2K+RkyV+94EFBp4TKx8gZ1PUPcpuk9RfTwJs+smy9TEFkvhDw5luUAVA+t/lZFNo
         jrKvtfi70wPCj+2CXC0l7A0wPSkaTSVg80pVDwSer2xqWvB5AyW1E3En5ZeEnvKLJR0Y
         vv8dE39VrQJCSeFH7IrQlaTNO8REKDxKOoFoQbt1RJtwZzWkuq12vrYT8CAWeJOYu3p4
         LdvDwxK1Q06dCz1S1rkuAOLxs1fN7M5Ri7nXrq3HRkxVM+16oalyaOYEscW46T3da9GB
         EdaA==
X-Gm-Message-State: AIVw112Ra6tvNgmgsBvYdVrKAkVkduXFxegg3Ecr8srR7vM17cUjbirE
        xbP/m7AmIIF+V+887Wvs9A==
X-Received: by 10.98.15.71 with SMTP id x68mr1039581pfi.176.1500488399934;
        Wed, 19 Jul 2017 11:19:59 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4dc6:1937:2cfa:7fbe])
        by smtp.gmail.com with ESMTPSA id w70sm1032541pfd.15.2017.07.19.11.19.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Jul 2017 11:19:58 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, j6t@kdbg.org, l.s.r@web.de, peff@peff.net,
        schwab@linux-m68k.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] objects: scope count variable to loop
Date:   Wed, 19 Jul 2017 11:19:56 -0700
Message-Id: <20170719181956.15845-1-sbeller@google.com>
X-Mailer: git-send-email 2.14.0.rc0.3.g6c2e499285
In-Reply-To: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is another test balloon to see if we get complaints from people
whose compilers do not support variables scoped to for loops.

This part of the code base was chosen as it is very old code that does
not change often, such that a potential revert is easy.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

This is a rather aggressive test ballon, my compiler needed some
good arguments to accept the new world order:

object.c: In function ‘object_array_remove_duplicates’:
object.c:404:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
  for (unsigned src = 0; src < nr; src++) {
  ^
object.c:404:2: note: use option -std=c99 or -std=gnu99 to compile your code

Using -std=c99 works for me.

Thanks,
Stefan

 object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index f818777412..af26ee2fbc 100644
--- a/object.c
+++ b/object.c
@@ -397,11 +397,11 @@ static int contains_name(struct object_array *array, const char *name)
 
 void object_array_remove_duplicates(struct object_array *array)
 {
-	unsigned nr = array->nr, src;
+	unsigned nr = array->nr;
 	struct object_array_entry *objects = array->objects;
 
 	array->nr = 0;
-	for (src = 0; src < nr; src++) {
+	for (unsigned src = 0; src < nr; src++) {
 		if (!contains_name(array, objects[src].name)) {
 			if (src != array->nr)
 				objects[array->nr] = objects[src];
-- 
2.14.0.rc0.3.g6c2e499285

