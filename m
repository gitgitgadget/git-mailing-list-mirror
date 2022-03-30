Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3951C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 16:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349134AbiC3RBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348578AbiC3RBg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 13:01:36 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F73FBEC
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 09:59:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q5so28515605ljb.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBrgmuNSFwxENOFA+zSVPqBEDxj1TJ09OoKamrrYxJo=;
        b=SZmoR67o+bJyB65cFryEAgGN7ETF8bc5gBCeDmQOcSywQDjsJF55GHCRhyvfi+Segb
         OnxJAnh6cgm+AqGXBiTJTQQIwf8Lx4DxaTBmIS30SkVXhH969QJuPtlfwdpA/PM+5sDc
         5X1Gf+wPciTe/ThoBXjpVV8OIGq0gKCLKUZmEcq7AuYatx7uqTE8KrtvsCCQbQg4R4eZ
         7TwC7z0lqziGY/cYHJsOJAuUKWcidwaxEHSTSW2yhak8bNdeX+hIfbu5B3n8Rg5c5wjw
         WFdAtTYvHXh1SDbwWGTYIZ3a/9MHVsFOhcQtnFjYhC+Dv0bRxkkhfz31uDvO7wb+tHvq
         WDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBrgmuNSFwxENOFA+zSVPqBEDxj1TJ09OoKamrrYxJo=;
        b=pHRTZvZhCp0um5FKCaR5TlJjVs+ASPvJc0RS6s+sSk23hQjxd3sUxNXZ1DGrEsPWIK
         r1aroPHpfX6JGERt8d66G3wylnWflBWyrswfovTItVlDUAJolcsk3aHlpY4Hk60VGO7f
         OBiGO0iihpPWbpTBJ/wOyC7zDQIGKHv3jGjBWpwElpqOqNvzhY+hmF6h8vHfaY35vve2
         6WbAOQ3xaCr1VVpgibHFHLg+l/pbLVxs1F6SuUdb0o7TvNjRsYKk2S1Jcinu0Y/2kZFl
         c7NurSdkEmtUP6mRdypOO+KnTnH+q+Iu0eu7+btaxFEW3lIsA5J5rhzliH76mgCYViL/
         AmfA==
X-Gm-Message-State: AOAM530CCy8K9K7N+kVxXcEPuOPMHUg/M/1F9kKkOMStCvJAPRlzY/0z
        9nLEOho1pSss5KoVKW5zRMWtd3AWIFwBLvt7U+Dyhy3rH6+B+g==
X-Google-Smtp-Source: ABdhPJxzjG/MhdvSsYFc/x6My0ep7k1H/PKru0DXYIZJFxyWfbYihT+6ZE8xIKHfE0+r/YWsbDtLIQGPdD0JtrRfowg=
X-Received: by 2002:a05:651c:158e:b0:248:1ce:a2a with SMTP id
 h14-20020a05651c158e00b0024801ce0a2amr7130403ljq.172.1648659577754; Wed, 30
 Mar 2022 09:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
 <20220315191245.17990-1-neerajsi@microsoft.com> <220323.86fsn8ohg8.gmgdl@evledraar.gmail.com>
 <CANQDOdeeP8opTQj-j_j3=KnU99nYTnNYhyQmAojj=FZtZEkCZQ@mail.gmail.com>
 <220326.86ils1lfho.gmgdl@evledraar.gmail.com> <CANQDOdeduc8bFA_=R-kXmkM+nb__oTxVhjBfFYj70vCFew1EyA@mail.gmail.com>
 <220326.86sfr4k9rm.gmgdl@evledraar.gmail.com> <CANQDOdfWh5aO9cuJVuUccKyD9Cj+NndisokiewBH9Sq4oSUp5A@mail.gmail.com>
 <220327.86y20veeua.gmgdl@evledraar.gmail.com> <YkGUeQH4y1KIAdCc@ncase>
 <220328.86pmm6e0i0.gmgdl@evledraar.gmail.com> <CANQDOddSnSByqMrU+b11zywwWjOS+A5W0BSXa0rZURWn5zi2Tg@mail.gmail.com>
In-Reply-To: <CANQDOddSnSByqMrU+b11zywwWjOS+A5W0BSXa0rZURWn5zi2Tg@mail.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 30 Mar 2022 09:59:26 -0700
Message-ID: <CANQDOddVLOZJZtvTE3zDizwWdu3RsxiE6dCuNc3D=RyGsLRRqA@mail.gmail.com>
Subject: Re: do we have too much fsync() configuration in 'next'? (was: [PATCH
 v7] core.fsync: documentation and user-friendly aggregate options)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 12:56 PM Neeraj Singh <nksingh85@gmail.com> wrote:
>
> On Mon, Mar 28, 2022 at 5:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>
> So I think you're alone in thinking that anything needs to change here.
>

=C3=86var,
I apologize for the negative tone and content of this comment.

Thanks,
Neeraj
