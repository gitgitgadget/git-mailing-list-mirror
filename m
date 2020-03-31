Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C160C43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B182080C
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 21:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="jqhPXSjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgCaVq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:46:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCaVq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 17:46:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so1372191pfc.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PUbtHthlQFLGgcgEX07xxrSsnJfOYmIAPAT+XhN0r2k=;
        b=jqhPXSjO5KPyQaM6Hv3lL7I/odu1nDwOSBjYFHyUomeK96OugVan6diaJE6pr6eDR2
         0kTVJ5gsHbNjFi1hIqtwSq+jG9cl6BX8dAdjZxNTL2yp9U8DHTgBF8TPob+HfqoToYus
         i5k8ZhUmti0RwE0ejnH4L1sTCjbMKwX9YLFMkQu0Rsz5EkoOybVQKDag0mdUyEHkZvQL
         tUoZR3eimQnCjDU+2Mlx6myhGEra6fz77NcdYP7IZHZ1Vw2JclE37wbhyt3mAvKpmHbg
         zt4DdMfxx0MpiDbnPeLbwstc6E/TMtdBJl26HhDJiuqVPA1bqBnq6pTvc/Pesg8dkAb9
         6Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUbtHthlQFLGgcgEX07xxrSsnJfOYmIAPAT+XhN0r2k=;
        b=IIfL+ww+EZKXK98h108Yd4V+AjqQn8Ylzm71Q7JsKDENsZ6y1bIaLZGMLx9UrLywW3
         Fdbvw0phGCVsUvfDKtT/+qw7pNpqZUQqDWeUzrAcPeNy1/sf/7sWj4HjsyCrSKzKuNo7
         ZCZ1RLNs75Q2OTtyKwJhdypEU/PWRjQBbSwhHjTZDMs9xdkZfEA3+R+xhtJMM3Y1HZSD
         UukaU97uMkdrqj+nn9YcuCbp3ewkNFAgwnTAzxu26N9U/ohHlNonc9QS/GyXX08ghB5m
         U3KWZTEzpsSuc9JvU0ZJBJZDYy+YDcZqudjH7irR2e3AmqBRerIb8EueSPVC8B3+9VHp
         aneA==
X-Gm-Message-State: AGi0Pubx9ohQmB1hl5SIXMAc6fCTrSUK054PFb7KYhlxlxSKMBMoYEZh
        t0EZujToMWIcxjOm+PJr3KKPb3kPP4U=
X-Google-Smtp-Source: APiQypK/4rnmbU+6kJxNauCIirrzXeqNSq0vvJgNDnpjE0AqsTI/8l33qHTh2DCbtSG7kMp1IacaqQ==
X-Received: by 2002:a63:fe44:: with SMTP id x4mr7263871pgj.95.1585691214975;
        Tue, 31 Mar 2020 14:46:54 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id 8sm90762pfy.130.2020.03.31.14.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:46:54 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:46:53 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>, Konstantin Tokarev <annulen@yandex.ru>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Inefficiency of partial shallow clone vs shallow clone +
 "old-style" sparse checkout
Message-ID: <20200331214653.GA95875@syl.local>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
 <20200328144023.GB1198080@coredump.intra.peff.net>
 <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <decf87bb-dffc-e44e-912e-fe51bc2514c3@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 12:58:41PM -0400, Derrick Stolee wrote:
