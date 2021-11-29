Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB64C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 16:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346906AbhK2Qj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 11:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbhK2Qh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 11:37:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4839FC08ED38
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:26:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x15so72587354edv.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pIgBWXfdiZXCBPX8uvII7ZSt6aIJP2j+KSdtnWgs9IY=;
        b=cCT8gh3OcUIGQQMLHgUst64MA5HYRwqsEB2YtImMMYrkcq+4lnWN9PPMXHOwCLORTN
         CgbsVQu160F18cVo6pMzOLPQNJlXq2UgYXnFwwgjRpxtMoTrK0nuniks06BX7C1GHThl
         xaK8uJZ+AknJLv1Sh6Dm9LG3R+J2iocUWsnDSIl7/pMBGIJNspvajNjHpKm5/WXMV+7k
         zDrrNRI7TFqulAVYVLG8Co2XTHVE3kTYoYeC6ScYBGrnsNNza5yakZTz3+F5FSVma3zP
         qnU9rKjQgzE0M6+Lj3cJWPUNN3vot5KLv2HAScAhGffoMGWXJOeGbutr1U1MvGNJ7TS5
         gx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pIgBWXfdiZXCBPX8uvII7ZSt6aIJP2j+KSdtnWgs9IY=;
        b=rVfVdT7uxJ0V47qgtDZsnIbqd+e83Rg2+DZLfK1ULQtKGSk1cWkAxhUC2FNyyMWrB7
         vnOsT6lcZZtOJOHFl4HEl9fuktfmBY1cCtPbQDCjBcY07jYxU/QMhh0AnBkoR/RYzymy
         +gUulzxKUCH6PxpJ7Zcmx6zqWt0BQBzDQWFwJDORFZNvKDNLOqJAjqcrDfXNGKmObrTl
         0HI/RWGudhB76wp+w7Dr5wsCUkkwwkq6Cz1HhToO8yDGqyALz8a0Fvule6aKI/l/SNjL
         KbAbPUlVcC/zsw/DU30WJCNA/zr13oEnQVngZkp8d19KfRw/a8tNF2s5cGezmHvKuHUr
         9YyQ==
X-Gm-Message-State: AOAM531BrdLk7ZO1fsnR/6hvdPO0jaQm281vXyKTvpJ6Cm3sJvjLLBPB
        P/+enqvvXh/xYZKvX10Gbh8=
X-Google-Smtp-Source: ABdhPJzYir+gXxLXbeWIay75F/5Z5/00IUfFYkW75QniuB1v8+flA5v9N6G7Thh+jUjU1E2F/SxTUA==
X-Received: by 2002:a05:6402:3481:: with SMTP id v1mr76620702edc.337.1638196005681;
        Mon, 29 Nov 2021 06:26:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sa17sm7941669ejc.123.2021.11.29.06.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:26:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mrhcC-000l2n-8Q;
        Mon, 29 Nov 2021 15:26:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] test-lib.sh: set GIT_TRACE2_EVENT_NESTING
Date:   Mon, 29 Nov 2021 15:12:20 +0100
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <3d1bbc91aa3a465ecec2de130456b9ccc08f3032.1638193666.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <3d1bbc91aa3a465ecec2de130456b9ccc08f3032.1638193666.git.gitgitgadget@gmail.com>
Message-ID: <211129.86fsrff36j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 29 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The GIT_TRACE2_EVENT feed has a limited nesting depth to avoid
> overloading the feed when recursing into deep paths while adding more
> nested regions.
>
> Some tests use the GIT_TRACE2_EVENT feed to look for internal events,
> ensuring that intended behavior is happening.
>
> One such example is in t4216-log-bloom.sh which looks for a statistic
> given as a trace2_data_intmax() call. This test started failing under
> '-x' with 2ca245f8be5 (csum-file.h: increase hashfile buffer size,
> 2021-05-18) because the change in stderr triggered the progress API to
> create an extra trace2 region, ejecting the statistic.
>
> This change increases the value of GIT_TRACE2_EVENT_NESTING across the
> entire test suite to avoid errors like this. Future changes will remove
> custom assignments of GIT_TRACE2_EVENT_NESTING from some test scripts
> that were aware of this limitation.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/test-lib.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 2679a7596a6..2e815c41c8f 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -476,6 +476,13 @@ export GIT_TEST_MERGE_ALGORITHM
>  GIT_TRACE_BARE=3D1
>  export GIT_TRACE_BARE
>=20=20
> +# Some tests scan the GIT_TRACE2_EVENT feed for events, but the
> +# default depth is 2, which frequently causes issues when the
> +# events are wrapped in new regions. Set it to a sufficiently
> +# large depth to avoid custom changes in the test suite.
> +GIT_TRACE2_EVENT_NESTING=3D100
> +export GIT_TRACE2_EVENT_NESTING
> +

Thanks for following up on this.

Rather than hardcoding 100 wouldn't it make sense to have something like
the below (which I barely checked for whether it compiled or not, just
to check how hard it was to change), so that we can just set this to a
"false" value to disable the nesting guard entirely?

