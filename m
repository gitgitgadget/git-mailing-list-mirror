Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA20D20401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdFXMKk (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:10:40 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35645 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFXMKi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:10:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so18981785wrb.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mGGtuClS7P81Lz55eumbGSplNmTiED0xrcltrxPRlL0=;
        b=ebVdrO1UAQ2xUhhvRY4MAY77ogBDeKzLHF6EoIHsXec06xUfKhWl5ujLPN1BwR+XwN
         YcM/6AAsHj0XUX8zvJsk09OiClm/X8SYIxvyd02YqRCg0mNTcaNaN9NGSzBcGLvYFp2v
         xukbnHPQ6kUi9lJFHogx0guiz3Ygxlr8Av/c5M33Y1yIOojQmTmGlcQCsXGrR1u7Avvw
         COdPrSSy+Q+Gwg6tsO/DrtFXpS+jsuGsjRm9JPU8XEze8xClKchMiSKMAnMqdMVhi3cA
         gvT+hX0WJxikS0SDKMHHnxMRFCG9jVKWb/m8XjlWYmSILANS/sg2iLKA0Wcfo9PPVSBq
         StjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mGGtuClS7P81Lz55eumbGSplNmTiED0xrcltrxPRlL0=;
        b=TlvfCQhc59Yq8AeZerznOGZfbYQrZb+FLTYB6OwUIV8AkFjZMqqwCFNp2VQyeyXGyQ
         tS71jgtCMEvImSvwYKSamXHu5dERO5e4/YMYlr+AHz+UmMZablBEleFO4U+ZsFepUM7O
         QShTD80oKmgWZImDzfrO99PL55pbHXgRw81sPaKH0m7KtbveGCzvYII7mMh5rc7csps6
         GR2PZT+lxkdZox60QN5QH2w9HqoiV5G2Pkrj1lWyi4Lz8MPWhbW/LX8Lfu6+xiYUMkIN
         vYvvjkkJVBFd7snDjyGp0bmMjYYx8Y2wOhUEGTkQmZwVeQDEyqvkKY3CeRtqrBRBPYh9
         lHJw==
X-Gm-Message-State: AKS2vOyaWhbihcfx2Tf48rpzdvPygXSYnfvQlShd7hBpBEsgx8EvjWup
        3jF3muSKdRtvvP5CiPI=
X-Received: by 10.80.169.35 with SMTP id l32mr9867314edc.105.1498306236664;
        Sat, 24 Jun 2017 05:10:36 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b30sm4324043edd.6.2017.06.24.05.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 05:10:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Sat, 24 Jun 2017 12:10:23 +0000
Message-Id: <20170624121023.2636-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170624121023.2636-1-avarab@gmail.com>
References: <20170624121023.2636-1-avarab@gmail.com>
In-Reply-To: <20170624120259.5kbmkww66tymxb5i@sigill.intra.peff.net>
References: <20170624120259.5kbmkww66tymxb5i@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the code for deciding what's to be done about %Z to stop
passing always either a NULL or "" char * to
strbuf_addftime(). Instead pass a boolean int to indicate whether the
strftime() %Z format should be suppressed by converting it to an empty
string, which is what this code is actually doing.

This code grew organically between the changes in 9eafe86d58 ("Merge
branch 'rs/strbuf-addftime-zZ'", 2017-06-22). The intent was to use
this API in the future to pass a custom leave the door open to pass a
custom timezone name to the function (see my [1] and related
messages).

But that's not what this code does now, and this strbuf_addstr() call
always being redundant makes it hard to understand the current
functionality. So simplify this internal API to match its use, we can
always change it in the future if it gets a different use-case.

1. CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com
   (https://public-inbox.org/git/CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Sat, Jun 24, 2017 at 2:02 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 24, 2017 at 11:36:35AM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> >>  extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
>> >>                        const struct tm *tm, int tz_offset,
>> >> -                      const char *tz_name);
>> >> +                      const int omit_strftime_tz_name);
>> >
>> > This would need the new name, too (whatever it is).
>>
>> *Nod*. Now the parameter is called suppress_tz_name.
>
> Thanks. That sounds good (and your initial re-ordering patch looks fine,
> too). One minor typo:
>
>> diff --git a/strbuf.h b/strbuf.h
>> index 6708cef0f9..d3e6e65123 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -343,11 +343,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>>   * with modifiers (e.g. %Ez) are passed to `strftime`.
>> - * `tz_name` is used to expand %Z internally unless it's NULL.
>> + * `suppress_tz_name` when set, means let suppress the `strftime` %Z
>> + * format and replace it with an empty string.
>
> I couldn't quite parse "let suppress". I'm not sure if it was supposed
> to be "let's". Probably "means to suppress the strftime..." would be
> more clear. I'd probably have written it more like:
>
>   `suppress_tz_name`, when set, expands %Z internally to the empty
>   string rather than passing it to `strftime`.

Thanks. Docs fixed per your suggestion. I sent a v4 of 1/2 too, but
that's unchanged, just thought it was simpler than having just one
patch have a v4...

 date.c   | 2 +-
 strbuf.c | 5 ++---
 strbuf.h | 5 +++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 1fd6d66375..c3e673fd04 100644
--- a/date.c
+++ b/date.c
@@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
-				mode->local ? NULL : "");
+				!mode->local);
 	else
 		strbuf_addf(&timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
diff --git a/strbuf.c b/strbuf.c
index be3b9e37b1..89e40bb496 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -786,7 +786,7 @@ char *xstrfmt(const char *fmt, ...)
 }
 
 void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
-		     int tz_offset, const char *tz_name)
+		     int tz_offset, int suppress_tz_name)
 {
 	struct strbuf munged_fmt = STRBUF_INIT;
 	size_t hint = 128;
@@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			fmt++;
 			break;
 		case 'Z':
-			if (tz_name) {
-				strbuf_addstr(&munged_fmt, tz_name);
+			if (suppress_tz_name) {
 				fmt++;
 				break;
 			}
diff --git a/strbuf.h b/strbuf.h
index 6708cef0f9..d3e6e65123 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -343,11 +343,12 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
  * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
  * of Greenwich, and it's used to expand %z internally.  However, tokens
  * with modifiers (e.g. %Ez) are passed to `strftime`.
- * `tz_name` is used to expand %Z internally unless it's NULL.
+ * `suppress_tz_name` when set, means let suppress the `strftime` %Z
+ * format and replace it with an empty string.
  */
 extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
 			    const struct tm *tm, int tz_offset,
-			    const char *tz_name);
+			    int suppress_tz_name);
 
 /**
  * Read a given size of data from a FILE* pointer to the buffer.
-- 
2.13.1.611.g7e3b11ae1

