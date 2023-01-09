Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F6C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 03:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjAIDWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 22:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjAIDW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 22:22:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5D210FFA
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 19:22:27 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so3230413plo.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 19:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uG9JdIivOd9XS0vNuVfaqiet/alF6wc4RfyDih8tKI=;
        b=NAp+FUWn0m6u+ZF+VMxt9IYv8ZkUaCql5w7jtvtfr8RafQu2L/30gZUBX/nuLKVPq0
         u+KSgGYTMJWsmvcDLYtFGCa4JYj6K/k1u79Ll5u0+fSNydYYLUnNfwvbuwG+96Ua74KX
         kniMl+bVeQy0I8W4dFM2EggBL6lJrImWH5X6v0OQiyWR79pEETlx0mZgucQp83443iol
         z3PxaCar0rsaAxWIOEzdQ6GjvblCzdHevweMkULscNLBVMS8WC1jL/S8ZAmAhduWqXMV
         7lk0rpTZrX2evFM+WN1r2MTXYdeapc7Ak8mgzfzb/3993hffhtczscuIz+aKi1L6FCpk
         5yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uG9JdIivOd9XS0vNuVfaqiet/alF6wc4RfyDih8tKI=;
        b=s78WuomCz2Tq824DfKAXKl3oC6lG8EEOzp3ynCwBeBydJufiKx6SovzwM6YNwwmxDW
         7JT4kLbRkeGeCoKPyWNQ1D24fZB38PB7R0A5FGKKmHddjc/IoAIKTOnSIPDDL6Da7e8U
         7J2yLBfE8PZgN4smSUZFbOBtBJ3j4k3/uyommSPOkI947GmJlK5/8p+1TCxLBID0pgWK
         fpmWcXpINZYhFjht9kcLzvE+96l8ooo03eJaRdhZxoiG90DiXAyOz2TC34jlKoA0Gp5Z
         Y5l+RQj/29EeM1S2dpmCQZiiyCdqLj0vPyw4HxNuFxvIKaTnsTK+G1x+ZSIzPeOLU+XY
         Yf0A==
X-Gm-Message-State: AFqh2krlmqjZgaTLSVeA4EwBIE6dN/lLsvm36Fj22DxgIJm9MDmzHXJN
        6h+/5HMhnM8BBwlR+Toh0IlTcyqvSaYrwA==
X-Google-Smtp-Source: AMrXdXvp2jPMoNpb7DzLNb6OVNaJ7+0n6W7N7UKuRFtauWl0On+A7Eq/sl/bYc/7P+lBm4i5DHDKag==
X-Received: by 2002:a17:902:cb0f:b0:193:38ce:7bb8 with SMTP id c15-20020a170902cb0f00b0019338ce7bb8mr165182ply.37.1673234547149;
        Sun, 08 Jan 2023 19:22:27 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b00172b87d9770sm4869737plg.81.2023.01.08.19.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:22:26 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 4/8] bundle-uri: download in creationToken order
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 12:22:26 +0900
In-Reply-To: <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 06 Jan 2023
        20:36:41 +0000")
Message-ID: <xmqqtu10wfwt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct sorted_bundle_list {
> +	struct remote_bundle_info **items;
> +	size_t alloc;
> +	size_t nr;
> +};
> +
> +static int insert_bundle(struct remote_bundle_info *bundle, void *data)
> +{
> +	struct sorted_bundle_list *list = data;
> +	list->items[list->nr++] = bundle;
> +	return 0;
> +}

Especially given that the type of the list claims it to be "sorted",
insert_bundle() is a misleading name for a helper that merely
appends to it to make the list (tentatively) unsorted.

I am not opposed to "append all to make an unsorted list, then sort
the list at the end" strategy.

> +static int compare_creation_token(const void *va, const void *vb)
> +{
> +	const struct remote_bundle_info * const *a = va;
> +	const struct remote_bundle_info * const *b = vb;
> +
> +	if ((*a)->creationToken > (*b)->creationToken)
> +		return -1;
> +	if ((*a)->creationToken < (*b)->creationToken)
> +		return 1;
> +	return 0;
> +}

Usually compare(a,b) returns the sign of (a-b), but the returned
value from the above is the opposite.  This is because we want the
list sorted from newer to older?  It may help developers to name
such a (reverse) "compare" function differently.

> +static int fetch_bundles_by_token(struct repository *r,
> +				  struct bundle_list *list)
> +{
> +	int cur;
> +	int pop_or_push = 0;
> +	struct bundle_list_context ctx = {
> +		.r = r,
> +		.list = list,
> +		.mode = list->mode,
> +	};
> +	struct sorted_bundle_list sorted = {
> +		.alloc = hashmap_get_size(&list->bundles),
> +	};
> +
> +	ALLOC_ARRAY(sorted.items, sorted.alloc);
> +
> +	for_all_bundles_in_list(list, insert_bundle, &sorted);
> +
> +	QSORT(sorted.items, sorted.nr, compare_creation_token);

If I were doing this patch, I would call the type of the list of
bundles "struct bundle_list" (without "sorted_" in its name), and
name the variable of that type used here "sorted".  That would make
it more clear that this particular bundle list starts its life as
unsorted (with "append_bundle" function adding more elements) and
then gets sorted in the end, from the above several lines.

