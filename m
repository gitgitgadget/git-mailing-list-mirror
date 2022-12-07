Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9494DC352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 12:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiLGM5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 07:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLGM5K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 07:57:10 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D16537E5
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 04:57:09 -0800 (PST)
Received: (qmail 19243 invoked by uid 109); 7 Dec 2022 12:57:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 12:57:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1003 invoked by uid 111); 7 Dec 2022 12:57:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 07:57:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 07:57:07 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 10/11] bundle-uri: download bundles from an advertised
 list
Message-ID: <Y5CNo5kyByIHDVYh@coredump.intra.peff.net>
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69bf154bec63a22df8e5eac89f975625ce73c8ac.1670262639.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 05, 2022 at 05:50:38PM +0000, Derrick Stolee via GitGitGadget wrote:

> +int fetch_bundle_list(struct repository *r, const char *uri, struct bundle_list *list)
> +{
> +	int result;
> +	struct bundle_list global_list;
> +
> +	init_bundle_list(&global_list);
> +
> +	/* If a bundle is added to this global list, then it is required. */
> +	global_list.mode = BUNDLE_MODE_ALL;
> +
> +	if ((result = download_bundle_list(r, list, &global_list, 0)))
> +		goto cleanup;
> +
> +	result = unbundle_all_bundles(r, &global_list);
> +
> +cleanup:
> +	for_all_bundles_in_list(&global_list, unlink_bundle, NULL);
> +	clear_bundle_list(&global_list);
> +	return result;
> +}

The "uri" parameter in this function is unused. I'm not sure if that's
indicative of a bug or missing feature (e.g., could it be the base for a
relative url?), or if it's just a leftover from development.

If the latter, I'm happy to add it to my list of cleanups.

There are a couple other unused parameters in this series, too, but they
are all in virtual functions and must be kept. I'll add them to my list
of annotations.

-Peff
