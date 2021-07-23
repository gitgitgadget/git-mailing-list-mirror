Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D5C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485C960E90
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 07:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhGWGpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhGWGpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 02:45:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57BC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:25:35 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id df26so529024edb.9
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=sl2WOWo90tL19XZwvH+AojHCzDMD3hxAe7P5FAjt2/U=;
        b=L9fzqEsZMnyGmzDX7A4yFi3SDrpfJkXqIRWcxXtrY9a6QAFOtVm2fR+IqJEScfHO32
         8Z9V7QgO1/w1mDz0IRighSr+uqEtGoxdpd2Q0vRQKVXyw3tpXHrM6+G74noRCzdiK65f
         CLB7AHyq5TyHimp65o+4FtmXA8T+6255EX+3wkeJ+djKFQ7VMcnxgmOeu8SjAi9f/0oR
         3JEiW0pTojn9/v5MPumCioEMFTCI5V5l2GCg8LqTMLTCKdKp5mgBPLl1TDi+k8yZGk26
         WU5dw1XhnoPmItSz9N2ta+hUAbazWdrIXbwFtqaMaXyHE/oXa3VWGGMwH3B6aDTP0ehw
         p+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=sl2WOWo90tL19XZwvH+AojHCzDMD3hxAe7P5FAjt2/U=;
        b=ExUz2zZVQo97RjhC19g8+exInlEOAm02aPNnIQ6AOQ1JTFEhUiAdoxTnDpkMkFgEIT
         jZzCOKXFrDgTik6lKG+EYPcCkgArmVT4OMK6ULwsFotk8Zf13o+6k+HCO3wzrKNf5mxV
         4re3cVIA5sXKVZ++zdCTrivTY4x+BcS9zy4CNPAj4ASBZlTOEHKkKHPNv7S+9oGbrALB
         RMPZt4p20dwu0Q4TsiDYmJ2YYeHxqhKizfCRTnuVN3jFFSsWMw6PVuZcvCSaZOryrMWQ
         BbFxp0LNgR0Ee0xazius+4+sHm1TNFryFWZCI3k29wPn6p/2n1r+tXFmFjgERUTnEkgD
         YCZw==
X-Gm-Message-State: AOAM530SP/nSsl/yis5mdN+IUO3lZcGXmL39q5bdYf6IcTgh4SEY5tc8
        WNO+z+MZCfZcxbXrUbCaygs=
X-Google-Smtp-Source: ABdhPJylsSHM5UuJPMmo+wG5DXVj8tSMAS8epN3nFK70UHH7DLS7JjzgnWOdhwfbhh0QiCqvAbZvwA==
X-Received: by 2002:aa7:d8c1:: with SMTP id k1mr3971299eds.28.1627025134173;
        Fri, 23 Jul 2021 00:25:34 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l3sm10206712ejs.78.2021.07.23.00.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:25:33 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
Date:   Fri, 23 Jul 2021 09:17:58 +0200
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
 <YPimBp+TkaJ9ycuM@camp.crustytoothpaste.net>
 <87czravm96.fsf@evledraar.gmail.com>
 <YPn3jP0n+ghomSkX@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YPn3jP0n+ghomSkX@camp.crustytoothpaste.net>
Message-ID: <87h7gltrst.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 22 2021, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2021-07-22 at 07:09:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> I'll clarify this along with other fixes in a re-roll, but I think our
>> policy shouldn't have anything to do with upstream promises of support,
>> but merely the trade-off of how easy it is for us to support old
>> software & how likely it is that people use it in practice along with
>> git.
>
> I don't think I agree.  We should try to support major operating systems
> well provided we can adequately be expected to test on them, and that
> means that they should have publicly available security support.  In
> other words, a developer on the relevant operating system should be able
> to test on that OS without paying ongoing money for the privilege of doing
> so securely.

Doesn't drawing that line in the sand for Linux distributions by
implication leave out support for Windows, OSX and any other proprietary
system? You need to pay for security and other updates for those from
day one.

> Once an operating system is no longer supported security-wise, we should
> no longer support it, either, since we can't be expected to test or
> develop on it securely.  Nobody could responsibly run such an image on
> a CI system or test with it on an Internet-connected computer, so we
> should no longer consider it worthy of our support.

Yes, I do think we disagree. I just think we should focus narrowly on
whether it's a hassle for us to support older libcurl, whether some
version of it is packaged with an old OS that's known to be in wide use
or not is ultimately just a useful heuristic.

>> So as an example we still say we support Perl 5.8, which is ridiculously
>> ancient as far as any notion of upstream security support goes (and as
>> an aside, does have real DoS issues exposed by e.g. the gitweb we ship).
>>=20
>> But while we could probably bump that to something more modern nowadays
>> in practice we're not a mostly-Perl project, so I haven't found it to be
>> worth it to bump it when working on the relevant code.
>
> I've actually argued in favor of bumping the version to 5.14 a long time
> ago.  I can send a patch for that.  It has a bunch of nice new features
> we could take advantage of.

Sure, I'm not opposed. Just noting the in-tree nicer features for us
v.s. more aggressive versioning policy for packagers and users (not that
Perl 5.14 is aggressive).

>> I'm only using RHEL 5 as a shorthand for a system that's usually the
>> most ancient thing people want to build new gits with in practice.
>>=20
>> It's just not the case that you can't run RHEL 5 or even RHEL 4 "safely"
>> even today. Upstream has just abandoned it, but that doesn't mean users
>> in the wild have. There's also CentOS, not everyone cares about IBM
>> corporate support policies.
>
> Yes, and CentOS has dropped support earlier than Red Hat has.
>
> Just because users want to run new versions of Git on systems that
> should long ago have been abandoned[0] does not mean we should take the
> burden of maintaining that code for them.  Since they have the source
> code, they can build and maintain Git on those old systems and apply
> any necessary patches.  If this becomes burdensome, then perhaps the
> cost of maintaining the system will be an incentive to replace it with a
> secure system.
>
> I am unconvinced that we should make it easier for people to run
> insecure operating systems because they pose a hazard to the Internet
> when connected to it.  Just because it is behind some firewall doesn't
> mean that it cannot be compromised, and once it is, it can then become
> a source of spam and abuse.  This is not an idle thought experiment; it
> does practically happen with great frequency on the Internet today.  An
> unsupported system might be acceptable if it has no network connectivity
> at all, but then it would not need a newer version of Git.

Aren't you assuming that any network connectivity is equal to
connectivity to the open internet?

In any case, I think the notion that we should make git slightly more
painful to use on these systems as a distant proxy variable to forcing
OS upgrades is several levels away from where I think we should be
drawing the line, which is closer to "is it painful in-tree?" and "is
someone sending us patches to make it work?" etc.
