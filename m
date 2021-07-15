Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABBC636CA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A858161360
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245060AbhGOThO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345780AbhGOTgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 15:36:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90CC0613B2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 12:12:56 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so7349135ott.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yIpFF7K44C5awUFsKZ1Ev+6+nPUl6uWx6lkeDiis+/4=;
        b=eVS6veByuDE0lUA1SI6KWY3286yTGVGb4bYIY+Zgw8hkmmvxW1IuJzT+1zbSKyNFSM
         FugBzWdOTjncNGsgYHET2WzzVlt2O93NLK2vxEh/osq3rpzRBuyVO1qzn/TWcifCGMA/
         D+mhRdoJg/PmXK7z0XzABM7f6gqOQE6Qo4CeKC8FwS5Tuaoo5/zDwpfFATl3ZcKmSnWs
         VK6ZnAl5Os+P7B6k6cJ+mL6fQknSnzifItdt1aP88VbDogtBMbwRvOWVrwBDYlqzwQLS
         1vf/fs7jAsDtHO/Phrxa4McWhpsEfcntzzgReR+4RegnWotjLDFvSrSY1cmdl4cGtltq
         JFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yIpFF7K44C5awUFsKZ1Ev+6+nPUl6uWx6lkeDiis+/4=;
        b=ey1YK13iD9EI/FdkEg5ir5dfgAjUTdJ9qv2VREAH2mThzxWhGvXfPrKVG5XChg1wLT
         13t/KOp6gfl4J/LDmgboE1ozsr4OxlACi7sO5ymZA/NV2uh0jEaSsNqI8wzlkeDJlERG
         RBhiRX2/XuDgzegrKM5jN9paTHK7StnUr7PNEbDmYao3kPDbqqCfNMSAHHvvO5fZlXig
         qSzy03+AROx3im6yYa0S6uRSOVrg5HLdz6jgVAbtU9eOhxJyJrtjhovvRvSTqaSHJ1YN
         jhl8b/5WjZ2StrQR3nhTD8VOSRF6BUHUQGosSaua4NTm38PlqKTn8oC8IU53sKlVTjZl
         bRZQ==
X-Gm-Message-State: AOAM530Ipi+7sDdY9PbzolhAGeJkrJIovckR94Z0z8xbX3UaJfGcltA7
        BU+A64WEW2GI5O5xjG4pCzU=
X-Google-Smtp-Source: ABdhPJzNTTy76FazAGDXHgyy6igC0MNHn/K7ofVOjM2gKtDZhkA/JZ0P1AA9XUA6fGpwELomrlhLCw==
X-Received: by 2002:a9d:4105:: with SMTP id o5mr4907529ote.20.1626376375538;
        Thu, 15 Jul 2021 12:12:55 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id b21sm1291238otp.81.2021.07.15.12.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 12:12:54 -0700 (PDT)
Date:   Thu, 15 Jul 2021 14:12:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60f088b054e74_519c2084d@natae.notmuch>
In-Reply-To: <878s28zdmz.fsf@evledraar.gmail.com>
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
 <20210714202344.614468-2-felipe.contreras@gmail.com>
 <87bl74zdtb.fsf@evledraar.gmail.com>
 <878s28zdmz.fsf@evledraar.gmail.com>
Subject: Re: [PATCH v3 1/1] completion: graduate out of contrib
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Thu, Jul 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> > On Wed, Jul 14 2021, Felipe Contreras wrote:
> >> [...]
> >> @@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completion s=
cript clears cached --options' '
> >>  	verbose test -n "$__gitcomp_builtin_checkout" &&
> >>  	__gitcomp_builtin notes_edit &&
> >>  	verbose test -n "$__gitcomp_builtin_notes_edit" &&
> >> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
> >> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
> >>  	verbose test -z "$__gitcomp_builtin_checkout" &&
> >>  	verbose test -z "$__gitcomp_builtin_notes_edit"
> >>  '
> >>
> >> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
> >> index bbd513bab0..784e523fd4 100755
> >> --- a/t/t9903-bash-prompt.sh
> >> +++ b/t/t9903-bash-prompt.sh
> >> @@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >>  =

> >>  . ./lib-bash.sh
> >>  =

> >> -. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
> >> +. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
> >>  =

> >>  actual=3D"$TRASH_DIRECTORY/actual"
> >>  c_red=3D'\\[\\e[31m\\]'
> >
> > It's more of a "for bonus points", but a nic way to round-trip this
> > would be to make this work with GIT_TEST_INSTALLED.
> >
> > I.e. source these relative to GIT_EXEC_PATH, not $GIT_BUILD_DIR, I th=
ink
> > that just sourcing them as e.g.:
> >
> >     . git-completion.bash
> >
> > But the GIT_TEST_INSTALLED case is tricker, maybe we'd need to add a
> > "git --share-path" :(
> =

> I forgot to include this not-working patch, i.e. I've got no idea what
> the "something" should be other than the harder thing of compiling
> "sharedir" into git and making "git --share-path" work.

I don't think there's a "something" that would make sense.

It would be something like '/opt/git/bin/completion'?

-- =

Felipe Contreras=
