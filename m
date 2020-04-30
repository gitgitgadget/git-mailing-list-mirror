Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC91C83000
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D8D20731
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 00:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BmU7fyG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD3AbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AbG (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 20:31:06 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC3C035494
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:31:04 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id 198so4700905qkf.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 17:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y5OJoC6hzM7ljNrEXkg2oh0iemQ24MuUGunuJxb+MDM=;
        b=BmU7fyG9uQFd1VwHfpg/aBjzhK+gK48bY4tG4AgFcxryimfjNy+svHd95upuSAnfVb
         WOz6p1IG+L/vi0+cR4kr5sqPVEbOVpzxlDt5ckSQ6JqiRD61SNRT1EDL9REgjtxd1yus
         llm0cHQUUeGpIlI4YJbcd5433rUh8c0Q69XLCf3G9qiAkh9hcOlT48Z38XX+bgfY4HnB
         clMOzir7G13VRJSn8mZ4dUvTbJb89ZEucxkT1IJGzM4VSqYyEJTtrkp11+k1z+rIFicx
         L37wfzNBXQR5b01fLo6a4OpqyzGLvl7NJ2zlFftzpJhhdyO/Riw6ygVckJhaz0ZSiXHG
         4XlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y5OJoC6hzM7ljNrEXkg2oh0iemQ24MuUGunuJxb+MDM=;
        b=Nfapq/H2z2GtlEj2ZcsTFC+qzCxnFjGxqB9Y7T5FU5Ejis2ba19JpLYZFDC56Fyo1Z
         +NfvrQoG75oa+UHfODNFa6JEpB8IYbR07OVxlBUdvo7AZe13m7nWObXr7+TnOTN8fORX
         BfO6buMoTMjpHS/uQFgOZ8+TVW8n7gGtSbdWVlLMb9tAL1EY5c1rcDVe9AFGYFx9N3CH
         0Ga50b+aUsjW7erjFujpKBaFVffDJxcgVlVQrhiS/J8nMMQBJsoUl8mfOFK77sG989Kf
         Ws/J6kU07ZptcOqlACYiYsAaC30JLu6ZYJWh6gplOdLxViWFEfYqaTN6TacFioFx9uPr
         T+og==
X-Gm-Message-State: AGi0PubjwESy/kJpg4oINoO61Kck9jDp+IzUmcZEaO2BGCwCPGL+zPsT
        O4L3TAZrv4gwSeu/F72+0SvypRzzA0y6/ibpNfZt
X-Google-Smtp-Source: APiQypIcV+YIpWIXvAS7FRjjqfG41O5CfaDPjr1c9MUySyb/128tXcIR2Iwy8sk4GBwQcc+COPp15mgbGIZnx/V/Oy0B
X-Received: by 2002:a0c:9a4f:: with SMTP id q15mr550186qvd.132.1588206663586;
 Wed, 29 Apr 2020 17:31:03 -0700 (PDT)
Date:   Wed, 29 Apr 2020 17:30:59 -0700
In-Reply-To: <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
Message-Id: <20200430003059.236985-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <c0dc5024a9b368dfbca99b81bc843f66d725f3d7.1588199705.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: Re: [PATCH 5/5] shallow: use struct 'shallow_lock' for additional safety
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -428,14 +428,14 @@ void prune_shallow(unsigned options)
>  		strbuf_release(&sb);
>  		return;
>  	}
> -	fd = hold_lock_file_for_update(&shallow_lock,
> +	fd = hold_lock_file_for_update(&shallow_lock.lk,
>  				       git_path_shallow(the_repository),
>  				       LOCK_DIE_ON_ERROR);
>  	check_shallow_file_for_update(the_repository);
>  	if (write_shallow_commits_1(&sb, 0, NULL, flags)) {
>  		if (write_in_full(fd, sb.buf, sb.len) < 0)
>  			die_errno("failed to write to %s",
> -				  get_lock_file_path(&shallow_lock));
> +				  get_lock_file_path(&shallow_lock.lk));
>  		commit_shallow_file(the_repository, &shallow_lock);
>  	} else {
>  		unlink(git_path_shallow(the_repository));

I was hoping that the inner lock ("lk") wouldn't need to be exposed, so
that it wouldn't be possible to inadvertently commit the lock without
going through commit_shallow_file(), but this patch is still a step
towards that.

> diff --git a/shallow.h b/shallow.h
> index 08e1bc4fd0..d12096fbc4 100644
> --- a/shallow.h
> +++ b/shallow.h
> @@ -10,12 +10,22 @@ void set_alternate_shallow_file(struct repository *r, const char *path, int over
>  int register_shallow(struct repository *r, const struct object_id *oid);
>  int unregister_shallow(const struct object_id *oid);
>  int is_repository_shallow(struct repository *r);
> +
> +/*
> + * shallow_lock is a thin wrapper around 'struct lock_file' in order to restrict
> + * which locks can be used with '{commit,rollback}_shallow_file()'.
> + */
> +struct shallow_lock {
> +	struct lock_file lk;
> +};

As far as I know, we don't use many abbreviations in struct members -
maybe s/lk/lock/.

I couldn't find any other issues with all 5 patches in this patch
series, but I would like to be able to apply the patches to be sure.
