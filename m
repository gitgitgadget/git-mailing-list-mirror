Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423AC433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 09:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiDNJlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241861AbiDNJlU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 05:41:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795470CFE
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 02:38:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so5604687edw.6
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 02:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rNr7pmafAGNmbta21cWSnW/PtsEFtz1ZaEXCuuL6N20=;
        b=Sf4Xw/cVJX2ipAoABre1Z/R54salNa9gK+IAQsMzoxf5N3fa+CTzatIzAuuf9OAi39
         x1lZYOGcVrPV6wW/TylRAQ4vmltRTIeZTG1cDQ804QPKBL9uppKaeuNfInqPCpOmXFCL
         EyMCkr+6DB96c7yLyINuy7CsGiciWM0byDDgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rNr7pmafAGNmbta21cWSnW/PtsEFtz1ZaEXCuuL6N20=;
        b=u1v7h1kGvMNq1V8+hS2f6qHnJkqXr5XHZ2XhVlzCun2D2W8zkc0I5HUVVh8M1ypXjI
         4uKBCC+E+EDlIUAcMuzeiFodDqJwdMTTqskGb+W01flv/DKp8I3FeOQsXkp1bU39y2hP
         TcCKJdOtn0s81jGZPpIfa2aEz/vET+SvpU8UV1B4ZLkyWQnHaV3CQvUpOfReR9N1Xgyf
         dDrC+kC5w6Kq7v55/34nQYMOaua+yrti6fkrWBv5/eJaY9WSdTSzVADGhfivUe1T+EHf
         cSoSaVae+GP3gK2eVWNMqNiYGobVtKm/dPLUIvQygYr33eKBsUq5h7AgLMJj8AvSbErP
         45TQ==
X-Gm-Message-State: AOAM5318BKQXjA3Dt2iyv8+0C0RD3caZHK76oJEVhX//qPSa9sKr9qjM
        4kh69S4ZCQNhdCUOnvT5BuGnmTj01qocTV3CM+3fRVebK9EypGQE
X-Google-Smtp-Source: ABdhPJyF7qH5z3aC2NRGVTpKVlybWz+GH61c1p/Exb1HN3JKxTbcUp3rhnmpK6R6eJYVcnO1UA+jqhqHwTIEKu5hMRo=
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr1993743edt.416.1649929133567; Thu, 14
 Apr 2022 02:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com> <220413.86zgkpf5g7.gmgdl@evledraar.gmail.com>
 <CAPMMpoj3xZfKnH456AbiHatbBx98yXuj=yWBA8tdHhHdqn_H3Q@mail.gmail.com> <220413.86sfqgerf7.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.86sfqgerf7.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 14 Apr 2022 11:38:42 +0200
Message-ID: <CAPMMpojSp0kdAC7JD10kv+rODKV3eYdt0W1cNva3tzF3sLru+A@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] git-p4: improve encoding handling to support
 inconsistent encodings
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 9:04 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> AFAICT we only allow selecting between encodings, not "no idea what this
> is, but here's some raw sequence of bytes", except by omitting the
> header.
>

I don't understand what you mean here. My reading of the docs is that
omitting the header *does not* imply "no idea what this is" - it
implies "this is utf-8".

Git will do the best it can (convert to utf-8 at output time if the
bytes are parseable in the specified or implied encoding, and return
the raw bytes otherwise), *regardless* of whether an encoding is
explicitly specified or utf-8 is implied.

> It seems to me that between legacy/strict/fallback there's a 4th setting
> missing here. I.e. a "try-encoding". One where if your data is valid
> utf8 (or cp1252 if we want to get fancy and combine it with "fallback")
> you get an encoding header, but having tried that we'll just write
> whatever raw data we found, but *not* munge it.

For utf-8 specifically, the "legacy" strategy achieves this effect
with less overhead: It copies the bytes over raw, and in git the
implied encoding is utf-8. So if the bytes were utf-8 in the first
place, then they're good (we didn't need to munge them in any way),
and if they weren't utf-8 we copied them over anyway, which is the
"tried and failed" behavior you propose also.

For cp1252 or another encoding, the behavior you propose is an
enhancement/modification of the current "fallback" behavior, I guess:
Currently if the fallback encoding doesn't wash, any remaining "bad
bytes" get replaced out of existence. This leads to data loss of those
individual bytes, and it also means that if the data really wasn't
cp1252 in the first place, you might just have garbled up the data
something awful. Of course, you might have done that without any
errors anyway - cp1252 only leaves 4 unmapped bytes, so most arbitrary
text data will be successfully "interpreted", no matter how
erroneously.

The advantage of the current "replace" behavior is that you *always*
end up with valid utf-8 data in your commit text. The disadvantage is
that you can suffer (minor) unrecoverable data loss.

I think your proposal is that (optionally?) the fallback-or-raw
behavior would simply spit out / leave the original bytes in this
situation, not making any attempt to interpret them or convert them to
utf-8, but simply bring them to git as-is. This would make that
particular commit message "invalidly encoded", in the sense that any
git client or git-caller would need to "do what it can" with that
sequence of bytes.

This tradeoff between avoidance of data loss, and type/encoding
coherence, is not one I'm comfortable deciding on. I would ideally
prefer a third route, where the data *is* interpreted and converted,
but in a fully reversible way.

What would you think of a scheme where, *if* the fallback encoding
fails to decode successfully, we simply take all x80+ bytes and escape
them to a form like "\x8c", so a commit message might end up like
"solve the problem with the japanese character: \8f\c4."? Would this
way of preserving the bytes, without breaking out of having a known
(utf-8) encoding in the git commits, make sense to you? We could even
add a suffix to the message like "[original data contained bytes that
could not be mapped in targeted encoding cp1252; bytes at or over x80
were escaped as \xNN, and backslashes were escaped as \\ to avoid
ambiguity]", or something less horrendously verbose :)

>
> I haven't worked with p4, but having done some legacy SCM imports it was
> nice to be able to map data 1=3D1 to git in those "odd encoding" cases, o=
r
> even cases where there was raw binary in a commit message or whatever...
>

My problem here, again, is that these "badly encoded commit messages"
endure forever in your commit history: any tool that wants to parse
your history will have to deal with them, skirt around them, etc. That
just seems like bad discipline. If the intent is to ensure that you
*can* reconstruct those bytes if/when you need to, we should find a
way to store them safely, in a way that won't randomly trip others up.

> Anyway, all of this is fine with me as-is, I just had a drive-by
> question after some admittedly not very careful reading, sorry.

Thanks for looking into it!
