Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A3C1FBB0
	for <e@80x24.org>; Fri, 18 Nov 2016 11:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbcKRL3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 06:29:38 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36090 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752483AbcKRL3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 06:29:36 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so5171004wma.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 03:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:from:date:message-id:subject:to;
        bh=umiBjEiK1RelqpvrGv4MvJ6kRx4W0UTXSJz9Yk3Lh7o=;
        b=Wtl6bTluoC2tZfDdtbNvpG9oFEP2KjywHG/i0uJd6y1AYlTAkchl3iOKB51mL81FrI
         SE7e94WccKkWn4vOIwaZUdExL92BEHZrRdpo2oiT7U77TlwLIaeSE3yLZ4/WDmeBPukE
         3h22HT61M4hZuxbwMrRIlPexC2/ZJKEOCsOZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=umiBjEiK1RelqpvrGv4MvJ6kRx4W0UTXSJz9Yk3Lh7o=;
        b=M3kmMCpks0hzmfMFtDJ+vi1NSO+MP4xZAlfW6V6dFiMO7DzGCsShhbDvTQ8pgRcCxf
         EVJRP1rHzhGSMIfgetLV1a1p6BwwjcoOtb9rQCfhIpOsKu0i4CqIDIoiDMnr+llpzsNl
         BLjVlhiW0ana5nGZDesS/PEsnwg4qEtvYSnwiroTCofT2/UNRlTkbepaOTV/G3g1mH8M
         la6+8TW9Jb25p84k23S08w4Qzoamv/0oVH0/JakVVw+hjZM713gWigG4+GQ+Y+pdeVnT
         NZzb9FydNhGcFtlHWoVjaFeK6PZuLDM6kMg4WGVgAJfTw7RR8Hy55t74mbp9R2Ba41hn
         AhfQ==
X-Gm-Message-State: ABUngvdqLVfuUY8YhLRVxyew9xp20wiil2tit3CJ2ThazItjLyhrL9+PKi1rQXBsN7N2Pg==
X-Received: by 10.28.150.75 with SMTP id y72mr23365692wmd.47.1479468574701;
        Fri, 18 Nov 2016 03:29:34 -0800 (PST)
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id w66sm2899885wme.4.2016.11.18.03.29.33
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 03:29:33 -0800 (PST)
Received: by mail-wm0-f47.google.com with SMTP id f82so31375294wmf.1
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 03:29:33 -0800 (PST)
X-Received: by 10.25.219.69 with SMTP id s66mr1620074lfg.116.1479468572750;
 Fri, 18 Nov 2016 03:29:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.21.102 with HTTP; Fri, 18 Nov 2016 03:29:32 -0800 (PST)
From:   Daurnimator <quae@daurnimator.com>
Date:   Fri, 18 Nov 2016 22:29:32 +1100
X-Gmail-Original-Message-ID: <CAEnbY+cEts2HrDLGd-5S9JC6PUrON_TpiyGy_=DAEbOT5z=MJw@mail.gmail.com>
Message-ID: <CAEnbY+cEts2HrDLGd-5S9JC6PUrON_TpiyGy_=DAEbOT5z=MJw@mail.gmail.com>
Subject: Staging chunks can get confused
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tonight I was staging changes with `git add -p` and noticed they got
applied at the *wrong* location.
My guess is that when you stage a hunk it doesn't do a line number
fix-up for earlier unstaged hunks in the file.

Screencast: https://asciinema.org/a/7y9qhr0837a7t96m8w14mupnk
Alternatively, an example follows:

$ git add -p
diff --git a/unistring/unistring.c b/unistring/unistring.c
index 62bbc8a..45ced5d 100644
--- a/unistring/unistring.c
+++ b/unistring/unistring.c
@@ -17,6 +17,27 @@ static const char *const uninormnames[] = {"NFD",
"NFC", "NFKD", "NFKC", NULL};
 #define lunistring_optuninorm(L, arg)
(lua_isnoneornil(L,(arg))?NULL:lunistring_checkuninorm((L), (arg)))


