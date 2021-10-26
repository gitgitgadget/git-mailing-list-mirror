Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1DC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11B960C51
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 15:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhJZPYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhJZPYw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 11:24:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66EC061745
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:22:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d3so15784796wrh.8
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OPDXn2y3fHDMUuEPpE4If9ftYDo5vR15UKj49XCV1T0=;
        b=S/2iV9KNg+Gs+WnZmoM/pVwO9Ec/9HR5Gi1wCD0Q7GdsgaDkVgX0nP+wCubi6nmjQj
         Pq/xICRclrV/7AcO2tqxBfke9tkM/TdRrp09fvYayxNUz0TH0Fl3ysjtOLOvSRuHn7nF
         2PjRFKYevLsoV4GhzGuRrTxF7QZkMYy8uhXyXUsnYsx4Zc4vjQtlpS4fpefqh1aXMJiu
         /aOViJGNWGKfJuvi4VCPUQCXs/cTVEQ5ydTsJOcrEFJmqtkCq3ZTsqmCli27y+r03dan
         5rv5Kd108Q5IEKLMvU9YJOElTdS8kyELCh/y8HJMdyoOj0TQoojSM7kKi33rAhPRXO6Y
         UBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OPDXn2y3fHDMUuEPpE4If9ftYDo5vR15UKj49XCV1T0=;
        b=S+5a6RQtsrf2QwWDSQbKz0WL+vaU4u7yrojnqjekDs3ziQ4Mj3wRYkXDiqywFr9e7e
         XQaXXs24Udwt5l66ZFETkv2XyHBFayFu67tR6LmuSwMv5e2e1vPQ2HiPCJP97U54SmrM
         fcHV1EZhF0yq5XSIT0ek46hVnSaWKZw6+rNq/QN3pGQfAGVlRf3B9WF/d923MExGAwyO
         AYByo8k6r0EGURfojyq+ADFiUCgtoypHLI8t3OpZ+/NEQ6VY1d4+xTbo6jodvl9rZI4L
         UC1cfdmqTVaBIy+gpu8CdGFlRsEPxokMfHqVGOX7HXhKj7t9NW6DxYF0A4DDsgeNSAh8
         7iTA==
X-Gm-Message-State: AOAM530kkF9cwe53dHlWDOwrKIS4imi7xaqA3nMqu9+lksxhur+KxGrx
        bztHgzLDSnNQncdhNnF+se+3oMre6G2pyg==
X-Google-Smtp-Source: ABdhPJzg1E8V0dxDwwH/xsf84wDFz28Bkai/sp50gcMTSoFqu1ZXflivK5faEy/jrF/6U8JO3sujyw==
X-Received: by 2002:adf:8bce:: with SMTP id w14mr18090535wra.391.1635261746877;
        Tue, 26 Oct 2021 08:22:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k6sm19668325wri.83.2021.10.26.08.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 08:22:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mfOHP-001qrd-JX;
        Tue, 26 Oct 2021 17:22:23 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        "Robin H . Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/3] protocol v2: specify static seeding of clone/fetch
 via "bundle-uri"
Date:   Tue, 26 Oct 2021 17:00:08 +0200
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com>
 <patch-2.3-3ac0539c053-20211025T211159Z-avarab@gmail.com>
 <f2269fc7-1688-d62e-02bb-01c5b5e33143@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <f2269fc7-1688-d62e-02bb-01c5b5e33143@gmail.com>
Message-ID: <211026.86cznrzu8g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 26 2021, Derrick Stolee wrote:

> On 10/25/2021 5:25 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/tec=
hnical/protocol-v2.txt
>> +bundle-uri CLIENT ERROR RECOVERY
>> +++++++++++++++++++++++++++++++++
>> +
>> +A client MUST above all gracefully degrade on errors, whether that
>> +error is because of bad missing/data in the bundle URI(s), because
>> +that client is too dumb to e.g. understand and fully parse out bundle
>> +headers and their prerequisite relationships, or something else.
>
> "too dumb" seems a bit informal to me, especially because you
> immediately elaborate on its meaning. You could rewrite as follows:
>
>   ...because
>   that client can't understand or fully parse out bundle
>   headers and their prerequisite relationships, or something else.

