Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D71C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 13:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjCON4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjCONz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 09:55:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495221DBB9
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:55:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o12so75869080edb.9
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888546;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ea01iQUCz//XwongBrGxPv+c6kXIpmXLYrQ8NJayl28=;
        b=qPQzJ02F+vZMARkfMLCG8t6801Krn2C0GhM+Q0DhiVdsCuYPO7BwDzCYsuqNcy6j2g
         oMGqoiyYtvo/4ESIXZiU0duU/QLwbQAQwIIjc8fWrCkVfFI8xXtxWC7T2SVn++RUsIVy
         zhn8qAmrHsQuKTCLFZ3VMvQ5140OzXyYooboYuDCJNFrtimTQ3h3uttFct18U49EqOF+
         W2mqh5O3ToNC0rAELi/U4PRts1FJM/kMBUyfcDYF4LytdnpH3+Y7K9u+HkCdgq+yBov0
         ggliUnrj7s9844mE6EPKlC5XQ0I7DU3o9yal3FkK3QipLqPuN2IOz8lpXyEyBqPYx1eG
         FVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888546;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea01iQUCz//XwongBrGxPv+c6kXIpmXLYrQ8NJayl28=;
        b=Bw2W5bvXrIybfg6TxsUtATL+/6soezS+tbnBDt+gIoI2uL7+oM7buj8dXP/5b3Bo5b
         +jaISajz29+qeSXw+PsdK0rypW89iCWO2tts2Vw8VxSvbt49dWkr8C90gqt/SyWkBAEi
         J6HB8bvdZMFHNmjhmtUqshnzVmQZKBXyKtrAnr/QhJUov4JkZc8ErFP0ihtpk7Mzbu72
         lNZREpaK5wO+9K82lbH70/3qY77jL4WMHY5OTx6xYPRgvv/N2Slk5Z/IgKPMJGaFWBQc
         FVgUH1UKyunbDobxsIL4YZfiIMwv+aBPSFfm0phwaXIbSDWHLqEH3sEYYgzC5At00Ete
         aKqQ==
X-Gm-Message-State: AO0yUKU7XkfTkmRb0cBEpj3rMjpoDmLpu0u4nA+wOaF25rVh+9qPQL74
        aq9unlf00yPK9vvMkWuX5Qucbtsmchs=
X-Google-Smtp-Source: AK7set+5AwUEZOdVGJS0IFEO6LX7Hl0mDIKZfk3Uk6UlCOUTOUGkvDmBn5lVLjRqWCWzJOD6kRCC8Q==
X-Received: by 2002:a17:906:d041:b0:878:955e:b4a4 with SMTP id bo1-20020a170906d04100b00878955eb4a4mr6656230ejb.33.1678888546436;
        Wed, 15 Mar 2023 06:55:46 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709060b5400b0092973e209f2sm2537710ejg.109.2023.03.15.06.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:55:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pcRbV-002xXE-1m;
        Wed, 15 Mar 2023 14:55:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 6/8] commit-reach: implement ahead_behind() logic
Date:   Wed, 15 Mar 2023 14:50:03 +0100
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <9831c23eadbcd990ca09628e5846056e4879ee3d.1678468864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <9831c23eadbcd990ca09628e5846056e4879ee3d.1678468864.git.gitgitgadget@gmail.com>
Message-ID: <230315.86cz5axgny.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
> [...]
> +void ahead_behind(struct commit **commits, size_t commits_nr,
> +		  struct ahead_behind_count *counts, size_t counts_nr)
> +{
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };

I see we have some of this already in this file, so maybe we should
leave it for a subsequent cleanup, but as DEVOPTS=extra-all notes here
we're using a positional initializer.

We could instead be more explicit, and do:

	{ .compare = compare_commits_by_gen_then_commit_date }

But as noted, maybe for asubsequent cleanup...

> +	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
> +	size_t i;

Nit: Consider dropping this "size_t i" line, and instead...

> +
> +	if (!commits_nr || !counts_nr)
> +		return;
> +
> +	for (i = 0; i < counts_nr; i++) {

...just make this "for (size_t i = 0; ...", ditto the 2x ones below.

> +struct ahead_behind_count {
> +	/**
> +	 * As input, the *_index members indicate which positions in
> +	 * the 'tips' array correspond to the tip and base of this
> +	 * comparison.
> +	 */
> +	size_t tip_index;
> +	size_t base_index;
> +
> +	/**
> +	 * These values store the computed counts for each side of the
> +	 * symmetric difference:
> +	 *
> +	 * 'ahead' stores the number of commits reachable from the tip
> +	 * and not reachable from the base.
> +	 *
> +	 * 'behind' stores the number of commits reachable from the base
> +	 * and not reachable from the tip.
> +	 */
> +	unsigned int ahead;
> +	unsigned int behind;

Even though this is the tip of the iceberg in terms of our codebase
overall, can't we just use "size_t" for counts in new APIs?

Trying to squash this into the end-state seems to work:
	
	diff --git a/commit-reach.h b/commit-reach.h
	index 2269fab8261..108651213d9 100644
	--- a/commit-reach.h
	+++ b/commit-reach.h
	@@ -123,8 +123,8 @@ struct ahead_behind_count {
	 	 * 'behind' stores the number of commits reachable from the base
	 	 * and not reachable from the tip.
	 	 */
	-	unsigned int ahead;
	-	unsigned int behind;
	+	size_t ahead;
	+	size_t behind;
	 };
	 
	 /*
	diff --git a/ref-filter.c b/ref-filter.c
	index cdc054beede..b328db696bf 100644
	--- a/ref-filter.c
	+++ b/ref-filter.c
	@@ -2013,7 +2013,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
	 			if (ref->counts) {
	 				const struct ahead_behind_count *count;
	 				count = ref->counts[ahead_behind_atoms++];
	-				v->s = xstrfmt("%d %d", count->ahead, count->behind);
	+				v->s = xstrfmt("%"PRIuMAX" " "%"PRIuMAX, count->ahead, count->behind);
	 			} else {
	 				/* Not a commit. */
	 				v->s = xstrdup("");

