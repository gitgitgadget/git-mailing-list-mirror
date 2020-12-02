Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E38C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B23206A4
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 07:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbgLBHVW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 02:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLBHVW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 02:21:22 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCBC0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 23:20:42 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c24so686465pfd.13
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 23:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=G7oSFIi66yX7zfeyBOG4mUHYhx8XfSz4qqTTA8+N8a8=;
        b=KvjzSpnckYo8fntayOiz6MReb4C1al67KXBjnJ1irjGqCSdaGff4E9X1xQ+SMLVSj4
         JCepagTqqB34A7dQbAn84mPEWJUgjhfiMvwh1j2TPU0bY+qL4vGVG4YLKx1KvcsuzE+Z
         JDRVzmaLSWpNx2xXRhTh3d2BNPSyt/QbWk3WL3n0hgBT/BO58y5/G83+pbcWcTQoPOem
         sZcFd4ik8t3MAeUkWsK49kzlh8ovq1plBsAOAOeFxD7vAJrRHQ1TTnnY8TmfiKK7XrO+
         dtqnNe5hPE+HZGiT4ITli/Et4DxzmM4gWyW/NEho2Xvrw0cvtw3l/zEj+IC9EKh5PBao
         0Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G7oSFIi66yX7zfeyBOG4mUHYhx8XfSz4qqTTA8+N8a8=;
        b=BI3UP891VHJoOoUexEJ9R6iKoF0PO/430+kefz8Blys5mndDGe6au+BXXa/q6u2odh
         eU9Pnm7CjH3QxrUTfNZuKi587tRG8AOK+O1Mtk9TOe4lHvV63SAufQBxjT+kICGNwixK
         WYcjK5tN3NimLJHBJS7rUdo198zTRRQQ+MM684FZzqXIcw4l2U0Bon+sm/3S2U2tOHQZ
         HeFSKGRdBWiVeeYIljx8C1h3/t5hzjJkiOpPeGGsUsvN+tz8CH/Fm7nUtxPNbuoZ24UX
         /oW03wE/a3zQYvkGsYcmLahs1pQu2CAdXwyd5ttSZlum4O3yYhoZKYsh07syGL8r/oDl
         sShw==
X-Gm-Message-State: AOAM531bCfNVNKluDb5pWawmaExpx4wcsIvkE+WTJ4X0U7HESmrVYwcb
        Bh3IFdeXh1ggYOvjxf/QiK84r3PXeDtc3M7l/qhs
X-Google-Smtp-Source: ABdhPJyS321KxqB+8Hyd86OHcL+JGRIy4ZmYyJbenvcck9B+wI7q1fKQb7RcCkGnhcK7ReMn5gFnAxS9j879fFOb8mz1
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9409:0:b029:18b:9e20:b9df with
 SMTP id x9-20020aa794090000b029018b9e20b9dfmr1342699pfo.63.1606893641921;
 Tue, 01 Dec 2020 23:20:41 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:20:40 -0800
In-Reply-To: <f40a39a48a834443f76015821c0e56021b58fc9a.1605649533.git.me@ttaylorr.com>
Message-Id: <20201202072040.3471532-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <f40a39a48a834443f76015821c0e56021b58fc9a.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 21/24] pack-bitmap: factor out 'add_commit_to_bitmap()'
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static int add_commit_to_bitmap(struct bitmap_index *bitmap_git,
> +				struct bitmap **base,
> +				struct commit *commit)
> +{
> +	struct ewah_bitmap *or_with = bitmap_for_commit(bitmap_git, commit);
> +
> +	if (!or_with)
> +		return 0;
> +
> +	if (*base == NULL)
> +		*base = ewah_to_bitmap(or_with);
> +	else
> +		bitmap_or_ewah(*base, or_with);
> +
> +	return 1;
> +}
> +
>  static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  				   struct rev_info *revs,
>  				   struct object_list *roots,
> @@ -544,21 +561,10 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		struct object *object = roots->item;
>  		roots = roots->next;
>  
> -		if (object->type == OBJ_COMMIT) {
> -			khiter_t pos = kh_get_oid_map(bitmap_git->bitmaps, object->oid);
> -
> -			if (pos < kh_end(bitmap_git->bitmaps)) {
> -				struct stored_bitmap *st = kh_value(bitmap_git->bitmaps, pos);
> -				struct ewah_bitmap *or_with = lookup_stored_bitmap(st);

The code from kh_get_oid_map() to lookup_stored_bitmap() here now
exists, in add_commit_to_bitmap(), in the form of an invocation to
bitmap_for_commit(). Which is correct - that is exactly what
bitmap_for_commit() does.

Looks good.
