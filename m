Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E8EC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B87207B1
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 13:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhADNyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADNyx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 08:54:53 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839DC061574
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 05:54:13 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z9so18446730qtn.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=5A/N97ovv2q/DkgZzTTVW2q4oE6xJdeo0pBkVOyhsRQ=;
        b=aokqnuVLeBf8bqKaUr6bATxCoh1uXTYVSu4x3jcYMlRRIAZhSHcn5uUipJEkTOckmj
         xBYrOn11LnBT/EvESUsad8SgPYNZJ1NE9Jy6uCPFuxPlws4/UPwunHHU4qath73V4Mjm
         g/EzTKAoUx0e4ungyVHufNgNOziJKp+jc2M2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=5A/N97ovv2q/DkgZzTTVW2q4oE6xJdeo0pBkVOyhsRQ=;
        b=HaE12qu7tnTYcFvhsXiNU3Qfvwhar8nW/mvYw1DgLs8QBjk3Mu/3ZrzVDV4mkzceXL
         8dWvigRfApb1IRYtYrhRWCdBDuMwsucurnJOtwBwAl8EGBO395kSScDjRnfBDjdSSWde
         npVWl5b7YySw/qyRx17dj8I2SNkZl5P6n/Pp5g56CgNnAoJEE71qUtH85t0uL+HWwYpu
         Bk4M5N6qOk3yUhR1KQOXCXSGniU9rO1cS9rBZ9wXFhnklNAK8M74wv2hf3c2ODIeB2C1
         gee54mycfH4+SSvsryfsirWatsNdVeqKBTB+Vhq64LDW0GzEimrWfBRywDHus2nOkwv5
         2hcg==
X-Gm-Message-State: AOAM533iNhbg6N5NxhWuqgyyZDWna5f76x6hloL5xwj6MOT94Vu6n5yI
        L3h7ZgDe5Tpq9lK7wfps7edGWntmLY1U4rfg
X-Google-Smtp-Source: ABdhPJw+rB7Ozmw0cjI72UG6UfiY3NL7KvE54dz6xLTLm8pxZgKbvM7/72pFHbs12I4dYquf/WjOTw==
X-Received: by 2002:ac8:7b33:: with SMTP id l19mr72911677qtu.251.1609768452354;
        Mon, 04 Jan 2021 05:54:12 -0800 (PST)
Received: from chatter.i7.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id f134sm36755778qke.23.2021.01.04.05.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 05:54:11 -0800 (PST)
Date:   Mon, 4 Jan 2021 08:54:10 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Destructive access to an "objects/info/alternates"
 repository
Message-ID: <20210104135410.myjaygaulqnxcnsc@chatter.i7.local>
Mail-Followup-To: Stefan Monnier <monnier@iro.umontreal.ca>,
        git@vger.kernel.org
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
 <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
 <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <20201229154403.xutnk2aoawdrjfwx@chatter.i7.local>
 <jwv1rf26k9n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jwv1rf26k9n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 03, 2021 at 11:50:35AM -0500, Stefan Monnier wrote:
> >> FWIW, I just tried it with
> >> 
> >>     git clone --shared ~otheruser/nongnu
> >> 
> >> and got the same result.
> >> I also tried with another repository, still with the same result (tho
> >> different pack.idx names, of course).
> >
> > I've tried several times to reproduce this, but I am unable to do so. You may
> > need to provide the tarball with ~otheruser/nongnu contents for someone to be
> > able to properly debug this.
> 
> OK, you can try with the following tarball:
> 
>     https://www.iro.umontreal.ca/~monnier/nongnu.tar.gz

Great, thank you for providing that. At this point, I can verify the behaviour
you are seeing:

$ cat .git/objects/info/alternates
/tmp/test/nongnu/.git/objects
$ git gc
Enumerating objects: 119, done.
Nothing new to pack.
warning: unable to unlink '/tmp/test/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx': Permission denied
warning: unable to unlink '/tmp/test/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx': Permission denied

Notably, if I run repack/prune by themselves, this does not happen:

$ git repack -Adln
Enumerating objects: 119, done.
Nothing new to pack.
$ git prune --expire=now
$

I would guess that this is happening in builtin/gc.c#686 [1], where it calls
clean_pack_garbage(). Running "git count-objects -v" shows:

$ git count-objects -v
warning: no corresponding .pack: /tmp/test/nongnu/.git/objects/pack/pack-0d85e74ac2f7e51ce26f281e64eb738e8182fa95.idx
warning: no corresponding .pack: /tmp/test/nongnu/.git/objects/pack/pack-5fe14feff49ccdee5469af9dc94f6784e8464a6b.idx
count: 0
size: 0
in-pack: 0
packs: 0
size-pack: 0
prune-packable: 0
garbage: 2
size-garbage: 6573
alternate: /tmp/test/nongnu/.git/objects

I agree with Stefan that this is undesired behaviour, even when it only
happens when attempting to clean up garbage -- git-gc (and git-count-objects)
should distinguish between garbage in the parent repository and its own
repository and not attempt any modification of the parent repository during
gc or any other operation.

[1] https://git.kernel.org/pub/scm/git/git.git/tree/builtin/gc.c#n686

-K
