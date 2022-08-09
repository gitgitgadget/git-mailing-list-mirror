Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A66C19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 21:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiHIVgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 17:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiHIVgn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 17:36:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511626566C
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660080992;
        bh=U6vIVBRsQrZGzPbpdgm6YT+WGSoHI3m3L7NKSL8pyyw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WFD/jXr1xe3qtuiraKJjaN9THF6FPLRlpqzUBjIuXG3RjCmw2FGiyRtaFdWKdrkpm
         bAvQGmx57vipLwS/VphFrV5njIAqG/WTLDzyIB7ifDGGW52CA95cv1TYHFAKVhLVBb
         au4RClRqaPO2ITD4yqwObrJm7wBeVH8U3lItKgQg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.31.241.252] ([89.1.214.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1nfde33nrc-00kPTg; Tue, 09
 Aug 2022 23:36:31 +0200
Date:   Tue, 9 Aug 2022 23:36:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v8 05/14] merge-index: add a new way to invoke
 `git-merge-one-file'
In-Reply-To: <20220809185429.20098-6-alban.gruin@gmail.com>
Message-ID: <o759r3qn-nqn9-oq22-p90o-2nrn24085n80@tzk.qr>
References: <20210317204939.17890-1-alban.gruin@gmail.com> <20220809185429.20098-1-alban.gruin@gmail.com> <20220809185429.20098-6-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e2pYH1EcQKy+6ZIA3jtUOB3FpAMj3ft2ESyN6RbDQXhIHOM6rId
 DuOVpGR6IsBETF0HUtBH9uUS4TODR9w/JVyJQ7Pzip8AzGc7yZ0ojbRwNkkwhqyk0TxU6e2
 ElOw3Gn+JiIVNWviXgEBdRlKGN8BwGPn5xrjXHOa5WIkAecihUS5FTB8Z+sy9GqacbU7EXS
 YhpsL2ScWKY53EE1z86zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HHlR7qPKIl4=:bqlK8vHARZ3Sd3icVWUAGd
 mTu92cl4UReX8G8u6b3FICqtBiTWCm0+dOQs+BXmcc6Gmd5RAjOD3BGCjtfAuDsuHgTCd4BYz
 fOHtal7mi2ym04GZhRMmqY5G21Hn76HWwsGw3oGsF6W7H/YcHp2nRy/L3B4MGft/3GFvXxGXw
 LNPa3AYSmZhQdhX3V6qGsVwfDyCRPwhHZoCrAknJuDvnZiSSFEqyV2VsKMT0pyhKqIJYrey8c
 ch2ukfvE+1WEa3BFWYH/IV2Ud6zasapqg7hBwcbLWGPxE8oBNZOEgenxZPdhYIrMbKU+tRQWY
 AIVrtDeXFqxlIG2iTyDqnP0zsUkX3HwPfTYEV7A/lK8eJO4TP2FJeFHNz6x3/GGVi4+9fVSWe
 tgHfjwp+AInHdsV8a4d8pS8NPQNEk7M/VT3P/cAuF//p5qEC2eg2AV6D/roHVZ0bouRdqJUbQ
 6bwM7FHonlyZeaEJDxWMuKbTOl0V14aCJ4ZLDQ1Gul7IJs+OVidIHUD4zCSNjgEDHuYy5qXnh
 /c8aMj89fwAtv9a2ap4rQeah7AA8x+F7jbipNuSVPQN04AZhl+YNOojTVEgwTVRBa31cIiWxu
 VwX0IcsXo8aO81UVnu9ILtdlTk8hxnw/GuXV9J9yzYNCaYtB5Ss9mohOwrGCWBVxnBn7Naq+1
 jtphYdxCjpFpzTu5qrRddxvjVxx/pHxKRcJZ5BScbax/jWtcxmi/dwcHJe56c/avCKIq5apE+
 pYi1nZX+h14Zvgx27F/gu6XoklAtNXZeDgnS0PvdHSB6nzSyOKuAF4eWh2mF+gYPkK+X9iE+a
 o+L1xZDpU195pyw5mPsa+wolNJi2EEIdSaoclDqqovnAyc7DCImuvwzv2Zm2jgiU5nj4BR4A+
 LxN9mEbUfcAVhZZkijOYOhp02aVjrT39mk1CmwxGa5+rnQm97btZgIofPeVIHkmKDmrsN708S
 UOGb7Z7IPI8UgHCbsFmLv5eAf0GTLH5OWFD3zPbq6D530SmgJQq/9GAo8pEQG8uRUgp7yRYC7
 msTUdm3rRJFnR/iISekLiPvUZq2mAM9cRQRUd1rLyShW4BJi1WUxHBmmYjoqzbzkTL9eQ9Ni4
 t8cfWXpv73Ce6Jsg40ICwxFtGQXdxUTMtSyw9Gz9BqeRPbj98PQPMDZpA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Tue, 9 Aug 2022, Alban Gruin wrote:

> Since `git-merge-one-file' will be rewritten and libified, there may be
> cases where there is no executable named this way (ie. when git is
> compiled with `SKIP_DASHED_BUILT_INS' enabled).  This adds a new way to
> invoke this particular program even if it does not exist, by passing
> `--use=3Dmerge-one-file' to merge-index.  For now, it still forks.

I read up about Stolee's and Phillip's suggestion, and about Junio chiming
in, but I have to point out that all the objections against special-casing
`!strcmp(pgm, "git-merge-one-file`") share one fundamental flaw: they fail
to acknowledge that we will _have_ to special-case this value once we turn
`merge-one-file` into a built-in.

And the reason is: there might be scripts out there that expect `git
merge-index git-merge-one-file [...]` to continue to work even when
building Git with `SKIP_DASHED_BUILT_INS`.

In light of that, I would like to point out that we really _must_ revert
to `if (!strcmp(pgm, "git-merge-one-file"))`, ie. to what v6 did (see
https://lore.kernel.org/git/20201124115315.13311-7-alban.gruin@gmail.com/)=
.

And since we must do that anyway, I do not see any need for the `--use`
option at all, it just complicates the usage and does not really provide
any benefit that I can see.

On the upside: skipping the `--use` option will dramatically simplify this
patch.

Sorry for not catching this earlier.

> diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge=
-index.txt
> [...]
> @@ -44,8 +44,9 @@ code.
>  Typically this is run with a script calling Git's imitation of
>  the 'merge' command from the RCS package.
>
> -A sample script called 'git merge-one-file' is included in the
> -distribution.
> +A sample script called 'git merge-one-file' used to be included in the
> +distribution. This program must now be called with
> +'--use=3Dmerge-one-file'.

It probably makes more sense to just drop this paragraph because we will
no longer provide that sample script.

Thanks,
Dscho
