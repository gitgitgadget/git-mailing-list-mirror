Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32FC433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiDLKBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377364AbiDLHtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 03:49:55 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9A04E3BE
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 00:30:23 -0700 (PDT)
Date:   Tue, 12 Apr 2022 07:30:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=palard.fr;
        s=protonmail3; t=1649748619;
        bh=iV3zTd91h3Y4hPWpNqy2e+9TzEwgbUKOhc6ToY3KQOE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=gSH+15Nq6/jtdXJNTmZlfnayGwnHWn9UVW+xowDtBT//XW+zvs/nWh1xGKGWY9H7+
         KelshRRQykpSXj7RSiFwCN/0SX9E09CFLRHd/SqbsAmnWvDG8Z/xo/UDc2vyD4mdsw
         5SM4xCmlLW1dcUQnZ9xCht+TJmNXy4lqhX04cFFUigP1jScKzQE09kky7V2R7Mz5M+
         FveP6dc83L/mXpWC3sXd4ZjACeBu2MQoA0gTIXvi4kBmZpZDaR7Zlzp1TdEwjOcSuu
         XKc2Ys3RYEH1Fm0hlkoYMA5wM8544RisliuBvSEI5ZjmzVnt8K5CHbveFNLT0XnMV4
         FtoloBc/mohtQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Julien Palard <julien@palard.fr>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien_Helleu?= <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Reply-To: Julien Palard <julien@palard.fr>
Subject: Re: [PATCH] Make a colon translatable
Message-ID: <CmgFntqFQcIxsSKePSKmmWvAMwsl-9shDqzWTT9GqI3S6PXNdhTTX6LypjY0l-R8B52pkh_MpYtq-NbbDjXT6EuZ9_S-QV4cUqxKhjZUpw8=@palard.fr>
In-Reply-To: <xmqq5ynfh101.fsf@gitster.g>
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr> <xmqq5ynfh101.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, thanks for you feedback!

> Sorry, but I do not quite buy this. The above is a representative
> example of what we call "sentence lego", which is what we absolutely
> want to avoid, isn't it?

I never heard of "sentence lego" but I can easily imagine it's building sen=
tences by mixing multiple levels of gettext and printf-like formatting, typ=
ically freezing the order of sentence components, rendering them untranslat=
able in some languages, like printf(_("if %s then %s"), _(if_part), _(then_=
part))? I I'm wrong tell me because I may have misundertood your whole poin=
t.

> We'd rather want to see
>
> printf_like_function(("Use 'git %s' ...", "string"));
>
> when "string" is something that should not be translated

Make sense.

> I.e. this one is better handled by
>
> status_printf_ln(s, c, _("%s:"), what);

I understand your comment while seeing my badly choosen example with `_("so=
me string:")`, but in the patch isn't your proposition more sentence-lego-i=
sh than mine? If I understand correctly you're proposing to replace:

    printf("%s", _("Untracked files:"))

with:

    printf(_("%s:"), _("Untracked files"))

This hides information to the translator (the presence of a following colon=
 while translating 'Untracked files'). It would be OK if we were 100% sure =
no translations can be impacted by this. I only speak french and english, s=
o I don't know. Maybe I should rename `what` to `heading`? I may clarify a =
bit, `what` make me feel it can be reused, but it's only used once alone on=
 its line.

Bests,
--=C2=A0
Julien Palard
https://mdk.fr

