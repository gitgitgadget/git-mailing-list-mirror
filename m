Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB55C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D943611C7
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 00:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhJUAnd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 20:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUAnc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 20:43:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60737C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 17:41:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i20so731755edj.10
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qB+RDfbLD2i1dhHAEVLytP1u2jSESAEMjQ1eXlkh9rc=;
        b=dvXlYENzZFHs2PfojzKndf+h8mZ+CcKBfRpqgGWgqz0uNe/8SkrX4mdUizuxLvuzzi
         9d6I9vkajuYXPyAaTl522NvTgDwvhDz+wUEkvqAiDn+ma+0LJvDOBK6yZ7Zvtyp+CGjU
         5RZd2DBgCN/w6Uc3KS/uQJEIgzOum51nEhJqth4PKtbuXbCOTOZzVLJOwLIgstGj6f3r
         DataeL20C1ZJ1o4q7yKyFUATMOvWcOSan0l4qz835tplsEv8/ELvr5G/6WOGvioLmzoA
         NPloES/rhckiqNKhStuLOlc+kYtpq1bLHhGcXfo73wVbSbF7Cuwdow4GGubHRNFpNhFW
         JFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qB+RDfbLD2i1dhHAEVLytP1u2jSESAEMjQ1eXlkh9rc=;
        b=YXf92EstOvoo5XBhYiDbvQCtPgLGuYvP5TVIVOU2nPDKjOfFszdIE979GGjh5ZQCjM
         edJm3xTT1mOXV5sC39GL9gJBKR43pOSCoELd0I+trlKiOQ6TuDI8PKppCUkNqH0C9UhK
         4Sep5J5w9N0vIeLNk4p8r9otwIMJLFBW49yJCYHGzUVGWYDuB3QvuR7z8liGRwC/OjoQ
         TYGHoKd2PezKHlAqMrXFQnErJIDFQskaLXFu2SMIynhIeGyu87uvRpdDDpbNFc9YGX78
         Vgr4JM34qgCizYfVguvVMb8M867liA2dRIrXer9OWtd1U9qMumie/SCLFq7dqeKKxlCc
         RRqg==
X-Gm-Message-State: AOAM5304INO9vNSvP1jfxnQimpN6FPVC3UGz1JpVK02dyEorz7b9dGip
        SxwqQuSQqAJaF52vNDxg8VEXzuEasVzEqg==
X-Google-Smtp-Source: ABdhPJzFKECPn+HuF97BSbXyzHqCLmkoo2Sn5sZ1lKOB0lY/NNyVB5hBoCAJHIY4CFzLgoXAM+ZoMw==
X-Received: by 2002:a17:907:96aa:: with SMTP id hd42mr3242668ejc.177.1634776875756;
        Wed, 20 Oct 2021 17:41:15 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p3sm1700566ejy.94.2021.10.20.17.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 17:41:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdM8w-000vg4-7K;
        Thu, 21 Oct 2021 02:41:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] doc: add a FAQ entry about syncing working trees
Date:   Thu, 21 Oct 2021 02:33:49 +0200
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
 <20211020010624.675562-5-sandals@crustytoothpaste.net>
 <211021.86r1cfmfhh.gmgdl@evledraar.gmail.com>
 <YXCuQ3KID6iq0vwa@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXCuQ3KID6iq0vwa@camp.crustytoothpaste.net>
Message-ID: <211021.86mtn3mcph.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-10-20 at 23:35:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Oct 20 2021, brian m. carlson wrote:
>>=20
>> > +The recommended approach is to use `rsync -a --delete-after` (ideally=
 with an
>> > +encrypted connection such as with `ssh`) on the root of repository.  =
You should
>> > +ensure several things when you do this:
>>=20
>> What's the reason to recommend --delete-after in particular? I realize
>> that e.g. in the .git directory not using *A* delete option *will* cause
>> corruption, e.g. if you can leave behind stale loose refs with an
>> up-to-date pack-refs file.
>>=20
>> But isn't that equally covered by --delete and --delete-before? I'm not
>> very well worsed in rsync, but aren't the two equivalent as far as the
>> end-state goes?
>
> Yes.  The goal is that if something goes wrong, you have all the objects
> you did before, even if you have some potentially invalid refs.  The
> goal is to make it a little less risky if you interrupt it with a Ctrl-C
> because you realize the destination contained data you wanted.  I always
> prefer --delete-after for that reason, assuming the destination has
> sufficient disk space.

Isn't it preferable to recommend --delete-before for that reason?
I.e. --delete-after will produce subtle corruption of e.g. refs
potentially pointing to the wrong thing.

But if you recommend --delete-before I think (but maybe I'm missing some
cases) that it will be more likely to produce obvious corruption,
e.g. git dying due to missing objects.

Anyway, I'm also happy to just leave this as-is, it just stood out to me
as od..

> It shouldn't make a difference in a successful end state, however.
>>=20
>> > +Be aware that even with these recommendations, syncing in this way is
>> > +potentially risky since it bypasses Git's normal integrity checking f=
or
>> > +repositories, so having backups is advised.
>>=20
>> Perhaps we should recommend running a "git gc" or other integrity check
>> after (or "git fsck"), although those don't cover some cases, e.g. the
>> pack-refs v.s. loose refs problem in the case of a missing
>> --delete-whatever.
>
> I can recommend something like that.

...or just leave it as-is is also fine with me, whatever you think is
best.
