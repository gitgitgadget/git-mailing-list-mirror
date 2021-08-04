Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8815C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9141A60EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhHDXts (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhHDXtq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:49:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800CBC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:49:32 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id zb12so1526932ejb.5
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=0s2RoGpRdfWJihbFJdZ5uTtj473eD1Can29gMbw+BmQ=;
        b=HxzqN2CTB8UwKAAH6uRAxTQHC/nIizQac5VGwyIxlKflrIlPsFBqyv8UB2cOZRawqU
         FA0L8uqVSfhtBk0j5Ixi5aCLkWHC72ZtNbXyRJl+QR19RcP25edVCh8MylChbBzje0r0
         rEM2n21sQhMXv5zMHJmbWyqrR/YvlkuE4BYzwceg3Gtz5I+ku0YK9Q655Bx3+SPhIVKC
         Ud+t+q4V1JBLpvojmfLtb4LKOd/dK1wIStKL2EflEO3a7UQGMKP2FcFCKDm3jvzWz46B
         ymg+ISzXAe0emm69nxU4eGNsaZ+0Xn6rXq+T4SUe9l3n74u2q8Z/MULGzZD/q/N4Ex7e
         LmkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=0s2RoGpRdfWJihbFJdZ5uTtj473eD1Can29gMbw+BmQ=;
        b=f3/yYQcevtl1RWIR7iJGImgMOiXpbvcB3p6pnSi9xlISdeIp15hAMx8/UTL1sf8KEF
         NeTyHViN+pW9T0h65MW0jBYoQbrBczpo3CKOGGImWVaGRL/vU57VRfQiVgnoEBOcYKjB
         lGes+xf6DjaAsJR9V/FZSZxkrrZPp0vefvjTfkrlsS9NbThHsjo6rj6RLubFttAtT2bg
         fyWGF2N0sNu43Nw7Lg+vlOzKn1v8+1SQzG5BWqjhffqGGYWE0niXcG3lHFw7Yz/1SH4e
         ih5CUQSIN9dQaASeHo7VeVW68EftsmX30713ahenF4iQlTkix5oIqgIvMqXm1vFFwtjo
         9cbQ==
X-Gm-Message-State: AOAM533AWWPSerqWbfakilpLEffh62kapQ+QJkMvm+vzWsc4a58+NQ/x
        bDBImw/zE3b1qvlzuVsAR/E=
X-Google-Smtp-Source: ABdhPJz0wqtfopp2t53CAqYtbJdoL/plaAvSoMP/f1mytVm6c8+67n51I/FgXomYNx82XNcRWhtScg==
X-Received: by 2002:a17:906:2642:: with SMTP id i2mr1610104ejc.323.1628120971002;
        Wed, 04 Aug 2021 16:49:31 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id fi23sm1077849ejc.83.2021.08.04.16.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:49:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
Date:   Thu, 05 Aug 2021 01:40:51 +0200
References: <cover.1628115064.git.steadmon@google.com>
 <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
Message-ID: <87a6lwn52u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Josh Steadmon wrote:

> It is useful for performance monitoring and debugging purposes to know
> the wire protocol used for remote operations. This may differ from the
> version set in local configuration due to differences in version and/or
> configuration between the server and the client. Therefore, log the
> negotiated wire protocol version via trace2, for both clients and
> servers.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---

I know Taylor asked you to change it to a string from in int upthread in
<YQmxSxTswHE/gTet@nand.local>, but I really don't see the point. But am
willing to be convinced otherwise.

It seems to me that both of these codepaths will never usefully use this
new "UNKNOWN_VERSION" string you added, i.e.:

>  connect.c                             |  3 +++
>  protocol.c                            |  3 +++
>  t/t5705-session-id-in-capabilities.sh | 12 ++++++++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index 70b13389ba..5f0e113625 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -150,6 +150,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
>  		break;
>  	}
>  
> +	trace2_data_string("transfer", NULL, "negotiated-version",
> +			   format_protocol_version(version));

Right after this.

>  	switch (version) {
>  	case protocol_v2:
>  		process_capabilities_v2(reader);

We'll die here with BUG("unknown protocol version") if it's unknown..

> diff --git a/protocol.c b/protocol.c
> index 7ec7ce896e..f52dc2d7a2 100644
> --- a/protocol.c
> +++ b/protocol.c
> @@ -87,6 +87,9 @@ enum protocol_version determine_protocol_version_server(void)
>  		string_list_clear(&list, 0);
>  	}
>  
> +	trace2_data_string("transfer", NULL, "negotiated-version",
> +			   format_protocol_version(version));
> +

And this code is simply unreachable as far as logging this
"UNKNOWN_VERSION" string goes. If we did have an unknown version we'd
die right above this with:

    die("server is speaking an unknown protocol")

And if we did not have a "version " at all we'd default to protocol_v0
here, i.e. we either die already on an unknown version, or we don't log
"UNKNOWN_VERSION" at all.

>  	return version;
>  }
>  
> diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
> index f1d189d5bc..88871c59b5 100755
> --- a/t/t5705-session-id-in-capabilities.sh
> +++ b/t/t5705-session-id-in-capabilities.sh
> @@ -40,6 +40,7 @@ do
>  		test -z "$(grep \"key\":\"server-sid\" tr2-client-events)" &&
>  		test -z "$(grep \"key\":\"client-sid\" tr2-server-events)"
>  	'
> +
>  done
>  
>  test_expect_success 'enable SID advertisement' '
> @@ -73,6 +74,17 @@ do
>  		grep \"key\":\"server-sid\" tr2-client-events &&
>  		grep \"key\":\"client-sid\" tr2-server-events
>  	'
> +
> +	test_expect_success "client & server log negotiated version (v${PROTO})" '
> +		test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
> +		cp -r "$LOCAL_PRISTINE" local &&
> +		GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
> +		git -c protocol.version=$PROTO -C local fetch \
> +			--upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
> +			origin &&
> +		test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events)" &&
> +		test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events)"
> +	'
>  done
>  
>  test_done

So given the above I think you can come up with trace2 output where we
log "UNKNOWN_VERSION", it just seems rather useless. We'll hit a BUG()
anyway, which we also trace2 log. In terms of anyone who collect logs
surely they'll first care about logged BUG(), and second about any
version aggregation involved in such a BUG(), and it's not a big deal if
the report of versions doesn't include the "UNKNOWN VERSION" to go with
such a one-off bug.

But perhaps you and Taylor really do have a use-case for this, hence the
"willing to be convinced otherwise". I suspect the desire to log
"<unknown>" came from an assumption that we did so in any recoverable
non-BUG() case, which we won't do.
