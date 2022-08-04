Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36329C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiHDU0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiHDU0U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 16:26:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5421263F
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 13:26:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gk3so1303150ejb.8
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=GMLy9USws/Iek4D4N8GWOo8JNxqjIrbVrrSrMxJB4OE=;
        b=Aag1+QqdJhKp1AKMQuDVKeeYk2koO3djv1Zl0IxxqGqT49wqiweE2TFu4SzSczPVZ4
         a1GbTABf5zykN8CqpYRWoF9IsfMjJXxON3DixCHELWfdGl/WULig2Tb57Rl5ee4VihNf
         WtXJZ1NjWc6j81467NzMThjC4xdPfBL9X22Wxvy1NwPzgIQ45WMC2DZG1NL5hk5ujuwT
         4Kjl7emK+aEfcE85kPayOEzG5Qk5AO4RNTmc38ugGElT1Cp3ZQmVCQAenHl8G7dWTuJp
         wxYvEIS2Uvbcn7sQ4njKSbOrZoccU5AnyMQK42iq0phWU0et2ct+IGnFr+CQgenRyEvk
         Q3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=GMLy9USws/Iek4D4N8GWOo8JNxqjIrbVrrSrMxJB4OE=;
        b=aYBQPQLa7+OoUyKAYaSoUJs2FRVNAtfjj/aXFW+jIWVo9R7o6IOYqS3GIl/QIZz5j8
         X+Emvu9M7yZkHk6pU2R4ywwAseOVspL1xomYqomtj1VWG5/qzWAv4sqa61g60QkrOw82
         SC8wjVLPx8Zlxg0gtNGc25oeiGBTtn7YARXCMk11mdpu0zxns/VX4FHzqMwO/r3pQSvV
         YiRGWh1hpaNolEBjClPvMe8mSh10zDOmN1HOon6hdzmafE4V2/vUJo5j+gdyxxQGem0k
         1T9l0CFpDMnJfi4tLpnOXw30NnFgFuPpRPXd9jDJOtSen2sNMfUH4jSF96T7vgBIUWoR
         qrXA==
X-Gm-Message-State: ACgBeo3dvzvhqQAfmiT/HikRkPSu0dnw3zjJ3qpuumXHiNK/jOjHB9GS
        Y/sCYnC9lK0POWZ9S9guBD0=
X-Google-Smtp-Source: AA6agR53TTINThwQRLsg27tda/F2vOeDriQKCfhmbR8LmyC1LhDhLwBaLdiUDGY7PEO6gdY9Pysmag==
X-Received: by 2002:a17:907:b0d:b0:730:aa17:a0b7 with SMTP id h13-20020a1709070b0d00b00730aa17a0b7mr2677454ejl.661.1659644778421;
        Thu, 04 Aug 2022 13:26:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id f1-20020a50fe01000000b0043d5ead65a6sm1087395edt.84.2022.08.04.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 13:26:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oJhQ8-0004VQ-2S;
        Thu, 04 Aug 2022 22:26:16 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 03/10] scalar-diagnose: add directory to archiver
 more gently
Date:   Thu, 04 Aug 2022 22:12:56 +0200
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
 <220804.868ro4fryg.gmgdl@evledraar.gmail.com> <xmqq35ec6igq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35ec6igq.fsf@gitster.g>
Message-ID: <220804.8635ebu55j.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 04 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> +	dir =3D opendir(at_root ? "." : path);
>>> +	if (!dir) {
>>> +		if (errno =3D=3D ENOENT) {
>>
>> Per [1]
>
> "Per [1]" somehow sounds more like a reference to an authoritative
> source, at least to me.  Every time you use it, I have to see what
> it refers to, and after realizing that you used it as a replacement
> of "I said it already in [1]" again, it leaves a funny feeling.

"Per" in the sense of "Per what I noted in [1]".

>> I think this is incorrect or overly strict. Let's not spew
>> warnings if the user "rm -rf .git/hooks" or whatever.
>
> The above is doing the right thing even in that situation, doesn't
> it?  If there is no ".git/hooks" that is fine.  We get ENOENT, give
> a warning to indicate that we found an unusual situation, and return
> without failing.  If we got something other than ENOENT, we fail with
> error_errno(), because opendir() failed for a reason other than "No
> such file or directory".

I'm mainly noting that the point of this step is to produce an archive
for the consumption of the remote end.

Therefore it seems to me like it would me much more useful to note these
"oddities" in some log that we're about to zip up, rather than issue a
warning().

The "per [1]" was a reference to the (paraphrasing) "maybe that's not
needed at all", but you seemed to think so. But for the purposes of the
discussion here let's assume we keep it.

>> You already have an errno, so using *_errno() will add the standard
>> information about what the issue is.
>
> Reading the code aloud, slowly, may help.  When errno says ENOENT,
> we know opendir() failed because of "No such file or directory",
> so "path" was missing.  So let's say 'not archiving a missing directory'".
>
> ENOENT or "No such file or directory" is an implementation detail
> that does not help the end user.
>
> The other side, i.e. when the errno is *not* ENOENT, already uses
> error_errno().
>
> So, I am puzzled.

I'm pointing out that we don't need to include that part in the message,
because warning_errno() will already give us that for free. I.e.:

	warning: could not archive directory '<some dir>': No such file or directo=
ry

v.s.:

	warning: could not archive missing directory '<some dir>'

The advantages of doing so being:

 * It's clear (at least to the keen eye) that it's using the "errno
   format", so you know it's not just saying "could not for <whatever
   reason>", it specifically got ENOENT.

 * The i18n for the strerror() comes from the C library, which will be
   translated already, whereas a new git.pot message won't be (but we'll
   hopefully bridge the gap eventually).

 * This way we we can share the message, whatever the errno happens to
   be, so we could e.g.:

      errno =3D ENOENT;
      warning_errno(_("could not archive directory '%s'"), "<some dir>");
      errno =3D ENOMEM;
      error_errno(_("could not archive directory '%s'"), "<some dir>");

   Whereas putting the reason for why we couldn't (which just duplicates
   the errno) in the message forces the messages & i18n to diverge.
