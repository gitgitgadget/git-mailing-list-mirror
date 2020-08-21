Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4E7C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A763207DE
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYmzn5j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHUVly (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHUVlx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:41:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF5C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so3198970wrl.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8eLjPJw8tgXirLD3G9373REH4VfPlXM/FhepQV9kAlY=;
        b=AYmzn5j41fZJf5lIyVfc4XdvxE9OpCpfzHfBjhLC7pFa8B7sPyZivUg+qU5fao1FAz
         5D0+HdggQT42EIjHWOmTtr6AJT9QzokGx6tDJ1zZeqeyUdSN/O19s8rln0qeZFgaCFKS
         ggVdNlN4h2vEbhZJxcMvGPPAUX/OS9hqPjWFOZcMGg8T1cttWA1ofuu21DloaT3AMXdy
         9MOGIs/Mle4ingtsW5GB1+XV6S3n06jpoSnVSml3Epo2y3e8BmBzaRHNHGbHRjXWlR8W
         BelTh678KnAqxwpKlL0FuUkAwJ8bMW7i9fAWcuk9o6ptqLERXyy3kJKeRVeBQG/gFKM2
         rodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8eLjPJw8tgXirLD3G9373REH4VfPlXM/FhepQV9kAlY=;
        b=BkUNMM3K9UpoiP93AnTsDtwi3gjLL3ksrXI/APWKNINGEZfnm9aVflMZVajSzHKQoV
         BhUcVdS09/w4Fitxozu98xalLv0eVw40Rk9DJd6i9NvOvwb3TvIiJWAwUSVOmIqqjI3F
         KDMM3hn6qc0PhA54uoDkZoRGusH09NkObEs//MyfG+5MzdyvSCUVk8IpSvSIkE4K56VT
         w94K0w5/lJ/5uqpGZ7NCEz//IVaDlmmyenOIqNp10LSlp2PR30K2YtGfaWWmEXOgME3r
         KStvKteHigkWnbiMQKAFsNI0IzWQZoucTx3Qc5YsUvBmRsvgZEFzNkyKLMU79xhljqSb
         5qVA==
X-Gm-Message-State: AOAM532RpbF5ufmBecVGIRsxPh6laWDI+fEvB9/87N44H7/L9ni4HUd/
        zNBLCdU9pqMSEgnGxkGmAzy26qAgnNc=
X-Google-Smtp-Source: ABdhPJzGPJMpCP3EWvaPQGkIDXLrI/smIncOumVXYo31/BQWQO0E2OsHujSvUGkcb4n7f4Aavy3qZw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4716919wro.271.1598046111481;
        Fri, 21 Aug 2020 14:41:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm7972861wrg.96.2020.08.21.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:41:50 -0700 (PDT)
Message-Id: <pull.684.v4.git.1598046110.gitgitgadget@gmail.com>
In-Reply-To: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
References: <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:41:42 +0000
Subject: [PATCH v4 0/8] [GSoC] Improvements to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first patch series that introduces some improvements and
features to file ref-filter.{c,h}. These changes are useful to ref-filter,
but in near future also will allow us to use ref-filter's logic in pretty.c

I plan to add more to format-support.{c,h} in the upcoming patch series.
That will lead to more improved and feature-rich ref-filter.c

Hariom Verma (8):
  ref-filter: support different email formats
  ref-filter: refactor `grab_objectname()`
  ref-filter: modify error messages in `grab_objectname()`
  ref-filter: rename `objectname` related functions and fields
  ref-filter: add `short` modifier to 'tree' atom
  ref-filter: add `short` modifier to 'parent' atom
  pretty: refactor `format_sanitized_subject()`
  ref-filter: add `sanitize` option for 'subject' atom

 Documentation/git-for-each-ref.txt |  10 +-
 pretty.c                           |  20 ++--
 pretty.h                           |   3 +
 ref-filter.c                       | 158 +++++++++++++++++++----------
 t/t6300-for-each-ref.sh            |  35 +++++++
 5 files changed, 161 insertions(+), 65 deletions(-)


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-684%2Fharry-hov%2Fonly-rf6-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-684/harry-hov/only-rf6-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/684

Range-diff vs v3:

  1:  3e6fc66a46 =  1:  55618fe4c1 ref-filter: support different email formats
  2:  5268b973da =  2:  c508c96eb8 ref-filter: refactor `grab_objectname()`
  3:  4a12ff8210 =  3:  582f00ace6 ref-filter: modify error messages in `grab_objectname()`
  4:  d53ca56778 =  4:  503a1874ce ref-filter: rename `objectname` related functions and fields
  5:  fd4ed82e80 =  5:  6b97166796 ref-filter: add `short` modifier to 'tree' atom
  6:  7a039823de =  6:  5ed5ac259d ref-filter: add `short` modifier to 'parent' atom
  7:  0ad22c7cdd !  7:  6105046d96 pretty: refactor `format_sanitized_subject()`
     @@ Commit message
          of `\n` in a variable `eol` and passed it in
          `format_sanitized_subject()`. And the loop runs upto `eol`.
      
     -    But this change isn't sufficient to reuse this function in
     -    ref-filter.c because there exist tags with multiline subject.
     -
     -    It's wise to replace `\n` with ' ', if `format_sanitized_subject()`
     -    encounters `\n` before end of subject line, just like `copy_subject()`.
     -    Because we'll be only using `format_sanitized_subject()` for
     -    "%(subject:sanitize)", instead of `copy_subject()` and
     -    `format_sanitized_subject()` both. So, added the code:
     -    ```
     -    if (char == '\n') /* never true if called inside pretty.c */
     -        char = ' ';
     -    ```
     -
     -    Now, it's ready to be reused in ref-filter.c
     -
          Mentored-by: Christian Couder <chriscool@tuxfamily.org>
          Mentored-by: Heba Waly <heba.waly@gmail.com>
          Signed-off-by: Hariom Verma <hariom18599@gmail.com>
     @@ pretty.c: static int istitlechar(char c)
       }
       
      -static void format_sanitized_subject(struct strbuf *sb, const char *msg)
     -+static void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
     ++void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
       {
     -+	char *r = xmemdupz(msg, len);
       	size_t trimlen;
       	size_t start_len = sb->len;
       	int space = 2;
     @@ pretty.c: static int istitlechar(char c)
      -	for (; *msg && *msg != '\n'; msg++) {
      -		if (istitlechar(*msg)) {
      +	for (i = 0; i < len; i++) {
     -+		if (r[i] == '\n')
     -+			r[i] = ' ';
     -+		if (istitlechar(r[i])) {
     ++		if (istitlechar(msg[i])) {
       			if (space == 1)
       				strbuf_addch(sb, '-');
       			space = 0;
     @@ pretty.c: static int istitlechar(char c)
      -			if (*msg == '.')
      -				while (*(msg+1) == '.')
      -					msg++;
     -+			strbuf_addch(sb, r[i]);
     -+			if (r[i] == '.')
     -+				while (r[i+1] == '.')
     ++			strbuf_addch(sb, msg[i]);
     ++			if (msg[i] == '.')
     ++				while (msg[i+1] == '.')
      +					i++;
       		} else
       			space |= 1;
       	}
     -+	free(r);
     - 
     - 	/* trim any trailing '.' or '-' characters */
     - 	trimlen = 0;
      @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
       	const struct commit *commit = c->commit;
       	const char *msg = c->message;
     @@ pretty.c: static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
       		return 1;
       	case 'b':	/* body */
       		strbuf_addstr(sb, msg + c->body_off);
     +
     + ## pretty.h ##
     +@@ pretty.h: const char *format_subject(struct strbuf *sb, const char *msg,
     + /* Check if "cmit_fmt" will produce an empty output. */
     + int commit_format_is_empty(enum cmit_fmt);
     + 
     ++/* Make subject of commit message suitable for filename */
     ++void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
     ++
     + #endif /* PRETTY_H */
  8:  7a64495f99 <  -:  ---------- format-support: move `format_sanitized_subject()` from pretty
  9:  1ab35e9251 !  8:  7cba8d7a28 ref-filter: add `sanitize` option for 'subject' atom
     @@ Documentation/git-for-each-ref.txt: contents:subject::
       	The remainder of the commit or the tag message that follows
      
       ## ref-filter.c ##
     -@@
     - #include "worktree.h"
     - #include "hashmap.h"
     - #include "strvec.h"
     -+#include "format-support.h"
     - 
     - static struct ref_msg {
     - 	const char *gone;
      @@ ref-filter.c: static struct used_atom {
       			unsigned int nobracket : 1, push : 1, push_remote : 1;
       		} remote_ref;

-- 
gitgitgadget
