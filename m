Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7F781F4B6
	for <e@80x24.org>; Sun, 12 May 2019 07:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfELHQg (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 May 2019 03:16:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44508 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfELHQg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 May 2019 03:16:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so12144579edm.11
        for <git@vger.kernel.org>; Sun, 12 May 2019 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=8vgikPXxEomIQq8C3ymFK/IWfoC0A9k9xziuI6ia72Y=;
        b=HapTt77AWZbDWn1u9GeRpZaSuXF1WSA0nRJyyUztowImv1tvsTwl0+kQG06tUAjo4q
         iu5xiRzFMIfVJXSub+eMRgZ2z/+RGIw2sV9UONobVTh/JapSSXhAW91Mz/xoMI9ntV0y
         UAzqZdysEh2ZzRM5JR8q9kFhe515UsCDlzPuNvRvgSaWKZuu0A0WBZW7C7qqOdAbcKbu
         cVPFAC0Rp+VnZJ0iuDWfV2J30XsV1k+lHnPlJXm6+LEzVXt1kvr/k2pVX7aC1vMUCXnl
         bU6M+DjAB7S8ApuE2BjK0BYFy29u7FbQMa5gxSSeL5blXDl/EZexdgMoQ1btLADwK/ec
         HohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=8vgikPXxEomIQq8C3ymFK/IWfoC0A9k9xziuI6ia72Y=;
        b=udm1HU6PEWcO6nTDwYZB8uRpdRm3avEw8iOxYVpvCeZpqQOVNiG3Ta+4AbHug8G5PB
         VV806ER8HHEU0ckaMci1fiG0TzwOoyzOEpCIxxSFGjGTLYjElizk9pK0mwcNcLxIpJhL
         UgSbU1LOUMw5cspckuIdL+bxUpSuTJIANinkHXan6JcIOoMxTZz1qDOUC/3oEbMYkFtk
         yCk6ZnxxuSerBoXQd7M1aBjaLJPH3ICpyPTeYDDd3hbDgpjD4w1MAnBfVLbOu2BVcj7b
         g4Dr3gCIZdCAfsgJrQ49yG40NZU2+5B4PW/5cAHutQnbmnEQGOf9vH9G8IpWpO12OgVg
         EcMQ==
X-Gm-Message-State: APjAAAW4mZp1p9DAStmzp3mnoh/o5b6XCVTuzUMfzHgc+sTxaJzg09bq
        pdxV5Bqc6JKejKM/6X3as4c+kle5
X-Google-Smtp-Source: APXvYqwGzOgsKJbC4DqNyu7leio+yUh8AbU1UPsOSbbgOY/ZI38jSWBhSgl11PVScXsC0D5hehHOGQ==
X-Received: by 2002:a17:906:6b01:: with SMTP id q1mr16571581ejr.34.1557645394108;
        Sun, 12 May 2019 00:16:34 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id b25sm2884419ede.34.2019.05.12.00.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 00:16:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
References: <20190511013455.5886-1-e@80x24.org> <87v9ygwoj0.fsf@evledraar.gmail.com> <20190512040825.GA25370@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190512040825.GA25370@sigill.intra.peff.net>
Date:   Sun, 12 May 2019 09:16:31 +0200
Message-ID: <87tve0w3ao.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, May 12 2019, Jeff King wrote:

> On Sun, May 12, 2019 at 01:37:55AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> This way of doing it just seems so weirdly convoluted. Read them one at
>> a time, compute the SHA-1, just to see if they're different. Why not
>> something closer to a plain memcmp():
>
> FWIW, I had the exact same thought on reading the patch. Checking sizes
> seems like an easy optimization and I don't mind it, but computing
> hashes when we could just compare the bytes seems pointless. I'd have
> expected to stream 4k blocks as we go.
>
>> I.e. optimze for code simplicity with something close to a dumb "cmp
>> --silent". I'm going to make the bold claim that nobody using "dumb
>> http" is going to be impacted by the performance of reading their
>> for-each-ref or for-each-pack dump, hence opting for not even bothing to
>> stat() to get the size before reading.
>
> You're probably right (especially because we'd just spent O(n) work
> generating the candidate file). But note that I have seen pathological
> cases where info/refs was gigabytes.

Wouldn't those users be calling update-server-info from something like a
post-receive hook where they *know* the refs/packs just got updated?