+const uint8_t * u8_check (const uint8_t *s, size_t n);
+int u8_mblen (const uint8_t *s, size_t n);
+int u8_mbtouc_unsafe (ucs4_t *puc, const uint8_t *s, size_t n);
+int u8_mbtouc (ucs4_t *puc, const uint8_t *s, size_t n);
+int u8_mbtoucr (ucs4_t *puc, const uint8_t *s, size_t n);
+int u8_uctomb (uint8_t *s, ucs4_t uc, int n);
+size_t u8_mbsnlen (const uint8_t *s, size_t n);
+
+int u8_strmblen (const uint8_t *s);
+int u8_strmbtouc (ucs4_t *puc, const uint8_t *s);
+const uint8_t * u8_next (ucs4_t *puc, const uint8_t *s);
+const uint8_t * u8_prev (ucs4_t *puc, const uint8_t *s, const uint8_t *start);
+
+uint8_t * u8_conv_from_encoding (const char *fromcode, enum
iconv_ilseq_handler handler, const char *src, size_t srclen, size_t
*offsets, uint8_t *resultbuf, size_t *lengthp);
+char * u8_conv_to_encoding (const char *tocode, enum
iconv_ilseq_handler handler, const uint8_t *src, size_t srclen, size_t
*offsets, char *resultbuf, size_t *lengthp);
+uint8_t * u8_strconv_from_encoding (const char *string, const char
*fromcode, enum iconv_ilseq_handler handler);
+char * u8_strconv_to_encoding (const uint8_t *string, const char
*tocode, enum iconv_ilseq_handler handler);
+uint8_t * u8_strconv_from_locale (const char *string);
+char * u8_strconv_to_locale (const uint8_t *string);
+
+
 static int lunistring_width(lua_State *L) {
  size_t n;
  const uint8_t *s = (const uint8_t*)luaL_checklstring(L, 1, &n);
Stage this hunk [y,n,q,a,d,/,j,J,g,e,?]? n
@@ -27,6 +48,17 @@ static int lunistring_width(lua_State *L) {
 }


+int u8_strwidth (const uint8_t *s, const char *encoding);
+void u8_wordbreaks (const uint8_t *s, size_t n, char *p);
+void u8_possible_linebreaks (const uint8_t *s, size_t n, const char
*encoding, char *p);
+int u8_width_linebreaks (const uint8_t *s, size_t n, int width, int
start_column, int at_end_columns, const char *override, const char
*encoding, char *p);
+
+
+int uc_decomposition (ucs4_t uc, int *decomp_tag, ucs4_t *decomposition);
+int uc_canonical_decomposition (ucs4_t uc, ucs4_t *decomposition);
+ucs4_t uc_composition (ucs4_t uc1, ucs4_t uc2);
+
+
 static int lunistring_normalize(lua_State *L) {
  uninorm_t nf = lunistring_optuninorm(L, 1);
  size_t n;
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -54,6 +86,9 @@ static int lunistring_normalize(lua_State *L) {
 }


+int u8_normcmp (const uint8_t *s1, size_t n1, const uint8_t *s2,
size_t n2, uninorm_t nf, int *resultp);
+
+
 static int lunistring_normxfrm(lua_State *L) {
  size_t n;
  const uint8_t *s = (const uint8_t*)luaL_checklstring(L, 1, &n);
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -83,6 +118,9 @@ static int lunistring_normxfrm(lua_State *L) {
 }


+int u8_normcoll (const uint8_t *s1, size_t n1, const uint8_t *s2,
size_t n2, uninorm_t nf, int *resultp);
+
+
 static int lunistring_uc_locale_language(lua_State *L) {
  lua_pushstring(L, uc_locale_language());
  return 1;
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -173,6 +211,15 @@ static int lunistring_totitle(lua_State *L) {
 }


+casing_prefix_context_t u8_casing_prefix_context (const uint8_t *s, size_t n);
+casing_prefix_context_t u8_casing_prefixes_context (const uint8_t *s,
size_t n, casing_prefix_context_t a_context);
+casing_suffix_context_t u8_casing_suffix_context (const uint8_t *s, size_t n);
+casing_suffix_context_t u8_casing_suffixes_context (const uint8_t *s,
size_t n, casing_suffix_context_t a_context);
+uint8_t * u8_ct_toupper (const uint8_t *s, size_t n,
casing_prefix_context_t prefix_context, casing_suffix_context_t
suffix_context, const char *iso639_language, uninorm_t nf, uint8_t
*resultbuf, size_t *lengthp);
+uint8_t * u8_ct_tolower (const uint8_t *s, size_t n,
casing_prefix_context_t prefix_context, casing_suffix_context_t
suffix_context, const char *iso639_language, uninorm_t nf, uint8_t
*resultbuf, size_t *lengthp);
+uint8_t * u8_ct_totitle (const uint8_t *s, size_t n,
casing_prefix_context_t prefix_context, casing_suffix_context_t
suffix_context, const char *iso639_language, uninorm_t nf, uint8_t
*resultbuf, size_t *lengthp);
+
+
 static int lunistring_casefold(lua_State *L) {
  size_t n;
  const uint8_t *s = (const uint8_t*)luaL_checklstring(L, 1, &n);
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -201,6 +248,10 @@ static int lunistring_casefold(lua_State *L) {
 }


+uint8_t * u8_ct_casefold (const uint8_t *s, size_t n,
casing_prefix_context_t prefix_context, casing_suffix_context_t
suffix_context, const char *iso639_language, uninorm_t nf, uint8_t
*resultbuf, size_t *lengthp);
+int u8_casecmp (const uint8_t *s1, size_t n1, const uint8_t *s2,
size_t n2, const char *iso639_language, uninorm_t nf, int *resultp);
+
+
 static int lunistring_casexfrm(lua_State *L) {
  size_t n;
  const uint8_t *s = (const uint8_t*)luaL_checklstring(L, 1, &n);
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -230,6 +281,9 @@ static int lunistring_casexfrm(lua_State *L) {
 }


+int u8_casecoll (const uint8_t *s1, size_t n1, const uint8_t *s2,
size_t n2, const char *iso639_language, uninorm_t nf, int *resultp);
+
+
 static int lunistring_casecoll(lua_State *L) {
  size_t n1, n2;
  const uint8_t *s1 = (const uint8_t*)luaL_checklstring(L, 1, &n1);
Stage this hunk [y,n,q,a,d,/,K,j,J,g,e,?]? n
@@ -288,7 +342,7 @@ static int lunistring_is_titlecase(lua_State *L) {
  return luaL_fileresult(L, 0, NULL);
  }

- lua_pushboolean(L, resultp);
+ lua_pushinteger(L, resultp);
  return 1;
 }

Stage this hunk [y,n,q,a,d,/,K,g,e,?]? y

$ git diff --cached
diff --git a/unistring/unistring.c b/unistring/unistring.c
index 62bbc8a..ea85d65 100644
--- a/unistring/unistring.c
+++ b/unistring/unistring.c
@@ -318,7 +318,7 @@ static int lunistring_is_cased(lua_State *L) {
                return luaL_fileresult(L, 0, NULL);
        }

-       lua_pushboolean(L, resultp);
+       lua_pushinteger(L, resultp);
        return 1;
 }
