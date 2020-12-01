Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A898C71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A4F20857
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 12:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxGWB2dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391031AbgLAMtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391016AbgLAMtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 07:49:42 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6299AC0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 04:49:02 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id lt17so3863877ejb.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=r+FGAmq5We/IgKFiLCf3J275KES5mgzWXvPeEyZYi1s=;
        b=CxGWB2dk31rcD654tDzuKYxtm0zNcx1GRlUmwGfT2sLaudXYnXyLEHLY3RkHFewICp
         yAB0qrlFVr78Ab2adLxtLtIxM0mWX3QVl5WFKJuoquNXHZCYOg3iH6y6hV+GOcxo016J
         D8WiB7VWxcaQvPhMbJyuHtNV3kk6TK8W2eqsbMZUE6lxHUAJbnLfKQAliAAI9rhXBXVZ
         tGl7VvtmqydYShBNMNvP95F4mnv/vwfrYTZRsZhzqwcjH+/u46cvJvgAjURLCD3C60Zx
         VncKgUI91YBTsAm26y+MOwdEUk2OGAQ1cnbQ2MkanIaUN/lwqA+5/JtdXfRZG1nDEbGo
         8a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=r+FGAmq5We/IgKFiLCf3J275KES5mgzWXvPeEyZYi1s=;
        b=obDIl7+k3wXn4hT6cux03Q+KGQUtDsSkR96eZtVU3BSmz6/FYcq0kFqqen7ZXf2xKw
         2JucOst8/vVwPp7NTwUFxLHThEJLaFsf1nCiLhlllZgSj9DZVur6D9JAytsnZp+/FlL5
         9GM/GQwPmLLJuhIUPiNt90SJLj4bZ5MiRQCinqiaM97Bha0A+lqBbPCq/SeMEB4VLOdR
         BTzRPqAEkYJXq9W1hES2KDrM9aV9rqmyfHODMj9ormc4yifYBUIm7qJITHFFNjfikkQk
         raHuqP5zwvkvOG5LceQFVePpa98ujWaOaOjrgTgGUtJmW/1KUbZ71bg/jTGMua+XlOHh
         55Nw==
X-Gm-Message-State: AOAM5320ccELOYLds+ln7HgwGbSZjviUHmicjUWrk6kY39ltdUR3U16L
        rFEaIfo5kiwNfNe/SrCIz3E=
X-Google-Smtp-Source: ABdhPJy4zkmBTmJCTdlJL0Yo4Ac/TdtdC59ZN6e3z7ksiZbz+LlewcBD/XCSP+AKHC6ILu1z3sV10A==
X-Received: by 2002:a17:906:7813:: with SMTP id u19mr2836519ejm.153.1606826940934;
        Tue, 01 Dec 2020 04:49:00 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ci20sm781884ejc.26.2020.12.01.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:49:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 6/9] Documentation: add Packfile URIs design doc
References: <87zh35okzy.fsf@evledraar.gmail.com>
 <20201125190957.1113461-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <20201125190957.1113461-1-jonathantanmy@google.com>
Date:   Tue, 01 Dec 2020 13:48:59 +0100
Message-ID: <87tut5vghw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 25 2020, Jonathan Tan wrote:

