Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E439DC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742342072E
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 22:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqMVNQId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKFW6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgKFW6c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 17:58:32 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B6C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 14:58:31 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id a73so2052902pge.15
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 14:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DahrcxKiHRhiN0NQvUdNJW1LC169YcLSxaGA8ivw8IE=;
        b=jqMVNQIdmvLl/DiDUddELUF4OjspoXhoiJYc/gPua5yZujLqAA9oCFjTzl+o3CzVeC
         5AnbR870kVTLO68nSWIDpnaMTpk9dJ2pEqCmmr20bMnR0W3GiVL6sYIzPQNidDE4MIRy
         zD34IkOA3QhqJxmNNMI2gIc+g2sD7zB5LeDo0wR/fONSskBTK6jr41ttEI+juaRwpkFf
         WWXCadYcmWRSVZUHnGBnABN4R8SQUH9ZBpfsiQyusdQJSV03I44CBCI5VAoIRKxWqpTP
         y0w4/bM+mwHYTdHvQFdQ6VINBA35v6FPX+Ud7aPXXz2lIJEslPz/OygduLUuVD/e1ac/
         fG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DahrcxKiHRhiN0NQvUdNJW1LC169YcLSxaGA8ivw8IE=;
        b=k8aetZESgoIQlcwPIOqI79dT/+twTZ6a3Ikp9tb+ATIfphzvdHPZsRowaiK7qwoYCs
         apTzMAUAgYv5IDQZntr1RPujjV4MQXY54/vUpI7ud0FuMTHf9krz8PEwvnkhcHhDpfV+
         X+2pBN2E5+TchiiPeRYe0q+/jZWItQeci1uXakU76cAw7eNqkdBBda9IaPWSwQ8tKkKF
         NL2GrSMxxcMJhec9eoYUO5hGC4swDAT80d85igUjxIxYyfB1CHiW4OmppvaikRyheqDx
         pqYNgJvbRkoMcVLGetN/OkUITzH8jyQerCUOpHAh0U4AWxKAqWlGdRsS5Wu5AuW6FKd+
         eRBA==
X-Gm-Message-State: AOAM533Fqzew6rmc2DpEu+6FYkCFvZrhIQpybh1v0uoExZwEznDsZdoC
        Rww/uKRU0yNBX5emi9orN3KvT8z1JI4jKZzaF16Q
X-Google-Smtp-Source: ABdhPJwgU4p8F0PQ5uWK68OhWRD8jscfJYJYtQ/ZfrfvdJcUBE9Ug7J4IqshoPT7GtwW/IpLATL3k6TaGsOoBGklgsxs
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a65:6847:: with SMTP id
 q7mr3594240pgt.42.1604703510772; Fri, 06 Nov 2020 14:58:30 -0800 (PST)
Date:   Fri,  6 Nov 2020 14:58:28 -0800
In-Reply-To: <20201102204344.342633-10-newren@gmail.com>
Message-Id: <20201106225828.774616-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20201102204344.342633-10-newren@gmail.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static void setup_path_info(struct merge_options *opt,
> +			    struct string_list_item *result,
> +			    const char *current_dir_name,
> +			    int current_dir_name_len,
> +			    char *fullpath, /* we'll take over ownership */
> +			    struct name_entry *names,
> +			    struct name_entry *merged_version,
> +			    unsigned is_null,     /* boolean */
> +			    unsigned df_conflict, /* boolean */

Booleans could be int, I think?

> +			    unsigned filemask,
> +			    unsigned dirmask,
> +			    int resolved          /* boolean */)
> +{
> +	struct conflict_info *path_info;
> +
> +	assert(!is_null || resolved);
> +	assert(!df_conflict || !resolved); /* df_conflict implies !resolved */
> +	assert(resolved == (merged_version != NULL));
> +
> +	path_info = xcalloc(1, resolved ? sizeof(struct merged_info) :
> +					  sizeof(struct conflict_info));
> +	path_info->merged.directory_name = current_dir_name;
> +	path_info->merged.basename_offset = current_dir_name_len;
> +	path_info->merged.clean = !!resolved;
> +	if (resolved) {
> +		path_info->merged.result.mode = merged_version->mode;
> +		oidcpy(&path_info->merged.result.oid, &merged_version->oid);
> +		path_info->merged.is_null = !!is_null;
> +	} else {
> +		int i;
> +
> +		for (i = 0; i < 3; i++) {
> +			path_info->pathnames[i] = fullpath;
> +			path_info->stages[i].mode = names[i].mode;
> +			oidcpy(&path_info->stages[i].oid, &names[i].oid);
> +		}
> +		path_info->filemask = filemask;
> +		path_info->dirmask = dirmask;
> +		path_info->df_conflict = !!df_conflict;
> +	}
> +	strmap_put(&opt->priv->paths, fullpath, path_info);

So these are placed in paths but not unmerged. I'm starting to wonder if
struct merge_options_internal should be called merge_options_state or
something, and each field having documentation about when they're used
(or better yet, have functions like collect_merge_info() return their
calculations in return values (which may be "out" parameters) instead of
in this struct).

> +	result->string = fullpath;
> +	result->util = path_info;
> +}
> +
>  static int collect_merge_info_callback(int n,
>  				       unsigned long mask,
>  				       unsigned long dirmask,
> @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
>  	 */
>  	struct merge_options *opt = info->data;
>  	struct merge_options_internal *opti = opt->priv;
> -	struct conflict_info *ci;
> +	struct string_list_item pi;  /* Path Info */
> +	struct conflict_info *ci; /* pi.util when there's a conflict */

Looking ahead to patch 10, this seems more like "pi.util unless we know
for sure that there's no conflict".
