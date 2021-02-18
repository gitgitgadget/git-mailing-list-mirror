Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19381C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDCB66186A
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhBRWYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBRWYI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:24:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33983C061574
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 14:23:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id e9so2079264plh.3
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 14:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/Tt1mNDAQTb47NVr8YXOFDrPBQxGvl3R08LjTv3Gd0M=;
        b=CCJRkiO4dy1AqauNy1dFb5N+NovkkkpjngJqc91Alsv1+syd9UKFDEm90cjYX23DN3
         30wFhTxn+OhG5vM/wns2MuPy5jc/VZ+MwmyZt/ifwokXwPVjk5SqBJFWyo/FuQDIi34/
         aIpcwzalzr6qpPsPC1wKBjK/I5qdtWgPUFXd3OG3rNE/ybNpgxpT7iU/AWE6KGjMW96x
         bKKIUIcgdMp4ZYJ/3Wy+4D2PPgkqFMqankLan9Jf/bsKD7OeDcnsxnp3YPOTC59lO6iQ
         CNv+PffEOzlYuoiQnlMYom594+ceoP6BdK/eUUclfuwCcJUprVy2uwh31cIUv+b2P3sQ
         xl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/Tt1mNDAQTb47NVr8YXOFDrPBQxGvl3R08LjTv3Gd0M=;
        b=Jye1jFJ077CeyjtmPxn0ysC2YaCPFb+HQGY+NN73HeLlAbZQiH8LwCnEWQWkFMnTXG
         9gjh3Y+YvcWpSFb0+41Q8pg1hQUPiJcxYi1aPRTwnxy3xbEY3Wrcq+UebWSxUNGDvHTI
         3wJ0OieVnIe+CQ5hkc+RR6sxHIg/Bs8fJ7Yp1YGq7pocqtnh6XZ9KIkBxFIx9l7+Ymug
         fQKzRq2ifMckmmo7yyPi9OQJ9asPc4+C4EA+yl7K/B/T10gIJqcjyXzbTnc+c4pTobxw
         sFvaz0rFpa9baWTgc19rZ+nLSsQIa48n5xmNDCjAKeyCcOWIAP+z2NsJUp+H+9BtFlYP
         D5Pw==
X-Gm-Message-State: AOAM5339+UbG49uka+Ra0R0GVJYiAMcJGKQ4lS0N5PWEafWY58jjsqNn
        2zqdGjf1jK+SOvkCC3SGGka13w==
X-Google-Smtp-Source: ABdhPJwKkNottVtxoZYpQkTHD/CDktQ1d4KUhM9BHckfcbgPo2D4bMSMUgsg59ROhfgs6qNDDfz0HA==
X-Received: by 2002:a17:902:6b06:b029:e3:5edf:c2a1 with SMTP id o6-20020a1709026b06b02900e35edfc2a1mr6136432plk.51.1613687007614;
        Thu, 18 Feb 2021 14:23:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:2173:5634:483e:aedd])
        by smtp.gmail.com with ESMTPSA id h5sm6814080pgv.87.2021.02.18.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 14:23:26 -0800 (PST)
Date:   Thu, 18 Feb 2021 14:23:22 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v7 09/17] hook: replace find_hook() with hook_exists()
Message-ID: <YC7o2rUQOEdiMdqh@google.com>
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

Yep. Also, removed the one instance I did replace in this commit for
some reason (builtin/bugreport.c). Not sure why that's here and not
later on in part II.

> 
> Also maybe briefly mention the future plans - e.g. in the future, no
> code will use find_hook() except <whatever the hook-internal functions
> are>, because all of them will use hook_exists() and run_hook().

Nice, good point - I'll do that.


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

Nope, and I think that's a pretty neat idea. I've done so.
