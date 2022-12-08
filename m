Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE5EC4332F
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 13:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLHNN6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 08:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLHNN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 08:13:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3070A8D655
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 05:13:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fc4so3675162ejc.12
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 05:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CslX1ahRpKwcMfxrId/6RFNP+R3orCOeCVMqBB1Alos=;
        b=dBK1Z1BGqbj3+FPp3Soyjh21KKtZwC7yXWa5I8ZPkMusr3uLYRqLGHUvPQKcrLI8Pn
         pcJRJmedpwSl7Ew+hZi2nd+Hhx802aSOGV9le5VxPXGdcFIBM2f2tcEHOQZK4FipIWPh
         w3vNMZlwTeK2es68MVOacmDyTDH8o6ynqXajE2D2+PP0sVDILsFI1bLDnXNtBMX9f5q7
         PBHQlWj72DLpMEALX4i/k4KW4BP0wa+6OTdukyFMrRtltCaJJ+fPHlDsmdWVfVEuxJrI
         Yhbkgl/eBX8NT9nGgzWrbEe7lFo8k7u9KCpCLb6YzUuas1U30I7fxMMtS1KKU2DttYuN
         GihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CslX1ahRpKwcMfxrId/6RFNP+R3orCOeCVMqBB1Alos=;
        b=VI/qyfTNNLJPJvTsaZRbOwFAwd/XC1DOEMJiQJU1+T0pwpcvfFJw9Sk6dqRZhT8i1h
         xqjg0xFN/enAGPvNEFKFDp5nCPtD86+o904xxXSWlHCGsJdFljGLeG63Ij34wzY1zxol
         7JW+c35hqcHh2Vpn4vzjeJQ0fftXxpK9Bq4YHO4u7D+xK7eFwt3Tc2M6jqJeLPoOqvAY
         o7M4ibdN/EekAWOV0lPjmXbrOokAclWzD9dL1Rf3xg7tAQVw+WWV4NcaJVO170Z0iept
         usHfVX7rt+z28Z95uLIrfDdgefu7CwhVuZPa0A8WFGvNO9zxMRETkS9djsilFS43NlCO
         CoFg==
X-Gm-Message-State: ANoB5pk0eleh3Z1V/wU/rrTJQGXfem9iELtBE18KxAPBoX6nQpqG5Uoi
        YXgaSUEBs2stmBemsmyqY5Q=
X-Google-Smtp-Source: AA0mqf45wzH1fASD/CjKoD2aMqtSVh2Ndkm75yajRBV3RnqZES1+8WZQsfUdq6o1wq2N88G5H02ppQ==
X-Received: by 2002:a17:907:2dab:b0:7c0:eba9:cf0f with SMTP id gt43-20020a1709072dab00b007c0eba9cf0fmr2761871ejc.30.1670505234639;
        Thu, 08 Dec 2022 05:13:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906139700b007815ca7ae57sm1357699ejc.212.2022.12.08.05.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 05:13:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3Gin-0054Vn-1G;
        Thu, 08 Dec 2022 14:13:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
Subject: Re: [PATCH v3 08/11] strbuf: introduce strbuf_strip_file_from_path()
Date:   Thu, 08 Dec 2022 13:52:44 +0100
References: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <1eec3426aee12bbd674ebd646075f0d4c0b1f5af.1670262639.git.gitgitgadget@gmail.com>
 <221206.86a640dda3.gmgdl@evledraar.gmail.com>
 <221206.86wn74bw35.gmgdl@evledraar.gmail.com>
 <98ee4b5b-9d72-31fc-d5b1-1a978450973f@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <98ee4b5b-9d72-31fc-d5b1-1a978450973f@github.com>
Message-ID: <221208.86k0326nse.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Derrick Stolee wrote:

> On 12/6/22 6:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> FWIW the "overkill" change on top to do this via callbacks is the
>> below. Which I tested just to see how easy it was, and whether it would
>> fail your tests (it doesn't).
>>=20
>> -- >8 --
>> Subject: [PATCH] strbuf: generalize "{,r,l}trim" to a callback interface
>
> I don't like this approach and think it distracts from the goal
> of the series. If you want to update it afterwards, then by all
> means go for it.

Yes, I think it shouldn't be part of this series at all.

I.e. the part in [1] that you're replying to is just something I poked
at because you nerd-sniped me into poking at it.

I think it's probably not worth it, and I don't think I like the
API[2]. What I do think is worth including in this series one way or
another is [3].

You're proposing a new addition to the strbuf API. I think it's relevant
feedback that you seem to be re-inventing close relative (literally a
1-byte difference!) of a function that's there already.

Or I'm just wrong, but then what input does your
strbuf_strip_file_from_path() handle differently than the
strbuf_trim_trailing_not_dir_sep() in [3]?

Making them sibling functions would make the API more discoverable. The
comment you're adding would also improve the existing code. I.e. we
could have this end-state in strbuf.h:

	/**
	 * Strip trailing directory separators, or not-directory separators.
	 *
	 * The "dir_sep" variant portably trims redundant slash(es) from the
	 * end, while the "not_dir_sep" gets you to the base directory, should
	 * the path refer to a file:
	 *
	 * |---------------+---------------+-------------------|
	 * | In            | out (dir_sep) | out (not_dir_sep) |
	 * |---------------+---------------+-------------------|
	 * | /path/to/file | /path/to/file | /path/to/         |
	 * | /path/to/dir/ | /path/to/dir  | /path/to/dir/     |
	 * |---------------+---------------+-------------------|
	 */
	void strbuf_trim_trailing_dir_sep(struct strbuf *sb);
	void strbuf_trim_trailing_not_dir_sep(struct strbuf *sb);

Or maybe you still think it's not worth it, I also think that's
fine. I'd really appreciate knowing if it's a "yeah maybe they're the
same, but I haven't checked", or if it's "I think you missed a case, but
I haven't explained it to you".

Otherwise if I do follow-up I'd probably have to start by brute-force
testing the two to satisfy my own paranoia :)

Thanks.

1. https://lore.kernel.org/git/221206.86wn74bw35.gmgdl@evledraar.gmail.com/
2. Although once I started poking at it I found a lot of cases in-tree
   where we hardcoded that exact loop (or the equivalent strbuf_setlen()
   variant), which could be replaced by "trim all cases of this
   character from the end of a strbuf", or "trim all cases of this
   character match ..." function.
3. https://lore.kernel.org/git/221206.86a640dda3.gmgdl@evledraar.gmail.com/
