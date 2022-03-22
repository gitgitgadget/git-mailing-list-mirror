Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB03FC433EF
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 10:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiCVKNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCVKNP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 06:13:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77717EA3B
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:11:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qx21so35020833ejb.13
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 03:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=BF/d2ti8EOGlYt0hjrCWaEwU4LjcL+26UR8LWYh6G1Q=;
        b=WpZN3EMyEgIk9XrUB9eNhht8Rv/yXXvwBf77A/mbE6cYDDXVoW5fzt7i3OLKgu9Jex
         WQ4FSi2t+xVeLqy7lwXIikPpCmXhv79K2shAV+AA79Bcwr55EYz29YmnB46z7J+fDpMT
         bb8tlHyvumn8onPwLzqQ3AA27zVL2VNQ0gC9SxGsSLnXoqqoOmNBi2O5NXvp7B4CYF/s
         YYts+TD0X3pzxFQgd8BTGPP1yi+hCHfFxqn0EMnekivp8/MaHi/2/SoJQVgtTcs9XASR
         ygweyfhy4qYxvAKcy520PaJhqKpCBYuQZ2v+23bLqU9+z4SX8nXjil7t+hLhlaOTeJK4
         hvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=BF/d2ti8EOGlYt0hjrCWaEwU4LjcL+26UR8LWYh6G1Q=;
        b=WsxJsLjVOwn1X+avVu4p0/DgBcQvP6Qi0Me000La7NXYrWGcIEycRCj5oFtvSmPmxI
         2ZPShD59PxRuyjyfrsAQ47LqfFGMynOWlWWkEm7F17DASo0paLmzujfvNgKjmxtsIY1Y
         qX0OUJOYQUv5gNKuXY41YgMqWsZX2koVL3diZ5opYouWoXcp360pny8c9OGmMH27Ta68
         3SlU0Bf/CYFouF0J6bON61o0eK1W5b+6aryulJgTSJTmuyN76n5ge/+fc7xqfAMFn+17
         RIuWzzaMtzrbRoTbxKA9ZqqUsO0Tv/y8Wu1IYvQvN6wgElXRyVI7TxeWtOFZqdSKTczw
         a2iA==
X-Gm-Message-State: AOAM533BJ7quqcRb8h7lwWj6CS0npPSMPxhGYzG14n6BaXOTGKWe/eiE
        oF0ER4TRE/nXFnOkIOGnqGBdeONLTumQfg==
X-Google-Smtp-Source: ABdhPJwzOrFv9E++32H5vQj4aEXWC/Q1StQeJCylq7cFuz31CDhCtnWA28nCdQVKng2ZezjhcPt42w==
X-Received: by 2002:a17:907:1c9a:b0:6df:bfc3:c9f3 with SMTP id nb26-20020a1709071c9a00b006dfbfc3c9f3mr18284153ejc.679.1647943904945;
        Tue, 22 Mar 2022 03:11:44 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id jg39-20020a170907972700b006e047c810dbsm576754ejc.56.2022.03.22.03.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:11:44 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWbUN-000H3a-Oj;
        Tue, 22 Mar 2022 11:11:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2] RFC: tracking branches: add advice to ambiguous
 refspec error
Date:   Tue, 22 Mar 2022 11:04:32 +0100
References: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
 <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <pull.1183.v2.git.1647940686394.gitgitgadget@gmail.com>
Message-ID: <220322.86ils6nvog.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Tao Klerks via GitGitGadget wrote:

> From: Tao Klerks <tao@klerks.biz>
> [...]
Looking much better!

> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index 063eec2511d..abfac4f664b 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -126,4 +126,8 @@ advice.*::
>  		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
>  		is asked to update index entries outside the current sparse
>  		checkout.
> +	ambiguousFetchRefspec::
> +		Advice shown when branch tracking relationship setup fails due
> +		to multiple remotes' refspecs mapping to the same remote
> +		tracking namespace in the repo.

Let's add this in alphabetical section order. It's *somewhat* true of
the order now, but for some, but in any case I've got a WIP patch to
sort these, so since it's new adding it at the top would save us the
churn :)

> +struct find_tracked_branch_cb {
> +	struct tracking *tracking;
> +	struct strbuf remotes_advice;
> +};

Nice, thanks!

>  static int find_tracked_branch(struct remote *remote, void *priv)
>  {
> -	struct tracking *tracking = priv;
> +	struct find_tracked_branch_cb *ftb = priv;
> +	struct tracking *tracking = ftb->tracking;
>  
>  	if (!remote_find_tracking(remote, &tracking->spec)) {
>  		if (++tracking->matches == 1) {
> @@ -28,6 +34,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
>  			free(tracking->spec.src);
>  			string_list_clear(tracking->srcs, 0);
>  		}
> +		strbuf_addf(&ftb->remotes_advice, "  %s\n", remote->name);

Do this as:

    strbuf_addf([...], _("  %s\n"), [...]);

And add a TRANSLATORS comment similar to show_ambiguous_object() in
object-name.c. I.e. the alignment needs to be translatable for RTL
languages.

> +static const char ambiguous_refspec_advice_pre[] =
> +N_("\n"
> +"There are multiple remotes whose fetch refspecs map to the remote\n"
> +"tracking ref";)
> +static const char ambiguous_refspec_advice_post[] =
> +N_("This is typically a configuration error.\n"
> +"\n"
> +"To support setting up tracking branches, ensure that\n"
> +"different remotes' fetch refspecs map into different\n"
> +"tracking namespaces.\n");

These were split up before since we incrementally built the message....

Also, is the \n at the beginning/end really needed?

>  /*
>   * This is called when new_ref is branched off of orig_ref, and tries
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> @@ -228,12 +247,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  	struct tracking tracking;
>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	struct find_tracked_branch_cb ftb_cb = {
> +		.tracking = &tracking,
> +		.remotes_advice = STRBUF_INIT,
> +	};
>  
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	tracking.srcs = &tracking_srcs;
>  	if (track != BRANCH_TRACK_INHERIT)
> -		for_each_remote(find_tracked_branch, &tracking);
> +		for_each_remote(find_tracked_branch, &ftb_cb);
>  	else if (inherit_tracking(&tracking, orig_ref))
>  		return;
>  
> @@ -248,9 +271,18 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			return;
>  		}
>  
> -	if (tracking.matches > 1)
> -		die(_("not tracking: ambiguous information for ref %s"),
> -		    orig_ref);
> +	if (tracking.matches > 1) {
> +		int status = die_message(_("not tracking: ambiguous information for ref %s"),
> +					    orig_ref);
> +		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC))
> +			advise("%s %s:\n%s\n%s",
> +			       _(ambiguous_refspec_advice_pre),
> +			       orig_ref,
> +			       ftb_cb.remotes_advice.buf,
> +			       _(ambiguous_refspec_advice_post)
> +			       );

...but now we don't, so this should just be inlined here. I.e. made it
one big translatable _() message, the only parameters need to be the
orig_ref and the "remote_advice" buf.

We're also missing a strbuf_release() here. You can just add it to the
"cleanup" omitted from the context:

	strbuf_release(&ftb_cb.remotes_advice);
