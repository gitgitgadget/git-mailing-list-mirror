Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91EFC433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 08:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351472AbiELIaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351324AbiELIaO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 04:30:14 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D4C21937F
        for <git@vger.kernel.org>; Thu, 12 May 2022 01:30:12 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so7170362pjb.3
        for <git@vger.kernel.org>; Thu, 12 May 2022 01:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPNTz8mZKECgGUkg94G5fPudm1GocJsNiqfe8zlWEg8=;
        b=OTsUGFcnqfBUh0UaQdH50cOhaf/1nRx4ZvJNfIRjYXKMYbzhajkLvUVOHfII3MKvdT
         C3awiQ7L40UGAMS6gFPXt+FVwECclhK5c9iiZLraEz9IRslcUATXzwhSTTWPOl7ynMbE
         VO6zsQhUmZVi5NbuX045dJWaRIhptiwEBdpqhXGyY9FL4NNm/dAkOfBATF+aLPr9dL7U
         nslXIQA0c7nuFLlJI6dZtQDJYurpJ2tG1liF15jSYT7PiVwJcQGp+AU1XleRi81qv2bs
         T6ObThtljh7SCaF2uMy6pG9wtEp4QG23f01NwMPudc2snDiwl3iCe6BKWByNwCjMZUbs
         8VNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPNTz8mZKECgGUkg94G5fPudm1GocJsNiqfe8zlWEg8=;
        b=a9V4Y8VM2uwbcp5ITmS4KXhjkC1pON2IR9BApSzAOMauOiMa6sNSoHALJyHFJLk76w
         Iw8s4c08PrDu03keMbZMTZh/a/KAHOMycOpDphl5ufK8FzGSTm8hhJoSj5qiP5qZhNGN
         hMX/TPs/afJhz6oPMpgdUNIYXcUxYxt0Umx3p5DNesnqHPB/DS1kNa/4qMBslRuaqGxv
         tmossWCx0PXZwqeTD/Zkj99fDsSi+JjyklOIOwk8LIfxZVtsB+6Gi38yvjlIHyCuo04J
         +D1SnuP+9Ne5VvdB+reCsHnvHKC4tNEl/7KwO94KiQPDOXxt5XaSkWstXIGHWuiGRqtk
         KcUw==
X-Gm-Message-State: AOAM5305V7yHpx2YTqZ88tacEoBh+iXGy3Zw4q4Sl2YkDijTdgLwTPLN
        DxJruhfZxlSx/Ue+gRYAFJ1hOMcRYcbyWQ74pqY=
X-Google-Smtp-Source: ABdhPJx7Yjr0vEknlqgm7F6chUVVUDQ+vwk91WuBL+Z9OTn5Z3Q1W/cmbPJsNMjYNOr7ea2MwC9Tt3BRtyJBIts4UPg=
X-Received: by 2002:a17:902:ce8b:b0:15e:c249:1bf0 with SMTP id
 f11-20020a170902ce8b00b0015ec2491bf0mr28912352plg.125.1652344211433; Thu, 12
 May 2022 01:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220504104601.136403-1-chriscool@tuxfamily.org>
 <20220509153834.485871-1-chriscool@tuxfamily.org> <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
In-Reply-To: <CAPUEsphA=q10wCsrf3AxR9fXz9HQHt374tDFoWBu++EPNDA-LA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 12 May 2022 10:29:59 +0200
Message-ID: <CAP8UFD2F=5RsB_WVOHKmzJsD9UJgZ2YM_yreTur2_huAAJ=+Vw@mail.gmail.com>
Subject: Re: [PATCH v3] http: add custom hostname to IP address resolutions
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 10, 2022 at 8:20 PM Carlo Arenas <carenas@gmail.com> wrote:
>
> On Mon, May 9, 2022 at 8:38 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index f92c79c132..4a8dbb7eee 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -567,4 +567,11 @@ test_expect_success 'client falls back from v2 to v0 to match server' '
> >         grep symref=HEAD:refs/heads/ trace
> >  '
> >
> > +test_expect_success 'passing hostname resolution information works' '
> > +       BOGUS_HOST=gitbogusexamplehost.com &&
> > +       BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
> > +       test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
> > +       git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> > +'
>
> Is setting it up as a command line config option the way you expect to
> use this, and if so why not make it a full blown command line option
> with the previous caveats that were discussed before?

Yeah, it's how GitLab will likely use this, but this is the same for
most (if not all) config options these days in GitLab. So I don't
think it's a good criteria.

I already talked about it, but one of the issues with a command line
option is that such an option might not be worth implementing for SSH
(which might not need it) or other protocols for different reasons. So
we would have a CLI option with probably a generic name that would
actually work only with one (or a few) protocols, and we would need to
decide what to do in case this option is used along with a protocol
that it doesn't support.

> I also think it might be a little confusing (and probably warranted of
> an advice message) if git will decide based on a configuration
> somewhere in its resolution tree that the IP I am connecting is
> different than the one I expect it to use through the system
> configured resolution mechanism for such a thing.

I would be Ok to add an advice message or another kind of message
telling users that the IP used is based on the config variable. It
could break scripts parsing Git's output though (even if it's bad
practice to do so). So we would need to decide the kind of message and
its content. Suggestions welcome.

> I assume that if you want to use this frequently, having that advice
> disabled in your global config wouldn't be a hassle, but it might be
> useful to know that I am interacting with a potentially different IP
> when referring to some host by name in my local repo, maybe because I
> forgot to change that setting after some debugging.

Yeah, maybe. On the other hand GIT_CURL_VERBOSE might already be the
canonical way to debug this and might already tell about this.

Yeah, it does:

<= Recv header:
== Info: Connection #0 to host gitbogusexamplehost.com left intact
== Info: RESOLVE gitbogusexamplehost.com:5551 is - old addresses discarded!
== Info: Added gitbogusexamplehost.com:5551:127.0.0.1 to DNS cache
== Info: Couldn't find host gitbogusexamplehost.com in the .netrc
file; using defaults
== Info: Found bundle for host gitbogusexamplehost.com: 0x5556d2bd1340
[serially]
== Info: Can not multiplex, even if we wanted to!
== Info: Re-using existing connection! (#0) with host gitbogusexamplehost.com
== Info: Connected to gitbogusexamplehost.com (127.0.0.1) port 5551 (#0)

I agree it might not be very clear that it's because
"http.curloptResolve" is used though. But maybe we could output a more
explicit warning message only if GIT_CURL_VERBOSE is set.

> I am sure all those folks that forget to edit their /etc/hosts after
> they are done with their local site versions might instead use this
> and then be happy to be warned about it later.

Do you mean that those folks might like a config option ;-)
