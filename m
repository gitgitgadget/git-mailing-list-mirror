Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD1C61DA3
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 22:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjCCWf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjCCWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 17:35:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BA6507E
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 14:32:13 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z10so2365767pgr.8
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SabXKq97H8vR00W465UpVZdk/xmgxugp9y7cCKg4AR8=;
        b=UjLR7MLqRhAw9e5am4ikl5llBgi+2h8h5G6lrAistfWX/twtlnbv7Ie/577wBwY7XW
         wh2MbB1j25zj5q94eHXI2hbLkomDQj9f2HuG+HUhyJygNE0rQ8dcZpOaBMXeWh4LPmzP
         BooD5ce6kd0h2iKzw0if4B7orfdIFfsSqDGn2qXLg21aGmqGdK0dIXR8z6FesNxzT3Hs
         hr3zeH6fhylD3y8vecigYfMVmTEu6qagsja+Sm1nHgkacf4E7GLHR6Sh3mHnWtVBy8fW
         VPzo0X0Uf/H0ojqQbk3xBNu5Gi5d/TepOYTGBdqrHsWXD1D9kqI9/Ir58Ri1kT/fxhVi
         budw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SabXKq97H8vR00W465UpVZdk/xmgxugp9y7cCKg4AR8=;
        b=4PhtODx0csBcfnT2hRvjlFvgOgk0DrucmGupzngFh1XBlcG4Mysme0s654eW5wXAxL
         jnE/IfSoQ0xDqoPWrJoIUQNCi2HBQNjYkgiQk2I7XLOpCkp8hQ9VSQha9WZqA1bI6LkC
         3AstgXDbWUKV4yyljuHUBiv/Cnuog2ozqBI/jKog2LGxOMO0nxHIXH+HFI3zGJWLBU6Q
         6mxkO0l/ugoCAdBTr5yhIoMfaFqgcfpMS3weaRCZai1dE0ZVsEweI5sr72gEgGvjSqHv
         vFA1Ns+EvfbSEY3kuoJw7Cl1sr4F9csZgq4/8YFTTHy5PKznzKTDMu2qx4ro66DBCRtD
         dbrQ==
X-Gm-Message-State: AO0yUKXa1bcJL/c1/8UuHG6u0AgOAKvuMRzMq9aP8Ylt+IVbOP4OWTMy
        Y8nafZx3Uwi4YqX72AFU3M4=
X-Google-Smtp-Source: AK7set8/tAPoV6R/ox6f+4yXLuB/cDxa/Zan/fbB09xSYPnoxTwD6AvkHc30KK10rnPn9PdET89/SA==
X-Received: by 2002:aa7:9f1a:0:b0:5df:5310:e2f9 with SMTP id g26-20020aa79f1a000000b005df5310e2f9mr3178728pfr.22.1677882667551;
        Fri, 03 Mar 2023 14:31:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id r15-20020a63a54f000000b004fadb547d0csm2026240pgu.61.2023.03.03.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:31:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Henry <git@drmikehenry.com>, git@vger.kernel.org
Subject: Re: `git bundle create -` may not write to `stdout`
References: <80beb487-cd93-06ed-88cf-87a96a829ff6@drmikehenry.com>
        <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net>
Date:   Fri, 03 Mar 2023 14:31:05 -0800
In-Reply-To: <Y/voNv1OQ1Cf/N5a@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 26 Feb 2023 18:16:06 -0500")
Message-ID: <xmqqv8jhcvrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The most directed fix is this:
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index acceef6200..145b814f48 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -59,7 +59,9 @@ static int parse_options_cmd_bundle(int argc,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
>  	if (!argc)
>  		usage_msg_opt(_("need a <file> argument"), usagestr, options);
> -	*bundle_file = prefix_filename(prefix, argv[0]);
> +	*bundle_file = strcmp(argv[0], "-") ?
> +		       prefix_filename(prefix, argv[0]) :
> +		       xstrdup(argv[0]);
>  	return argc;
>  }

This fell thru cracks, it seems.

OPT_FILENAME() needs to do exactly this, and has its own helper
function in parse-options.c::fix_filename(), but its memory
ownership rules is somewhat screwed (it was perfectly fine in the
original context of "we parse the bounded number of options the user
would give us from the command line, and giving more than one
instance of these last-one-wins option may leak but we do not
care---if you do not like leaking, don't give duplicates", but with
automated leak checking that does not care about such nuances, it
will trigger unnecessary errors), and cannot be reused here.

Here is your "most directed fix" packaged into a call to a helper
function.  Given that we may want to slim the cache.h header, it may
not want to be declared there, but for now, its declaration sits
next to prefix_filename().


diff --git c/abspath.c w/abspath.c
index 39e06b5848..b2fd9ff321 100644
--- c/abspath.c
+++ w/abspath.c
@@ -280,3 +280,10 @@ char *prefix_filename(const char *pfx, const char *arg)
 #endif
 	return strbuf_detach(&path, NULL);
 }
+
+char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
+{
+	if (!strcmp(arg, "-"))
+		return xstrdup(arg);
+	return prefix_filename(pfx, arg);
+}
diff --git c/builtin/bundle.c w/builtin/bundle.c
index acceef6200..3056dbeee3 100644
--- c/builtin/bundle.c
+++ w/builtin/bundle.c
@@ -59,7 +59,7 @@ static int parse_options_cmd_bundle(int argc,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc)
 		usage_msg_opt(_("need a <file> argument"), usagestr, options);
-	*bundle_file = prefix_filename(prefix, argv[0]);
+	*bundle_file = prefix_filename_except_for_dash(prefix, argv[0]);
 	return argc;
 }
 
diff --git c/cache.h w/cache.h
index 12789903e8..38867de41a 100644
--- c/cache.h
+++ w/cache.h
@@ -638,6 +638,9 @@ char *prefix_path_gently(const char *prefix, int len, int *remaining, const char
  */
 char *prefix_filename(const char *prefix, const char *path);
 
+/* Likewise, but path=="-" always yields "-" */
+char *prefix_filename_except_for_dash(const char *prefix, const char *path);
+
 int check_filename(const char *prefix, const char *name);
 void verify_filename(const char *prefix,
 		     const char *name,
diff --git c/parse-options.c w/parse-options.c
index fd4743293f..bd1ed906a8 100644
--- c/parse-options.c
+++ w/parse-options.c
@@ -59,6 +59,10 @@ static enum parse_opt_result get_arg(struct parse_opt_ctx_t *p,
 	return 0;
 }
 
+/*
+ * NEEDSWORK: fix memory ownership rules around here and then use
+ * prefix_filename_except_for_dash() helper.
+ */
 static void fix_filename(const char *prefix, const char **file)
 {
 	if (!file || !*file || !prefix || is_absolute_path(*file)
diff --git c/t/t6020-bundle-misc.sh w/t/t6020-bundle-misc.sh
index 7d40994991..d14f7cea91 100755
--- c/t/t6020-bundle-misc.sh
+++ w/t/t6020-bundle-misc.sh
@@ -606,4 +606,15 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 	)
 '
 
+test_expect_success 'send a bundle to standard output' '
+	git bundle create - --all HEAD >bundle-one &&
+	mkdir -p down &&
+	git -C down bundle create - --all HEAD >bundle-two &&
+	git bundle verify bundle-one &&
+	git bundle verify bundle-two &&
+	git ls-remote bundle-one >expect &&
+	git ls-remote bundle-two >actual &&
+	test_cmp expect actual
+'
+
 test_done
