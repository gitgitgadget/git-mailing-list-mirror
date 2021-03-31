Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EAAC433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 20:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712D26108D
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 20:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhCaUqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhCaUq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 16:46:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518ECC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 13:46:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt15so32026178ejb.12
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NH3Az9zyHt1/wUfSzm1Lq30pCz+weMaBNbxG2uBGE5A=;
        b=ebWRFX0sbhHKvTRDmr+JRGEIIjKPCcAK7iWtGLPX4j51NPwmLPgPXuSRXLsRXcfBzg
         m0/lTfrw7mXC/xOdVvRTxI7iPb5pWCEl78nwhwFaPU2aZg4w56DopFcEIlYhyT8jktmt
         j24xNL3vl2D6YRXgVb5ZGKdH864XFifVLFcUd/4NfMNVf62Fy7yZo5zbscrT68yJ5PEY
         UgrSUR39ng0CEhUihk+ErB1k4kfqsnL4QrLcx3NFVLgW3/z0JFvtVd5i3vjIycnfkWzH
         WBQncv8QLSWIsYc2zhnMOOVFF6yXuuqVtS/p76y9cIYHnFZGCCJsGtIVqaUlr98UyhxU
         4nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NH3Az9zyHt1/wUfSzm1Lq30pCz+weMaBNbxG2uBGE5A=;
        b=oTMc1XH3JRZCL9u9Qm3GpduvWKv6L1DyamUPOWKTVZfc6v8CobSTyfSEVkmmzO/fHw
         0FI7NWk2F9m/H6YAJMSQOE+p1+yH0zQiOQ+tDpO+I756GR4pVTZ3iD6SebQ6H5piEQhX
         zUhj4/n0Cl1TjEmmksT9SVYTKSnMS0B6OQEoxwiny/sshv3pNJy9gU4FqUC4UfCDVuGv
         u6K8RLTNy3R5Nt+0ZrsNA80NgJSYIzV12zVoNrKKUOoFSVkUdoaSOt8+1TW1tHas623n
         S2pIFxlaqfZTYt36VWYo82BgziYAB4K5WxDlNJ3jpwOQ1hlAAsqVn+QQdte1qUEn9Yn6
         0BgA==
X-Gm-Message-State: AOAM5318XUAzhDxHzgCcmB0FSgI2bBinqhyCP+sw0O3SeBlOn3zQ/tCK
        Udy7hkcYHZXNCcfMisasHpM=
X-Google-Smtp-Source: ABdhPJyDSKfuzWaJDNtstYq+MHI/ZEvvmv4iuRpfWClicaWe0qqNdP9UhHmJup5dakpKZZMrJV7v2g==
X-Received: by 2002:a17:907:98f5:: with SMTP id ke21mr5714587ejc.552.1617223583945;
        Wed, 31 Mar 2021 13:46:23 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jj16sm1770073ejc.19.2021.03.31.13.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 13:46:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g> <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
 <87k0pnkwej.fsf@evledraar.gmail.com>
 <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
Date:   Wed, 31 Mar 2021 22:46:22 +0200
Message-ID: <87eefvkq5d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 31 2021, Jeff King wrote:

> On Wed, Mar 31, 2021 at 08:31:16PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > =C3=86var's patch tries to improve the case where we might _know_ whic=
h is
>> > correct (because we're actually parsing the object contents), but of
>> > course it covers only a fraction of cases. I'm not really opposed to
>> > that per se, but I probably wouldn't bother myself.
>>=20
>> What fraction of cases? As far as I can tell it covers all cases where
>> we get this error.
>>=20
>> If there is a case like what you're describing I haven't found it.
>
> It would happen any time somebody calls lookup_foo() because they saw an
> object referenced, but _doesn't_ parse it. And then somebody later calls
> lookup_bar() in the same way. Neither of them consulted the actual
> object database.
>
> Try this with your patches:
>
> -- >8 --
> git init repo
> cd repo
>
> # just for making things deterministic
> export GIT_COMMITTER_NAME=3D'A U Thor'
> export GIT_COMMITTER_EMAIL=3D'author@example.com'
> export GIT_COMMITTER_DATE=3D'@1234567890 +0000'
>
> blob=3D$(echo foo | git hash-object -w --stdin)
> git tag -m 'tag of blob' tag-of-blob $blob
> git update-ref refs/tags/tag-of-commit $(
>   git cat-file tag tag-of-blob |
>   sed s/blob/commit/g |
>   git hash-object -w --stdin -t tag
> )
> git update-ref refs/tags/tag-of-tree $(
>   git cat-file tag tag-of-blob |
>   sed s/blob/tree/g |
>   git hash-object -w --stdin -t tag
> )
>
> git fsck
> -- >8 --
>
> That fsck produces (257cc5642 is the blob):
>
>   error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a blob, not a=
 commit
>   error: 257cc5642cb1a054f08cc83f2d943e56fd3ebe99: object could not be pa=
rsed: .git/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
>   error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not=
 a tree
>   error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in a=
aff0d42df150e1a734f6a8516878b2ea315ee0a
>   error: aaff0d42df150e1a734f6a8516878b2ea315ee0a: object could not be pa=
rsed: .git/objects/aa/ff0d42df150e1a734f6a8516878b2ea315ee0a
>   error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not=
 a blob
>   error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in b=
bd2b7077cd91ee6175cdc0e4c477c25c230cdc7
>   error: bbd2b7077cd91ee6175cdc0e4c477c25c230cdc7: object could not be pa=
rsed: .git/objects/bb/d2b7077cd91ee6175cdc0e4c477c25c230cdc7
>
> So we claim "is X, not Y" in multiple directions for the same object.
>
> It might just be that there are spots in the fsck code that need to be
> adjusted to use your new function (if they are indeed parsing the
> referred-to object). But there are lots of places that don't actually
> parse the object at the moment they're parsing the tag. E.g.:
>
>   $ git for-each-ref --format=3D'%(*objectname)'
>   error: object 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 is a commit, not=
 a tree
>   error: bad tag pointer to 257cc5642cb1a054f08cc83f2d943e56fd3ebe99 in a=
aff0d42df150e1a734f6a8516878b2ea315ee0a
>   Segmentation fault
>
> Neither of those types is the correct one. And the segfault is just a
> bonus! :)
>
> I'd expect similar cases with parsing commit parents and tree pointers.
> And probably tree entries whose modes are wrong.

