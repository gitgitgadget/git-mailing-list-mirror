Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8757FC433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 07:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJFHaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJFHao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 03:30:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B6C89961
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 00:30:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so2645782ejr.2
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 00:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+NMA+jaEgJ6a/MhdstAT3P+90obqjjRRPWWrHnMQpv4=;
        b=G/WjF9WKDAtlPCBY0MvlaBeUBDxPgGNyTohTSs/zx12lly2ePZ31mg4Iv7G1A9KavC
         Lg/PmoFn4Woo1z0pm4TVzqenXulNJQxOBOnt9yonS9xJ5Cuv80TNGyNDOEnORKX5lyXd
         Wpx9xxMdQAR41orArqpIyJjOHR1QCZ7w/RYu+QRJdEu7odVWPPv6wcoivAiUDaNzBRQN
         RF36akt7QniKi5cAhsYAjrdImL5ef8MSvxMyHDJbu4gINL90dashsj+MazJWiqY4WUsF
         Sfn9tuQ/tdG4csomInZ5y6zYRy36Wd/WjPnOmWImZ/H+6DFOS7/0GDuq9I1KzrqXnCP8
         C0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+NMA+jaEgJ6a/MhdstAT3P+90obqjjRRPWWrHnMQpv4=;
        b=Ugw4ijwqmqZEznZ2CaxIN1VUP0TCsh7SQQT61/zY5SCp29ngR0n/khfmzlcPq/e3aK
         9fB7B3EJ3/8hejNOdpVK+/h17Z+qhpwjtxw8VB2i0XsQFIQ6VjgGnqQRIEkF90xljAoS
         f3blt6bneB8alC1Pxroy2MbYOCgx8+OP+HTO4cHGbIV0yXu2VXiUKTlH5gANrugORPrw
         lU0E7/DIY4tFFEcjHeKBw6REx/fKjCVSoWV07wFrKUnzfa9uE85vJ9aySBSYQ+wCE+l1
         uh/CMToRSt3imiKgb4IxaA1IJ1bfYktJvMrEbEyDTTbf0GpWQXpqPQZGeFEEKcmPczAd
         CHIg==
X-Gm-Message-State: ACrzQf2YVJ/2XY78p3oNYhcL/we1rMVzPIytM9ido+sEIE/HAnz7SNiA
        pa1LN0iXLKPlB/lQ+wt44NUioQHKwdw=
X-Google-Smtp-Source: AMsMyM6VC2I9GKrVvHi3mEwjD6g6S2ORtJ/wEia6Kamu2g34yEx0+0LCLi4Ch20xBzsYLVL84DZbBQ==
X-Received: by 2002:a17:906:730e:b0:783:87a1:b5db with SMTP id di14-20020a170906730e00b0078387a1b5dbmr2880854ejc.383.1665041442097;
        Thu, 06 Oct 2022 00:30:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906c01400b007803083a36asm9775214ejz.115.2022.10.06.00.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 00:30:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ogLL6-002fne-14;
        Thu, 06 Oct 2022 09:30:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Aleajndro R =?utf-8?Q?Sede=C3=B1o?= <asedeno@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: GCC deprecated only takes a message
 in GCC 4.5+
Date:   Thu, 06 Oct 2022 09:29:11 +0200
References: <20221003212318.3092010-1-asedeno@google.com>
 <YzthTugwy+eaIUxr@tapette.crustytoothpaste.net>
 <CAOO-Oz2WnodBnw86mi2GZ+jLGoGy_saX=kCpwPdm2xohDO1s_Q@mail.gmail.com>
 <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Yz2afjRezq5oGN4g@coredump.intra.peff.net>
Message-ID: <221006.86lepts927.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 05 2022, Jeff King wrote:

> On Mon, Oct 03, 2022 at 07:45:44PM -0400, Alejandro R. Sede=C3=B1o wrote:
>
>> I'm targeting an old SunOS 5.10 with a GCC 3.4.3, for reasons that can
>> only be described as self-loathing. :-)
>> The other users of GIT_GNUC_PREREQ are used for 2.8, and 3.1, so I
>> figure distinguishing between 4.5+ and <4.5 should be well supported.
>>=20
>> Regardless, there's no reason to break older compilers over something
>> that's this trivial to fix.
>
> This will cause some mild hardships, as later patches will need to
> #define UNUSED in other spots, as well, in order to get full coverage of
> the code base (I have written those annotation patches, but they're not
> applied upstream yet).

Sorry about any trouble in having to rebase those on UNUSED.

If you're taking requests it would be really useful to prioritize
changes to shared headers and the like, e.g. DEVOPTS=3Dextra-all on pretty
much any file will start with:
=09
	git-compat-util.h: In function =E2=80=98precompose_argv_prefix=E2=80=99:
	git-compat-util.h:313:54: error: unused parameter =E2=80=98argc=E2=80=99 [=
-Werror=3Dunused-parameter]
	  313 | static inline const char *precompose_argv_prefix(int argc, const c=
har **argv, const char *prefix)
	      |                                                  ~~~~^~~~
	git-compat-util.h:313:73: error: unused parameter =E2=80=98argv=E2=80=99 [=
-Werror=3Dunused-parameter]
	  313 | static inline const char *precompose_argv_prefix(int argc, const c=
har **argv, const char *prefix)
	      |                                                            ~~~~~~~=
~~~~~~^~~~
	git-compat-util.h: In function =E2=80=98git_has_dos_drive_prefix=E2=80=99:
	git-compat-util.h:423:56: error: unused parameter =E2=80=98path=E2=80=99 [=
-Werror=3Dunused-parameter]
	  423 | static inline int git_has_dos_drive_prefix(const char *path)
	      |                                            ~~~~~~~~~~~~^~~~
	git-compat-util.h: In function =E2=80=98git_skip_dos_drive_prefix=E2=80=99:
	git-compat-util.h:431:52: error: unused parameter =E2=80=98path=E2=80=99 [=
-Werror=3Dunused-parameter]
	  431 | static inline int git_skip_dos_drive_prefix(char **path)
