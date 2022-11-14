Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550DCC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 13:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiKNNe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 08:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiKNNeR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 08:34:17 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0592A1DA5A
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 05:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668432851; bh=3O0ZraSprFdOYnHo1YA1WAk+vjEFUWF1IxJJ0wKrCSk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=F02cLd4QX+d86SjnPpmwUEG3yoIKJkT1cRyX9RiKV9UMnhkqH9c5TzKS6JSpVp32x
         SaDAgjVdxza6Ds7OrI15uqt0xK4O/UwL4hwfyojkPVhI+paNQUYue1Gy6FQwp66g5+
         tkHf+Blymodh2djFRyVYgzt0jur67UTv5nGQeKLKm5R+6D4P1Y1Fkgo06l4qXwCZsj
         QhkM8rSleZqSg3zIMjoJcje8dA7rcKdTagRjx7P1CY6zx6XrVuurNkwt8Rlcsy1Zjd
         9kYF0C6C6AqTXTverf+2k32RC4eDQCs66Hjfw30w2fh9x8lFLzxoTK1qb7wXW5C5ko
         Lpvf4aOvyAzKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.27.84] ([213.196.213.188]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1pNcpm0VoH-00ki53; Mon, 14
 Nov 2022 14:34:11 +0100
Date:   Mon, 14 Nov 2022 14:34:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
In-Reply-To: <Y3B36HjDJhIY5jNz@nand.local>
Message-ID: <1s951161-s35o-59sr-7988-q90qr6n28n6n@tzk.qr>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com> <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com> <a7f4265ceb26c6dd9d347ef4cbef2aac7d60bf13.1668290855.git.gitgitgadget@gmail.com> <Y3B36HjDJhIY5jNz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KpMDyB6ijllg4ylfNURrst5EPPk+CKCBwW/Jgblej4t1FcNZrkp
 zxiUuT2I6R4Qhl+pOo/I2v5AvPlbK2c+a6496PkYGEK03FHh9uttO+acGORr7MmSV3HlSr8
 tMV8RmFnwpOLkrcSXSh8AbvNvXcQ8dd96M6yo+jyYoRhPua33uwyn8PwBE379xESupyM3+W
 iKmrwXhxjM73YBuxHoEaA==
UI-OutboundReport: notjunk:1;M01:P0:7HsGFxg7Ps4=;MT7Z2AUFnwXK5rAAdx7SadjvGO8
 N6PbQTZngxI05aG1IxJKVg9hNgRXMtjv1WanBKbrs6G+Iw/xDTEcWGu2NaHjDqW0yqyiHLqiM
 uLOrs13fk7Rq2HQ//JK+scPI/DEoT3bcdY5C0Z6zB9pb9/aZMHoVUHUPkqYQDQRSLk7Xjf/M/
 M9Muo/dnw9bWlgugfHwAzFctW6KGL9DtZopxoBYQ6ztYI6sJ5xYHOew9i63xaeWNfesBPnKev
 GOpFRGmL3B2b1GpMomW1ACEy7r34gYrmb2ulgD6DFwxp8YXl7oCrT+3i8IFv1o3/czT6BxrO8
 rJI7nPDRghQwYxbEvowIF4rk1binB60sY7Ijj+j8z4wFtIsiJ+LPXihAyj9u7g57BYKRiX8S4
 sZTyQ33cBrdukN4YW3hRu9tVKmd/UY1rcBK/O+9tLWNgXWrRpqlMW2DyVRZ8BM0N1/moK3a/Q
 9GTkWLLkkjX8ho5BVma1v1JI8rCgL+1kdDYfV1KmqL49L+TMPrhRkCI/l9sWRpinQVQGckzpI
 Fg+yxJIf1lV4sp7WOlBo8hQ/KhVQXUV2Kb0mac/aktiSfHy/JukmR8seZohjLKSCR7lpgGa6i
 tMDdhXkLrj+Z9EIDLecBKNJ772Hcjj9g7+E0RDaLEo+ZvNYTvQhQCe5fYD2PNWRW0fuGC2ZO9
 jK4dOcxd2sKw/9SMUIizraaRtxik9KZAEgSXs+gnoYca58m9vfU3lK2U+QBheE/jxPw8+eWx+
 W850wnPr4YOgm6vPgB4ZJivFwszCufLDh7JQDctAbVZEL17OARXfF+mNc9yGFn57Y15bPYoao
 OY7OUhtCZ2RCyAUolfoj22O3ZAQh+kOPEuaEk0+XBAR6TMcoRMEaA6Z88PYsmcQGJfoV6ijai
 +GhzBGup83Qops1zerYi+xLtPVXlSNf4Mn1wTS48LQnVKEIVO/nw74F6xnm7VFGiGsMU9DXhW
 TitdSglMEe0qokdmh7uAhTEtQUE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Sat, 12 Nov 2022, Taylor Blau wrote:

> On Sat, Nov 12, 2022 at 10:07:34PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It is more performant to run `git diff --no-index` than running the
> > `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> > Windows uses. And a lot more readable.
>
> This makes sense, and motivates the changes below.
>
> > Note: Earlier attempts at fixing this involved a test helper that avoi=
ds
> > the overhead of the diff machinery, in favor of implementing a behavio=
r
> > that is more in line with what `mingw_test_cmp` does now, but that
> > attempt saw a lot of backlash and distractions during review and was
> > therefore abandoned.
>
> But I do not think that this paragraph adds as much as we'd like to the
> historical record.

It explains why we replace a relatively simple logic with a relatively
complex one.

> What about the original approach did you have trouble pushing forward?
> Perhaps framing that as an alternative approach, along with why it
> didn't ultimately get merged would be a more useful recollection of
> previous attempts here.
>
> One thing that the commit message doesn't allude to (that is covered in
> the earlier discussion) is why it is important to pass
> `--ignore-cr-at-eol`. I think that is worth mentioning here.

I elaborated on both in the new commit message.

Ciao,
Dscho
