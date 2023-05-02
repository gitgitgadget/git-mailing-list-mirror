Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7F3C77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjEBXqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 19:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEBXqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 19:46:06 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797E3E6
        for <git@vger.kernel.org>; Tue,  2 May 2023 16:46:05 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6a5f03551fdso3170730a34.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683071164; x=1685663164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lF7RawtYpN+KsNGdbE1QtO8ePx5BiIiO1LdWBFdCIHM=;
        b=S0RIeQwdzwXkjxNlJmBvVrt8uTo2/ZZGG2DCUFufUJZq/oNNZgO6xy/T2QI6bxyVJD
         vAHa27nsdB48otzlyYqRAc+IpfNZ/zXV2Jqujqy2XpX3TsF8HS/uAANI8sAFjf6Tax2I
         MRoCkXSOP+2HzGcPx4PAalO+m4+EBJfF2QsYd+BbepUFvSbpajDp8yXcdAp9En5d+U+n
         831PqDYozF4b86R//lbpVFz1hGEsRH3ISghjIN63jaQfjkIFatLKW2ToSQ374bGDYFdZ
         Y07UKrknpK27SVlf6WCqSdKaQ211QPwBpyb+VGPgi3AENaCA4iRRnjwJTddrTGO6B8qv
         3yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683071164; x=1685663164;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lF7RawtYpN+KsNGdbE1QtO8ePx5BiIiO1LdWBFdCIHM=;
        b=eijVDhd3SKiC8pTeoqQSvL0ZpZlrMON37xl+o05vQIG2H5HJLza7M35z6gJrfhZlX5
         jDwRdxhRMcjypag2hlXY0NikLrNEZkhhUEfqP/WoAwpYFAWJIsbadxpEytkTH8dFzsCy
         hG7Z+1oEMcofsF7nU5Yrak/zSpHo52Wt9blDzj4nkbBmjdYwqoDIHgKzqz3VTLh3Xkwj
         RqOlpsDjH87GUnqFLgCiXFVUb4llfTQP45liIEfzHIr65ApRzccnLqt0BhYaS3wcpUii
         ZxC/fnebKU3m0oZ8TrPDuBPJKHfGHcoBj3U+8tBLJA4RJawzL8tbmcE+Za6iBjZqsmM6
         j+rw==
X-Gm-Message-State: AC+VfDyQLn7V/Rzfttv0WPEhS7KCnMAU0R7Axxh957yDwBeyAwmcEZm2
        F1rdP1WdFFyX4oNMBNWcaLG9xsh7Zb0=
X-Google-Smtp-Source: ACHHUZ5+loP1JTYlWutJMA24laaUoQ/vrVWPogPh8tlAMMByWj/OOU6oTo/xlx/wkRL4aBSXSuydcw==
X-Received: by 2002:a05:6830:1e33:b0:6a7:c10b:45b1 with SMTP id t19-20020a0568301e3300b006a7c10b45b1mr9244456otr.7.1683071164541;
        Tue, 02 May 2023 16:46:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d6544000000b006a205a8d5bdsm50461otl.45.2023.05.02.16.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 16:46:03 -0700 (PDT)
Date:   Tue, 02 May 2023 17:46:02 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Adam Majer <adamm@zombino.com>
Message-ID: <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
In-Reply-To: <20230427054343.GE982277@coredump.intra.peff.net>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
Subject: Is GIT_DEFAULT_HASH flawed?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Changing the subject as this message seems like a different topic.

Jeff King wrote:
> On Wed, Apr 26, 2023 at 02:33:30PM -0700, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > 
> > >  `GIT_DEFAULT_HASH`::
> > >  	If this variable is set, the default hash algorithm for new
> > >  	repositories will be set to this value. This value is currently
> > > +	ignored when cloning if the remote value can be definitively
> > > +	determined; the setting of the remote repository is used
> > > +	instead. The value is honored if the remote repository's
> > > +	algorithm cannot be determined, such as some cases when
> > > +	the remote repository is empty. The default is "sha1".
> > > +	THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
> > > +	in linkgit:git-init[1].
> > 
> > We'd need to evantually cover all the transports (and non-transport
> > like the "--local" optimization) so that the object-format and other
> > choices are communicated from the origin to a new clone anyway, so
> > this extra complexity "until X is fixed, it behaves this way, but
> > otherwise the variable is read in the meantime" may be a disservice
> > to the end users, even though it may make it easier in the shorter
> > term for maintainers of programs that rely on the buggy "git clone"
> > that partially honored this environment variable.
> > 
> > In short, I am still not convinced that the above is a good design
> > choice in the longer term.
> 
> I also think it is working against the backwards-compatible design of
> the hash function transition.

To be honest this whole approach seems to be completely flawed to me and
against the whole design of git in the first place.

In a recent email Linus Torvalds explained why object ids were
calculated based {type, size, data} [1], and he explained very clearly
that two objects with exactly the same data are not supposed to have the
same id if the type is different.

If even the tiniest change such as adding a period to a commit messange
changes the object id (and thus semantically makes it a different
object), then it makes sense that changing the type of an object also
changes the object id (and thus it's also a different object).

And because the id of the parent is included in the content of every
commit, the top-level id ensures the integrity of the whole graph.

But then comes this notion that the hash algorithm is a property of the
repository, and not part of the object storage, which means changing the
whole hash algorithm of a repository is considered less of a change than
adding a period to the commit message, worse: not a change at all.

I am reminded of the warning Sam Smith gave to the Git project [2] which
seemed to be unheard, but the notion of cryptographic algorithm agility
makes complete sense to me.

In my view one repository should be able to have part SHA-1 history,
part SHA3-256 history, and part BLAKE2b history.

Changing the hash algorithm of one commit should change the object id of
that commit, and thus make it semantically a different commit.

In other words: an object of type "blob" should never be confused with
an object of type "blob:sha-256", even if the content is exactly the
same.

The fact that apparently it's so easy to clone a repository with
the wrong hash algorithm should give developers pause, as it means the
whole point of using cryptographic hash algorithms to ensure the
integrity of the commit history is completely gone.

I have not been following the SHA-1 -> OID discussions, but I
distinctively recall Linus Torvalds mentioning that the choice of using
SHA-1 wasn't even for security purposes, it was to ensure integrity.
When I do a `git fetch` as long as the new commits have the same SHA-1
as parent as the SHA-1s I have in my repository I can be relatively
certain the repository has not been tampered with. Which means that if I
do a `git fetch` that suddenly brings SHA-256 commits, some of them must
have SHA-1 parents that match the ones I currently have. Otherwise how
do I know it's the same history?

Maybe that's one of the reasons people don't seem particularly eager to
move away from SHA-1:

Better the SHA-1 you know, than the SHA-256 you don't.

Cheers.

[1] https://lore.kernel.org/git/CAHk-=wjr-CMLX2Jo2++rwcv0VNr+HmZqXEVXNsJGiPRUwNxzBQ@mail.gmail.com/
[2] https://lore.kernel.org/git/D433038A-2643-4F63-8677-CA8AB6904AE1@samuelsmith.org/

-- 
Felipe Contreras
