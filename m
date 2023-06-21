Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE110EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjFUMOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFUMOn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:14:43 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEF4DD
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:14:42 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57040e313c5so85783147b3.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687349682; x=1689941682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdetxocN8zCRJTejWtdfNbJ4D8ap2jeaFV0PVRZb8Ic=;
        b=5Ngfh/D/htUNvqR/AhUl+kCHxfcNSjlKDa0ar8yBRlW0XWGujIn607mS2w0xl0DqEw
         wmVqN0qFzA4g+SuYsoHa1ejxTm4BPE9hC8vdarHku6b5oYaZxI5u8xD+fpD4L7mQej3Z
         ELcwtTkhE4UcNyXhzkw6/UThGvADXFAm7UAHyi5szgcO6dLb+Ej7MQTXeWqoGNDcVBEH
         vMIFzs71fjf+rfTZuUyGm+jh3jpcvW9+pTz0H3HFRpKDsmFu7YI/mJPVmj10Sb1yInuQ
         wwA9SEgT9xgBBTJov1IwmeV4ka6fspz24lImOpr7u/7Iz4W5ADQq3ujKYIcLYizO3bqr
         piQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349682; x=1689941682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdetxocN8zCRJTejWtdfNbJ4D8ap2jeaFV0PVRZb8Ic=;
        b=Q/jHNp/DLJLkXdT/U9lEXWJ9OQliHKho02QgaT0SI3u3Y1r63+cwczJI7JPut7USyM
         kQDglbzzD+k6cIUk00Eha89NuEa4p7/yF0NXektQOz+FG+NkiYCs48EhzaV+hY/OKQ9C
         4XF+vDdIgttfV8UAbpFcFCZrcGsRrUDhXpq6R2y5chH6xFQmd9l3AbeRWdTQCPeNmBB1
         QM0vLfDVD5Ivnpt7LRZelVqWixZuP2jTTRaTKZROiDfia8Um/sdz6+8tKNnKgTuBKU22
         phYj0JFF8C64hGr6NZNH/1OLy4y/6SYfP8l9AI3HxSImyFNbkahwYoaDl39gKdEU62/b
         heYw==
X-Gm-Message-State: AC+VfDyDWZBJHCOzpCCaLmy9s7dPCz6b0WT82oTBwH2DtnVu8ugG7UXe
        qvpqiHgp6E0eehBdzzWx+9fzNA==
X-Google-Smtp-Source: ACHHUZ5oZI4vM5klpIvNpSeLam1FpeTIrUd6z4TheZbW83bEoerWLkA49DuR3UHCj0tPWhNUSDEGOw==
X-Received: by 2002:a0d:e243:0:b0:56d:2e66:bd55 with SMTP id l64-20020a0de243000000b0056d2e66bd55mr17381185ywe.3.1687349682055;
        Wed, 21 Jun 2023 05:14:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w142-20020a0dd494000000b00568a207aaedsm1059186ywd.68.2023.06.21.05.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:14:41 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:14:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] repo-settings: introduce
 commitgraph.changedPathsVersion
Message-ID: <ZJLprjbzaSvwkNTd@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <6adfa53dafc8c34f94a017fdc08460911f53d310.1686677910.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6adfa53dafc8c34f94a017fdc08460911f53d310.1686677910.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 10:39:57AM -0700, Jonathan Tan wrote:
> diff --git a/Documentation/config/commitgraph.txt b/Documentation/config/commitgraph.txt
> index 30604e4a4c..eaa10bf232 100644
> --- a/Documentation/config/commitgraph.txt
> +++ b/Documentation/config/commitgraph.txt
> @@ -9,6 +9,16 @@ commitGraph.maxNewFilters::
>  	commit-graph write` (c.f., linkgit:git-commit-graph[1]).
>
>  commitGraph.readChangedPaths::
> -	If true, then git will use the changed-path Bloom filters in the
> -	commit-graph file (if it exists, and they are present). Defaults to
> -	true. See linkgit:git-commit-graph[1] for more information.
> +	Deprecated. Equivalent to changedPathsVersion=1 if true, and
> +	changedPathsVersion=0 if false.
> +
> +commitGraph.changedPathsVersion::
> +	Specifies the version of the changed-path Bloom filters that Git will read and
> +	write. May be 0 or 1. Any changed-path Bloom filters on disk that do not
> +	match the version set in this config variable will be ignored.
> ++
> +Defaults to 1.
> ++
> +If 0, git will write version 1 Bloom filters when instructed to write.
> ++
> +See linkgit:git-commit-graph[1] for more information.

Hmm. I'm a little confused: we should still be able to use the old
broken filters if (and only if) the paths we're querying don't have any
bytes with their high-order bit set, no?

That should be true with the caveat that querying such a path would need
to result in our querying function returning "maybe" instead of
"definitely not" to protect against the false-negatives described
earlier.

As I read this, it seems to imply that as soon as this change lands that
we'll stop reading old Bloom filters altogether. Is that the case?

If so, I wonder if we can do this with without needing this
configuration setting at all (by writing the newest version of Bloom
filters possible, and working around the existing ones with the
aforementioned workaround).

Thanks,
Taylor
