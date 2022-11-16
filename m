Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8DDC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 15:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiKPPuj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiKPPuh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 10:50:37 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF2345A0A
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:50:36 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f27so45158982eje.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88eDgFl3a5wm7IoeUmCd8bQ5QAx5YiFvjJgQ1L9ysPA=;
        b=fkr5tzAT/cUXe8RrM1NPNK1sH5/BepS3ZIyJkP1xdXyGR0weIljaDLI0QuXxXIciUR
         8w1YSSDZ2wH3d2fqiEIWU/EucuswmC8bwx/jnkqUbYUS5muWsWA5SEQkaViD2i6Reipc
         TASieQioSOvOevUU/d8CFsGpDxjgSzB6ZfeERWo7ROMvjHoEAEN/Dkx/zlLVKiF7XEiF
         iCAe9Is6pd8w1x+i0lLPCnS0E4nvfEgh9X2oJ0Khh54rL8Yr259VheUr5LVTOu4eo3Vm
         n/c8tEG7tQvgaRPKfB9djEz9y4Rj7OecMWJ9/5MZoyf0vumjV33B+TRUbxbkJzka5o1V
         MNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88eDgFl3a5wm7IoeUmCd8bQ5QAx5YiFvjJgQ1L9ysPA=;
        b=lyFhg1OBxs23mYuvsPVuCBJplLBzEA7HwTzOwyp5MnzyN9Q48XV7x8kzstNYvlaYrk
         ytYZuN3l9nDZlaj/w+5CTcNXVe+YmUu3r01m2ogw/IxR7i0mpg8H0X/x3iXR/5KD8Xan
         tje02R+VZ3db8qneOA+wImMTY2rOm07gd/Cm38M82tGvXqa9KbVwV+PgEWyRCIcBD7mc
         23vXfqdpOdTGPNZlg4dUXkgPnPpCouaIDVUmG8XylJXnl2sZcW2+iuspD5rcAiZWRIVR
         huiRfxqWnHR4uhD0dH2H2nF6wXQFOlGrGbxrXk7HmdwCEW7SB+fyvcKsvO+XHmzjgppT
         7IAw==
X-Gm-Message-State: ANoB5pkKQlkZMP/Ais1Rh2d+Fqipktz45zuTSamj9cMq85B8uuUc79ZH
        2/x5msM0B7tyK1nmZYRIGlQRn48wHuu15w==
X-Google-Smtp-Source: AA0mqf6YX9UGckMEQ7L+m5YYzQ8HTt/SsQebpB2tr62oq3ZWXyzz2ZPa20VoRjcEjHIse5bM0ozyEQ==
X-Received: by 2002:a17:907:8b87:b0:78e:ebf:2722 with SMTP id tb7-20020a1709078b8700b0078e0ebf2722mr17558963ejc.490.1668613834690;
        Wed, 16 Nov 2022 07:50:34 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b26-20020a1709062b5a00b00780f24b797dsm6988438ejg.108.2022.11.16.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:50:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovKgL-004FK5-2k;
        Wed, 16 Nov 2022 16:50:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] delta-islands: free island-related data after use
Date:   Wed, 16 Nov 2022 16:44:31 +0100
References: <20221116105013.1777440-1-e@80x24.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221116105013.1777440-1-e@80x24.org>
Message-ID: <221116.861qq2kieu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 16 2022, Eric Wong wrote:

> On my use case involving 771 islands of Linux on kernel.org,
> this reduces memory usage by around 25MB.  The bulk of that
> comes from free_remote_islands, since free_island_regexes only
> saves around 40k.
>
> This memory is saved early in the memory-intensive pack process,
> making it available for the remainder of the long process.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>   Note: I only noticed this when I screwed up up a pack.island RE,
>   ended up with hundreds of thousands of islands instead of 771,
>   and kept OOM-ing :x
>
>   Memory savings were measured using the following patch which
>   relies on a patched LD_PRELOAD-based malloc debugger:
>   https://80x24.org/spew/20221116095404.3974691-1-e@80x24.org/raw

FWIW SANITIZE=leak will find this if you stick a "remote_islands = NULL"
and run e.g. t5320-delta-islands.sh, but maybe you needed this closer to
production.

Valgrind will also work, but of course be *much* slower.

