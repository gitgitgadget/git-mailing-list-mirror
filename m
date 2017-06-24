Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F102082E
	for <e@80x24.org>; Sat, 24 Jun 2017 11:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbdFXLgz (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 07:36:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35826 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbdFXLgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 07:36:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id z45so18826530wrb.2
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=rMmaK4f5flBprgEGuONU8LmAPB3PFPhr0OukO0XJm08=;
        b=iNhGPjpLkK1neyFJOKBZcX0kTgqxVE/sKcMEcxN/NGqS2gQvWzhGBjqspTH201eqFR
         9ihIAuG0tqUqHO+mg1zzBRDwLZD0c8Pq6urWLG3hM9hA3nCerAniq0HMKmwX10XnZBhL
         Y/3O8Z3ugnMGm1k72+/Ja4H94UkivBrRp0G5y6dHok6RpCt4wUoSbSF3qNsLkjWREVR/
         1TwGH3jzWL1T3l7FSybQxzovtfOHF//I7YJKwdDOPX/W07nTVKFWjffGFcEYzQcban9A
         ty3YHCaAbjUZbRY3hXhBDuK7vz8199Qz61rCVMKB7zvC9H+xIaKOoIBSDiG8YP5JD5cX
         oTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rMmaK4f5flBprgEGuONU8LmAPB3PFPhr0OukO0XJm08=;
        b=KcK8W7KMbF+TPYmiRPbjZetQUWtZ7G8YAoKvddg/vxtQU/9QRMtpP/F0NB8px7rUPU
         ltgebk9x8xtpPt4QR3pTXeURbixr6sdFOCOGp7/VvlAGz34JEWewjZVqSmApcZ45F4hV
         GlT/Keb4FFAz+mivewWIspuz3oMN1kpPO4nXwE3xlxQnWlXQ8C2Z19ccpHduZdl/2LyD
         Gd5v7nn69y3npeLr71kjmdgsokHn0D6zdvW/LNGf72aT7Zv6jBIL6KU1k+LbKoN1IGse
         jw8xFDFfkrXvt/kbyOZ8KiOl3GBxi4kabyl4Ewr6HF9XwOxHTTJELZWwO/S/zIPFzi8Z
         qN0g==
X-Gm-Message-State: AKS2vOwF61Rqg3p7Ootytm77Y8NkWhhfZjGmiANi5V4ccHSyvMaNxddr
        9hqMiHTdwAnTD1wgYeE=
X-Received: by 10.80.194.66 with SMTP id t2mr9796433edf.86.1498304211952;
        Sat, 24 Jun 2017 04:36:51 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id n26sm1284651edd.51.2017.06.24.04.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 04:36:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] strbuf: change an always NULL/"" strbuf_addftime() param to bool
Date:   Sat, 24 Jun 2017 11:36:35 +0000
Message-Id: <20170624113635.16360-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170624113635.16360-1-avarab@gmail.com>
References: <20170624113635.16360-1-avarab@gmail.com>
In-Reply-To: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
References: <20170623164403.bxilz7k5ny7hs466@sigill.intra.peff.net>
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

On Fri, Jun 23 2017, Jeff King jotted:

> On Fri, Jun 23, 2017 at 04:36:06PM +0000, Ævar Arnfjörð Bjarmason wrote:
>
>> I believe this addresses the comments in the thread so far. Also Re:
>> René's "why const?" in a2673ce4-5cf8-6b40-d4db-8e2a49518138@web.de:
>> Because tzname_from_tz isn't changed in the body of the function, only
>> read.
>
> Sure, it's not wrong. But that property is also held by 99% of the
> parameters that are passed by value. It's the normal style in our code
> base (and in most C code bases I know of) to never declare pass-by-value
> as const. It pollutes the interface and isn't something the caller cares
> about.
>
> Without passing judgement on whether that style is good or not (though
> IMHO it is), making this one case different than all the others is a bad
> idea. It makes the reader wonder why it's different.

Makes sense. I wasn't trying to be snary or curt or whatever. I'd just
never noticed this pattern in the codebase.

Seems a bit odd to me to not make use of the compiler guarding against
accidental assignments and giving it a strong hint to inline the value
where possible, but whatever, makes sense to have it stylistically be
consistent. So this version does that.

>> diff --git a/date.c b/date.c
>> index 1fd6d66375..17db07d905 100644
>> --- a/date.c
>> +++ b/date.c
>> @@ -256,7 +256,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
>>  			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
>>  	else if (mode->type == DATE_STRFTIME)
>>  		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
>> -				mode->local ? NULL : "");
>> +				mode->local);
>
> You flipped the boolean here. That's OK by me. But in the definition...
>
>>  void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>> -		     int tz_offset, const char *tz_name)
>> +		     int tz_offset, const int tzname_from_tz)
>
> Wouldn't tzname_from_tz only happen when we're _not_ in local mode? I
> suggested that name anticipating your second patch to actually compute
> it based on "tz". In local-mode it's not coming from tz, it's coming
> from secret unportable magic (the combination of localtime() and
> strftime()).

I misread (I think) an earlier E-Mail of yours and thought this was
what you were suggesting. This version hopefully looks OK.

>> @@ -815,8 +815,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>>  			fmt++;
>>  			break;
>>  		case 'Z':
>> -			if (tz_name) {
>> -				strbuf_addstr(&munged_fmt, tz_name);
>> +			if (!tzname_from_tz) {
>>  				fmt++;
>>  				break;
>>  			}
>
> This logic matches your inversion in the caller, so it does the right
> thing. But I think the name is wrong, as above.

Fixed.

>> index 4559035c47..eba5d59a77 100644
>> --- a/strbuf.h
>> +++ b/strbuf.h
>> @@ -340,14 +340,15 @@ extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
>>  
>>  /**
>>   * Add the time specified by `tm`, as formatted by `strftime`.
>> - * `tz_name` is used to expand %Z internally unless it's NULL.
>>   * `tz_offset` is in decimal hhmm format, e.g. -600 means six hours west
>>   * of Greenwich, and it's used to expand %z internally.  However, tokens
>>   * with modifiers (e.g. %Ez) are passed to `strftime`.
>> + * `tzname_from_tz` when set, means let `strftime` format %Z, instead
>> + * of intercepting it and doing our own formatting.
>>   */
>>  extern void strbuf_addftime(struct strbuf *sb, const char *fmt,
>>  			    const struct tm *tm, int tz_offset,
>> -			    const char *tz_name);
>> +			    const int omit_strftime_tz_name);
>
> This would need the new name, too (whatever it is).

*Nod*. Now the parameter is called suppress_tz_name.

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