Thanks, I've snipped all your subsequent comments on
phrasing/clarifications etc, except insofar as they have questions I
need to address (as opposed to just my bad grammar/phrasing etc).

Thanks a lot for them, will go through them closely for any subsequent
re-roll & address them.

> [...]
>> +While no per-URI key-value are currently supported currently they're
>> +intended to support future features such as:
>> +
>> + * Add a "hash=3D<val>" or "size=3D<bytes>" advertise the expected hash=
 or
>> +   size of the bundle file.
>
> I suppose if one wanted to add this server-to-bundle coupling, then some
> clients might appreciate it.

For packfile-uri there's a hard dependency on the server transferring
the hash of the PACK file.

I've intentionally omitted it, the reasons are covered in [1], which I
realize now should really be part of this early series.

Basically having it as a hard requirement isn't necessary for security
or payload validation. Any server who's worried about their transport
integrity would point to a https URI under their control, any
checksumming and validation we'll need we'll get from the transport
layer and the client's reachability check.

Having it would mean that you need closer cooperation by default between
server and CDN than I'm aiming for, i.e. a server should be able to
point to some URI somewhere updated by a dumb hourly cronjob, without
needing to pass information back & forth about what the "current" URL
is. The client will discover all that.

But I left that "hash=3D*" in because it could be optionally added, in
case someone really wants it for some reason...

1. https://lore.kernel.org/git/RFC-patch-13.13-1e657ed27a-20210805T150534Z-=
avarab@gmail.com/

>> + * Advertise that one or more bundle files are the same (to e.g. have
>> +   clients round-robin or otherwise choose one of N possible files).
>
>   * Advertise that one or more bundle files are the same, to allow for
>     redundancy without causing duplicated effort.

*nod*

>> +static void send_bundle_uris(struct packet_writer *writer,
>> +			     struct string_list *uris)
>> +{
>> +	struct string_list_item *item;
>> +
>> +	for_each_string_list_item(item, uris)
>> +		packet_writer_write(writer, "%s", item->string);
>> +}
>> +
>> +static int advertise_bundle_uri =3D -1;
>> +static struct string_list bundle_uris =3D STRING_LIST_INIT_DUP;
>
> I see you put send_bundle_uris() before the global bundle_uris so
> it can be independent, but do you expect anyone to call send_bundle_uris()
> via a different list?

No, I'll move that around or rather fold it into bundle_uri_command()
directly.

I think I'd originally copied the structure of send_ref() and ls_refs()
from ls-refs.c, but it doesn't make much sense anymore here for this
2-line function. Thanks.

> Should we find a different place to store this data?
>
>> +static int bundle_uri_config(const char *var, const char *value, void *=
data)
>> +{
>> +	if (!strcmp(var, "uploadpack.bundleuri")) {
>> +		advertise_bundle_uri =3D 1;
>> +		string_list_append(&bundle_uris, value);
>> +	}
>> +
>> +	return 0;
>> +}
>
> Here, we are dictating that the URI list is available as a multi-valued
> config "uploadpack.bundleuri".
>
> 1. Should this be updated in Documentation/config/uploadpack.txt?

Definitely. I'll either incorporate that or re-structure this leading
series so that it's more design-doc/protocol focused, in any case all of
this ends up documented in the right places eventually...

> 2. This seems difficult to extend to your possible future features as
>    listed in the protocol docs, mainly because this can only store the
>    flat URI string. To add things like hash values, sizes, and prereqs,
>    you would need more data included and grouped on a per-URI basis.
>    What plans do you have to make extensions here while remaining
>    somewhat compatible with downgrading Git versions?

[...addressed below...]

