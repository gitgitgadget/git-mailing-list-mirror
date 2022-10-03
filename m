Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB56C433F5
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJCP4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 11:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJCP4B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 11:56:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A452B27F
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 08:56:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso7764584pjb.0
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 08:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNkBMw2u1yILWDM7CuhW/nfZuJTNS5zs40EvNatU7ok=;
        b=BVsXZTuf3JUghA5aDADmlXv2hYFQeHvoZ/8xyrAhoc7gxWphp+hIk5ZPC+zLwbqUFr
         1rk4Z2XU2XqWlO3qm+L/GF59LEy2gQiUV/1HCew+1OsUg8QXJrnxJxdrEslbZYDeNNcY
         TP8u8BXPs44rmAlFEDEx04kQgmFTx4kYT6Ovif5rakiq9WUZVSj1b4hN3NVwIfUyx06L
         FBwN02uWJyxBk9cyCdP+tCEb2g5e4pkkTn4iOMt9gz1eSPbh4lR7jFlSbGIJDvfrKvnA
         aU+kIQNOAUdhgTeOAgALKioBYID3To9bFyHOokAHdgoOXDicO1XTbIguAJKMD8kB51Uc
         QhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNkBMw2u1yILWDM7CuhW/nfZuJTNS5zs40EvNatU7ok=;
        b=gdDlckkkdQnqOwq0qAKa/kg8feRLkGQyTBIgueZTDTjN7b3d+xHSTdXVQU8oy/cGWD
         Nm3bZYwbH8Y+jgRpMTZO3B8zjrQyR9jQ97RVlInzI67dICRxh0Hh8OhK1GEXUAzSBF37
         1ev/l4iWuhShD/hLqPZ/hJz/17tug99rxGtmyLn6n+px6TV4Prk8uC2qXPtVR0Rlr/em
         Yl2fsh0RXE5mZfQdtZT6k2eZs00t73xtHdi28qfHaYaQ4bnnP0N5In1XKRXXhcF/fHbY
         Q6uIWXnQZ94oIyK6/xzYXToM9/N/JtY8mRAQNgI4ZLhpb4pRmsY6PXiXL+0i3Dqypdp9
         HSnA==
X-Gm-Message-State: ACrzQf1VQG1IifUF8/iAMkfaxD7+Kc7Mo3jmCoP2QiT371HSJP9VeFw+
        PEKqkf9eGmsxhKoEfkLyc4M=
X-Google-Smtp-Source: AMsMyM7VISx7ZxFCdd8I+9TGrTbBGmNsNjUhJMqjl0AYoiiDQsvRA9tjZs4KunPw3x6ERNmyKlP2Iw==
X-Received: by 2002:a17:903:11c8:b0:179:de93:bd7e with SMTP id q8-20020a17090311c800b00179de93bd7emr22941358plh.95.1664812559650;
        Mon, 03 Oct 2022 08:55:59 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id ix11-20020a170902f80b00b0016ee4b0bd60sm7360098plb.166.2022.10.03.08.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 08:55:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/36] doc txt & -h consistency: make "rerere"
 consistent
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-22.36-702eb747c0f-20220930T180415Z-avarab@gmail.com>
        <xmqqmtaf2xig.fsf@gitster.g>
        <221003.86sfk5tgrs.gmgdl@evledraar.gmail.com>
Date:   Mon, 03 Oct 2022 08:55:58 -0700
In-Reply-To: <221003.86sfk5tgrs.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 03 Oct 2022 11:00:28 +0200")
Message-ID: <xmqqczb8yk8h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Sat, Oct 01 2022, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> For "rerere" say "pathspec" consistently, and list the subcommands in
>>> the order that they're discussed in the "COMMANDS" section of the
>>> documentation.
>>
>> pathspec refers to the entire set of patterns, which consists of one
>> or more "pathspec element"s, so there is no need for "..." there.
>
> Maybe I'm misreading this, but are you suggesting that whenever
> "<pathspec>" appears in the text the user should understand it as
> "<pathspec>...", i.e. as is the case with the special-case that is
> "<options>".

Not really.  A <pathspec> is a set of <pathspec element>s, so
writing "<pathspec-element>..." and "<pathspec>" are equivalent.

> I'm not opposet do that, but I really wish we could avoid further
> special-cases, there's no current user of "<pathspecs>" (with an "s" for
> plural.

Presumably just like range-diff compares two ranges (which in the
normal command line syntax we would not have), some future commands
may need to take two pathspecs (that is two sets of patterns to
match paths) to do something interesting, but I do not think of
anything that does so in the current command set, so it is very good
that nobody claims to take <pathspecs> with an "s"for plural.

> 	Documentation/git-clone.txt:--recurse-submodules[=<pathspec>]::
>
> Should be read as supporting:
>
> 	--recurse-submodules some/path some-other-path

Yup, the option should support it, alternatively it could take
<path>.  Or it could take multiple of these options in which case
each of them is taking a pathspec element.
