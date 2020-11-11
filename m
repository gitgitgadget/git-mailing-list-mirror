Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BFC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC07207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 20:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LT6yl4uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKKUCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUCB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 15:02:01 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BAFC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y11so3415574ybm.22
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 12:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=u9ARaOXv8YEzQ4vY6KmYdvovsIsDyHKmCNmvmh0DTyM=;
        b=LT6yl4uQpJIEs/a0IYpDbFpsvmZAJSUezHnl6oruJKkxy3UpyUi+oqa+efU3+XRUHN
         j5q8JtZtNFBQ2FLA2B+tDufq45ubvlI0rfSeFnJWWAqbB8gM68YKyXCe1O8N2drley0C
         uDead6b7trdFwxlGgfCkpqoJqCP4nEf2IwTUFszabxt3r1csNIazA9MaS9dV4eDLyeWm
         Atxg/fU3qM+TZl1P25c+ZArfh+JFygzAqwSPtk+Zt9zSlzqbsWgl2ouCfLDqvnTjcuHg
         /QEAw4azossHKGYT4eDZD1DAdllZ+utlMBHGd7JeCSAn7Dar9OaIU/PnMjh0pg3qCD0B
         AdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u9ARaOXv8YEzQ4vY6KmYdvovsIsDyHKmCNmvmh0DTyM=;
        b=b5xqMk3GzrVh0OpQeyfYdf22P9zxHS4WYVLbQsGHmyijBv3K/Kii82UP295ffbd3jK
         dw9xL7XiIRG4euA02YPyNiYrJkf1ejKWTQFXyhLrLzx0O2E/uh4EsBgh8vNbBsLC86yO
         O/OdAkIxT1EIsiyNgCtY6KDfC+OwST1M7NCFGJEEz9ev1yimhpB8OsDNwi2O2t7K9fMz
         ZIcyHV1TwqAujoay962454XiHYaQmifamZoMt1lzKWHzOv1EC6yqmtSIHWTRpPERaZcL
         RICbZyUo+t+mYa4bU8q6HYx3EiO+VaqkBEwObUXW2XkFmZew6+CF3wQL2PgFKZ1HOj3X
         Oq7A==
X-Gm-Message-State: AOAM5319OIYoeH5o0yfNytExwOyfPs7DvmxNvpdfHHNgmkA5CRoj8klL
        ebHVZ9PbJeeyvMUOEKm2jgfH2bTJEgV539flAxO0
X-Google-Smtp-Source: ABdhPJw9H+iNQnuaBpMNG0T+Q73eYcXtfzXhG0KDOihICanZddmkjsXttOM4qnhb0wI5mOIBj6uBJ17LZHPlyL/5ZK9e
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:57d6:: with SMTP id
 l205mr35502012ybb.117.1605124919499; Wed, 11 Nov 2020 12:01:59 -0800 (PST)
Date:   Wed, 11 Nov 2020 12:01:57 -0800
In-Reply-To: <20201102204344.342633-14-newren@gmail.com>
Message-Id: <20201111200157.3118955-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-14-newren@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: Re: [PATCH v2 13/20] merge-ort: step 1 of tree writing -- record
 basenames, modes, and oids
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +struct directory_versions {
> +	struct string_list versions;

Maybe comment that this is an unordered list of basenames to <whatever
the type of ci->merged.result is>.

> @@ -442,6 +464,7 @@ static void process_entries(struct merge_options *opt,
>  	struct strmap_entry *e;
>  	struct string_list plist = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *entry;
> +	struct directory_versions dir_metadata;
>  
>  	if (strmap_empty(&opt->priv->paths)) {
>  		oidcpy(result_oid, opt->repo->hash_algo->empty_tree);
> @@ -458,6 +481,9 @@ static void process_entries(struct merge_options *opt,
>  	plist.cmp = string_list_df_name_compare;
>  	string_list_sort(&plist);
>  
> +	/* other setup */
> +	string_list_init(&dir_metadata.versions, 0);
> +

Might be clearer to just initialize dir_metadata as {
STRING_LIST_INIT_NODUP }.

The rest makes sense.
