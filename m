Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE8C433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADB6610FB
	for <git@archiver.kernel.org>; Mon,  3 May 2021 21:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECVxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECVxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 17:53:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0EC061573
        for <git@vger.kernel.org>; Mon,  3 May 2021 14:52:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a15-20020a05622a02cfb02901b5e54ac2e5so2348937qtx.4
        for <git@vger.kernel.org>; Mon, 03 May 2021 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G3vKW/LH5iFVnBKARFfvYPhPNmWar/i6sf9d0ZElYz0=;
        b=AzXgFnCd9O2Qaelow2RdcyLmB+/HdSDU652faXmJ/fBhPHj3tNh9Xp6pqWBzxDTi9n
         f4s3ELNk+fs3Qt4luktrayXanOM75bnikhxOqQoJ+wVkoBNYuEoNA1ed2KRGF2uOaEEX
         Mz0j7ELm/Xgf+PpGZZp8rSfgFzWnEclBWsfBpcN5BGkqEg3BAkv1EAoKKZsXYb343wv+
         obkzF1Gh14Kyg/epT4zwnUqZpdwMnZEJkSAzUbMwVcAa88RRsphygukyvEKr1ke+g1pz
         QGYPFhO8j2hqnZBlo4Fwel9g2nxOqXr9tUcOB1+lflCQgcLqNA+fNpVG0SNLvz8b3a8n
         FrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G3vKW/LH5iFVnBKARFfvYPhPNmWar/i6sf9d0ZElYz0=;
        b=eyn/ah3VJ4bzaEHeSCNz905qJnU2jM3IABQkOVfMIOY0NWQ0UxcoEGFDjHhxr1T3DC
         +1zpEotxbZ0y7zJj7l/cFWtoZ871krDBaA7KnVrpHqWIfDtCAZfxMFiRaQUrSqWAsi6o
         fZTgllC3uzT5sqoF03Aua7jWSfqTNJuDLtzzysWWAzwVOKT3AflGJpxVvXt3dSc7C5wk
         RD9Zq2s/st7wufeRpAyPgVNP3xZfaW/pk2AqDxeqfk8NmoXL/AWieCw4nTo5YwT+d4Mv
         miEP1iey+4yCf6XvE7ulMNWXUmY41PeIImm6o4zF4ShuPJB58V45rVxa5M4qGWCSbOOl
         WwLw==
X-Gm-Message-State: AOAM532WYc85NXF5oIZmUDRJAClbfTXUALCOJHrY+kNxFxNqt76aT1Ps
        tabKl40xr4YsKA7/okY1475vLzzPYGuDZIs1xngi
X-Google-Smtp-Source: ABdhPJysc+b+bMDNr6Aeoxmc9Yh8DxCXoO4d21lIhvX3JtQGzpmLl9EDPOY/4rWFFQoY1Xo5syXhcKAQMLXSxIOWNQqd
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:556a:: with SMTP id
 w10mr3290560qvy.1.1620078762954; Mon, 03 May 2021 14:52:42 -0700 (PDT)
Date:   Mon,  3 May 2021 14:52:39 -0700
In-Reply-To: <cb441f5b-33db-90a7-1492-e86c4ec1ed1a@gmail.com>
Message-Id: <20210503215239.2877489-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cb441f5b-33db-90a7-1492-e86c4ec1ed1a@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 4/8/21 9:10 PM, Jonathan Tan wrote:
> > Currently, the packfile negotiation step within a Git fetch cannot be
> > done independent of sending the packfile, even though there is at least
> > one application wherein this is useful. Therefore, make it possible for
> > this negotiation step to be done independently. A subsequent commit will
> > use this for one such application - push negotiation.
> ...
> > --- a/Documentation/technical/protocol-v2.txt
> > +++ b/Documentation/technical/protocol-v2.txt
> > @@ -346,6 +346,14 @@ explained below.
> >  	client should download from all given URIs. Currently, the
> >  	protocols supported are "http" and "https".
> >  
> > +If the 'wait-for-done' feature is advertised, the following argument
> > +can be included in the client's request.
> > +
> > +    wait-for-done
> > +	Indicates to the server that it should never send "ready", but
> > +	should wait for the client to say "done" before sending the
> > +	packfile.
> > +
> 
> Ok, this is a good way to handle the compatibility case. I'll check
> in the next patch how this feature is checked before sending a pack-file
> in 'git push'.

