Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA21C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiDMPVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbiDMPVa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:21:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088113C493
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:19:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s18so4743345ejr.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NGLvo13ZeLQqSqA5IbmgghuGUD8e5bBKkWxISe/6aPE=;
        b=e2NDFoyyFUpzGXewEpLBiwlNvsGjjaMWxCUiacs6CW3o25msdMBQ/mMj/8TjMpGY5e
         Tn13BVu6HuoRwSMuq2ngNjrgmjIc+IgrzdiBrcmMYqtS/L74CdFY7FRTEQ6uqcX3cRwJ
         QL8JYcdLbu9d9An2M95zLgQQ8ybQt2yNl/6TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NGLvo13ZeLQqSqA5IbmgghuGUD8e5bBKkWxISe/6aPE=;
        b=4e1UODpjFtzCwu2OzqTRRmHRbsJVugcMIyp7/VPUPJNVMIYcLe2J1yTzP2DYWnuItW
         r6gP4WKW0i4eRFkaS2ye/avuu7yQ+aLdfBAtAHDp1CBm7a8wVpyCdwaoX/PkyBlLIbG9
         Gq46PLfoOGa3wotjKRZ2t6uVUqCIBcesdVCJjGfvwBnaFAWNDgLC+woD0wb9ZYqhm14k
         HiUt9qISAsiKqmUlOljegKgadypmElasfa+D7QsllCOmMWXStDZG13ZavRZ8sSCEky2n
         VvrBpBlZz5WatnGUwejakxBCvQlGEoNleBpsj4C0e5FtrJqQjwA84sCdScWGXXEzkFeO
         h+mw==
X-Gm-Message-State: AOAM533JabcuIgiB7ZnumJaJiMRt0azE1FJWWAaU/8C41saeu5OmgxPG
        tbc2p2tEqXCYOHcqQ2jdtQDErQS83n68tiPkrlmcXQ==
X-Google-Smtp-Source: ABdhPJx+JksSjNV7zv0V3C5APUwgZiju8ll1CMXyL1VqMfdnhDmD+hKun455EcBYvurcy7s2uwjqDtb4NbSWCdGAYAI=
X-Received: by 2002:a17:907:724c:b0:6e8:59c1:914c with SMTP id
 ds12-20020a170907724c00b006e859c1914cmr23324236ejc.172.1649863142516; Wed, 13
 Apr 2022 08:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1206.git.1649670174972.gitgitgadget@gmail.com>
 <pull.1206.v2.git.1649831069578.gitgitgadget@gmail.com> <220413.86zgkpf5g7.gmgdl@evledraar.gmail.com>
In-Reply-To: <220413.86zgkpf5g7.gmgdl@evledraar.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 13 Apr 2022 17:18:51 +0200
Message-ID: <CAPMMpoj3xZfKnH456AbiHatbBx98yXuj=yWBA8tdHhHdqn_H3Q@mail.gmail.com>
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

On Wed, Apr 13, 2022 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Wed, Apr 13 2022, Tao Klerks via GitGitGadget wrote:
>
> > Under python2, git-p4 "naively" writes the Perforce bytestream into git
> > metadata (and does not set an "encoding" header on the commits); this
> > means that any non-utf-8 byte sequences end up creating invalidly-encod=
ed
> > commit metadata in git.
>
> If it doesn't have an "encoding" header isn't any sequence of bytes OK
> with git, so how does it create invalid metadata in git?

Just because git allows you to shove any sequence of bytes into a
commit header, doesn't mean the resulting text is "valid" metadata
text for all or most purposes. The correct way to encode text in git
commit metadata is utf-8 (OR tell any readers of this data that it's
something other than utf-8 via the encoding header) - it's just that
git itself, the official client, is tolerant of bad byte sequences.
Other clients are less tolerant. "Sublime Merge", for example, will
fail to display the commit text at all in some contexts if the bytes
are not valid utf-8 (or noted as being something else).

>
> Do you mean that something on the Python side gets confused and doesn't
> correctly encode it in that case, or that it's e.g. valid UTF-8 but
> we're lacking the metadata?

In git-p4 under python2, the bytes are simply copied from the perforce
commit metadata into the git commit metadata verbatim; if those bytes
happen to be valid utf-8, then they will be interpreted as such in git
and everything is great. If that is *not* the case, eg the bytes are
actually windows cp1252 (with bytes/characters in the x8a+ range),
then "git log" for example will output the raw bytes, and anything
looking at those bytes (a terminal, or a process that called git) will
get those unexpected bytes, and need to deal accordingly. A terminal
will probably display "unprintable character" glyphs, python3 will
blow up by default, python 2 will be perfectly happy by default, etc.

I summarize this "non-utf-8 bytes in a git commit message without a
qualifying 'encoding' header" situation as "invalidly-encoded commit
metadata in git", due to the impact on downstream consumers of git
metadata. Is there a better characterization?

Thanks,
Tao
