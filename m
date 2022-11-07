Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0444FC43217
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 23:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiKGXXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 18:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKGXXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 18:23:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB172716C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 15:23:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so72675pjh.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 15:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAZjWtVoNCCgN9CGShOipluJ7y5My1H/PbYs8HqgZ2s=;
        b=qVB+C1eWwJJtbfyGyKtm3TnRnBwJmylAPBsvWp+IHwFHTdQUtSiGnhXVpYYU4SzDum
         RsD94jY/kwJ/gT9bycgNMpDaRCBuOEnbxlUzrqMhZyhJngxysAUo7rGEaCpg4OO+6lZX
         9JmP3xHeL230yTw/7mwdWDXbRXiB/nrdn6gNd4zcKn0lJL+5conQdlh6VO21P7T6hWJc
         ARbExJrVboydtdexRBG3Dzb3Ml5hrK+250y6SOPqk38vBnem2dyQ5b4v2klwqRGUxvQ1
         G3Y+8FAGymPaqkoG6EZxM1PLZweynHSGR0gRKwMuhstq1eleayZiUN63UkJJlgOxFkJI
         a4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAZjWtVoNCCgN9CGShOipluJ7y5My1H/PbYs8HqgZ2s=;
        b=ZH8KzJan6cO9/cmGdkhVbpz4X4WshuU4bxImfpMmNJHzoS06hbeeTRSpe6pNElNYvX
         783W+tP+v/U3Wh2WMBVXodXhtQIBZvHfm4MbHuE7+dmW580+kAZ7m3FFU4tHQqCCT0Wi
         xRsBC3ya95Fr2A4uH2sg30yaErsKVy6MfNv39xgNEx938FlJuF9uaRPUOGK1pa/ZOBuw
         S6yoNEN2mhZbA5mOGZhHqj5u06B6w7tQR1t7cPY02iWtJAsFML3d/QFY9ph/BJczs19O
         aO1p4Baj2skCxJ1l7iU+m3cqwBR04kC5mX9k4m7ituH5HzLJBeN4cp53EPf3q14Ydcgs
         tJUw==
X-Gm-Message-State: ACrzQf27l1nZ+n1VuacGnqgXzsjN+AgbtFQPk9ZqOCBIVD4XWw+PTz1I
        ZP0tjWkReGQ2pRqegwyID7VTj3cSjiFh/drVeZ0=
X-Google-Smtp-Source: AMsMyM4Vazb55Wok+qlV8kriCgmtrIi+zUUWKskO0s2PxcEH+FEAfCkAdNMWpPSNjHrcXeE4Te1ePph94HYnHbwnWaQ=
X-Received: by 2002:a17:903:100c:b0:186:63a1:3b5d with SMTP id
 a12-20020a170903100c00b0018663a13b5dmr54124124plb.148.1667863391310; Mon, 07
 Nov 2022 15:23:11 -0800 (PST)
MIME-Version: 1.0
References: <e2164b04-98de-6f19-6c33-6979c1a328ff@gmail.com> <198be0ca-4768-d3ce-caf3-bce4b1bb1e49@gmail.com>
In-Reply-To: <198be0ca-4768-d3ce-caf3-bce4b1bb1e49@gmail.com>
From:   Stefan Beller <stefanbeller@gmail.com>
Date:   Mon, 7 Nov 2022 15:23:00 -0800
Message-ID: <CALbm-EagU-kDg5wDO2z1canSifq0fo+hOqf8Xz1gAzbUO4COrQ@mail.gmail.com>
Subject: Re: Potential bug in --color-words output
To:     Simeon Krastnikov <skrastnikov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     gitster@pobox.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

in my copy of git there is:

----
git % git grep --line-number --no-color  color-words

Documentation/RelNotes/1.5.4.txt:377: * "git diff --color-words"
colored context lines in a wrong color.

Documentation/RelNotes/1.6.2.txt:100:* The definition of what
constitutes a word for "git diff --color-words"

Documentation/RelNotes/1.6.5.3.txt:23: * "git diff --color-words -U0"
didn't work correctly.

Documentation/RelNotes/1.7.2.txt:64: * "git diff --word-diff=3D<mode>"
extends the existing "--color-words"

Documentation/RelNotes/1.7.2.txt:141: * "git diff --graph" works
better with "--color-words" and other options

Documentation/diff-options.txt:475:--color-words[=3D<regex>]::

contrib/completion/git-completion.bash:1718:
--no-color --color-words --no-renames --check

contrib/diff-highlight/README:9:You can use "--color-words" to
highlight only the changed portions of

diff.c:1914: * '--color-words' algorithm can be described as:

diff.c:1929: * For '--graph' to work with '--color-words', we need to
output the graph prefix

diff.c:2138:/* In "color-words" mode, show word-diff of words
accumulated in the buffer */

diff.c:5566:            OPT_CALLBACK_F(0, "color-words", options, N_("<rege=
x>"),

gitk-git/gitk:207:            "--color-words*" - "--word-diff=3Dcolor" {

t/t4034-diff-words.sh:70:               word_diff --color-words

t/t4034-diff-words.sh:100:      word_diff --color-words &&

t/t4034-diff-words.sh:180:      word_diff --color-words --unified=3D0

t/t4034-diff-words.sh:185:      word_diff --color-words=3D"[a-z]+"

t/t4034-diff-words.sh:190:      word_diff --color-words=3D"[a-z${LF}]*"

t/t4034-diff-words.sh:203:      word_diff --color-words=3D"[a-z]+"

t/t4034-diff-words.sh:208:      word_diff --color-words

t/t4034-diff-words.sh:217:      word_diff --color-words=3D"[a-z]+"

t/t4034-diff-words.sh:240:      word_diff --color-words

t/t4034-diff-words.sh:262:      word_diff --color-words

t/t4034-diff-words.sh:278:      word_diff --color-words=3D"a+"

t/t4034-diff-words.sh:294:      word_diff --color-words=3D.
----


So there are tests in t/t4034-diff-words.sh and probably around
diff.c:1914- diff.c:2138

Best,
Stefan


Am Mo., 7. Nov. 2022 um 12:43 Uhr schrieb Simeon Krastnikov
<skrastnikov@gmail.com>:
>
> Hi Junio, Phillip, and Stefan,
>
> I apologize for forwarding this to you personally, but based on the recen=
t commit history, I figured that you would be the right persons to ask abou=
t this.
>
> Sorry again, if you consider this to be spam.
>
> Best,
>
> Simeon
>
>
>
> -------- Forwarded Message --------
> Subject: Potential bug in --color-words output
> Date: Fri, 28 Oct 2022 23:08:09 +0200
> From: Simeon Krastnikov <skrastnikov@gmail.com>
> To: git@vger.kernel.org
>
>
> Hello,
>
> Given an initial file with the contents "not to be", which I then change =
to "to be", the output of 'git diff --color-words', is
>
>   notto be
>
> with the first three letters colored red. To me this seems incorrect as i=
t implies, or at least misleadingly suggests, that there was no space betwe=
en "not" and "to" in the original file. (Even though in that case the outpu=
t is actually "nottoto be" with the "notto" in red and "to" in green.)
>
> If instead I start with a file with contents "to be", which I then change=
 to "not to be", then the output is as expected:
>
>   not to be
>
> (First three letters colored green.)
>
> Am I correct in seeing this as a bug? If so, any tips on what parts of di=
ff.c to look at when starting a patch?
>
> Thanks,
>
> Simeon
>
