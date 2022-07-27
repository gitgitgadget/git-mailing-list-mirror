Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A6C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 22:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiG0WKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 18:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiG0WJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 18:09:25 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD85A150
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:09:19 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f65so1309pgc.12
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 15:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=vxxkBQ9AAOe9Z/PTPhMQ7z7joF9XHpqjZ2JdWCYXfXM=;
        b=rIAcPr3Ba1+pfJoduqA7SnGWHCcjukRIRULhf2+af1FSXP08UdN2JcsSgDCD/CWcvE
         eHGivmoNhR3qqQ4boWS1e4LkZkxTlWolUsaO1KcQvsSJVTT225V2WlyqKwhzX1zY70Cr
         VClQA8JZTOPJV1kjXn3FL9dLWJ6kVO2ePgiv6N5nEnqg3zUcr2SWavwSG6rqv25Fdzl9
         gNMHNqK7HH+ccjFMLoZPho7M7BhOSSD7KQpOfTUjUVL/+bxNLdrGwmyxLzcVZ4ISANUI
         N3p63JqLQPGYQOWpJP6bFpVeVqDW7CvbZ5GWvfeQw1lb84oEE6zDAH0jctDv90FLkFYL
         iRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=vxxkBQ9AAOe9Z/PTPhMQ7z7joF9XHpqjZ2JdWCYXfXM=;
        b=bHSVKqglvWSeS2hMSo4scPjuLDrz832pKHBQ1DZ8aDxa2bIJoJGVqsrswkXpGfrKSX
         81NWV1Poh+oQgiLvEWo4lIqiif3F/kF+7Nl6uR3iVZhLmnFE8/Bc/lneP/Tj9N/DklsS
         5LWuyILZ7elAzuDaAtwwwCtPaqaJXXxx7Jo3bK/wmj9/VimQpYyO1R1BIJh70vG73YNd
         2bSvhMaDKe473ZQ7FEnB+XAdSZDgE81RCdilBYU7cYUrdPGbJ8iSh+spo7w5sLEWjB3L
         wvJ4RknQroZS8Jb2l0qeE4Gah6n4/j4GjbNX5s39zOwL/Uj0N67MDQeSw28hcEF6fAA4
         fZNg==
X-Gm-Message-State: AJIora8rLA1yCntkTy/fSMpSH+ncxIOR5jZGwY7irJhUosPSW9jQc5GK
        tu170Ep2AaLIUu8Q3KJn9JAR/A==
X-Google-Smtp-Source: AGRyM1s7P52FUmhqY5QA8D7EDA1fdAJGYfa1lcOCIS2C5hIU+M3x6Th1qm8PXHlsfudnufrfLNIDJA==
X-Received: by 2002:a63:4521:0:b0:419:a2dc:b3b7 with SMTP id s33-20020a634521000000b00419a2dcb3b7mr20953799pga.578.1658959758322;
        Wed, 27 Jul 2022 15:09:18 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:6dea:f5ba:2fa:f9c3])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016be527753bsm14479829plh.264.2022.07.27.15.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 15:09:17 -0700 (PDT)
Date:   Wed, 27 Jul 2022 15:09:11 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/5] bundle-uri: create basic file-copy logic
Message-ID: <YuG3h4AcZjyILvdK@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, dyroneteng@gmail.com,
        Johannes.Schindelin@gmx.de, szeder.dev@gmail.com,
        mjcheetham@outlook.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
 <7d3159f0d9a29a04b5856982f787f4eddfb91b53.1658781277.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d3159f0d9a29a04b5856982f787f4eddfb91b53.1658781277.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.07.25 20:34, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Before implementing a way to fetch bundles into a repository, create the
> basic logic. Assume that the URI is actually a file path. Future logic
> will make this more careful to other protocols.
> 
> For now, we also only succeed if the content at the URI is a bundle
> file, not a bundle list. Bundle lists will be implemented in a future
> change.
> 
> Note that the discovery of a temporary filename is slightly racy because
> the odb_mkstemp() relies on the temporary file not existing. With the
> current implementation being limited to file copies, we could replace
> the copy_file() with copy_fd(). The tricky part comes in future changes
> that send the filename to 'git remote-https' and its 'get' capability.

> At that point, we need the file descriptor closed _and_ the file
> unlinked.

Ahh, it looks like this was the point I missed in my previous review.
IIUC, we need the file unlinked because http_get_file() will eventually
call finalize_object_file() to move a tempfile to the final object name,
and that will fail if we have an empty file already in place.


