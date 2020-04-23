Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB8DC55185
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6272075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpG+ktPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgDWBXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWBXJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 21:23:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEF9C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:23:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g6so2033120pgs.9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Kzf8/6ZIIxzhwXpbiID6u5AVpqCfUxffBGYAB6hodiA=;
        b=TpG+ktPRP4K1ebfk3FDRhYRLK2DRyad6L5zzRbBpaP4DNHnq5++7XBfOnvr/kXShci
         0HZnuGF7D8bhnSlxmtDkmQRDUHCvRmBCb13ULN5Rwhg5B5AOqW/k2gc2WibYB4CS/1tw
         nUZki9q2DtRGRUCmJW8YoQYOHKc6C2SPPtGVrnALPnA5qpdDrY88xDhSYwIpZolG3T04
         Cgymbni2nBq7FBIYGjedRgZmVEPttmqLmIR6LcU/Vp6nh+qxfrHNQKKCSsNhQaesjjm3
         eyYkSTOuZCoOOeRg5q+WLD0htKhtwdopJh+3gCMoxsMJrT/63iUklEycVu648pLAJMnB
         A3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kzf8/6ZIIxzhwXpbiID6u5AVpqCfUxffBGYAB6hodiA=;
        b=cRCNS/nK0zL2lozQ/n0NME8UEgWDH4EO126jTY6P79YIz6XF3N06MXw6SLmNQ0sQmn
         K2Tzoe0XR+xqrUMpgrtqamsphgfOqrqgQ90ji+2w1Jlh+sGKJrQMD9kBSZJSCQONcznF
         qGTov0oMfAI+/KrS1iBO7ESTOcikj+N/AedBRpiBsflvj+EoKurCfxEloeHbSFj8vVYg
         qOcyC9lGADVcG777lyhh9T+j3mmHX5AGpZFyl5Ap/8ZBG7naY2cj+huqpVmeIqm6r/TT
         yhV6AL/MetQ2kEC0z7tqBleOuIuZi/c+sih8Glnus5Nv7lP4p6qMYS/EnpY5n6V3zosl
         6XUw==
X-Gm-Message-State: AGi0Pub7hmlI3Ejq5cQt9apr8zQm8Mftos3urzjx8vgr0+Upot+iNU6J
        hM39IqyrbfeO32qYI66bMV8=
X-Google-Smtp-Source: APiQypLmkWwa8r8klWJ1oNPgn2j40kg1h7cbiXDUPhhNxYOgyVRYqHNoxVt2K1+IULs56dQIsJfXqg==
X-Received: by 2002:a63:e749:: with SMTP id j9mr1655592pgk.319.1587604988385;
        Wed, 22 Apr 2020 18:23:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t126sm774168pfb.29.2020.04.22.18.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:23:07 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:23:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com
Subject: Re: [PATCH v2 2/2] shallow.c: use '{commit,rollback}_shallow_file'
Message-ID: <20200423012305.GH140314@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296e70790d7a391d471554b0bc5a58e2a091ce88.1587601501.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:

> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -872,12 +872,12 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	opt.env = tmp_objdir_env(tmp_objdir);
>  	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
>  	if (check_connected(command_singleton_iterator, cmd, &opt)) {
> -		rollback_lock_file(&shallow_lock);
> +		rollback_shallow_file(the_repository, &shallow_lock);

I like it.

I wonder, is there a way we can make it more difficult to accidentally
use rollback_lock_file where rollback_shallow_file is needed?  For
example, what if shallow_lock has a different type "struct
shallow_lock" so one would have to reach in to its lock_file member to
bypass the shallow_file interface?

[...]
>  		oid_array_clear(&extra);
>  		return -1;
>  	}
>  
> -	commit_lock_file(&shallow_lock);
> +	commit_shallow_file(the_repository, &shallow_lock);
>  
>  	/*
>  	 * Make sure setup_alternate_shallow() for the next ref does
> diff --git a/commit.h b/commit.h
> index 008a0fa4a0..ab91d21131 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -249,6 +249,8 @@ struct oid_array;
>  struct ref;
>  int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
> +int commit_shallow_file(struct repository *r, struct lock_file *lk);
> +void rollback_shallow_file(struct repository *r, struct lock_file *lk);

optional: might make sense to put this near setup_alternate_shallow
for discoverability

Could this have an API doc comment?

[...]
> --- a/shallow.c
> +++ b/shallow.c
> @@ -40,13 +40,6 @@ int register_shallow(struct repository *r, const struct object_id *oid)
>  
>  int is_repository_shallow(struct repository *r)

Not about this patch: it might make sense to split out a shallow.h
header / API.

Thanks and hope that helps,
Jonathan