Needing to dance around the value beint an integer or true/false is an
unfortunate side-effect of there not being two separate "enable nesting
guard?" and "nest level?" config knob, but there's not much to do about
that at this point, so I just mapped "false" to "-1" internally.

Maybe values of 0 and 1 should be an error in any case? I didn't check,
that would make this approach simpler.

diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.=
txt
index fe1642f0d40..2be5474fdcd 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -35,10 +35,14 @@ trace2.eventBrief::
 	`GIT_TRACE2_EVENT_BRIEF` environment variable.  Defaults to false.
=20
 trace2.eventNesting::
-	Integer.  Specifies desired depth of nested regions in the
+	Integer or "false" boolean.  Specifies desired depth of nested regions in=
 the
 	event output.  Regions deeper than this value will be
 	omitted.  May be overridden by the `GIT_TRACE2_EVENT_NESTING`
 	environment variable.  Defaults to 2.
++
+Set this to a "false" value (see linkgit:git-config[1] for accepted
+values, i.e. "false", "off" etc.) to remove the limitation on nesting
+entirely.
=20
 trace2.configParams::
 	A comma-separated list of patterns of "important" config
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 3a0014417cc..135d3fbd8c3 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -53,8 +53,22 @@ static int fn_init(void)
 		return want;
=20
 	nesting =3D tr2_sysenv_get(TR2_SYSENV_EVENT_NESTING);
-	if (nesting && *nesting && ((max_nesting =3D atoi(nesting)) > 0))
-		tr2env_event_max_nesting_levels =3D max_nesting;
+	if (nesting) {
+		/*
+		 * TODO: Maybe expose the "off" part of
+		 * git_parse_maybe_bool_text() as
+		 * git_parse_maybe_bool_text_false() and use it here?
+		 * Note that we accept "GIT_TRACE2_EVENT_NESTING=3D" and
+		 * "trace2.eventNesting=3D" as "false", as with the rest
+		 * of the config mechanism and git_parse_maybe_bool()
+		 * users.
+		 */
+		if (!*nesting || !strcmp(nesting, "false") ||
+		    !strcmp(nesting, "no") || !strcmp(nesting, "off"))
+			tr2env_event_max_nesting_levels =3D -1;
+		else if (*nesting && ((max_nesting =3D atoi(nesting)) > 0))
+			tr2env_event_max_nesting_levels =3D max_nesting;
+	}
=20
 	brief =3D tr2_sysenv_get(TR2_SYSENV_EVENT_BRIEF);
 	if (brief && *brief &&
@@ -503,6 +517,15 @@ static void fn_repo_fl(const char *file, int line,
 	jw_release(&jw);
 }
=20
+static int nesting_ok(int nr_open_regions)
+{
+	if (tr2env_event_max_nesting_levels =3D=3D -1)
+		return 1;
+	if (nr_open_regions <=3D tr2env_event_max_nesting_levels)
+		return 1;
+	return 0;
+}
+
 static void fn_region_enter_printf_va_fl(const char *file, int line,
 					 uint64_t us_elapsed_absolute,
 					 const char *category,
@@ -512,7 +535,7 @@ static void fn_region_enter_printf_va_fl(const char *fi=
le, int line,
 {
 	const char *event_name =3D "region_enter";
 	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
-	if (ctx->nr_open_regions <=3D tr2env_event_max_nesting_levels) {
+	if (nesting_ok(ctx->nr_open_regions)) {
 		struct json_writer jw =3D JSON_WRITER_INIT;
=20
 		jw_object_begin(&jw, 0);
@@ -537,7 +560,7 @@ static void fn_region_leave_printf_va_fl(
 {
 	const char *event_name =3D "region_leave";
 	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
-	if (ctx->nr_open_regions <=3D tr2env_event_max_nesting_levels) {
+	if (nesting_ok(ctx->nr_open_regions)) {
 		struct json_writer jw =3D JSON_WRITER_INIT;
 		double t_rel =3D (double)us_elapsed_region / 1000000.0;
=20
@@ -564,7 +587,7 @@ static void fn_data_fl(const char *file, int line, uint=
64_t us_elapsed_absolute,
 {
 	const char *event_name =3D "data";
 	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
-	if (ctx->nr_open_regions <=3D tr2env_event_max_nesting_levels) {
+	if (nesting_ok(ctx->nr_open_regions)) {
 		struct json_writer jw =3D JSON_WRITER_INIT;
 		double t_abs =3D (double)us_elapsed_absolute / 1000000.0;
 		double t_rel =3D (double)us_elapsed_region / 1000000.0;
@@ -592,7 +615,7 @@ static void fn_data_json_fl(const char *file, int line,
 {
 	const char *event_name =3D "data_json";
 	struct tr2tls_thread_ctx *ctx =3D tr2tls_get_self();
-	if (ctx->nr_open_regions <=3D tr2env_event_max_nesting_levels) {
+	if (nesting_ok(ctx->nr_open_regions)) {
 		struct json_writer jw =3D JSON_WRITER_INIT;
 		double t_abs =3D (double)us_elapsed_absolute / 1000000.0;
 		double t_rel =3D (double)us_elapsed_region / 1000000.0;
