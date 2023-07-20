Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0F1EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGTUmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGTUmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:42:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DEB12F
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:42:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-573cacf4804so11299437b3.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689885755; x=1690490555;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n2g+bFWELCFZZl+6MEu0MQzepu9tnxCFiZznu2paeLg=;
        b=dd1RfscffeMFkvdZgs2OuF5QnaoCGBaLOvHbMxsZRTZJjdM38tjF7EGjgY9vpMplIP
         HAhYXEdFYM+Uv0cJnwTyqsIHQ1oK++Whfil0c+7R6GcFETZ/LNOt5ViYK2Mp525x0OyH
         smtqyU+PmWqVz3isQbCe7qPJ+ZI96a+PwUyGxEluQqFbglzr02CTDyxKuFd1asPGJFfy
         a9DvzC3GlORm4FBv0htCVnC27dZAAKUcanI26uXNOiFoBpOLdHZgZZvYH0YqxqWrqq+J
         wi+W5yUc1FP4YEblk8ObNTxn2zQJQOAzBC77cpl64xqvgMXgiynw8h7cOBF2pjBLawVj
         QxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689885755; x=1690490555;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n2g+bFWELCFZZl+6MEu0MQzepu9tnxCFiZznu2paeLg=;
        b=lNUEn/exMASF9djh677cUJpSliXAwwUA90jTHM6G4wpCBbA9UDn4BEz8XpwWQ1kJS+
         0zYByoJ/KY8zFah7pOvyILfbooGr4iX9JDuJUJNYYCb5tPyXp//IBZ9xY3wJXDaiyUvD
         uJ5U2usvjZdW5ReabQgt80jY67rDd108vdNK3qYtR1gRvukLiNm2Iio+MT9MG4d2WMct
         2r1Jd1J2tqoldCc2N8NbaX40DIinhhFfFSsp7eKKju58UXhaBE0kGk10uxRrxs+dNnaE
         8yXIG8G7Mkie3buCl1iAD4xpp3lb74RkCH2nB/u67rPLGX0SKjearJ9FjCMH9NhW2gR+
         3BRw==
X-Gm-Message-State: ABy/qLamPUW2FRxcUkmEfDoP8/liVtw0BvrC59VCpAJ1BP+FQ7MR06wx
        HM7IUObmbmbYoHM8y8O5eMbYLbLkD/Q0HxZXc4XC
X-Google-Smtp-Source: APBJJlGqqlaJx45GXeGNh/5oOve0T7Vn4ktDkEGKPgP60hXlVYSu5BDJt36h3cU8tE2AxNE71hHuAZar+99Y85sS8FKF
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a25:51c2:0:b0:ced:497e:df40 with
 SMTP id f185-20020a2551c2000000b00ced497edf40mr605ybb.7.1689885755059; Thu,
 20 Jul 2023 13:42:35 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:42:32 -0700
In-Reply-To: <ZLgnJdo3o9WA5sNy@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720204232.1328482-1-jonathantanmy@google.com>
Subject: Re: [PATCH v5 3/4] repo-settings: introduce commitgraph.changedPathsVersion
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> What happens if we have a combination of the two, like:
> 
>     [commitGraph]
>         readChangedPaths = false
>         changedPathsVersion = 1
> 
> ? From reading the implementation below, I think the answer is that
> changedPathsVersion would win out. I think that's fine behavior to
> implement (the more modern configuration option taking precedence over
> the deprecated one). But I think that we should either (a) note that
> precedence in the documentation here, or (b) issue a warning() when both
> are set.
> 
> For my $.02, I think that doing just (a) would be sufficient.

Thanks. I added a note to the documentation.

> > -	if (s->commit_graph_read_changed_paths) {
> > +	if (s->commit_graph_changed_paths_version != 0) {
> >  		pair_chunk(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> >  			   &graph->chunk_bloom_indexes);
> >  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
> 
> Just a small note, but writing this as
> 
>     if (!s->commit_graph_changed_paths_version)
> 
> would probably be more in line with our coding guidelines.

Ah, yes. Changed it (without the exclamation mark).

> > diff --git a/repo-settings.c b/repo-settings.c
> > index 3dbd3f0e2e..e3b6565ffc 100644
> > --- a/repo-settings.c
> > +++ b/repo-settings.c
> > @@ -24,6 +24,7 @@ void prepare_repo_settings(struct repository *r)
> >  	int value;
> >  	const char *strval;
> >  	int manyfiles;
> > +	int readChangedPaths;
> 
> Small note: this should be snake-cased like "read_changed_paths".

Whoops...thanks for the catch.

 
