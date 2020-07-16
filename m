Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C723C433FE
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5302E2070E
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptw3P7kn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgGPXKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGPXJT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03DEC08C5DF
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:37:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so5383513pjt.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yvr3p9+7J1C4EGlQ5Qy+ZXAYo0ocyOOgzFavkyRFGnM=;
        b=ptw3P7knT/WFIBy73Ct/wqQQgSCThGrDO8PQkIZ/Kw55MLlY++UIGabqr1nN5nksRi
         ZoSSe/Bgsm6d/5pqase0wOmxPkaZTU6o0HVq4KzIIcoQIh8SA6VHh8H84kq5hLBAZabP
         1xjB6exOlc+fBacYntK5Hidv4qbDh9A5+Ae1bFfn95uAvVHz4hDljDhbLNE+UOggfhoS
         qeFM9sXD2w84P2Mpho1Sw/d1BNgvtEctuCYhUgv2pLP5gLHdTrQsNLJXy8jEx77AKgut
         eQHMJ40fv+bHF1LUBJdZsnww3ukDOumFMXtZ22iLSmdDFhDtWG3q/bi8DXDjSHVAyyZI
         lXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yvr3p9+7J1C4EGlQ5Qy+ZXAYo0ocyOOgzFavkyRFGnM=;
        b=Eebw2GfDRV+sg3k8ibyJqVuwLANeQALs9RgFgKzsqFx2GQ0/fncSpc0lLnutzXk2E+
         lCFW1qGL3GMPgStf0KEtJXqExC0uNhlz8/Fdw0//3mhD18oO8H5irlOTe9OS7fHoI/ky
         lkthIc+JuAc1HWiW8syO8+ZmAqcgyVT/Y/JSTP63KU9SjMsE3zjVpov8jbQOD70+knlG
         P2zsrcdsYmJwKA0zVjaeLy4qwbcm8oTwpt1DGWWU8VrzUVQp63JTEpK6o726uzNn6iMR
         EkkUBjXEF7c14uYd+PRlVGKbexZ4kJK74cfYpmrUFOPonF1YkBz2GenHp5QCX/0hism0
         7Vlw==
X-Gm-Message-State: AOAM532cJ6J00hVeuPzbhwwdRAmy+lhytVSBHXwS7ht6GVefc9zIpkHB
        QBA3fwV/Mgk8ho5HT5luiS8=
X-Google-Smtp-Source: ABdhPJx9m0k6q8/jiMUKQdT9YiGyfqcpclBvKLy8glWNmZoOmPoBuOslOdsKozU306gITwohQK1vqQ==
X-Received: by 2002:a17:90b:388d:: with SMTP id mu13mr6655178pjb.187.1594939044032;
        Thu, 16 Jul 2020 15:37:24 -0700 (PDT)
Received: from gmail.com (135.84.247.35.bc.googleusercontent.com. [35.247.84.135])
        by smtp.gmail.com with ESMTPSA id y8sm897907pju.49.2020.07.16.15.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 15:37:22 -0700 (PDT)
Date:   Thu, 16 Jul 2020 15:37:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716223719.GA899@gmail.com>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
 <xmqqd04vigpy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd04vigpy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(replying from vacation; back tomorrow)
Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

>> Yeah, I agree with this line of reasoning. I'd prefer to see it
>> addressed now, so that we don't have to remember to do anything later.
>
> Very true.  Also the documentation may need some updating,
> e.g. "These 4 extensions are honored without adding
> repositoryFormatVersion to your repository (as special cases)" to
> avoid further confusion e.g. "why doesn't my objectFormat=SHA-3 does
> not take effect by itself?".

Yes, I agree, especially about documentation.

For 2.29, I would like to do or see the following:

- defining the list of repository format v0 supported extensions as
  "these and no more", futureproofing along the lines suggested in
  Peff's patch.  I like the general approach taken there since it
  allows parsing the relevant config in a single pass, so I think
  it basically takes the right approach.  (That said, it might be
  possible to simplify a bit with further changes, e.g. by using the
  configset API.)

  When doing this for real, we'd want to document the set of
  supported extensions.  That is especially useful to independent
  implementers wanting to support Git's formats, since it tells
  them "this is the minimum set of extensions that you must
  either handle or error out cleanly on to maintain compatibility
  with Git's repository format v0".
 
- improving the behavior when an extension not supported in v0 is
  encountered in a v0 repository.  For extensions that are supported
  in v1 and not v0, we should presumably error out so the user can
  repair the repository, and we can put the "noop" extension in that
  category for the sake of easy testing.  We can also include a check
  in "git fsck" for repositories that request the undefined behavior
  of v0 repositories with non-v0 extensions, for faster diagnosis.

  What about unrecognized extensions that are potentially extensions
  yet to be defined?  Should these be silently ignored to match the
  historical behavior, or should we error out even in repository
  format v0?  I lean toward the latter; we'll need to be cautious,
  though, e.g. by making this a separate patch so we can easily tweak
  it if this ends up being disruptive in some unanticipated way.

- making "git init" use repository format v1 by default.  It's been
  long enough that users can count on Git implementations supporting
  it.  This way, users are less likely to run into v0+extensions
  confusion, just because users are less likely to be using v0.

Does that sound like a good plan to others?  If so, are there any
steps beyond the two first patches in jn/v0-with-extensions-fix that
we would want in order to prepare for it in 2.28?

My preference would be to move forward in 2.28 with the first two
patches in that topic branch (i.e., *not* the third yet), since they
don't produce any user facing behavior that would create danger for
users or clash with this plan.  Today, the only extensions we
recognize are in that set of extensions that we'll want to continue to
recognize in v0 (except possibly the for-testing extension "noop").
The steps to take with additional extensions are more subtle so it
seems reasonable for them to bake in "next" and then "master" for a
2.29 release.

Thanks,
Jonathan
