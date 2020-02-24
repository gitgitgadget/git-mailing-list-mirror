Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC12EC35DEA
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD102176D
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mI/LH3i7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgBXXqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:46:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45700 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXXqB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 18:46:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so4687473pls.12
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 15:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWnkz8rIE7stsX+9+n9yuDd0OJwE/M9tmTirTCke23w=;
        b=mI/LH3i7Uz7FUxtRTK/I7UY7U4iLrMVu0SzDZ1LR7sSgbYqKsRaX43RA05qydlPxPK
         naUK+Cfn7Lcw/Cs1iC1JRm0oNhI4mPPfX5dKXbPWckjlQ/uVgYwzq8yphfcxRdVTZFF1
         ascEHuO+34hXjYDkFjEeV164CAq2hsK9K4HiQ3+hzsrACtjR5M6G5NCYoNszlhUqPr83
         FnwtRj48GX56pOp6OutYjhDEC+QD6MAyb81OV4DElC80MLOJ/AB4u5XU5eme1l9z7A8E
         qMbmEOv8HnWJUqcXo6PtijVqoeM34WuvcCbghO3WhW/GIvUKl8M5b/l8yt/EuWzH+TEC
         NQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWnkz8rIE7stsX+9+n9yuDd0OJwE/M9tmTirTCke23w=;
        b=Vz1hHypEv21zyvKfF0R5et9XAEIQhvVHtlRjLmz+EVej3Sbai1tTa2l8hD3E65MSoP
         AbtbIiNYh2u1bLKxKZvwiF5VFDuGvhSjso8SZaWt4FyCFxwhbo04ugXNvXmoUAjUde8L
         PwgX5qmqtW8UuSFk8Jb1V3vdbKWAt9Rqng9qZEb9fSzeXUHyIN9QFdoi6WmCmOdiUmKB
         ajf9yyi6d7KLJTI8ssU7JNAYFeMidwLIDYLoBUy7NofX9LvOZTqNSHb81Ey9OlqU4QT3
         H3q6Wj6Csi6vV5D1HuihlJNmWulnPCnA0PAGflybUjE2lNoCi7REDHfbJJwX+xJMyRoE
         qnrw==
X-Gm-Message-State: APjAAAWWnv6R5yXFvOQTOD/bNkaoOjr8pNoVQM3qAX/FI+BEkWBCvR7+
        TOBES7VFA8Zf5rg3DrmaiyxIpQ==
X-Google-Smtp-Source: APXvYqy626e3gMzkJzrP4YQS2kk3Z4RkvwXNEHyjLwouusf+LM0W/W9TS0PSWOae+IjEyxOBwjKhKQ==
X-Received: by 2002:a17:902:864a:: with SMTP id y10mr52678423plt.2.1582587959096;
        Mon, 24 Feb 2020 15:45:59 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id t65sm13978345pfd.178.2020.02.24.15.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:45:58 -0800 (PST)
Date:   Mon, 24 Feb 2020 15:45:54 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v4 2/3] advice: revamp advise API
Message-ID: <20200224234554.GB255447@google.com>
References: <pull.548.v3.git.1582144442.gitgitgadget@gmail.com>
 <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c3e5760f60cf394af66bfdb4fe1d561a093567.1582557199.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 03:13:17PM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Currently it's very easy for the advice library's callers to miss
> checking the visibility step before printing an advice. Also, it makes
> more sense for this step to be handled by the advice library.
> 
> Add a new advise_if_enabled function that checks the visibility of
> advice messages before printing.
> 
> Add a new helper advise_enabled to check the visibility of the advice
> if the caller needs to carry out complicated processing based on that
> value.
> 
> A list of config variables 'advice_config_keys' is added to be used by
> list_config_advices() instead of 'advice_config[]' because we'll get
> rid of 'advice_config[]' and the global variables once we migrate all
> the callers to use the new APIs.
> 
> Also change the advise call in tag library from advise() to
> advise_if_enabled() to construct an example of the usage of the new
> API.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>

I read Junio's review and agree with that too; but here are some more
thoughts.

> +static int get_config_value(enum advice_type type)
> +{
> +	int value = 1;

So we default to true if the config is unset...

> +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> +	git_config_get_bool(key, &value);
...and per config.h, "when the configuration variable `key` is now
found, returns 1 without touching `dest`. Nice, so the default-true
works. If some problem is found when converting the value to a bool,
this function die()s, so you don't have to check the return value.

> +	free(key);
> +	return value;
> +}
> +
> +int advice_enabled(enum advice_type type)
> +{
> +	switch(type) {
> +	case PUSH_UPDATE_REJECTED:
> +		return get_config_value(PUSH_UPDATE_REJECTED) &&
> +		       get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
So I can ask advice_enabled(PUSH_UPDATE_REJECTED) and still be told
'false' if earlier I set "advice.pushNonfastForward" to 0.

I wondered if this was really identical behavior to how this thing
worked before.

Before, it looks like we use the older config callback method
(git_default_advice_config()): we read each config option the user has,
in order, and then we check it against each member of advice_config, and
if it's a match, we set the appropriate value. That means that
advice_push_update_rejected is determined by whichever config is set
last, e.g. a config like so:

global: advice.pushUpdateRejected = 1
local:  advice.pushNonFastForward = 0

results in advice_push_update_rejected == 0.

Now, though, you consider the values of both. In the example above, you
have the same value; but if you reverse the values:

global: advice.pushUpdateRejected = 0
local:  advice.pushNonFastForward = 1

then your new code says advice_enabled(PUSH_UPDATE_REJECTED) == 0, and
the old codepath says advice_push_update_rejected = 1.

Although, using the config lookup methods as you are, I don't think you
can make it stay the same - I don't think there's a way to compare the
relative position of two different configs, is there?

Is this such a big deal? My gut says no; my gut says if someone had
advice.pushNonFastForward set, they aren't touching their config to
unset it, which means they aren't touching their config to fiddle with
advice.pushUpdateRejected either.

Maybe someone who was around when this alias was added can provide some
context?

 - Emily
