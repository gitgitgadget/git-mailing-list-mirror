Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D14CC07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9A66101E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 21:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhGTUbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhGTU1o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 16:27:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315E4C061767
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:07:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id hd33so1538ejc.9
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8rLGhKvj6CwWqOzKiGM2J7K1AIYzu7hf+xza1uF6LBQ=;
        b=BfrLxq6TAu3Vau41aKBW7c8wd7A5jAKG10cggfUV4MGho3AMaQzsvW662iVtsgTX5c
         CPSDMDxsV8K8tX8ARUwVMOGEZJ/R7Eag6KsOJNfPkilZT4GZ6AgNJ3JwF/QHqVklYX9B
         Ot42Za94WqROe4kkWoS54WZDn46FEuORhclUcwb+QdW7ifRQImi9oV4pmZWlJhBFtIY1
         a3lPv2NMwl3EDiJFU1j6osvWkp7rApYeZKfTcK1S8WHbw7ztVzozFFlbcwJ0JBXIY1Jj
         bunUkoSNcNUyzTD/2bAF1R3Jyf/CcYpdYHunY+PFarvSXmWQ3RVwHRUG6zobERA6agQn
         yE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8rLGhKvj6CwWqOzKiGM2J7K1AIYzu7hf+xza1uF6LBQ=;
        b=p8BPymIBv8qeYZkOznTz3tYmx8j6/KlMi5ofZFB7I2YF5HmE2MN1Hgtz9Ni2Uj59MA
         COPx664bDI821loiVq13F3656HCEWTTSw2dTCg+Js8NFjpWnfQ6dnDKkNCxvUjJ3gXmL
         Zvif61m67KYBvWrwyLy1CKEPfcNl1kO5kGe0joSwf/XUCNiad6QNAyOdonYVLwLWH6re
         p0Mt4yLg1T57CnMhqLjtySsagaoWAXBgA7v3Z1NC6rUTgk3v6EfBDgNuYDuWywQzFHtM
         SFsv/2u2IuV0RtpnLhJG2krvtyrY4TzHlKk7rj8EivmrprfWD0fMYVECBseWdAT2XRLq
         QlTw==
X-Gm-Message-State: AOAM5334V0apXkKgCfl/C0DFad1qR7ii1ry+3A6LNFIynvNrQyWEaCXf
        qWcZ1mEkQtO2K7Ww3kukt+X7CgPO8wUqeg==
X-Google-Smtp-Source: ABdhPJwG/hlNnL+2GT59vEFyGkQKbEWY7DKdGEZjuOyx/G7zVTwsKaUFNXbSgQqCoKBFhQsX6X3W8w==
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr34698008eji.177.1626815263222;
        Tue, 20 Jul 2021 14:07:43 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n6sm7582062ejc.120.2021.07.20.14.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 14:07:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net, emilyshaffer@google.com
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
Date:   Tue, 20 Jul 2021 22:55:29 +0200
References: <cover.1623881977.git.jonathantanmy@google.com>
 <cover.1626453569.git.jonathantanmy@google.com>
 <1ec1c958eb2b8aa2581280d050836dd0e7f6edef.1626453569.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <1ec1c958eb2b8aa2581280d050836dd0e7f6edef.1626453569.git.jonathantanmy@google.com>
Message-ID: <87o8awvglr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Jonathan Tan wrote:

> Teach the "git hook install all|<hook-name>" command, that can install
> one or all remote-suggested hooks.
>
> If a configuration option hook.promptRemoteSuggested is set, inform the
> user of the aforementioned command:
>
>  - when cloning, and refs/remotes/origin/suggested-hooks is present in
>    the newly cloned repo
>  - when fetching, and refs/remotes/origin/suggested-hooks is updated
>  - when committing, there is a remote-suggested commit-msg hook, and
>    there is currently no commit-msg hook configured
>
> NEEDSWORK: Write a more detailed commit message once the design is
> finalized.

This is a bit orthagonal to what you're going for I guess, so sorry in
advance about the "but what about" bikeshedding you must be getting
tired of by now...

> @@ -1393,6 +1393,18 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  			   branch_top.buf, reflog_msg.buf, transport,
>  			   !is_local);
>  
> +	if (hook_should_prompt_suggestions()) {
> +		for (ref = mapped_refs; ref; ref = ref->next) {
> +			if (ref->peer_ref &&
> +			    !strcmp(ref->peer_ref->name,
> +				    "refs/remotes/origin/suggested-hooks")) {
> +				fprintf(stderr, _("The remote has suggested hooks in refs/remotes/origin/suggested-hooks.\n"
> +						  "Run `git hook install all` to install them.\n"));
> +				break;
> +			}
> +		}
> +	}
> +
>  	update_head(our_head_points_at, remote_head, reflog_msg.buf);
>  
>  	/*
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 769af53ca4..e86c312473 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "hook.h"
>  
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>  
> @@ -1313,6 +1314,22 @@ static int consume_refs(struct transport *transport, struct ref *ref_map)
>  				 ref_map);
>  	transport_unlock_pack(transport);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);
> +
> +	if (hook_should_prompt_suggestions()) {
> +		struct ref *ref;
> +
> +		for (ref = ref_map; ref; ref = ref->next) {
> +			if (ref->peer_ref &&
> +			    !strcmp(ref->peer_ref->name,
> +				    "refs/remotes/origin/suggested-hooks") &&
> +			    oidcmp(&ref->old_oid, &ref->peer_ref->old_oid)) {
> +				fprintf(stderr, _("The remote has updated its suggested hooks.\n"));
> +				fprintf(stderr, _("Run 'git hook install all' to update.\n"));
> +				break;
> +			}
> +		}
> +	}
> +
>  	return ret;
>  }

...but this part makes me think that if this is all we're aiming for as
far as server-client interaction is concerned we'd be much better off
with some general "server message-of-the-day" feature. I.e. server says
while advertising:

    version 2
    agent=...
    # does protocol v2 have a nicer way to encode this in the capabilities? I think not...
    motd=tellmeaboutref:suggested-hooks;master

Client does, while handshake() etc.:

    # other stuff
    command=ls-refs
    ....
    0000
    # Get motd from server
    command=motd
    0001
    refat suggested-hooks $SUGGESTED_HOOKS_AT_OID
    refat master $MASTER_AT_OID
    0000

And server says, after just invoking a "motd" hook or whatever, which
would be passed the git version, the state of any refs we asked politely
about and the client was willing to tell us about etc.

    Hi, we've got suggested hooks in this repository, it seems:
    if $agent > $min_git_version
        you have a supported git version, great....
    else
        <sadtrombone> you might want to upgrade your git to....
    fi

We could even carry this specific message in git.git, but under the hood
it would be the equivalent of a default 'motd' hook you could enable.

Maybe where you're going with this precludes such a MOTD approach.

FWIW I think there's lots of use-cases for it, and this specific hook
case is just one, so if we could make it slightly more general & just
make this a special-case of a generally useful facility.

Even for your use-case it would be useful, e.g. the whole discussion
we've been having about should the hooks by in a magic ref or your
current branch or not.

With a motd hook it doesn't matter, you just make "git hook install"
support installing hooks from whatever rev/tree, and a combination of
the "tellmeaboutref" and that feature means you can pick one or the
other, or tell users they need to install <some custom dependency> first
or whatever.