So the segfault happens without my patches, but the change is that
before we'd always get it wrong and say "commit, not a tree", but now
we'll get it right some of the time. Patching the relevant object.c code
to emit different messages from the various functions shows that it's
the oid_is_type*() functions that get it right, but object_as_type() is
wrong as before.

So that's certainly something I missed.

But are there any cases where it makes things worse? Or is it just that
it's not a full fix in all cases, but only a partial one?

>> I.e. it happens when we have an un-parsed "struct object" whose type is
>> inferred, and parse it to find out it's not what we expected.
>>=20
>> It's not ambigious at all what the object actually is. It's just that
>> the previous code was leaking the *assumption* about the type at the
>> time of emitting the error, due to an apparent oversight with parsed
>> v.s. non-parsed.
>>=20
>> Or in other words, we're leaking the implementation detail that we
>> pre-allocated an object struct of a given type in anticipation of
>> holding a parsed version of that object soon.
>
> Right. In the case that you are indeed parsing the object later, you can
> say definitively "it is X in the odb, but seen as Y previously". But we
> do not always hit the "is X, not Y" error when parsing the object. It
> might be caused by two of these "pre-allocations" (though really I think
> it is not just an implementation detail; the pre-allocation happened
> because some other object referred to us as a given type, so it really
> is a corruption in the repository. Just not in the object we mention).

Indeed, the goal is to emit a sensible message on-the-fly when we see
that corruption.

>> > @@ -169,10 +169,16 @@ void *object_as_type(struct object *obj, enum ob=
ject_type type, int quiet)
>> >  		return obj;
>> >  	}
>> >  	else {
>> > -		if (!quiet)
>> > -			error(_("object %s is a %s, not a %s"),
>> > -			      oid_to_hex(&obj->oid),
>> > -			      type_name(obj->type), type_name(type));
>> > +		if (!(flags & OBJECT_AS_TYPE_QUIET)) {
>> > +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
>> > +				error(_("object %s is a %s, but was referred to as a %s"),
>> > +				      oid_to_hex(&obj->oid), type_name(obj->type),
>> > +				      type_name(type));
>> > +			else
>> > +				error(_("object %s referred to as both a %s and a %s"),
>> > +				      oid_to_hex(&obj->oid),
>> > +				      type_name(obj->type), type_name(type));
>> > +		}
>> >  		return NULL;
>> >  	}
>> >  }
>>=20
>> Per the above I don't understand how you think there's any uncertainty
>> here.
>>=20
>> If I'm right and there isn't then first of all I don't see how we could
>> emit 1/2 of those errors. The whole problem here is that we don't know
>> the type of the un-parsed object (and presumably don't want to eagerly
>> know, it would mean hitting the object store).
>
> Forgetting for a moment how to trigger it with actual Git commands, the
> root of the problem is that:
>
>   lookup_tree(&oid);
>   lookup_blob(&oid);
>
> is going to produce an error message. But we cannot know which object
> type is wrong and which is right (if any). So we'd want to produce the
> "referred to as both" message.
>
> _If_ the caller happens to know that it has just parsed the object
> contents and got a tree, then it would call lookup_parsed_tree(&oid),
> which would pass along OBJECT_AS_TYPE_EXPECT_PARSED, and produce the
> other message.
>
> In practice, of course those two lookup_foo() calls are not right next
> to each other. But they may be triggered on an identical oid by two
> references from different objects.

[...]

>> But when we do know why would we beat around the bush and say "was
>> referred to as X and Y" once we know what it is.=20
>>=20
>> AFAICT there's no more reason to think that parse_object_buffer() will
>> be wrong about the type than "git cat-file -t" will be. They both use
>> the same underlying functions to get that information.
>
> My point is that we are not always coming from parse_object_buffer()
> when we see these error messages.

If my solution of relying on the parsed v.s. non-parsed shouldn't we
just devolve to a full object info lookup when emitting the error? It's
more expensive, but we're emitting an error anyway...