> If we were to keep the file descriptor open for the sake of
> normal file copies, then we would pollute the rest of the code for
> little benefit. This is especially the case because we expect that most
> bundle URI use will be based on HTTPS instead of file copies.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Makefile     |   1 +
>  bundle-uri.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  bundle-uri.h |  14 +++++++
>  3 files changed, 119 insertions(+)
>  create mode 100644 bundle-uri.c
>  create mode 100644 bundle-uri.h
> 
> diff --git a/Makefile b/Makefile
> index 1624471badc..7d5f48069ea 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -906,6 +906,7 @@ LIB_OBJS += blob.o
>  LIB_OBJS += bloom.o
>  LIB_OBJS += branch.o
>  LIB_OBJS += bulk-checkin.o
> +LIB_OBJS += bundle-uri.o
>  LIB_OBJS += bundle.o
>  LIB_OBJS += cache-tree.o
>  LIB_OBJS += cbtree.o
> diff --git a/bundle-uri.c b/bundle-uri.c
> new file mode 100644
> index 00000000000..b35babc36aa
> --- /dev/null
> +++ b/bundle-uri.c
> @@ -0,0 +1,104 @@
> +#include "cache.h"
> +#include "bundle-uri.h"
> +#include "bundle.h"
> +#include "object-store.h"
> +#include "refs.h"
> +#include "run-command.h"
> +
> +static int find_temp_filename(struct strbuf *name)
> +{
> +	int fd;
> +	/*
> +	 * Find a temporary filename that is available. This is briefly
> +	 * racy, but unlikely to collide.
> +	 */
> +	fd = odb_mkstemp(name, "bundles/tmp_uri_XXXXXX");
> +	if (fd < 0) {
> +		warning(_("failed to create temporary file"));
> +		return -1;
> +	}
> +
> +	close(fd);
> +	unlink(name->buf);
> +	return 0;
> +}
> +
> +static int copy_uri_to_file(const char *file, const char *uri)
> +{
> +	/* File-based URIs only for now. */
> +	return copy_file(file, uri, 0);
> +}
> +
> +static int unbundle_from_file(struct repository *r, const char *file)
> +{
> +	int result = 0;
> +	int bundle_fd;
> +	struct bundle_header header = BUNDLE_HEADER_INIT;
> +	struct string_list_item *refname;
> +	struct strbuf bundle_ref = STRBUF_INIT;
> +	size_t bundle_prefix_len;
> +
> +	if ((bundle_fd = read_bundle_header(file, &header)) < 0)
> +		return 1;
> +
> +	if ((result = unbundle(r, &header, bundle_fd, NULL)))
> +		return 1;
> +
> +	/*
> +	 * Convert all refs/heads/ from the bundle into refs/bundles/
> +	 * in the local repository.
> +	 */
> +	strbuf_addstr(&bundle_ref, "refs/bundles/");
> +	bundle_prefix_len = bundle_ref.len;
> +
> +	for_each_string_list_item(refname, &header.references) {
> +		struct object_id *oid = refname->util;
> +		struct object_id old_oid;
> +		const char *branch_name;
> +		int has_old;
> +
> +		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
> +			continue;
> +
> +		strbuf_setlen(&bundle_ref, bundle_prefix_len);
> +		strbuf_addstr(&bundle_ref, branch_name);
> +
> +		has_old = !read_ref(bundle_ref.buf, &old_oid);
> +		update_ref("fetched bundle", bundle_ref.buf, oid,
> +			   has_old ? &old_oid : NULL,
> +			   REF_SKIP_OID_VERIFICATION,
> +			   UPDATE_REFS_MSG_ON_ERR);
> +	}
> +
> +	bundle_header_release(&header);

We still also need to release bundle_ref here, right?


> +	return result;
> +}
> +
> +int fetch_bundle_uri(struct repository *r, const char *uri)
> +{
> +	int result = 0;
> +	struct strbuf filename = STRBUF_INIT;
> +
> +	if ((result = find_temp_filename(&filename)))
> +		goto cleanup;
> +
> +	if ((result = copy_uri_to_file(filename.buf, uri))) {
> +		warning(_("failed to download bundle from URI '%s'"), uri);
> +		goto cleanup;
> +	}
> +
> +	if ((result = !is_bundle(filename.buf, 0))) {
> +		warning(_("file at URI '%s' is not a bundle"), uri);
> +		goto cleanup;
> +	}
> +
> +	if ((result = unbundle_from_file(r, filename.buf))) {
> +		warning(_("failed to unbundle bundle from URI '%s'"), uri);
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	unlink(filename.buf);
> +	strbuf_release(&filename);
> +	return result;
> +}
> diff --git a/bundle-uri.h b/bundle-uri.h
> new file mode 100644
> index 00000000000..8a152f1ef14
> --- /dev/null
> +++ b/bundle-uri.h
> @@ -0,0 +1,14 @@
> +#ifndef BUNDLE_URI_H
> +#define BUNDLE_URI_H
> +
> +struct repository;
> +
> +/**
> + * Fetch data from the given 'uri' and unbundle the bundle data found
> + * based on that information.
> + *
> + * Returns non-zero if no bundle information is found at the given 'uri'.
> + */
> +int fetch_bundle_uri(struct repository *r, const char *uri);
> +
> +#endif
> -- 
> gitgitgadget
> 