Thanks.

> > @@ -202,6 +203,8 @@ static struct option builtin_fetch_options[] = {
> >  			TRANSPORT_FAMILY_IPV6),
> >  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
> >  			N_("report that we have only objects reachable from this object")),
> > +	OPT_BOOL(0, "negotiate-only", &negotiate_only,
> > +		 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
> 
> It seems a little strange for this step, which is mostly used for tests,
> to be so visible. I think it would be too much work to create a test
> helper with an equivalent implementation, so maybe describe this option
> as only for tests in Documentation/git-fetch.txt.

As you mention in your review of the subsequent patch [1], this is
because we're calling "fetch" as a subprocess from "push", so it needs
to accept command-line arguments specifying that we're not interested in
the packfile.

[1] https://lore.kernel.org/git/c2780570-81ec-bede-2f4e-75748b788bbb@gmail.com/

> > -	if (remote) {
> > +	if (negotiate_only) {
> > +		struct oidset acked_commits = OIDSET_INIT;
> > +		struct oidset_iter iter;
> > +		const struct object_id *oid;
> > +
> > +		if (!remote)
> > +			die(_("Must supply remote when using --negotiate-only"));
> 
> Please use lowercase letters to start your error messages.

Thanks - done.

> > +static int add_to_object_array(const struct object_id *oid, void *data)
> > +{
> > +	struct object_array *a = data;
> > +
> > +	add_object_array(parse_object(the_repository, oid), "", a);
> > +	return 0;
> > +}
> 
> Why parse_object() over lookup_object()?

Switched to lookup_object(). I don't think it matters here because we'll
need to parse all commits when doing negotiation anyway (to find their
parents), but I changed it to avoid confusion.

> > +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> > +			   const struct string_list *server_options,
> > +			   int stateless_rpc,
> > +			   int fd[],
> > +			   struct oidset *acked_commits)
> 
> It might be worth a careful doc comment to say that we _must_
> have already verified the wait-for-done capability.

OK - written in the .h file.

[snip min_generation explanation]

> And finally here you can use min_generation. Otherwise, you will suffer
> performance problems when there is a deep history but this returns false.
> 
> As long as min_generation is the minimum generation of a commit with the
> COMMON flag, you will be correct to use that limit.

Thanks for the precise guidance of how to use generation numbers to
speed things up. I've implemented your suggestions.

> 
> > +			last_iteration = 1;
> > +	}
> > +	strbuf_release(&req_buf);
> 
> Don't forget to clear the COMMON flag before returning.

OK - done. (I don't think it matters here, but I guess it's clearer if
we do as you suggest. The loop will take some time to run, but it's
small compared to the network time needed anyway.)

> > +/*
> > + * Execute the --negotiate-only mode of "git fetch", adding all known common
> > + * commits to acked_commits.
> > + */> +void negotiate_using_fetch(const struct oid_array *negotiation_tips,
> > +			   const struct string_list *server_options,
> > +			   int stateless_rpc,
> > +			   int fd[],
> > +			   struct oidset *acked_commits);
> 
> Here is a good place to specifically mention the wait-for-done capability,
> or else this method will die() when seeing the "ready" from the server.

Acknowledged.

> > diff --git a/transport-helper.c b/transport-helper.c
> > index 4cd76366fa..4be035edb8 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -684,6 +684,16 @@ static int fetch(struct transport *transport,
> >  		return transport->vtable->fetch(transport, nr_heads, to_fetch);
> >  	}
> >  
> > +	/*
> > +	 * If we reach here, then the server, the client, and/or the transport
> > +	 * helper does not support protocol v2. --negotiate-only requires
> > +	 * protocol v2.
> > +	 */
> > +	if (data->transport_options.acked_commits) {
> > +		warning(_("--negotiate-only requires protocol v2"));
> > +		return -1;
> > +	}
> > +
> 
> This method continues to do a lot that doesn't seem specific to
> --negotiate-only. The warning message seems incorrect to me, but
> is also seems like this would break several cases when using
> protocol v0. It is equally possible that I'm misunderstanding
> what is going on here.

It's specific to --negotiate-only in that acked_commits is set if and
only if we use --negotiate-only. What cases are you think of that break
when using protocol v0?

> > +	if (data->options.acked_commits) {
> > +		if (data->version < protocol_v2) {
> > +			warning(_("--negotiate-only requires protocol v2"));
> > +			ret = -1;
> > +		} else if (!server_supports_feature("fetch", "wait-for-done", 0)) {
> > +			warning(_("server does not support wait-for-done"));
> > +			ret = -1;
> > +		} else {
> > +			negotiate_using_fetch(data->options.negotiation_tips,
> > +					      transport->server_options,
> > +					      transport->stateless_rpc,
> > +					      data->fd,
> > +					      data->options.acked_commits);
> > +			ret = 0;
> > +		}
> > +		goto cleanup;
> > +	}
> 
> These prereqs look right. This makes it look rather strange that
> negotiate_using_fetch() returns void (and has several die() calls inside)
> and could instead return an 'int' that is consumed here (and use
> error() calls instead of die()).

When negotiate_using_fetch() is used, we are already past the capability
advertisement step, so we need to believe here that the wait-for-done
prerequisite has been met. (Admittedly, said prerequisite wasn't
documented, but I've documented it following your suggestion above.) So
I think it would be too late to return an "int" after several
negotiation steps have occurred and the packfile downloaded.

> > +
> > +	/*
> > +	 * If set, whenever transport_fetch_refs() is called, add known common
> > +	 * commits to this oidset instead of fetching any packfiles.
> > +	 */
> > +	struct oidset *acked_commits;
> 
> nit: s/If set/If allocated/

Changed.

> > @@ -1668,10 +1673,13 @@ int upload_pack_v2(struct repository *r, struct strvec *keys,
> >  		case FETCH_PROCESS_ARGS:
> >  			process_args(request, &data);
> >  
> > -			if (!data.want_obj.nr) {
> > +			if (!data.want_obj.nr && !data.wait_for_done) {
> >  				/*
> > -				 * Request didn't contain any 'want' lines,
> > -				 * guess they didn't want anything.
> > +				 * Request didn't contain any 'want' lines (and
> > +				 * the request does not contain
> > +				 * "wait-for-done", in which it is reasonable
> > +				 * to just send 'have's without 'want's); guess
> > +				 * they didn't want anything.
> >  				 */
> >  				state = FETCH_DONE;
> >  			} else if (data.haves.nr) {
> > @@ -1723,7 +1731,7 @@ int upload_pack_advertise(struct repository *r,
> >  		int allow_sideband_all_value;
> >  		char *str = NULL;
> >  
> > -		strbuf_addstr(value, "shallow");
> > +		strbuf_addstr(value, "shallow wait-for-done");
> 
> It might be nice to have this wait-for-done capability configurable.
> I'd likely want this on by default, but in case there is an issue it
> is easier to change config values than ship new binaries.

I felt that we didn't need this knob on the server side as this doesn't
expose any more information than a regular fetch, but I'm open to adding
it if neeed be.

> This is a pretty big patch. It might have been nice to split the
> server-side stuff out as its own patch with a follow-up for the client
> code and the tests.
> 
> Thanks,
> -Stolee

Personally I prefer that such changes (server and client) be together,
so that I can see on both sides how things work. There is (in theory)
already a clear divide between both sides, even within a patch, since
the server and client parts are usually in different parts. But if the
majority prefers that such changes be separate, I'm OK with doing that
too.

Also, thanks for your review.
