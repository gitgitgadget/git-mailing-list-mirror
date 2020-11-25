Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D9CC63777
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B5A206F7
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDbtiOOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgKYJPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgKYJPd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 04:15:33 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C3FC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:15:32 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k27so1946135ejs.10
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=v7eFqi852MHqBvH7Wi5yxSTsFMOZpfvAOsgQGAEVODo=;
        b=PDbtiOOO2rKefmexCXW08e6DdgP+j4TYRFd1viW2HZOQ6AaQ8oUZgGj3CE2pUwuLPE
         qoJW6g48mKukjanB8boMOY5X7pI4H6atfZ9WWNFjRJTxKqRnZOT5m5HqW7z4qaHPJfva
         m1qCioFrnjw9+ZGUeaHP/0yfjNNTxGpHFGJzSEWRUAXDOhim0pc4YaFPgEbRr2HJyUcR
         7SNHh/21SAiljMmHIhijiGz1FaMYZXqmbUDtV2p9JljVVd+5cKn3tFLZ8mbo1NwbwpKM
         /lATSUQpT1fE/pgvBZXeIYMSLPsTnr84Y2FsJ7jJItpbuTMWKoKoY5eUHZFUS5sudZEg
         qZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=v7eFqi852MHqBvH7Wi5yxSTsFMOZpfvAOsgQGAEVODo=;
        b=dLMsbmgc/tgPHC76xY98GgcanwBhG/qX+TS+/1cqpPPHoGM4sC818eUBjPBjQdAbBI
         W2tPgx3D0Q2gzpfUDf5zKMsEd5+qg4h6DUKkdysYqQNkPmKzLMmvTLG2AhbJIKqObV1r
         nEHO9teVl2OM40LxJCVTjqKDbYhMYDsb+FE+pM844HSiyxO8qILPffBX0YXW+tunZTrK
         0Rfaaj50kqRpAYLpdT5HYjYCrX91F7ELzlZ9G8zKTHdeLP1Agt9jFWcHCOWsVHcYQ6Wu
         sQvYeIPnNasj0LfyIscSv/LHuZQ1Wgt7I1TA0AntmYzQJC2lumh4IfaFKJUBoQOtxRCr
         +yZQ==
X-Gm-Message-State: AOAM531NI8/9M7k0zkXyd1LpP/Knvmyzha35CkUuGo7gmsvrTcxse3EX
        8QCGIavxRGniFfnlUw/8IFs=
X-Google-Smtp-Source: ABdhPJx4pX40rt6TG6SaRVGk+pUunJnQIjiw7nbh6BNzRd3C3nTybtG57S1EGdFDGDGFUIaCI0A3NA==
X-Received: by 2002:a17:906:1744:: with SMTP id d4mr2399932eje.176.1606295731575;
        Wed, 25 Nov 2020 01:15:31 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id u17sm858520eje.11.2020.11.25.01.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 01:15:30 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/9] Documentation: add Packfile URIs design doc
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com> <6344c225897de1a2d8aa86d610e9eaf1c6ec82b4.1591821067.git.jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <6344c225897de1a2d8aa86d610e9eaf1c6ec82b4.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 25 Nov 2020 10:15:29 +0100
Message-ID: <87zh35okzy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 10 2020, Jonathan Tan wrote:

> +This is the implementation: a feature, marked experimental, that allows the
> +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
> +<uri>` entries. Whenever the list of objects to be sent is assembled, all such
> +blobs are excluded, replaced with URIs. The client will download those URIs,
> +expecting them to each point to packfiles containing single blobs.

I was poking at this recently to see whether I could change it into the
more dumb method I noted in
https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/

As an aside on a protocol level could that be supported with this
current verb by having the client say "packfile-uris=early" or something
like that instead of "packfile-uris"? The server advertising the same,
and the client then just requesting packfile-uris before ls-refs or
whatever? The server would need to be stateful about what's requested
when and serve up something different than the current
one-blob-per-pack. Any pointers to where/how to implement that would be
welcome, I got lost in the non-linearity of the
connect.c/fetch-pack.c/upload-pack.c code yesterday.

But I'm mainly replying here to ask if it's intentional that clients are
tolerant of the server sending whatever it pleases in the supposedly
"single blob" packs. As demonstrated by the tests passing with this
patch:
    
    diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
    index 7d5b17909bb..4fe2030f4c1 100755
    --- a/t/t5702-protocol-v2.sh
    +++ b/t/t5702-protocol-v2.sh
    @@ -797,11 +797,12 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
     
     configure_exclusion () {
     	git -C "$1" hash-object "$2" >objh &&
    +	echo -n shattered | git -C "$1" hash-object --stdin -w >>objh &&
     	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
     	git -C "$1" config --add \
     		"uploadpack.blobpackfileuri" \
    -		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
    -	cat objh
    +		"$(head -n 1 objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
    +	head -n 1 objh
     }
     
     test_expect_success 'part of packfile response provided as URI' '
    @@ -820,10 +821,11 @@ test_expect_success 'part of packfile response provided as URI' '
     	configure_exclusion "$P" my-blob >h &&
     	configure_exclusion "$P" other-blob >h2 &&
     
    -	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
    -	git -c protocol.version=2 \
    +	GIT_TRACE=1 GIT_TRACE2="$(pwd)/log" GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
    +	CHECK_SHATTERED=1 git -c protocol.version=2 \
     		-c fetch.uriprotocols=http,https \
     		clone "$HTTPD_URL/smart/http_parent" http_child &&
    +	cp "$(pwd)/log" /tmp/clone.log &&
     
     	# Ensure that my-blob and other-blob are in separate packfiles.
     	for idx in http_child/.git/objects/pack/*.idx
    @@ -832,7 +834,7 @@ test_expect_success 'part of packfile response provided as URI' '
     		{
     			grep "^[0-9a-f]\{16,\} " out || :
     		} >out.objectlist &&
    -		if test_line_count = 1 out.objectlist
    +		if true
     		then
     			if grep $(cat h) out
     			then

As you may guess from the "shattered" I was trying to find if the
particulars around the partial fsck allowed me to exploit this somehow,
I haven't found a way to do that, just be annoying by sending the client
more than they asked for, but I could also do that with the normal
dialog. Just wondering if the client should be opening the pack and
barfing if it has more than one object, or not care.
