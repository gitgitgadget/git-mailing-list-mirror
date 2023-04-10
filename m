Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBF0C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 16:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDJQUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjDJQUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 12:20:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0015106
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:20:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so10316481pjb.5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681143651; x=1683735651;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOYdEMEWyZhzPPAopvkxcV3TEymsDH6eVttEYVK79Mg=;
        b=Ro4PjzhNT+OKpuRE/bj9/EtgKlOljXjgFUTWxTFAOsbtA0NqX9AX/s7pcZFqVEhEfo
         +RGXdGsN9+6SDe7WT6bXGxyxV6/rdmKGscwMHEmyedBHmsAED2lISp1ET8LG6kYX0aLM
         RmTcg7HmeOXHAYT1m3ubPkJM4n6oU15K+6xmlS4y2Ygi3flJCnIvsVbpNHAJ9RJq3rLi
         QUqfVN7wHWc5radprG3yZ8SU0Jo1fSfEhFbyR7qtQG6bLJrGp7IAJ6Ki3RUO3GC6wZke
         pW1fiPFZdGDFWdemDnGlFpJoXeiJahWSJTvdbet2L8WyYVfdA3hxUqdh+uig/BkOe2ks
         jmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143651; x=1683735651;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOYdEMEWyZhzPPAopvkxcV3TEymsDH6eVttEYVK79Mg=;
        b=7rNqHzmDqHNejhx6hvrUYK3D778f0d6ATsYbLrhGMX22lZBp48ua6akpBpgz7Y0vcF
         LEYC6NLX+xdXVG/DK+ibInfGpREOQwuwVju5iJKYrbZGpOqgfS/TdSaYfUU8hFgX3vBS
         P/ZmdMZ+1TFRWwtZ2Xh/QJNFE862qQkPmnE1bvNH10wWjJr1+zuYAmMD5wIpy8qN088v
         VPW2coOiWMboeKjk2CxtiAYf8wu1Ga0V6VfPbgdqlWqPiaQeHa087D1frOJi3oExSHYe
         fJKGsDPbL7LWap50pBv/ax7mrb3mJ0f2khs6e4fILkjsLYeJWsVsQYaEApW5RVOYi3I6
         lruw==
X-Gm-Message-State: AAQBX9ftGxwiUMho4x76UolnPZySq+xTN+cxLKUT6/cb/vLrpAT8VLdt
        rt/97r2HSKeTl05WEA8JfJg=
X-Google-Smtp-Source: AKy350Y4zSZOGvYPxRTeW7BrFZ9Od48D846BwBEAe7JtVe8rL6Z4An0TJRwqWqTCf+PlWSe4hIac6w==
X-Received: by 2002:a05:6a20:1823:b0:da:8917:bdc5 with SMTP id bk35-20020a056a20182300b000da8917bdc5mr6765510pzb.45.1681143651094;
        Mon, 10 Apr 2023 09:20:51 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id j3-20020aa79283000000b005d22639b577sm8023184pfa.165.2023.04.10.09.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 09:20:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
Date:   Mon, 10 Apr 2023 09:20:49 -0700
In-Reply-To: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 8 Apr 2023 11:35:24 +0200")
Message-ID: <xmqqjzyjemji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> When 29f4332e66 (Quit passing 'now' to date code, 2019-09-11) removed
> its timeval parameter, approxidate_relative() became equivalent to
> approxidate().  Convert its last two call sites and remove the redundant
> function.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---

We might keep a backward compatibility definition or comment to help
migrating in-flight (or pre-flight) callers if this were a function
more often used, but seeing that the only remaining two callers are
in the test helper, I agree the simplicity of straight removal like
this patch does is appropriate.

Thanks, will queue.

> Formatted with -U16 for easier review.  Only useful in date.c, but
> cannot be restricted to just one file.

Perhaps

	$ git -c format-patch.date.c.context=16 format-patch -1

would be a workable idea?  I do not think it makes any sense to say
"when taking a diff for this path, always use 16 lines of context"
so it should not be stored in a file to be used every time, like

	[format-patch "date.c"] context = 16

and it makes even less sense to say that all project participants
should use this context, always, so making it an attribute would be
even less appropriate.

But this was the easiest way to prototype ;-)  If this turns out to
be useful, the real version should probably be done by:

 * designing a command line option format, e.g.

    --per-path-context=date.c:16

 * instead of adding an extra "int ctxlen" parameter to the call
   path(s), add a ctxlen_map that maps path to ctxlen we read from
   the command line options to the diff_options structure.

 * In builtin_diff() where xecfg.ctxlen is assigned to, consult
   o->ctxlen_map and use o->context as a fallback.

or something along that line, I guess.

 diff.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git c/diff.c w/diff.c
index 469e18aed2..cbfbb4af96 100644
--- c/diff.c
+++ w/diff.c
@@ -3460,6 +3460,7 @@ static void builtin_diff(const char *name_a,
 			 const char *xfrm_msg,
 			 int must_show_header,
 			 struct diff_options *o,
+			 int ctxlen,
 			 int complete_rewrite)
 {
 	mmfile_t mf1, mf2;
@@ -3657,7 +3658,7 @@ static void builtin_diff(const char *name_a,
 		xpp.ignore_regex_nr = o->ignore_regex_nr;
 		xpp.anchors = o->anchors;
 		xpp.anchors_nr = o->anchors_nr;
-		xecfg.ctxlen = o->context;
+		xecfg.ctxlen = (ctxlen < 0) ? o->context : ctxlen;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (o->flags.funccontext)
@@ -4443,6 +4444,17 @@ static void fill_metainfo(struct strbuf *msg,
 	}
 }
 
+static int configured_ctxlen(const char *path)
+{
+	struct strbuf key = STRBUF_INIT;
+	int ctxlen;
+
+	strbuf_addf(&key, "format-patch.%s.context", path);
+	if (!repo_config_get_int(the_repository, key.buf, &ctxlen))
+		return ctxlen;
+	return -1;
+}
+
 static void run_diff_cmd(const char *pgm,
 			 const char *name,
 			 const char *other,
@@ -4480,12 +4492,14 @@ static void run_diff_cmd(const char *pgm,
 		return;
 	}
 	if (one && two) {
+		int ctxlen = configured_ctxlen(attr_path);
+
 		if (!o->ignore_driver_algorithm && drv && drv->algorithm)
 			set_diff_algorithm(o, drv->algorithm);
 
 		builtin_diff(name, other ? other : name,
 			     one, two, xfrm_msg, must_show_header,
-			     o, complete_rewrite);
+			     o, ctxlen, complete_rewrite);
 	} else {
 		fprintf(o->file, "* Unmerged path %s\n", name);
 	}

