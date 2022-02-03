Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B6AC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 02:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348934AbiBCCBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 21:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348933AbiBCCBq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 21:01:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E534C061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 18:01:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id r10so2508893edt.1
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 18:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nLEHJab0d2auP9ycF/ysVCY2nDB5k4nb87DRMRYZJdQ=;
        b=Co3Z4jGbGdwPz4MJ5xU0ag6m3LbZK3elHRoWY8aNBAK/yjgwKeD4PQ6c6RpGNL9fhc
         EBAU1XDGd2t2jH1Ppdaisk8YCgLIx1tYS7SwERNq9U/DFmlFkJ33K+49S+OQfU54OM4z
         D8Pf2KKQdEPYpc9QsrTRtUz7o7oklysyuXi62FwhPgDJpszm8h20Wl0bu3OTtRCcVdqK
         CatdiccPNNeA1RF0McmFjEGDgFlDQY8qqcN1qMF8UY33a4F5lzWN7H01n+mAxYLKxYc5
         XJNEYG8GNzlcFos0dfx21qahfE2YQDsCmDgCRiPOotjsMlAvkopOVDpxZbSex2rGYCC5
         GXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nLEHJab0d2auP9ycF/ysVCY2nDB5k4nb87DRMRYZJdQ=;
        b=ZSoOQH0vF48d5vQE9xsp4AVP/b05VvfJXUGmxRdf8iUZfiHqA7Xmtl0qX3GTnLlPKg
         cFR9E9e1gs308GBc0wgeulZxJE0pPAPyzpw8aQE2a9BoNPeCWqRfPNPmsX/VQRQwkTAE
         eE4bwCBzrLIFEvfCNhXU5WnPWBuQB0Qlym3FtOVr0+eFtrZRM0EJauWue4AlBlYU98F9
         tC23voVFHuEBYv4vJXSP8PYaU5emGmRcldPAsolurKYKBQ15yIAXAqWc5ZHfOWQvneyN
         XgNM6rVfRER8P6d2eq9XqShgzOk9r9aYPHqKO+dLXUBZTRWU3dt+EPe5o9JFPaQYUPAq
         e65Q==
X-Gm-Message-State: AOAM5320HXHuH8h9v5c5HMvKHsq5GE2kpmtHKZmmTgppMeRELoynCAzf
        ViUNdUAzhlvpEUTv98UK5fyhPcCWNTNUng==
X-Google-Smtp-Source: ABdhPJx0gjgwPxIPjt9yp4LhWXpo8MglX6yFy5WLqJ/2JjT5lc+yyQld0W5HZWekC3YMUct6WkFEXQ==
X-Received: by 2002:a05:6402:5147:: with SMTP id n7mr33011309edd.2.1643853704697;
        Wed, 02 Feb 2022 18:01:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q5sm8654587ejc.115.2022.02.02.18.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 18:01:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFRRP-004pO8-FV;
        Thu, 03 Feb 2022 03:01:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 08/15] merge-ort: allow update messages to be written
 to different file stream
Date:   Thu, 03 Feb 2022 02:48:06 +0100
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
 <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <04c3bdc44d2c76ffc82a95db3ca4fd07270f94cf.1643787281.git.gitgitgadget@gmail.com>
Message-ID: <220203.86ee4k7lo8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 02 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> This modifies the new display_update_messages() function to allow
> printing to somewhere other than stdout.  It also consolidates the
> location of the diff_warn_rename_limit() message with the rest of the
> CONFLICT and other update messages to all go to the same stream.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 9 +++++----
>  merge-ort.h | 3 ++-
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 82d2faf5bf9..d28d1721d14 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>  }
>  
>  void merge_display_update_messages(struct merge_options *opt,
> -				   struct merge_result *result)
> +				   struct merge_result *result,
> +				   FILE *stream)
>  {
>  	struct merge_options_internal *opti = result->priv;
>  	struct hashmap_iter iter;
> @@ -4263,13 +4264,13 @@ void merge_display_update_messages(struct merge_options *opt,
>  	for (i = 0; i < olist.nr; ++i) {
>  		struct strbuf *sb = olist.items[i].util;
>  
> -		printf("%s", sb->buf);
> +		strbuf_write(sb, stream);
>  	}
>  	string_list_clear(&olist, 0);
>  
>  	/* Also include needed rename limit adjustment now */
>  	diff_warn_rename_limit("merge.renamelimit",
> -			       opti->renames.needed_limit, 0, stderr);
> +			       opti->renames.needed_limit, 0, stream);

At the tip of this series I tried to s/stream/stderr/g this, and
t4301-merge-tree-write-tree.sh passes, doesn't this warning_fp() special
behavior need a test somewhere?

I assumed that warning_fp() would be using vreportf() in usage.c, but
it's not, it's just falling back to the equivalent of fprintf(out, ...),
no? I don't really see why 05/15 and parts of 06/15 & this are needed
over a much simpler simple helper macro like the below. applied on top
of this series.

I would get it if the point was to actually use the full usage.c
machinery, but we're just either calling warning(), or printing a
formatted string to a file FILE *. There's no need to go through usage.c
for that, and adding an API to it that behaves like this new
warning_fp() is really confusing.

I.e. an API in usage.c that allowed warning to a given FD would be
trying to replace the "2" in the write_in_full() call in vreportf(), I
would think.

diff --git a/diff.c b/diff.c
index 28368110147..4cf67e93dea 100644
--- a/diff.c
+++ b/diff.c
@@ -6377,14 +6377,21 @@ static const char rename_limit_advice[] =
 N_("you may want to set your %s variable to at least "
    "%d and retry the command.");
 
+#define warning_fp(out, fmt, ...) do { \
+	if (out == stderr) \
+		warning(fmt, __VA_ARGS__); \
+	else \
+		fprintf(out, fmt, __VA_ARGS__); \
+} while (0)
+
 void diff_warn_rename_limit(const char *varname, int needed, int degraded_cc,
 			    FILE *out)
 {
 	fflush(stdout);
 	if (degraded_cc)
-		warning_fp(out, _(degrade_cc_to_c_warning));
+		warning_fp(out, _(degrade_cc_to_c_warning), NULL);
 	else if (needed)
-		warning_fp(out, _(rename_limit_warning));
+		warning_fp(out, _(rename_limit_warning), NULL);
 	else
 		return;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 64ba60e5c71..d70ce142861 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -475,7 +475,6 @@ int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-void warning_fp(FILE *out, const char *warn, ...) __attribute__((format (printf, 2, 3)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
diff --git a/usage.c b/usage.c
index 0bfd2c603c0..c7d233b0de9 100644
--- a/usage.c
+++ b/usage.c
@@ -253,20 +253,6 @@ void warning(const char *warn, ...)
 	va_end(params);
 }
 
-void warning_fp(FILE *out, const char *warn, ...)
-{
-	va_list params;
-
-	va_start(params, warn);
-	if (out == stderr)
-		warn_routine(warn, params);
-	else {
-		vfprintf(out, warn, params);
-		fputc('\n', out);
-	}
-	va_end(params);
-}
-
 /* Only set this, ever, from t/helper/, when verifying that bugs are caught. */
 int BUG_exit_code;
 
