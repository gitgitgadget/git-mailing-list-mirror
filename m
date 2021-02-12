Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDC7C433E0
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7094264E0A
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 22:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBLWQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 17:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBLWQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 17:16:03 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F074C061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 14:15:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id e9so429088pjj.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 14:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ISj3jhmD0eYZ+DIxYBCF+vZS9BQWAMq7JCD29fZdP9k=;
        b=S2t96P0cXpn2UrVR3lo1BHnA22Z4VimDUwtAYqIafCK4Nk9CHXnntL7vQYseA/bq8U
         fHQhBHPIrH04xM6T3wXZtpRGc9DBIKdlvcbbniLKuiS2odtgzO1/KmOuYNyGdtXZi3Mh
         mLFo0OSoYyOFYtvMYd08REcFFN8UtlA30whSmJUFr3lPlBAdJvd3GP+tDNuAfz2g0z2L
         V3V3jwVNSjVyqXmsDh7XZ7NNnLr5mnOsvGg0BdEvGXtMzsnpFzvazFet2Fl0bXvnV7lI
         E7oSmhwSyP9mN2uunEKzhgoNLcAFFGRz+urhDDivJTLBLcphQ9y3PSk3hK1L+OANwSCh
         XJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ISj3jhmD0eYZ+DIxYBCF+vZS9BQWAMq7JCD29fZdP9k=;
        b=iZI6JC86P5SuLXlEEuHz9/FcNXu/kCqBPtJifMENHXz7uhA5MbVYtx8e5e/YJeMc4y
         83ZXl2W4barw6QrsFI5a9UKYUlosFJ/L2PjVrPFTqZX/mWC9bQ5NJE6ZfMwZhk12rK56
         dOSKKlVtBIjK3BuPGROJLVq50FvQlPg9U9UX9ChkZcIp6lwML+ScqVb0mKbOs06r6Zsd
         ZvVIDP2WsuCaOtefqzHmFdKEhgoTwNppRJOQrgjn9YYfIjqprizasypTqTzYYew7OHi2
         K6Rr8oDKMKCcWVtVFkyJr2srnqgXqpQak8zi9qW3nbTPGLgLvz3gCGhZwQrJCI2MTDSI
         gG5A==
X-Gm-Message-State: AOAM533o2ESgDI9o7oCStRX0iNDv8m98l8tVOGtHKdZUrPnL0JlY1HNn
        kb6yYyynwK6ek7lTVwnDoJFdzdctSdnBog==
X-Google-Smtp-Source: ABdhPJz6BhHyzXW60TZ8hZStb0fu1ucbmZhJw1SVAnRvfx62gDiTzfRlxn/HlPn5wN2I6HYotGZgAg==
X-Received: by 2002:a17:90a:ea0b:: with SMTP id w11mr4640200pjy.140.1613168122433;
        Fri, 12 Feb 2021 14:15:22 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:d80d:72f8:54c:94f])
        by smtp.gmail.com with ESMTPSA id u10sm2742995pjr.27.2021.02.12.14.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 14:15:21 -0800 (PST)
Date:   Fri, 12 Feb 2021 14:15:17 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 09/17] hook: replace find_hook() with hook_exists()
Message-ID: <YCb99egCYoTJUU8B@google.com>
References: <20201222000220.1491091-10-emilyshaffer@google.com>
 <20210131043928.1036246-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131043928.1036246-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 30, 2021 at 08:39:28PM -0800, Jonathan Tan wrote:
> 
> > Add a helper to easily determine whether any hooks exist for a given
> > hook event.
> > 
> > Many callers want to check whether some state could be modified by a
> > hook; that check should include the config-based hooks as well. Optimize
> > by checking the config directly. Since commands which execute hooks
> > might want to take args to replace 'hook.runHookDir', let
> > 'hook_exists()' mirror the behavior of 'hook.runHookDir'.
> 
> The text makes sense, but the title might better be "introduce
> hook_exists()" instead of "replace", since find_hook() is still around.
> 
> Also maybe briefly mention the future plans - e.g. in the future, no
> code will use find_hook() except <whatever the hook-internal functions
> are>, because all of them will use hook_exists() and run_hook().
> 
> > +/*
> > + * Returns 1 if any hooks are specified in the config or if a hook exists in the
> > + * hookdir. Typically, invoke hook_exsts() like:
> > + *   hook_exists(hookname, configured_hookdir_opt());
> > + * Like with run_hooks, if you take a --run-hookdir flag, reflect that
> > + * user-specified behavior here instead.
> > + */
> > +int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
> 
> I wonder if enum hookdir_opt should support a "unspecified" instead, in
> which case hook_exists() will automatically read the config (instead of
> relying on the caller to call configured_hookdir_opt()), but I see that
> this patch set is version 7 and perhaps this design point has already
> been discussed.

No, I don't think it has been. So you mean something like:

  enum hookdir_opt
  {
  	HOOKDIR_NO,
  	HOOKDIR_WARN,
  	HOOKDIR_INTERACTIVE,
  	HOOKDIR_YES,
  	HOOKDIR_USE_CFG,
  	HOOKDIR_UNKNOWN,
  };

(name subject to quibbling) and then reimagining
configured_hookdir_opt() to something like:

  enum hookdir_opt resolve_hookdir_opt(enum hookdir_opt o)
  {
  	if (o != HOOKDIR_USE_CFG)
		return o;
	/* former contents of configured_hookdir_opt here */
  }

I like that, if nobody has complaints.

 - Emily
