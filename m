Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEC3C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFCC61215
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234073AbhJEMbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 08:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbhJEMbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 08:31:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F8FC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 05:29:20 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g8so78067808edt.7
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 05:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OsqwvdMNw59NroadHVSPa/+w+L1SY3snyiCYq67Dip0=;
        b=D+MWhu7lWNSyCho24z1r/SrPaglhetYyQfHU5IjnyErKz3kEoYYLupleQZ9Y8/J2hv
         90C0ybDBtgbgYkXhldW0BG8050Fr5HpuTh7ZYSASiM+Bg+szxSUGAFteiQ4a6GtWsm2p
         r+8KvJv1WQ16++BKwdn0fS+gmh9YPlDUMvnGAE0rlwOGnHO9zEXpRgfgrucGbxiwlpD6
         oNf59lLG9/iXdLzM97jh46vPJpadC4kWgtlNS+pu8PzLTIlOCYze5FjfYySMyjEazwjI
         wSK0oUn8bkcJpSXTwtLKh+toedZEuljCfAPCTUeqPEUln8R5UScG2Q1oVv2asnqyT11c
         HjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OsqwvdMNw59NroadHVSPa/+w+L1SY3snyiCYq67Dip0=;
        b=rjSzzAcpxb//e1NBuBOHRPTBP48Yl/+jlnbaQLvCTcLjh3lCCcghfacXhMwq4WCkZZ
         3fshZLsQqDW/ouuj8q1jLq7pby/teMfw6P9/YRo2mZQmccIjjU9f4rv5Ds3bZ8T9riVz
         QTCxHyAg4nGbLilpk1JP4+QrpUIQi0py2d+hbpUOb9RJAgRCc+OrAsi3LBCFZIJw+Tbh
         YDqnmohH+3qx6D2wXB8AwVg0oa1+cuTKsRDKQGGyRAhDVoh4E2hrdd5+91uwBHy8bzOY
         RyaXU2v5JiahveIqX2sabCrFbLX+jU/jUfB3n7fGHL9a/7TwpcDrbVv5hB//uXNvwVqi
         p0WA==
X-Gm-Message-State: AOAM533WtR6FqLZktxwOQ46Rt06hoVLV8G5K/rL90wiOax4SmXzrwA+V
        3Ppe4R6u+I6o8z0EAaKzo7k=
X-Google-Smtp-Source: ABdhPJwHT9zo373XHYlmf3LYQbmmn51Q5prn7P0seIzgKbxIUkJfD6lsDhqadqyjwBCZQQA/pCAiWw==
X-Received: by 2002:a05:6402:1d2b:: with SMTP id dh11mr25719074edb.276.1633436958906;
        Tue, 05 Oct 2021 05:29:18 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t20sm7672913ejc.105.2021.10.05.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 05:29:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Don't ignore transport_disconnect error codes in fetch
 and clone
Date:   Tue, 05 Oct 2021 14:21:49 +0200
References: <20210928001726.2592734-1-mh@glandium.org>
 <874ka5z9pz.fsf@evledraar.gmail.com>
 <20211005045412.pqwsid6gpprxajbw@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211005045412.pqwsid6gpprxajbw@glandium.org>
Message-ID: <87h7dvlko2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Mike Hommey wrote:

> Hi,
>
> Sorry for the delay, I managed to miss this reply.
>
> On Tue, Sep 28, 2021 at 04:56:37AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Tue, Sep 28 2021, Mike Hommey wrote:
>>=20
>> > When a remote-helper fails in a way that is not directly visible in the
>> > remote-helper protocol, the helper failure is ignored by git during
>> > fetch or clone.
>> >
>> > For example, a helper cannot directly report an error during an `impor=
t`
>> > command (short of sending `feature done` to the fast-import file
>> > descriptor and not sending a `done` later on).
>> >
>> > Or if the helper crashes at the wrong moment, git doesn't notice and
>> > thinks everything went well.
>> >
>> > Signed-off-by: Mike Hommey <mh@glandium.org>
>> > ---
>> >  builtin/clone.c | 5 +++--
>> >  builtin/fetch.c | 6 +++---
>> >  2 files changed, 6 insertions(+), 5 deletions(-)
>> >
>> > What I'm not sure about is whether a message should be explicitly
>> > printed by git itself in those cases.
>> >
>> > diff --git a/builtin/clone.c b/builtin/clone.c
>> > index 66fe66679c..f26fa027c5 100644
>> > --- a/builtin/clone.c
>> > +++ b/builtin/clone.c
>> > @@ -1398,7 +1398,7 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>> >  	submodule_progress =3D transport->progress;
>> >=20=20
>> >  	transport_unlock_pack(transport);
>> > -	transport_disconnect(transport);
>> > +	err =3D transport_disconnect(transport);
>> >=20=20
>> >  	if (option_dissociate) {
>> >  		close_object_store(the_repository->objects);
>> > @@ -1406,7 +1406,8 @@ int cmd_clone(int argc, const char **argv, const=
 char *prefix)
>> >  	}
>> >=20=20
>> >  	junk_mode =3D JUNK_LEAVE_REPO;
>> > -	err =3D checkout(submodule_progress);
>> > +	if (!err)
>> > +		err =3D checkout(submodule_progress);
>> >=20=20
>> >  	free(remote_name);
>> >  	strbuf_release(&reflog_msg);
>>=20
>> This seems buggy in some cases, e.g. just because we couldn't close()
>> some final socket we should just not run the checkout at all? Shouldn't
>> we note the disconnect status, but still see if we can do the checkout
>> etc?
>
> I guess it could be seen both ways. In my particular use case, I do want
> automated testing to be able to catch Leak Sanitizer failures from a
> remote-helper.

I'd like that too, but I'm pointing out something unrelated (or at least
I think I am), which is that this is changing the equivalent of this code:

    int fd =3D open(...);
    close(fd);
    do_stuff();

To be:

    int err;
    int fd =3D open(...); /* check err here too, but whatever, pseuodocode(=
) */
    if (!close(fd))
        do_stuff();

But just with sockets, i.e. just because transport_disconnect() had
*some* error are we really confident that checkout() should not be run?

*Maybe*, but at the very least shouldn't we distinguish some of those
error states? Isn't any serious protocol error going to be caught
earlier transport_disconnect() is just going to give us the equivalent
of not being able to cleanly close the socket?

Except as noted in my second comment it doesn't, since we ignore
disconnect_git(). At this point I can't recall what we do check, and I
intentionally haven't re-looked, but that's also a suggestion for your
commit message :) I.e. what error states are going to be different now,
when don't we proceed because of a disconnect_git() failure?

>> > diff --git a/builtin/fetch.c b/builtin/fetch.c
>> > index 25740c13df..66bccf6f50 100644
>> > --- a/builtin/fetch.c
>> > +++ b/builtin/fetch.c
>> > @@ -1886,7 +1886,7 @@ static int fetch_one(struct remote *remote, int =
argc, const char **argv,
>> >  {
>> >  	struct refspec rs =3D REFSPEC_INIT_FETCH;
>> >  	int i;
>> > -	int exit_code;
>> > +	int exit_code, disconnect_code;
>> >  	int maybe_prune_tags;
>> >  	int remote_via_config =3D remote_is_configured(remote, 0);
>> >=20=20
>>=20
>>=20
>> > @@ -1952,9 +1952,9 @@ static int fetch_one(struct remote *remote, int =
argc, const char **argv,
>> >  	exit_code =3D do_fetch(gtransport, &rs);
>> >  	sigchain_pop(SIGPIPE);
>> >  	refspec_clear(&rs);
>> > -	transport_disconnect(gtransport);
>> > +	disconnect_code =3D transport_disconnect(gtransport);
>> >  	gtransport =3D NULL;
>> > -	return exit_code;
>> > +	return exit_code || disconnect_code;
>> >  }
>> >=20=20
>> >  int cmd_fetch(int argc, const char **argv, const char *prefix)
>>=20
>> This seems like it really needs fixes in other areas,
>> i.e. disconnect_git() returns 0 unconditionally, but should check at
>> least finish_connect(), no?
>>=20
>> Also once that's done you'll have a logic error here where you're
>> conflating exit and error codes, we should not return -1 from main() (we
>> do in a few cases, but it's nasty)>
>
> transport_disconnect returns the remote-helper exit code for external
> helpers, though, but I guess we don't necessarily need to return that
> particular exit code.

Right, some of these functions are quite naughty about that, and as
noted we get it wrong in a lot of existing cases.

But it is unportable (non-standard C, but POSIX plasters over it),
i.e. a return of -1 from main() is interpreted as a wait() status in
POSIX, and results in a return of -1 & 0xff =3D=3D 255.

But for new code let's try to get it right, which in this case is going
to be transport_disconnect() being being a syscall error code, and the
"exit code" being a return code, which should not be mixed, no?
