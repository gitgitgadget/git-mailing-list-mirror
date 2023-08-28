Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A921C83F11
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 23:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjH1XWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjH1XWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 19:22:02 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B27C2
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:21:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58cd9d9dbf5so52200847b3.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693264919; x=1693869719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oPcAEYpnFDv/9h6XSoPBPK1ijSQz47/BX9vuzxYoZs=;
        b=haterrXVmwt0BLpkk99QoPwKQGQZ4xrXlYhZyUkoJ6cKq/7Gz63JQVg6UnyacsawBw
         Z/cvQVXy0h3/5183sl1gS5IL9GzpH43CMiP8YgT0Euz4GdFxMytCg0NnuPc4OghyKFXa
         LGPcywZ5fFXsLlXAJmsyqeCfjKefHycCKx/FvFI41cnPo/FmkY/jE7jxswav6XBPOYBp
         arKcSmDXelbe6teAVMdgs6RgmbRlltBDb6CwZmcfDPDQRtnJAk+dKrmYWv6UMBRpbw5u
         j2c1lLkHfYuVq5xsG0Uq7nrjmbrXNVAZwM8o72qtvZPKUHPEhl6mVAh9ewpKpO3ngF+g
         zREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693264919; x=1693869719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oPcAEYpnFDv/9h6XSoPBPK1ijSQz47/BX9vuzxYoZs=;
        b=CeV9MsNawHd8bv88D/YloP1lHXJk9tspe3oSdTXCMw52U8A4d6TWPUtNTY1y8y3LJb
         S4WheNrVRP/786QnFN5t9B24ozNwURZaqW2gIkWxcFF15kt++7HXnbCKCrcUJNiREeFj
         IQRZNjd8kuVhb76MuuTow6o3SP7xUYxuFloGVoqHeIu8daksrDDT5wXieftkA82KuCOM
         d+svKIfO1fs3M51gq0Z8IfWoLXdXuhzgDgZ9lnAyS0g4g4TBImRA0lLsGlzo7/RWmSNq
         J8mqEp/9by0QvD2g8nDB8f4ATajayJoMSpPmD/0X7Ou9xkhTgGtBcrD2HGUs/SX/Ou5H
         Vryg==
X-Gm-Message-State: AOJu0Yw74o5p5eX/2GhJ+wsDiDH88kFKRiv1DXAOs/qGh9WZuOdEtRR1
        MMJcRc/iRcouKhC7MJaVL3t2RtBjwn2kOy7iHLsjUw==
X-Google-Smtp-Source: AGHT+IEqZyVH4WYSyjf8EVcDkqsDWUk4lfH6fERMHPqpKqdzkgzoqP6t9Q1Im6iEdFmuxpTUSHKzEA==
X-Received: by 2002:a0d:d812:0:b0:583:9935:b8ba with SMTP id a18-20020a0dd812000000b005839935b8bamr1303072ywe.6.1693264919006;
        Mon, 28 Aug 2023 16:21:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u128-20020a816086000000b005869d49212fsm2441607ywb.32.2023.08.28.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 16:21:58 -0700 (PDT)
Date:   Mon, 28 Aug 2023 19:21:57 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/log.c: prepend "RFC" on --rfc
Message-ID: <ZO0sFWJLX8YaJ2F/@nand.local>
References: <20230828144940.18245-1-sir@cmpwn.com>
 <xmqqa5ubi1nh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5ubi1nh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2023 at 09:15:30AM -0700, Junio C Hamano wrote:
> In the current code before this patch, the rev.subject_prefix member
> holds one of:
>
>  * hardcoded "PATCH" in BSS (i.e. fmt_patch_subject_prefix)
>  * hardcoded "RFC PATCH" in BSS when "--rfc" is given
>  * value given to command line arg "--subject-prefix=<prefix>"
>  * value given to format.subjectprefix
>
> and the last one should be freed.  We are removing the second one
> and replacing it with whatever we will do when adding this feature
> so we should be able to make it freeable.  And I do not think it is
> hard to make the third one freeable.
>
> I wonder how far we can go to plug this leak by simply
>
>  - making subject_prefix_callback() xstrdup() its arg and free the
>    current value, unless it is the same pointer as
>    fmt_patch_subject_prefix, before assigning a new value, and
>
>  - making "format.subjectprefix" take the value in a temporary
>    variable from git_config_string(), call
>    subject_prefix_callback(), and free that temporary.

I am not super familiar with this code, so could easily be missing
something here, but I think that you can do this in a more direct way
like so:

--- 8< ---
diff --git a/builtin/log.c b/builtin/log.c
index 854216ee9c..f1c6c08f75 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -67,6 +67,7 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
 static int format_no_prefix;
+static char *subject_prefix;

 static const char * const builtin_log_usage[] = {
 	N_("git log [<options>] [<revision-range>] [[--] <path>...]"),
@@ -362,6 +363,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 static int cmd_log_deinit(int ret, struct rev_info *rev)
 {
 	release_revisions(rev);
+	free(subject_prefix);
 	return ret;
 }

@@ -1463,32 +1465,27 @@ static int keep_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }

-static int subject_prefix = 0;
-
 static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
+	struct rev_info *revs = opt->value;
 	BUG_ON_OPT_NEG(unset);
-	subject_prefix = 1;
-	((struct rev_info *)opt->value)->subject_prefix = arg;
+
+	revs->subject_prefix = arg;
+
 	return 0;
 }

 static int rfc_callback(const struct option *opt, const char *arg, int unset)
 {
-	/*
-	 * The subject_prefix in rev_info is not heap-allocated except in this
-	 * specific case, so there is no obvious place to free it. Since this
-	 * value is retained for the lifetime of the process, we just
-	 * statically allocate storage for it here.
-	 */
-	static char *prefix;
+	struct rev_info *revs = opt->value;
+
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);

-	free(prefix);
-	prefix = xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_prefix);
-	return subject_prefix_callback(opt, prefix, unset);
+	free(subject_prefix);
+	subject_prefix = xstrfmt("RFC %s", revs->subject_prefix);
+	return subject_prefix_callback(opt, subject_prefix, unset);
 }

 static int numbered_cmdline_opt = 0;
--- >8 ---

since we already have cmd_log_deinit(), which currently just calls
`release_revisions()` and then propagates a return code.

We can't foist freeing the subject_prefix into release_revisions, since
(as noted above), sometimes the value will point into the program's BSS.

But the only time we care about free()-ing subject_prefix is when we
xstrdup() a new value into it, and the only place we do that is in
rfc_callback().

Thanks,
Taylor
