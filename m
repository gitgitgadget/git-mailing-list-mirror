Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C2FC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8927320714
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgzoSfwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgCTAhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:37:19 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54801 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTAhT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 20:37:19 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so1739761pjb.4
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ki5PD54HhQezZ5Konhy5isORWe6ldKxP2Cfi/KOR84c=;
        b=mgzoSfwj8a8IHkhrNkSV2g/hL6V5AbczJA4tO5pWrXsJfuTUkuBEYPtVqB3mD/ipju
         fB5yUFfhTMaWwRBMeFRc7boJ/E9LBSVRzdCybjpsCMYewAf5tag0OI1FORKdo9/3l5JZ
         NJ1hyIxDJfPTZoecDjW7SN5xxq1iqYQOyckIjntcBRaeyYr0Fw+HwTGmbWDQB/djJkao
         Wz2IT+09FVyirVZQyXbJufDRgG1BUcejxjEZJHVNE/egZV1wC/n6mHBxx/sZzRNvjb7X
         47fJvRPyrrrF61devwHR4c/B4mpRHYqnmRPlSugJ1woBdjudCitjxk4IpOa0sTjIxvtH
         L2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ki5PD54HhQezZ5Konhy5isORWe6ldKxP2Cfi/KOR84c=;
        b=QcubaQaA4edBObMTf6FQ/IqXaNFWfNenMxi0VcMaTM66E3Z+GGCByUwGtFomLsTE13
         h4UaNLQf/QKJkub4xMUejgsS9HoAQnazEnL4iXQHJ5gPZCjuM43EMkUrfF2cCECC27DA
         ZFhJXH1USGhJWKvudIJjEfq8+/6XuHHD8Ar/0JJdmDUTZYkf3qQPZ4HS9bfMtHnyBGF1
         h6/0DjOjcX0S8tN+MseHEwjuuebABOyO1byYiip7NfGviH4T5K/XhN1G2WxGirAf50M7
         LTzpSDt50gVxGHeX/6a4sYfsLybN8Z05KHDok7ViNC7O9xI8tG4QEFxCVDK1+DkuJVo/
         VaHg==
X-Gm-Message-State: ANhLgQ3pd/VKHAAvNmcIeApFP2sE14/7+oZVhKSiqyyhOlPL3cUSlwL5
        x0NnzdlvbMVV24irCczmxPOy/F2y
X-Google-Smtp-Source: ADFU+vv4/KsH9tKxgVHke9PIwIVQ8cJcIo0BA5toTVUW3K45BeVR8l5Sq7S2sxINIRjRIHbBj52xuA==
X-Received: by 2002:a17:902:ac85:: with SMTP id h5mr5852095plr.76.1584664637848;
        Thu, 19 Mar 2020 17:37:17 -0700 (PDT)
Received: from localhost ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id c9sm2903562pjr.47.2020.03.19.17.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 17:37:17 -0700 (PDT)
Date:   Fri, 20 Mar 2020 07:37:15 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/6] fix test failure with busybox
Message-ID: <20200320003715.GA1858@danh.dev>
References: <cover.1584625896.git.congdanhqx@gmail.com>
 <20200319155136.GA3513282@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200319155136.GA3513282@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-03-19 11:51:36-0400, Jeff King <peff@peff.net> wrote:
> On Thu, Mar 19, 2020 at 09:00:01PM +0700, Đoàn Trần Công Danh wrote:
> 
> > Despite some non-compiance from busybox's sh(1), grep(1), diff(1),
> > Alpine Linux is still a popular choice for container these days.
> > 
> > Fix false-positive failure in testsuite when run in Alpine Linux.
> > 
> > t5703.{4,5,6,7} is still failing.
> > Despite git pack-objects behaves correctly,
> > upload-pack.c works incorrectly on this platform.
> > 
> > I haven't dig deeper, yet.
> 
> I was able to reproduce the problems on Debian (with busybox installed)
> with:
> 
>   mkdir /tmp/bb
>   (cd /tmp/bb
>    bb=$(which busybox)
>    for i in $($bb --list); do
>      ln -s $bb $i
>    done)
>   PATH=/tmp/bb:$PATH make test TEST_SHELL_PATH=/tmp/bb/sh
> 
> The issue in t5703 is the sed call in get_actual_commits(). It's trying
> to cut off the early (text) part of the file, and pass through the
> binary goo of the packfile. Presumably busybox's sed isn't binary-clean.

I've checked, busybox's sed think every input is text file,
and in POSIX, every line in every text file must be terminated by
<newline>.

Thus, busybox's sed append a <newline> after `0000` marker, render the
pack file invalid.

> Our usual strategy here would be to switch to perl, which is more
> predictable about binary bytes.

Perl works fine here.

> We're also feeding this into a test-tool helper. It's possible that
> helper could be made smart enough to replace both this sed invocation
> and the one in get_actual_refs().

I looked into this direction, I guess you meant something like this:

-------------8<--------------
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 282d536384..1d62143dbc 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "test-tool.h"
 #include "pkt-line.h"
+#include "strbuf.h"
 
 static void pack_line(const char *line)
 {
@@ -53,6 +54,13 @@ static void unpack(void)
 static void unpack_sideband(void)
 {
 	struct packet_reader reader;
+	struct strbuf buf = STRBUF_INIT;
+
+	while (strbuf_getline(&buf, stdin) == 0)
+		if (strstr(buf.buf, "packfile"))
+		    break;
+	strbuf_release(&buf);
+
 	packet_reader_init(&reader, 0, NULL, 0,
 			   PACKET_READ_GENTLE_ON_EOF |
 			   PACKET_READ_CHOMP_NEWLINE);
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 7fba3063bf..a34460f7d8 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -13,10 +13,7 @@ get_actual_refs () {
 }
 
 get_actual_commits () {
-	sed -n -e '/packfile/,/0000/{
-		/packfile/d
-		p
-		}' <out | test-tool pkt-line unpack-sideband >o.pack &&
+	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
 	grep commit objs | cut -d" " -f1 | sort >actual_commits
----------------------->8-------------------

But, this doesn't work. as `packet_reader_read` reads directly from fd 0.

I think perl should be good for now.

-- 
Danh