>> @@ -136,6 +137,11 @@ static struct protocol_capability capabilities[] =
=3D {
>>  		.advertise =3D always_advertise,
>>  		.command =3D cap_object_info,
>>  	},
>> +	{
>> +		.name =3D "bundle-uri",
>> +		.advertise =3D bundle_uri_advertise,
>> +		.command =3D bundle_uri_command,
>> +	},
>>  };
>
> I really appreciate that it is this simple to extend protocol v2.

Yeah! FWIW I've got some WIP patches to make it easier still, i.e. some
further simplification & validation in the serve.[ch] API.

>> +test_expect_success 'basics of bundle-uri: dies if not enabled' '
>> +	test-tool pkt-line pack >in <<-EOF &&
>> +	command=3Dbundle-uri
>> +	0000
>> +	EOF
>> +
>> +	cat >err.expect <<-\EOF &&
>> +	fatal: invalid command '"'"'bundle-uri'"'"'
>> +	EOF
>> +
>> +	cat >expect <<-\EOF &&
>> +	ERR serve: invalid command '"'"'bundle-uri'"'"'
>> +	EOF
>> +
>> +	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actua=
l &&
>> +	test_cmp err.expect err.actual &&
>> +	test_must_be_empty out
>> +'
>> +
>> +
>
> hyper-nit: double newline.
>
> The implementation seems simple enough, which I like. I'm a bit

I mentally inserted the missing "skeptical/uncertain" etc. here :)

> your current use of Git config as the back-end, only because it is
> difficult to be future-proof. As the functionality stands today, the
> current config design works just fine. Perhaps we don't need to
> worry about the future, because we can design a new, complementary
> storage for that extra data. It seems worth exploring for a little
> while, though. Perhaps we should take a page out of 'git-remote'
> and how it stores named remotes with sub-items for metadata. The
> names probably don't need to ever be exposed to users, but it could
> be beneficial to anyone implementing this scheme.
>
> [bundle "main"]
> 	uri =3D https://example.com/my-bundle
> 	uri =3D https://redundant-cdn.com/my-bundle
> 	size =3D 120523
> 	sha256 =3D {64hexchars}
>
> [bundle "fork"]
> 	uri =3D https://cdn.org/my-fork
> 	size =3D 334
> 	sha256 =3D {...}
> 	prereq =3D {oid}
>
> This kind of layout has an immediate grouping of data that should
> help any future plan. Notice how I included multiple "uri" lines
> in the "main", which helps with your plan for duplicate URIs.

At first sight I like that config schema much better than my current
one, in particular how it makes the future-proofed "these N urls are one
logical URL" case simpler.

But overall I'm a bit on the fence, and leaning towards keeping what I
have, not out of any lazynes or wanting to just keep what I have mind
you.

But rather that the main benefit of the current one is that it's a 1=3D1
mapping to the line-based protocol, and you can say update your URLs as:

    git config --replace-all uploadpack.bundleUri "$first_url" &&
    git config --add uploadpack.bundleUri "$second_url"

Having usually you'd know the URL you'd like to replace, so you can use
the [value-pattern] of --replace-all, if it's a named section or other
split-out structure that become a two-step lookup.

Also for testing I've got a (trivial) plumbing tool I'll submit called
"git ls-remote-bundle-uri" (could be folded into something else I guess)
to dump the server-side config, it's nice that you can pretty much
directly copy/paste it into config without needing to adjust it.

Having said all that I'm not sure I feel strongly about it either way,
what do you think given the above?

I think most "real" server operators will use this as
GIT_CONFIG_COUNT=3D<n> GIT_CONFIG_{KEY,VALUE}_<1..n>, which can of course
work with any config schema, but if you've got code generating it on the
other side naming the targets is probably a slight hassle / confusing.

There's also the small matter of it being consistent with the
packfile-uri config in its current form, but that shouldn't be a reason
not to come up with something better. If anything any better suggestion
(if we go for that) could be supported by it too...
