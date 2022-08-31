Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072EDECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 22:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiHaWCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaWCP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 18:02:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF28D4F79
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:02:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g9-20020a17090a290900b001fd59cc2c14so246038pjd.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 15:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Rh8Pkm7wzr//RxJonDWl6aI+roRD2pTtol8vbUwGzYQ=;
        b=lo9VTx7lqo9Odc2gWl5kDnK4SozfKm/tVtnJ1WOPgDgJtEaGgquJ0ULKN0qa5TCkUH
         rVfU0Os7xHciN4yfsajwfuNMHmXSohsAcBcLq2Tk7qko8ONpOz7vTsj0mw1RZyUsuBE6
         7px+ftShS2LzP+xAn93ApWZ9xnkumpzlmo2LuC03TP1FPX8YcgY8vSYFHsjobV94hJNF
         39PKg234T/4k169CryB2OXD2Uq9WJhHrIvu6GU8Vm34RrmhESJ85GmBfAJLqq/Mm1Cq3
         rCWiNwRuChmUpFPc+V8AoXeHuPSbqaFqmzle6bJqNsDr7JXfJkMcWOG6igFVn2d3nDgF
         jjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Rh8Pkm7wzr//RxJonDWl6aI+roRD2pTtol8vbUwGzYQ=;
        b=AwpNp9yUTuMnIWa8mSKRELSa15laeBl8f/7FLCcagdB7PQch5R0c0J88wVKhHna8Qq
         +CtIwwU1jXwGTwJIY0KwSBz73qbPRJPhQBeCN2lmlAM7kDE+mHgbJdcsQ69o5gUK3adl
         V5V87x1RcPLemRT8k18+tEiLStiPDJEDuFCPUZlRx7UdljzJysmsndZI8DypITQMlqCQ
         reWNUZDj1yfi6S1bTL6+bBSFikwgKhzTHm+wUAE4AH250fMuciUsS9J41LvyVKI4jgkG
         ONy0H3Bo617e0VqHPIQavrcf+wOkXpacfeQkC7/UF3H7cp8fkP3bA+C37W1nrzvnG/+K
         HlOQ==
X-Gm-Message-State: ACgBeo1Uw4CrttmBYMc25eBBG5UZfj3j/+mLrHQxmw40rkdqNSoO0YdA
        zD+EW+xcSaluIJyeh9Ve4mDKHEF5NeQ80w==
X-Google-Smtp-Source: AA6agR5EWtwVf6y6Z8rK5thtvSNuxIhbZNT/W2T3kKHkMWrqkrVB6QKjBM13CKwq1h/sv9JszZvh2R3QBMvn/w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:1cd:0:b0:430:6b9b:df37 with SMTP id
 196-20020a6301cd000000b004306b9bdf37mr998170pgb.154.1661983333235; Wed, 31
 Aug 2022 15:02:13 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:02:04 -0700
In-Reply-To: <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com> <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
Message-ID: <kl6l5yi8cbs3.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/7] bundle-uri: create base key-value pair parsing
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/**
> + * Given a key-value pair, update the state of the given bundle list.
> + * Returns 0 if the key-value pair is understood. Returns 1 if the key
> + * is not understood or the value is malformed.
> + */
> +MAYBE_UNUSED
> +static int bundle_list_update(const char *key, const char *value,
> +			      struct bundle_list *list)
> +{
> +	const char *pkey, *dot;
> +	struct strbuf id = STRBUF_INIT;
> +	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
> +	struct remote_bundle_info *bundle;
> +
> +	if (!skip_prefix(key, "bundle.", &pkey))
> +		return 1;
> +
> +	dot = strchr(pkey, '.');
> +	if (!dot) {
> +		if (!strcmp(pkey, "version")) {
> +			int version = atoi(value);
> +			if (version != 1)
> +				return 1;
> +
> +			list->version = version;
> +			return 0;
> +		}
> +
> +		if (!strcmp(pkey, "mode")) {
> +			if (!strcmp(value, "all"))
> +				list->mode = BUNDLE_MODE_ALL;
> +			else if (!strcmp(value, "any"))
> +				list->mode = BUNDLE_MODE_ANY;
> +			else
> +				return 1;
> +			return 0;
> +		}

Drive-by comment from Review Club: we could simplify
"section.[subsection.]key" parsing using parse_config_key(). There are
other places in the code that do custom parsing like this, but maybe
they should use parse_config_key() too.

> +
> +		/* Ignore other unknown global keys. */
> +		return 0;
> +	}
> +
> +	strbuf_add(&id, pkey, dot - pkey);
> +	dot++;
> +
> +	/*
> +	 * Check for an existing bundle with this <id>, or create one
> +	 * if necessary.
> +	 */
> +	lookup.id = id.buf;
> +	hashmap_entry_init(&lookup.ent, strhash(lookup.id));
> +	if (!(bundle = hashmap_get_entry(&list->bundles, &lookup, ent, NULL))) {
> +		CALLOC_ARRAY(bundle, 1);
> +		bundle->id = strbuf_detach(&id, NULL);
> +		strbuf_init(&bundle->file, 0);
> +		hashmap_entry_init(&bundle->ent, strhash(bundle->id));
> +		hashmap_add(&list->bundles, &bundle->ent);
> +	}
> +	strbuf_release(&id);
> +
> +	if (!strcmp(dot, "uri")) {
> +		free(bundle->uri);
> +		bundle->uri = xstrdup(value);
> +		return 0;
> +	}
> +
> +	/*
> +	 * At this point, we ignore any information that we don't
> +	 * understand, assuming it to be hints for a heuristic the client
> +	 * does not currently understand.
> +	 */
> +	return 0;
> +}
> +
>  static int find_temp_filename(struct strbuf *name)
>  {
>  	int fd;
> -- 
> gitgitgadget
