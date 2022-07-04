Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E1C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiGDIJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiGDIJs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:09:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98DB1DD
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:09:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ay16so15326052ejb.6
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=q8MRN/mQBioVNET4NAUhKTTNLWNoBFHTymxxaVrM6FM=;
        b=FiAoX0rde1cFv0zqTmHsbodieJTUNn+j3QRFqSwiHngB7uM0Whj5FxCdtY8RS461Qg
         A9XKlLQOv6cUVqxW5DahUxJTs8Eg6OIkupoyDGdygJMIed5gufNKN6LdKItKx2AD12l1
         8QYGawH2DXisSKNKeydt1bojLWguBy52UJI2LNUJIUTSt0H9z/RHKNFuIX/attREwvfy
         UEwsU/4Lr0mEzYQhzWNB3Mmf2I3VLQjrMqRVUs/GMwMdlcPv6qssuAYnv1xxZooSFdM5
         xgUquG8o1YNqADUeml1dt7MmS0QvyE4M8TMHO1a4pN3foNdpRNfIFWsoOF1SvOkyyekJ
         DS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=q8MRN/mQBioVNET4NAUhKTTNLWNoBFHTymxxaVrM6FM=;
        b=blPMeKULDZFX2UzyAFhBWlnJhR5h44TGg+R+K2+5V+fRIph6/0VMxQOKp2gvZ7osOh
         Q4N0IFhFR4Xpolqj0oLfBAxXuI0ZeAJVzPetkTujzHGLqnE+d/PUcQNKviKLYN8xb/S2
         +E+W9hY1o47xaCUNeY2Q8clAID9H2MnDrxasfQMnZZQ0Vjx9ZU2Lhig7CKj4xcikh9l6
         BFeo2AtKroF/EAPJF0SPFMezI6qlde1iuHZROWMr1S1Z6CTIAb0zbJPP7r56TQrBOQaD
         VNvWAbVR1KCKJsMMkC0xtw0JJ1ar93szYo/60BmOlPBtkSNy4CMV+b6cjimH0O5cBDx2
         Qo3g==
X-Gm-Message-State: AJIora9yYhJx2i/YPUymJNHKpwrP5WX6aXur/svS6jEPxgolMb5drNqa
        NX3PKnvowZS5gJFJM2RBb5Y=
X-Google-Smtp-Source: AGRyM1tsUdnf6JQu7d8bepMWMvqxUvVqR3kqELptx1LXW6YCD7sgh/u2+xgyqQmXRrHhqj4lFQ/ifA==
X-Received: by 2002:a17:907:a079:b0:72a:b46b:529a with SMTP id ia25-20020a170907a07900b0072ab46b529amr9007137ejc.313.1656922184809;
        Mon, 04 Jul 2022 01:09:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b3-20020a17090636c300b00726b8e84c1asm9330207ejc.21.2022.07.04.01.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:09:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o8H9L-003HPz-3M;
        Mon, 04 Jul 2022 10:09:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: support building on RHEL6
Date:   Mon, 04 Jul 2022 09:38:06 +0200
References: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
 <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net>
 <xmqqpmio7c3m.fsf@gitster.g> <xmqq7d4w7bcw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d4w7bcw.fsf@gitster.g>
Message-ID: <220704.867d4tb8oo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> But I do not think the patch text, what the patch does, is that bad.
>> We advertise in INSTALL that you need 7.19.4 to build without NO_CURL;
>
>> IOW, you should be able to build Git with 7.21.3 or later.
>
> That conclusion is nonsense.  "with a version before 7.21.3 as long
> as it is newer than 7.19.4" is what I should have said.

I find this line of argument to be circular legalese without a
distinction.

As 644de29e220 (http: drop support for curl < 7.19.4, 2021-07-30) notes
(which I submitted as part of the git-curl-compat.h series) the reason
we have 7.19.4 as a cut-off is entirely due to RHEL.

So, if you do agree with brian that supporting RHEL6 is a bad idea
supporting RHEL6 v.s. supporting libcurl 7.19.4 is a distinction without
a difference.

There's also a 7.19.3, and a 7.19.5, we didn't pick specifically 7.19.4
by accident.

Yes you *could* run Linux-From-Scratch and just so happen to have that
version, but in reality practice almost everyone who cares about 7.19.4
does so because the cut-off is synonymous with RHEL6 and its
derivatives. The same goes for other "magic versions" shipped by later
major OS versions from various vendors.

Brian & I have disagreed on the larger point in the past, not to re-hash
the entire thing here (which can be found in some libcurl threads in
particular, and other "older OS" threads), but somewhat briefly:

 * I think we should be more aggressive in bumping required dependency
   versions, but not as a stick to force users on older systems to
   upgrade out of some enforcement of the Greater Good.

   But simply because we should weigh our time & effort in supporting
   and testing older versions, v.s. the relatively small effort for
   packager to build a newer git *and* its updated dependencies[1].

 * Having said that I entirely disagree with the premise that we should
   view the consumers of our software on free software platforms as
   helpless users who can't make an informed decision about whether they
   should run on older OS with newer software.

   Whether something is supported by upstream is only one factor in
   evaluating the security of a given installation, and whether security
   even really matters in that case (some older RHEL installs are
   firewalled off, or one some private network etc.).

   It's one thing to demand that we do their work for them (which per
   the above, I think it's fair to ask them to do more work). But
   arguing from the *principle* that we use non-support for older
   systems as a wedge quickly leads to justifying actively breaking
   older OS's, or not taking portability patches where the maintenance
   burden is trivial.

 * I really don't care that much about older libcurl in particular
   (using NO_CURL=Y or compiling it yourself is easy).

   But the reason some of us use or test on older OS's is not because we
   think exposing Solaris 10 (released in 2005, see [2]) or whatever to
   the wider internet would be a good idea, but because those older OS's
   tend to find edge cases is our portability assumptions, which
   sometimes even helps portability on newer or future OSs.

The reason I wrote the above now is because I'd really not like
e.g. future C portability patches or whatever that are easy to carry but
happen to cater to some "EOL" OS to be rejected out of hand because
"there's no possible way that any Git developer can be expected to
support [it]", and to have this thread cited as justification without
there being a dissenting argument to be found.

Even if I agreed with the goals I think the argument is still
fundamentally flawed. Some vendors of older OS's don't publish the same
sort of deprecation and support time tables that Red Hat does, even
though their older (and sometimes newer) OS's are probably more insecure
in practice.

Therefore if our criteria for shunning an OS is that its vendor deems it
insecure, we're not only using our clout to encourage them to upgrade,
but also encouraging the use of OS's whose vendors aren't themselves as
strict about encouraging users to upgrade.

1. https://lore.kernel.org/git/CACBZZX78oKU5HuBEqb9qLy7--wcwhC_mW6x7Q+tB4suxohSCsQ@mail.gmail.com/
2. https://cfarm.tetaneutral.net/machines/list/
