Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC91C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B47C20C09
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 20:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L/OKuMbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgIIUcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:32:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50552 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIIUcS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 16:32:18 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B78BEF0BFF;
        Wed,  9 Sep 2020 16:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mfaUnXHJkPWmcB+OCMbJXDsZYi8=; b=L/OKuM
        bmWKm00iBNTYFCGV486gHl9UvYnzreEa+9v03WmlSYH0Nx5qfbcG9diSoSljZuix
        tHhRwgmarK1jprNeZfQ7XxIg7jA3mzCfXNNsDr1BOZrEfXzp7Gqpki2sPXh9j7zg
        2PTfdHoy7zKqmWfHH5jvSA1ch3RsDG1VA2pqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyHU88WrE5UgA8QaLUAFtmDMf+7aCT7v
        5bZxODan6WmlCiViFmPSVPalMssbryh3bjvhHW/XhMur4oBB7plak9Uf52GR79KD
        5mW4fYZ+abJ9dsSQdTRGchb3cKQ3U/6Xu+hMWUsmz5vJOmYUlH1oaevae7AFzAW9
        zhZWiYymlwE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFF67F0BFE;
        Wed,  9 Sep 2020 16:32:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0318EF0BFB;
        Wed,  9 Sep 2020 16:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 7/9] hook: replace run-command.h:find_hook
References: <20200909004939.1942347-1-emilyshaffer@google.com>
        <20200909004939.1942347-8-emilyshaffer@google.com>
Date:   Wed, 09 Sep 2020 13:32:12 -0700
In-Reply-To: <20200909004939.1942347-8-emilyshaffer@google.com> (Emily
        Shaffer's message of "Tue, 8 Sep 2020 17:49:37 -0700")
Message-ID: <xmqqwo12u1wz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B7DE376-F2DB-11EA-A69A-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Add a helper to easily determine whether any hooks exist for a given
> hook event.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  hook.c | 9 +++++++++
>  hook.h | 1 +
>  2 files changed, 10 insertions(+)

Should we consider the last three patches still work-in-progress
technology demonstration, or are these meant as a proposal for a new
API element as-is?

It is perfectly fine if it is the former.  I just want to make sure
we share a common understanding on the direction in which we want
these patches to take us.  Here is my take:

 - For now, a hook/event that is aware of the config-based hook
   system is supposed to use hook_exists(), while the traditional
   ones still use find_hook().  We expect more and more will be
   converted to the former over time.

 - Invoking hook scripts under the new world order is done by
   including hook.h and calling run_hooks(), not by driving the
   run-command API yourself (I count run_hook_ve() as part of the
   latter) like the traditional code did.  We expect more and more
   will be converted to the former over time.

 - From the point of view of the end users who have been happily
   using scripts in $GIT_DIR/hooks, everything will stay the same.
   hook_exists() will find them (by calling find_hook() as a
   fallback) and run_hooks() will run them (by relying on
   hook_list() to include them).

I am guessing that the above gives us a high-level description.

The new interface needs to be described in hook.h once the series
graduates from the technology demonstration state, in order to help
others who want to help updating the callsites of traditional hooks
to the new API.  And the above three-bullet point list is my attempt
to figure out what kind of things need to be documented to help
them.

I am not seeing anything in run_hooks() that consumes input from us
over pipe, by the way, without which we cannot do things like the
"pre-receive" hooks under the new world order.  Are they planned to
come in the future, after these "we feed anything they need from the
command line and from the enviornment" hooks are dealt with in this
first pass?

Thanks.

> diff --git a/hook.c b/hook.c
> index 0dab981681..7c7b922369 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -111,6 +111,15 @@ struct list_head* hook_list(const struct strbuf* hookname)
>  	return &hook_head;
>  }
>  
> +int hook_exists(const char *hookname)
> +{
> +	const char *value = NULL;
> +	struct strbuf hook_key = STRBUF_INIT;
> +	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> +
> +	return (!git_config_get_value(hook_key.buf, &value)) || !!find_hook(hookname);
> +}
> +
>  int run_hooks(const char *const *env, const struct strbuf *hookname,
>  	      const struct strvec *args)
>  {
> diff --git a/hook.h b/hook.h
> index d020788a6b..d94511b609 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -11,6 +11,7 @@ struct hook
>  };
>  
>  struct list_head* hook_list(const struct strbuf *hookname);
> +int hook_exists(const char *hookname);
>  int run_hooks(const char *const *env, const struct strbuf *hookname,
>  	      const struct strvec *args);