>   Will try to hunt down more memory savings in the nearish future.
>
>  delta-islands.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/delta-islands.c b/delta-islands.c
> index 26f9e99e1a..391e947cc6 100644
> --- a/delta-islands.c
> +++ b/delta-islands.c
> @@ -454,6 +454,31 @@ static void deduplicate_islands(struct repository *r)
>  	free(list);
>  }
>  
> +static void free_island_regexes(void)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < island_regexes_nr; i++)
> +		regfree(&island_regexes[i]);
> +
> +	FREE_AND_NULL(island_regexes);
> +	island_regexes_alloc = island_regexes_nr = 0;
> +}
> +
> +static void free_remote_islands(void)
> +{
> +	const char *island_name;
> +	struct remote_island *rl;
> +
> +	kh_foreach(remote_islands, island_name, rl, {
> +		free((void *)island_name);
> +		oid_array_clear(&rl->oids);
> +		free(rl);
> +	});
> +	kh_destroy_str(remote_islands);
> +	remote_islands = NULL;
> +}
> +
>  void load_delta_islands(struct repository *r, int progress)
>  {
>  	island_marks = kh_init_oid_map();
> @@ -461,7 +486,9 @@ void load_delta_islands(struct repository *r, int progress)
>  
>  	git_config(island_config_callback, NULL);
>  	for_each_ref(find_island_for_ref, NULL);
> +	free_island_regexes();
>  	deduplicate_islands(r);
> +	free_remote_islands();
>  
>  	if (progress)
>  		fprintf(stderr, _("Marked %d islands, done.\n"), island_counter);

Perfect shouldn't be the enemy of the good & all that, but in this case
it's not too much more effort to just give this data an appropriate
lifetime instead of the global, I tried that out for just the "regex"
part of this below.

The free_remote_islands() seems to be similarly alive between
"find_island_for_ref" and "deduplicate_islands".

Your version also works, but the root cause of this sort of thing is
these global lifetimes, which sometimes we do for a good reason, but in
this case we don't.

It's more lines, but e.g. your FREE_AND_NULL() and resetting "nr" and
"alloc" makes one wonder how the data might be used outside fo that
load_delta_islands() chain (which is needed, if we invoke it again),
when we can just init a stack variable to hold it instead...

diff --git a/delta-islands.c b/delta-islands.c
index 26f9e99e1a9..ef86a91059c 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -312,29 +312,41 @@ void resolve_tree_islands(struct repository *r,
 	free(todo);
 }
 
-static regex_t *island_regexes;
-static unsigned int island_regexes_alloc, island_regexes_nr;
+struct island_config_data {
+	regex_t *rx;
+	size_t nr;
+	size_t alloc;
+};
 static const char *core_island_name;
 
-static int island_config_callback(const char *k, const char *v, void *cb UNUSED)
+static void island_config_data_release(struct island_config_data *icd)
+{
+	for (size_t i = 0; i < icd->nr; i++)
+		regfree(&icd->rx[i]);
+	free(icd->rx);
+}
+
+static int island_config_callback(const char *k, const char *v, void *cb)
 {
+	struct island_config_data *data = cb;
+
 	if (!strcmp(k, "pack.island")) {
 		struct strbuf re = STRBUF_INIT;
 
 		if (!v)
 			return config_error_nonbool(k);
 
-		ALLOC_GROW(island_regexes, island_regexes_nr + 1, island_regexes_alloc);
+		ALLOC_GROW(data->rx, data->nr + 1, data->alloc);
 
 		if (*v != '^')
 			strbuf_addch(&re, '^');
 		strbuf_addstr(&re, v);
 
-		if (regcomp(&island_regexes[island_regexes_nr], re.buf, REG_EXTENDED))
+		if (regcomp(&data->rx[data->nr], re.buf, REG_EXTENDED))
 			die(_("failed to load island regex for '%s': %s"), k, re.buf);
 
 		strbuf_release(&re);
-		island_regexes_nr++;
+		data->nr++;
 		return 0;
 	}
 
@@ -365,8 +377,10 @@ static void add_ref_to_island(const char *island_name, const struct object_id *o
 }
 
 static int find_island_for_ref(const char *refname, const struct object_id *oid,
-			       int flags UNUSED, void *data UNUSED)
+			       int flags UNUSED, void *cb)
 {
+	struct island_config_data *data = cb;
+
 	/*
 	 * We should advertise 'ARRAY_SIZE(matches) - 2' as the max,
 	 * so we can diagnose below a config with more capture groups
@@ -377,8 +391,8 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	struct strbuf island_name = STRBUF_INIT;
 
 	/* walk backwards to get last-one-wins ordering */
-	for (i = island_regexes_nr - 1; i >= 0; i--) {
-		if (!regexec(&island_regexes[i], refname,
+	for (i = data->nr - 1; i >= 0; i--) {
+		if (!regexec(&data->rx[i], refname,
 			     ARRAY_SIZE(matches), matches, 0))
 			break;
 	}
@@ -456,11 +470,14 @@ static void deduplicate_islands(struct repository *r)
 
 void load_delta_islands(struct repository *r, int progress)
 {
+	struct island_config_data data = { 0 };
+
 	island_marks = kh_init_oid_map();
 	remote_islands = kh_init_str();
 
-	git_config(island_config_callback, NULL);
-	for_each_ref(find_island_for_ref, NULL);
+	git_config(island_config_callback, &data);
+	for_each_ref(find_island_for_ref, &data);
+	island_config_data_release(&data);
 	deduplicate_islands(r);
 
 	if (progress)
