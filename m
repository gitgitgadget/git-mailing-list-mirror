Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E137C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562E661058
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 17:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbhHYRE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 13:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbhHYRE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 13:04:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951DAC061757
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 10:04:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id h9so53011671ejs.4
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 10:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=yg9IUBbc34QyzLrNIe6s21wlj1Ord6iSmZFWjR6dc/U=;
        b=aCcgcsHRcsrU3XzwsLi5RhdS5CPRPr+r3kpSsQDbnFg/cnbMjGhdrhMpuBNohcTRUd
         Hjj5a4LMYiZ7jOBf3Dp1A24mEvNxHgI8JXLEVZqN8+teiyvZQvqUngjtAJc+rKGo2f59
         haGXGCNkQIEI3QqxfzK6L6VS98bsjrtW5QR26PRMGSFe75t4m86PqV9+CdNh+mQxwwYC
         jXn+F8CA1AB2N1SDWwDHPTvTB7micm53AynH9pp5N3CFL9YDGOyJbR9zw5DLXCT5glcT
         adoVBxs0sSimZ1ZS1PlqWHDzCTfFJ3h65xKRFa+thlZOlYiIHtnocgBOETedBf2Qm/+q
         UFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=yg9IUBbc34QyzLrNIe6s21wlj1Ord6iSmZFWjR6dc/U=;
        b=BvWbs5xfAp7a6/30J8JISRxMMd1h/BUcA7W8k08nxBwGJk5bWVHBBT/k8BlBsTZ2Dl
         sadR5WPLEqkwTS+iFioVRcX/gL4iP2pnJr9BiZG9y32c/6EOGocEQCUMyGVLiuklNjk3
         d0smuRJw708BtDhNSl007G/5rq5DFt7+E0isZbxosCFr35bXKcnovWJ6mnKNqUn0GIu/
         9l1l3RmRW+lC75wsxqSEtAn0LKnVtdzeR/qpBPv+VPFS9C4z5FHduyT45uewFobxzSLB
         GdTlT4INTpCHT4ukceB3VDQdyHrzE9QH6SmypevI4uaopm6QD4sndce/FlkTLb8cFrJO
         hiQA==
X-Gm-Message-State: AOAM531hiTxT9pnfYVt86dnJ5puNAgaIZGr3f9CbGDc2GV+bQST28Do2
        maOrFN1UROlr6Fb5abfHczc=
X-Google-Smtp-Source: ABdhPJzX6KShficVFJ6nOcU66vDg0GD6w1mV+PymRkKt7c7DaGCYFgVzeJpcgJUjMdlNCHxEXFeYlw==
X-Received: by 2002:a17:906:b2d2:: with SMTP id cf18mr9112520ejb.308.1629911049049;
        Wed, 25 Aug 2021 10:04:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g10sm129376ejj.44.2021.08.25.10.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 10:04:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: skip formatting updated refs with `--quiet`
Date:   Wed, 25 Aug 2021 18:57:44 +0200
References: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <40c385048a023dbd447c5f0b4c95ff32485e1e23.1629906005.git.ps@pks.im>
Message-ID: <87k0k9cv7c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 25 2021, Patrick Steinhardt wrote:

> [[PGP Signed Part:Undecided]]
> When fetching, Git will by default print a list of all updated refs in a
> nicely formatted table. In order to come up with this table, Git needs
> to iterate refs twice: first to determine the maximum column width, and
> a second time to actually format these changed refs.
>
> While this table will not be printed in case the user passes `--quiet`,
> we still go out of our way and do all these steps. In fact, we even do
> more work compared to not passing `--quiet`: without the flag, we will
> skip all references in the column width computation which have not been
> updated, but if it is set we will now compute widths for all refs.
>
> Fix this issue by completely skipping both preparation of the format and
> formatting data for display in case the user passes `--quiet`, improving
> performance especially with many refs. The following benchmark shows a
> nice speedup for a quiet mirror-fetch in a repository with 2.3M refs:
>
>     Benchmark #1: HEAD~: git-fetch
>       Time (mean =C2=B1 =CF=83):     26.929 s =C2=B1  0.145 s    [User: 2=
4.194 s, System: 4.656 s]
>       Range (min =E2=80=A6 max):   26.692 s =E2=80=A6 27.068 s    5 runs
>
>     Benchmark #2: HEAD: git-fetch
>       Time (mean =C2=B1 =CF=83):     25.189 s =C2=B1  0.094 s    [User: 2=
2.556 s, System: 4.606 s]
>       Range (min =E2=80=A6 max):   25.070 s =E2=80=A6 25.314 s    5 runs
>
>     Summary
>       'HEAD: git-fetch' ran
>         1.07 =C2=B1 0.01 times faster than 'HEAD~: git-fetch'
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/fetch.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e064687dbd..d064b66512 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -757,6 +757,9 @@ static void prepare_format_display(struct ref *ref_ma=
p)
>  		die(_("configuration fetch.output contains invalid value %s"),
>  		    format);
>=20=20
> +	if (verbosity < 0)
> +		return;
> +
>  	for (rm =3D ref_map; rm; rm =3D rm->next) {
>  		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
>  		    !rm->peer_ref ||
> @@ -827,7 +830,12 @@ static void format_display(struct strbuf *display, c=
har code,
>  			   const char *remote, const char *local,
>  			   int summary_width)
>  {
> -	int width =3D (summary_width + strlen(summary) - gettext_width(summary)=
);
> +	int width;
> +
> +	if (verbosity < 0)
> +		return;
> +
> +	width =3D (summary_width + strlen(summary) - gettext_width(summary));
>=20=20
>  	strbuf_addf(display, "%c %-*s ", code, width, summary);
>  	if (!compact_format)

I wonder what you think of the below, which is a bit more of a verbose
search/replacement change, but I think ultimately cleaner. We just pass
the "ref_map" down to all the formatting functions, and the first
function that needs to know the "compact_format" or "refcol_width"
lazily computes it (stored in a static variable). So we avoid the tricky
action at a distance of not preparing certain things because we know
we're in the quiet mode.

But if I understand your change correctly we're on the one hand not
preparing the format change, but then also not printing this at all now
under --quiet, correct? I think it would be good to split up that
proposed functional change from the optimization of the output, it also
seems like if that were done the git-fetch docs on --quiet need to be
changed.

But I wonder if once we have the change below, whether the small change
on top of it to just add a fetch.outputRefWidth=3D123 wouldn't also
largely solve the optimization problem you have, i.e. adding a config
variable to adjust the width, instead of us auto-discovering it by
looping over all refs.

Or maybe not, but I think it would be interesting to see how much of the
slowdown you have is that v.s. that we end up emitting this output to
stderr. I.e. is it the I/O of the output or the extra loop that's the
expensive part?

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e064687dbdc..88a8b3660d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -707,6 +707,24 @@ static int s_update_ref(const char *action,
 static int refcol_width =3D 10;
 static int compact_format;
=20
+static int prepared_compact_format;
+static void prepare_compact_format(void)
+{
+	const char *format =3D "full";
+
+	if (prepared_compact_format++)
+		return;
+
+	git_config_get_string_tmp("fetch.output", &format);
+	if (!strcasecmp(format, "full"))
+		compact_format =3D 0;
+	else if (!strcasecmp(format, "compact"))
+		compact_format =3D 1;
+	else
+		die(_("configuration fetch.output contains invalid value %s"),
+		    format);
+}
+
 static void adjust_refcol_width(const struct ref *ref)
 {
 	int max, rlen, llen, len;
@@ -726,6 +744,7 @@ static void adjust_refcol_width(const struct ref *ref)
 	 * anyway because we don't know if the error explanation part
 	 * will be printed in update_local_ref)
 	 */
+	prepare_compact_format();
 	if (compact_format) {
 		llen =3D 0;
 		max =3D max * 2 / 3;
@@ -743,19 +762,13 @@ static void adjust_refcol_width(const struct ref *ref)
 		refcol_width =3D rlen;
 }
=20
-static void prepare_format_display(struct ref *ref_map)
+static int prepared_refcol_width;
+static void prepare_refcol_width(struct ref *ref_map)
 {
 	struct ref *rm;
-	const char *format =3D "full";
=20
-	git_config_get_string_tmp("fetch.output", &format);
-	if (!strcasecmp(format, "full"))
-		compact_format =3D 0;
-	else if (!strcasecmp(format, "compact"))
-		compact_format =3D 1;
-	else
-		die(_("configuration fetch.output contains invalid value %s"),
-		    format);
+	if (prepared_refcol_width++)
+		return;
=20
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
 		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
@@ -767,9 +780,10 @@ static void prepare_format_display(struct ref *ref_map)
 	}
 }
=20
-static void print_remote_to_local(struct strbuf *display,
+static void print_remote_to_local(struct ref *ref_map, struct strbuf *disp=
lay,
 				  const char *remote, const char *local)
 {
+	prepare_refcol_width(ref_map);
 	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
 }
=20
@@ -800,7 +814,7 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct strbuf *display,
+static void print_compact(struct ref *ref_map, struct strbuf *display,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
@@ -816,13 +830,14 @@ static void print_compact(struct strbuf *display,
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display, r.buf, l.buf);
+	print_remote_to_local(ref_map, display, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct strbuf *display, char code,
+static void format_display(struct ref *ref_map,
+			   struct strbuf *display, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local,
 			   int summary_width)
@@ -830,15 +845,17 @@ static void format_display(struct strbuf *display, ch=
ar code,
 	int width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display, "%c %-*s ", code, width, summary);
+	prepare_compact_format();
 	if (!compact_format)
-		print_remote_to_local(display, remote, local);
+		print_remote_to_local(ref_map, display, remote, local);
 	else
-		print_compact(display, remote, local);
+		print_compact(ref_map, display, remote, local);
 	if (error)
 		strbuf_addf(display, "  (%s)", error);
 }
=20
-static int update_local_ref(struct ref *ref,
+static int update_local_ref(struct ref *ref_map,
+			    struct ref *ref,
 			    struct ref_transaction *transaction,
 			    const char *remote,
 			    const struct ref *remote_ref,
@@ -857,7 +874,7 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display, '=3D', _("[up to date]"), NULL,
+			format_display(ref_map, display, '=3D', _("[up to date]"), NULL,
 				       remote, pretty_ref, summary_width);
 		return 0;
 	}
@@ -870,7 +887,7 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display, '!', _("[rejected]"),
+		format_display(ref_map, display, '!', _("[rejected]"),
 			       _("can't fetch in current branch"),
 			       remote, pretty_ref, summary_width);
 		return 1;
@@ -881,12 +898,12 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display, r ? '!' : 't', _("[tag update]"),
+			format_display(ref_map, display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
 			return r;
 		} else {
-			format_display(display, '!', _("[rejected]"), _("would clobber existing=
 tag"),
+			format_display(ref_map, display, '!', _("[rejected]"), _("would clobber=
 existing tag"),
 				       remote, pretty_ref, summary_width);
 			return 1;
 		}
@@ -918,7 +935,7 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display, r ? '!' : '*', what,
+		format_display(ref_map, display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		return r;
@@ -940,7 +957,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display, r ? '!' : ' ', quickref.buf,
+		format_display(ref_map, display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
@@ -952,13 +969,13 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display, r ? '!' : '+', quickref.buf,
+		format_display(ref_map, display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
+		format_display(ref_map, display, '!', _("[rejected]"), _("non-fast-forwa=
rd"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
@@ -1111,8 +1128,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 		}
 	}
=20
-	prepare_format_display(ref_map);
-
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, so
 	 * merged entries are written before not-for-merge. That lets readers
@@ -1187,8 +1202,9 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, transaction, what,
-						       rm, &note, summary_width);
+				rc |=3D update_local_ref(ref_map, ref,
+						       transaction, what, rm,
+						       &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1196,7 +1212,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				format_display(&note, '*',
+				format_display(ref_map, &note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
@@ -1357,7 +1373,7 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url =3D 1;
 			}
-			format_display(&sb, '-', _("[deleted]"), NULL,
+			format_display(ref_map, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), prettify_refname(ref->name),
 				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