> On 3/28/2020 10:40 AM, Jeff King wrote:
> > On Sat, Mar 28, 2020 at 12:08:17AM +0300, Konstantin Tokarev wrote:
> >
> >> Is it a known thing that addition of --filter=blob:none to workflow
> >> with shalow clone (e.g. --depth=1) and following sparse checkout may
> >> significantly slow down process and result in much larger .git
> >> repository?
>
> In general, I would recommend not using shallow clones in conjunction
> with partial clone. The blob:none filter will get you what you really
> want from shallow clone without any of the downsides of shallow clone.
>
> You do point out a bug that happens when these features are combined,
> which is helpful. I'm just recommending that you do not combine these
> features as you'll have a better experience (in my opinion).
>
> >> In case anyone is interested, I've posted my measurements at [1].
> >>
> >> I understand this may have something to do with GitHub's server side
> >> implementation, but AFAIK there are some GitHub folks here as well.
> >
> > I think the problem is on the client side. Just with a local git.git
> > clone, try this:
> >
> >   $ git config uploadpack.allowfilter true
> >   $ git clone --no-local --bare --depth=1 --filter=blob:none . both.git
> >   Cloning into bare repository 'both.git'...
> >   remote: Enumerating objects: 197, done.
> >   remote: Counting objects: 100% (197/197), done.
> >   remote: Compressing objects: 100% (153/153), done.
> >   remote: Total 197 (delta 3), reused 171 (delta 3), pack-reused 0
> >   Receiving objects: 100% (197/197), 113.63 KiB | 28.41 MiB/s, done.
> >   Resolving deltas: 100% (3/3), done.
> >   remote: Enumerating objects: 1871, done.
> >   remote: Counting objects: 100% (1871/1871), done.
> >   remote: Compressing objects: 100% (870/870), done.
> >   remote: Total 1871 (delta 1001), reused 1855 (delta 994), pack-reused 0
> >   Receiving objects: 100% (1871/1871), 384.93 KiB | 38.49 MiB/s, done.
> >   Resolving deltas: 100% (1001/1001), done.
> >   remote: Enumerating objects: 1878, done.
> >   remote: Counting objects: 100% (1878/1878), done.
> >   remote: Compressing objects: 100% (872/872), done.
> >   remote: Total 1878 (delta 1004), reused 1864 (delta 999), pack-reused 0
> >   Receiving objects: 100% (1878/1878), 386.41 KiB | 25.76 MiB/s, done.
> >   Resolving deltas: 100% (1004/1004), done.
> >   remote: Enumerating objects: 1903, done.
> >   remote: Counting objects: 100% (1903/1903), done.
> >   remote: Compressing objects: 100% (882/882), done.
> >   remote: Total 1903 (delta 1020), reused 1890 (delta 1014), pack-reused 0
> >   Receiving objects: 100% (1903/1903), 391.05 KiB | 16.29 MiB/s, done.
> >   Resolving deltas: 100% (1020/1020), done.
> >   remote: Enumerating objects: 1975, done.
> >   remote: Counting objects: 100% (1975/1975), done.
> >   remote: Compressing objects: 100% (915/915), done.
> >   remote: Total 1975 (delta 1059), reused 1959 (delta 1052), pack-reused 0
> >   Receiving objects: 100% (1975/1975), 405.58 KiB | 16.90 MiB/s, done.
> >   Resolving deltas: 100% (1059/1059), done.
> >   [...and so on...]
> >
> > Oops. The backtrace for the clone during this process looks like:
> >
> >   [...]
> >   #11 0x000055b980be01dc in fetch_objects (remote_name=0x55b981607620 "origin", oids=0x55b9816217a8, oid_nr=1)
> >       at promisor-remote.c:47
> >   #12 0x000055b980be0812 in promisor_remote_get_direct (repo=0x55b980dcab00 <the_repo>, oids=0x55b9816217a8, oid_nr=1)
> >       at promisor-remote.c:247
> >   #13 0x000055b980c3e475 in do_oid_object_info_extended (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8,
> >       oi=0x55b980dcaec0 <blank_oi>, flags=0) at sha1-file.c:1511
> >   #14 0x000055b980c3e579 in oid_object_info_extended (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8, oi=0x0, flags=0)
> >       at sha1-file.c:1544
> >   #15 0x000055b980c3f7bc in repo_has_object_file_with_flags (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8, flags=0)
> >       at sha1-file.c:1980
> >   #16 0x000055b980c3f7ee in repo_has_object_file (r=0x55b980dcab00 <the_repo>, oid=0x55b9816217a8) at sha1-file.c:1986
> >   #17 0x000055b980a54533 in write_followtags (refs=0x55b981610900,
> >       msg=0x55b981601230 "clone: from /home/peff/compile/git/.") at builtin/clone.c:646
> >   #18 0x000055b980a54723 in update_remote_refs (refs=0x55b981610900, mapped_refs=0x55b98160fe20,
> >       remote_head_points_at=0x0, branch_top=0x55b981601130 "refs/heads/",
> >       msg=0x55b981601230 "clone: from /home/peff/compile/git/.", transport=0x55b98160da90, check_connectivity=1,
> >       check_refs_are_promisor_objects_only=1) at builtin/clone.c:699
> >   #19 0x000055b980a5625b in cmd_clone (argc=2, argv=0x7fff5e0a1e70, prefix=0x0) at builtin/clone.c:1280
> >   [...]
> >
> > So I guess the problem is not with shallow clones specifically, but they
> > lead us to not having fetched the commits pointed to by tags, which
> > leads to us trying to fault in those commits (and their trees) rather
> > than realizing that we weren't meant to have them. And the size of the
> > local repo balloons because you're fetching all those commits one by
> > one, and not getting the benefit of the deltas you would when you do a
> > single --filter=blob:none fetch.
> >
> > I guess we need something like this:
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 488bdb0741..a1879994f5 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -643,7 +643,8 @@ static void write_followtags(const struct ref *refs, const char *msg)
> >  			continue;
> >  		if (ends_with(ref->name, "^{}"))
> >  			continue;
> > -		if (!has_object_file(&ref->old_oid))
> > +		if (!has_object_file_with_flags(&ref->old_oid,
> > +						OBJECT_INFO_SKIP_FETCH_OBJECT))
> >  			continue;
> >  		update_ref(msg, ref->name, &ref->old_oid, NULL, 0,
> >  			   UPDATE_REFS_DIE_ON_ERR);
> >
> > which seems to produce the desired result.
>
> This is a good find, and I expect we will find more "opportunities"
> to insert OBJECT_INFO_SKIP_FETCH_OBJECT like this.

Should we turn this into a proper patch and have it reviewed? It seems
to be helping the situation, and after thinking about it (only briefly,
but more than not ;-)), this seems like the right direction.

There's an argument to be had about bundling a number of these up
instead of having a slow drip of patches that sprinkle
'SKIP_FETCH_OBJECT' everywhere, but I don't think that we want perfect
to be the enemy of good here.

Peff, if you don't feel like doing this, or have a backlog that is too
long, I'd be happy to polish this for you.

> -Stolee

Thanks,
Taylor