Well, there is "transfer.unpackLimit" to contend with, but that's just
for "packs are same", not "refs are same", and that file's presumably
much smaller.

So I'd think that *if* this is a case where there's even a question of
the performance mattering here, and I'd assume "refs changed but size is
the same" is a common case (e.g. craploads or tags, but just "master"
pushed-to) we could make this an opt-in "--update-if-changed", because
the "if changed" is extra work, and we're already documenting that you
should be calling this on the "I know it changed" hook path.

I don't care even if we use the initial SHA-1 method. It just struck me
as odd to conflate the reasonable "don't update mtime for optimizing
dumb over-the-wire client" with "optimize resource use when updating".

>> >  /*
>> >   * Create the file "path" by writing to a temporary file and renaming
>> >   * it into place. The contents of the file come from "generate", which
>> >   * should return non-zero if it encounters an error.
>> >   */
>> > -static int update_info_file(char *path, int (*generate)(FILE *))
>> > +static int update_info_file(char *path, int (*generate)(FILE *), int =
force)
>> >  {
>> >  	char *tmp =3D mkpathdup("%s_XXXXXX", path);
>>
>> Unrelated to this, patch, but I hadn't thought about this nasty race
>> condition. We recommend users run this from the "post-update" (or
>> "post-receive") hook, and don't juggle the lock along with the ref
>> update, thus due to the vagaries of scheduling you can end up with two
>> concurrent ref updates where the "old" one wins.
>>
>> But I guess that brings me back to something close to "nobody with that
>> sort of update rate is using 'dumb http'" :)
>>
>> For this to work properly we'd need to take some sort of global "ref
>> update/pack update" lock, and I guess at that point this "cmp" case
>> would be a helper similar to commit_lock_file_to(),
>> i.e. a commit_lock_file_to_if_different().
>
> I don't think our usual dot-locking is great here. What does the
> race-loser do when it can't take the lock? It can't just skip its
> update, since it needs to make sure that its new pack is mentioned.

Right, I mean a *global* .git/I_AM_DOING_WRITES.lock, because there's no
way to square the ref backend's notion of per-ref ref lock enabling
concurrent pushes with update-server-info's desire to generate metadata
showing *all* the refs.

> So it has to wait and poll until the other process finishes. I guess
> maybe that isn't the end of the world.

If "its" is update-server-info this won't work. It's possible for two
update-server-info processes to be racing in such a way that their
for_each_ref() reads a ref at a given value that'll be updated 1
millisecond later, but to then have that update's update-server-info
"win" the race to update the info files (hypothetical locks on those
info files and all).

Thus the "info" files will be updated to old values, since we'll see we
need changes, but change things to the old values.

All things that *can* be dealt with in some clever ways, but I think
just further proof nobody's using this for anything serious :)

I.e. the "commit A happened before B" but also "commit B's post-* hooks
finished after A" is a thing that happens quite frequently (per my
logs).

>> Then in b3223761c8 ("update_info_refs(): drop unused force parameter",
>> 2019-04-05) Jeff removed the unused-for-a-decade "force" param.
>>
>> So having gone through the history I think we're better off just
>> dropping the --force argument entirely, or at least changing the
>> docs.
>>
>> Before this change the only thing it was doing was pruning stuff we
>> haven't written since 2005-ish (see 3e15c67c90 ("server-info: throw away
>> T computation as well.", 2005-12-04)), rather than "detect if useless"
>> we should just write out the file again, and then skip if changed
>> (i.e. this logic).
>
> Yeah, my commit only ripped out the useless force parameter for
> info/refs. For info/packs, there's still that weird "is is stale"
> computation (which I fixed several bugs in). It's not entirely clear to
> me if that can just go away, but I agree that if we can it's simpler and
> more desirable to just generate the candidate result and see if it's
> bit-for-bit identical or not.
>
> I'm not entirely sure of all of the magic that "stale" check is trying
> to accomplish. I think there's some bits in there that try to preserve
> the existing ordering, but I don't know why anyone would care (and there
> are so many cases where the ordering gets thrown out that I think
> anybody who does care is likely to get disappointed).

My reading of it is that it's premature optimization that can go away
(and most of it has already), for "it's cheap" and "if not it's called
from the 'I know I had an update'" hook case, as noted above.<
