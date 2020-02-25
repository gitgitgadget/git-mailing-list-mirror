Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB50C35E04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187B2082F
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 19:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN/yKguR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbgBYT4z (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:56:55 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44334 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYT4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 14:56:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id a14so55172pgb.11
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 11:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xebrs0CFlIUhyDdsSK7svXlCM/rDF7w6nsSe7M9JZ4k=;
        b=fN/yKguR4Hltb5QDx/eyVSii3jlOhwBy1m+JUpfU/cSUURfRs4S9xk3BYYPXihg1Eh
         avVu/zHO0i3Q6oSufzgy+OakLxAb26VmRb1uWbIC16nRg/ox54sxCvmR2DCF/WfOOJNG
         BHb3lWO+yFwWv35WNLCZ4eeLq1og2CFcvQSEfcGwUzZqlVcZq+mZ+alkYR/yYZbuUnZb
         HfSOP/Ovv3VB8D9z/jB0Ozlqum935Ryyj0wB91j5veXdyhOfZjozwxhusy9Sua8ytiww
         lRIavVqQxvhEVpLNqs0JSE2GK/f2moyHnBnN4gMAyp4VDA6zalGXsFrNmhgrpmBnYRub
         Evqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xebrs0CFlIUhyDdsSK7svXlCM/rDF7w6nsSe7M9JZ4k=;
        b=E21FxYUA+22O5BX2j0KkyKlcE7zdjhtVstElVxU2DkFFD2lfx03GmByab/dLzDiPnY
         wzaQ0/14ejZ4aH7IHytT7yQQrXBd7lWMKtl7nl9rXy//qaPXiDjes9vcyrUz+pr2XI3q
         NSTiGx5SxKqw+jiWt0nhUKvzuEY81gocctaW8lYuYnDM1lHZNIaJhw0l0sIPjY2AVC5p
         mxhZl0bEjz9aDx1jfM72SkEkiDtdJsRX45TM+e5aCwtsPig2jNUi/kxrSHdUiLyuTmtE
         GI8BJUTjxODivYDqFXuF7T+eZe7cBlLJz3NuUe7YB2mRtJIWbHCzfc6p1lr7/T91JjSb
         8YgQ==
X-Gm-Message-State: APjAAAXSaAudr7ptrxbb8gnVqpsO1eE7Kdlp2ggRXTdtG9qyMQ9YZTlZ
        ZqclqVcvt1GP4m3VMjnaBT4FIw==
X-Google-Smtp-Source: APXvYqwMaet1dKNiq4mTN4BuuFgJZ93jCNeBREUTrJiL8os3ql+7qIos7QTglLMKAZB6D5T5mhdxWw==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr168217pgi.33.1582660614529;
        Tue, 25 Feb 2020 11:56:54 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id v7sm17472425pfn.61.2020.02.25.11.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:56:53 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:56:48 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
Message-ID: <20200225195648.GA212281@google.com>
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
 <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
 <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 09:40:28AM -0800, Junio C Hamano wrote:
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +static int get_config_value(enum advice_type type)
> > +{
> > +	int value = 1;
> > +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> > +
> > +	git_config_get_bool(key, &value);
> > +	free(key);
> > +	return value;
> > +}
> 
> So, in this hypothetical but quite realistic example:
> 
> 	if (advice_enabled(ADVICE_FOO)) {
> 		char *foo = expensive_preparation();
> 		advice_if_enabled(ADVICE_FOO, "use of %s is discouraged", foo);
> 	}
> 
> we end up formulating the "advice.*" key twice and ask git_config_get_bool()
> about the same key twice?
> 
> > +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> > +{
> > +	char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> > +	va_list params;
> > +
> > +	if (!advice_enabled(type))
> > +		return;
> 
> Oh, no, make the number of calls to xstrfmr() three times, not
> twice, as I said in the previous example.
> 
> I wonder if it would make the implementation better to do these:
> 
>  - Rename advice_config_keys[] to advice_setting[] that does not
>    imply it is only about the keys;
> 
>  - This table will know, for each enum advice_type, which
>    configuration variable enables it, *and* if it is enabled.
> 
> i.e.
> 
>         static struct {
>                 const char *config_key;
>                 int disabled;
>         } advice_setting[] = {
>                 [ADVICE_ADD_EMBEDED_REPO] = { "addEmbeddedRepo" },
>                 [ADVICE_AM_WORK_DIR]      = { "amWorkDir" },
>                 ...
>                 [ADVICE_WAITING_FOR_EDITOR] = { "waitingForEditor" },
>         };
> 
> 
> Side Note: you have AMWORKDIR that is unreadable.  If the config
>            name uses camelCase by convention, the UPCASED_WORDS
>            should be separated with underscore at the same word
>            boundary.
> 
> Then, upon the first call to advice_enabled(), call git_config()
> with a callback like
> 
> 	static int populate_advice_settings(const char *var, const char *value, void *cb)
> 	{
> 		int advice_type;
> 		const char *name;
> 
> 		if (!skip_prefix(var, "advice.", &name))
> 			return 0;
> 		advice_type = find_advice_type_by_name(advice_setting, name);
> 		if (advice_type < 0)
> 			return 0; /* unknown advice.* variable */
> 		/* advice.foo=false means advice.foo is disabled */
> 		advice_setting[advice_type].disabled = !git_config_bool(var, value);
> 	}
> 
> only once.  Your get_config_value() would then become a mere lookup
> in advice_setting[] array, e.g.
> 
> 	int advice_enabled(unsigned advice_type)
> 	{
> 		static int initialized;
> 
> 		if (!initialized) {
> 			initialized = 1;
> 			git_config(populate_advice_settings, NULL);
> 		}
> 		if (ARRAY_SIZE(advice_setting) <= advice_type)
> 			BUG("OOB advice type requested???");
> 		return !advice_setting[advice_type].disabled;
> 	}
> 
> with your "push-update-rejected has two names" twist added.

I'm a little confused about the need to cache the result of
git_config_get_bool() - isn't that a lookup from a hashmap which is
already populated at setup time, and therefore inexpensive? I would
think the only expensive part here is the xstrfmt() calls, which it
seems like would be easy to do away with by storing the fully-qualified
advice key in the array instead. What am I missing?

 - Emily