>> On Wed, Jun 10 2020, Jonathan Tan wrote:
>> 
>> > +This is the implementation: a feature, marked experimental, that allows the
>> > +server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
>> > +<uri>` entries. Whenever the list of objects to be sent is assembled, all such
>> > +blobs are excluded, replaced with URIs. The client will download those URIs,
>> > +expecting them to each point to packfiles containing single blobs.
>> 
>> I was poking at this recently to see whether I could change it into the
>> more dumb method I noted in
>> https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/
>> 
>> As an aside on a protocol level could that be supported with this
>> current verb by having the client say "packfile-uris=early" or something
>> like that instead of "packfile-uris"? 
>
> Hmm...would the advantage of this be that the client can subsequently
> report any OIDs it finds as "want"s?

Yes, as a means-to-an-end of allowing the server CDN part to be dumb and
possibly out-of-date.

I.e. the current "here's some blobs and then a complimentary pack"
requires very close CDN/server coordination.

Whereas if you can say early in the dialog "here's a pack that should
have most of what you need, then do a want/fetch to get up-to-date" you
can just make that pack in a cronjob, the pack could even be corrupted
etc. and we'd just optimistically fall back on a full clone.

It wouldn't be reporting any OID it finds (too noisy). I haven't
experimented, but one dumb way to do it is for the server to serve up a
pack with "start negotiating with this SHA", which would just be a
recent revision of HEAD guaranteed to be in the served pack.

Or the client could scour the pack and e.g. find all commit tips in it
by running the equivalent of commit-graph on it first. More expensive,
but expensive on the client-side, and allows e.g. re-using that codepath
to clone on the basis of a GIT_ALTERNATE_OBJECT_DIRECTORIES containing
objects the <remote url> might have already.

> I guess the protocol could be extended to support "packfile-uris" at any
> negotiation step.

*nod*

>> The server advertising the same,
>> and the client then just requesting packfile-uris before ls-refs or
>> whatever? The server would need to be stateful about what's requested
>> when and serve up something different than the current
>> one-blob-per-pack. 
>
> Statefulness will be difficult. Right now, protocol v2 is stateless,
> and updating it to be stateful will be difficult, I believe - at least
> for HTTP, the statelessness design has been long there and other
> implementations of Git or systems that use Git might have already made
> that assumption (it is stateless both for protocol v0 and v2).

Sorry, on second thought what I'm suggesting doesn't really require
state, just the server to get/read/understand the "client supports this"
flags that it already does.

> As for serving more than one blob per pack, the current protocol and
> implementation already allows this. You can see a demonstration by
> cloning the following repository, which supports it on the server side:
>
>   GIT_TRACE_PACKET=1 git -c fetch.uriprotocols=https clone \
>     https://chromium.googlesource.com/chromium/src/base

So cloning that produces two packs (the packfile-uri one, and the
negotiated one), the packfile-uri one being:
    
    $ git show-index <objects/pack/pack-d917d9803d3acb03da7ea9e8ebb8e643364ba051.idx
    12 3ea853619c232488e683139217585f520ec636e0 (8e33883c)
    9371 83d1358e4979bf9aff879cb4150276cd3894463a (0ea17153)
    13640 d0f8c611c044b36b8ac57b7a3af18a8d88e4dde2 (af8be7a0)
    572 da9ca8b36d5029bd9b18addc054ba9c0b016e6bc (d57fdbac)

So 3ea853619 is a commit with a tree da9ca8b36/ , that tree has pointer
to win/ via 83d1358e4, which has a blob win/.clang-tidy at d0f8c611c.

So this is intended & you're already using it like that. So shouldn't
the docs be updated from:

    [...]one or more `uploadpack.blobPackfileUri=<sha1> <uri>`
    entries. Whenever the list of objects to be sent is assembled, all
    such blobs are excluded, replaced with URIs. The client will
    download those URIs, expecting them to each point to packfiles
    containing single blobs.

To something like:

    [...]one or more `uploadpack.postWantPackfileUri=<sha1> <uri>`
    entries. When the server sends the subsequent full pack any objects
    sent out-of-bound may be excluded. The client will download those
    URIs, expecting them to each contain some amount of objects. The
    union of the packs found at these URIs and the server's own returned
    packfile is expected to yield a valid repository that'll pass an
    fsck.

Aside from the hassle of renaming the "uploadpack.blobPackfileUri"
variable to some more accurate "this clearly has nothing to do with
blobs per-se, really" name that re-done paragraph seems to more
accurately reflect what this is doing & intended to do.

Also, why it it necessary to make it an error if the expected hash for
the packfile doesn't match, since we're about to do a full fsck
connectivity check anyway? The POC patch at the end of this mail[1]
shows that we mostly support it not matching now.

I suppose you might want to point to an evil CDN, but since it currently
needs to fsck the potential for that evilness seems rather limited. It's
not a hassle in the current closely coupled server/CDN implementation,
but to e.g. have a server dumbly pointing at
https://some-cdn.example/REPONAME/some-big-recent-pack.pack it's a
hassle, so having it at least optionally support the NULL_SHA would be
ideal for that. So I'm curious what you think it adds to the overall
security of the feature.

>> Any pointers to where/how to implement that would be
>> welcome, I got lost in the non-linearity of the
>> connect.c/fetch-pack.c/upload-pack.c code yesterday.
>
> upload_pack_v2() in upload-pack.c and do_fetch_pack_v2() in fetch-pack.c
> have the state machines of the server and client side respectively - I
> think those would be the first places to look.

Thanks.

>> But I'm mainly replying here to ask if it's intentional that clients are
>> tolerant of the server sending whatever it pleases in the supposedly
>> "single blob" packs. As demonstrated by the tests passing with this
>> patch:
>
> [snip test]
>
> Yes, it has the same tolerance w.r.t. the packfile URI packs as w.r.t.
> the inline packfile that gets sent.
>
>> As you may guess from the "shattered" I was trying to find if the
>> particulars around the partial fsck allowed me to exploit this somehow,
>> I haven't found a way to do that, just be annoying by sending the client
>> more than they asked for, but I could also do that with the normal
>> dialog. Just wondering if the client should be opening the pack and
>> barfing if it has more than one object, or not care.
>
> Ah yes, as you said, it's the same as with the normal dialog.

1.:

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..87d948b023 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1661,9 +1661,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 
 		if (memcmp(packfile_uris.items[i].string, packname,
 			   the_hash_algo->hexsz))
-			die("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
-			    uri, (int) the_hash_algo->hexsz,
-			    packfile_uris.items[i].string);
+			warning("fetch-pack: pack downloaded from %s does not match expected hash %.*s",
+				uri, (int) the_hash_algo->hexsz,
+				packfile_uris.items[i].string);
 
 		string_list_append_nodup(pack_lockfiles,
 					 xstrfmt("%s/pack/pack-%s.keep",
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7d5b17909b..bc0fc4d8e3 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -798,9 +798,13 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 configure_exclusion () {
 	git -C "$1" hash-object "$2" >objh &&
 	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+	fake_sha=$(git hash-object --stdin <packh) &&
+	mv \
+		"$HTTPD_DOCUMENT_ROOT_PATH/mypack-$(cat packh).pack" \
+		"$HTTPD_DOCUMENT_ROOT_PATH/mypack-$fake_sha.pack"
 	git -C "$1" config --add \
 		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+		"$(cat objh) $fake_sha $HTTPD_URL/dumb/mypack-$fake_sha.pack" &&
 	cat objh
 }
 
@@ -852,7 +856,7 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
-test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
+-test_expect_success 'fetching with valid packfile URI but invalid hash warns' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	rm -rf "$P" http_child log &&
 
@@ -870,13 +874,12 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
 	# expected length.
-	git -C "$P" hash-object other-blob >objh &&
 	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
 	git -C "$P" config --add \
 		"uploadpack.blobpackfileuri" \
 		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 
-	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
+	env GIT_TEST_SIDEBAND_ALL=1 \
 		git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
 		clone "$HTTPD_URL/smart/http_parent" http_child 2>err &&
