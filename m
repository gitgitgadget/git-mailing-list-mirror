Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3634C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89416101A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 14:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhCaOmJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 10:42:09 -0400
Received: from mout.gmx.net ([212.227.15.18]:57889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235968AbhCaOlx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 10:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617201711;
        bh=pu0QXpfHGM/LWRE/am7Zbvbroj4by4XQPSxJ25JYXR4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WePF8YDSSnLQqUcjzJb1E0gZUDRu2a6sWF6d7Dfba+vqAKijFfNqS6KP+A1+cW3BI
         69WxQTJEO9J4PtCbL5VlPTkpXWDvpcIyg/2LnGBmrzg2eCqMUy7QMn3kRRR1QpQbuW
         zbf8L92Pl3/ULsaukqRZ6wPt7wkldnPa0t1a1XFs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.22.127.121] ([213.196.212.198]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bk4-1lgRG51HBO-0183hB; Wed, 31
 Mar 2021 16:41:51 +0200
Date:   Wed, 31 Mar 2021 16:38:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3] sequencer: fix edit handling for cherry-pick and
 revert messages
In-Reply-To: <pull.988.v3.git.git.1617173541301.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103311638280.52@tvgsbejvaqbjf.bet>
References: <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com> <pull.988.v3.git.git.1617173541301.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wr/WUWuPnG/aV1X9ZmNHMvLbmLCkNa6EQbsWh0gRX1eyaZ1/r0D
 ls+K9s/vxjU8yEpB0dKNEsuEyP/0qMfhzS2327I3cfdoKDz5dpMZio9ZjDjWxT91ys2cfkp
 9zuqkNoVMw6M1HvOxJsBoN1LYhFU6FTbdWDuN/uk6k+GewaUTDWR4wiXGWkHBBP6Pgyx+86
 k/9lI1m/qQDdtOZZjjWpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x1b+iKH1gls=:twi6w/QGcYNFoMW2SvR308
 Rl/JYZvUGNaEjWiK9XEVcXgRr0WtFaJfol3eBFTRVvKaBkL7oZyMGkXKETSWvkUJkItOiJKb0
 Hji6nLNQ7yfn+wXlNoAAqB9LmlOC3CnVWf97PE4T5T1G/W3xDl00MDOczSj72LBDNZ7GNUELQ
 hPduPihfQumLfHEEMeH1c9MXzxcF86hP9Q3m2a99Q1VejMATS+dASnG47iagzGXcXxrblZcY7
 m/GitpGp65Zoj3bCuSnQ8riY8u8jYw7kk5soIlc0wPgGdhQfJ4h7MGX+S0Jn0ULk1ORSt/NyJ
 0r+W60nlB1BzGrRErWoSLOUiNkZvbaqQxGe6Fu6UfKPQ9yQJFzVKvddj6Zh0A00xL1prJM8TF
 aHZGHE3/Bh8oWKNBq6azve77eGTajJ5JvA7Gv0KUBSr/O45My/LtSEQvX7sHWaFyWTbCnIr9l
 4ndsndMgCLu62aIS1Z5mUmGIKK4pyfcW1x1MQ61gGrnl9j9y+t/rR2NWxlzrBzWqfl3VDNOUN
 LTUDJuHx2Mt8vyS5JQNqT0Yp1qJ8CQFxHFlGDS0BkjX4uyQYj3ppbxWGyAoBCX6GhK88SWqH1
 U7B3+zCGmhjxFssadK2np29fkV3gXaUqYntEgOCQpCuBAm2fB9jMX7LGSTo2FNbWDEU5mMuM4
 gW1lO4f8tf+n+R5E2FpPcdST4vL5oIk4eS10t/aMVjOy8Q1sPjF/xM+ME5GpVlgIbHIazjn1V
 Wx9845TaNd5ngqewd5Al45GsyESjXZXKT/MagSrolzwHtXF+z3qQ9fluRrdHGa14alL9J0x6u
 Sw3WlS7F3IJkkzAmRAvfBQw2jBfkHphs0hPNeoW5aiuaU8WEhBgz3kKnobJkPhb8G9Z4/7wLA
 WQ4KDyYyQB1OKmfzBEIwv9GguQg2yEbUE1eNnDNHO/Hp52QIcvMQRo8MgEm8rNiyiI6d3v3oc
 GzlhZo0gq74c5Tjf7VaZHR5jF9ldif+yNRHyAhvk21IJtnJjZ+h7pNM4+lTqTn91IFcAeyrBA
 0tYCv1rlh+xHVE4NsJTbr5YeFWmdSDJRRRapFk1dwi12sR8h/N7PPtMYS1mhC58+llMIS51nr
 W0VitJqrB0DGN8gxfOvbeL3+hhZswzHeuczqlNRAPjGNuLZRa7kPTY0NKXLJGDx78Kc1OaAwh
 j0MoZvcTXU9WU6JJjz+GfVCFXbDUFw4e8vCjJ/4flr4ZBvBzu5RKfRQSSu+CSp+8Qm665SbjX
 DF3hlwhA1IqDaMayD
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 31 Mar 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> save_opts() should save any non-default values.  It was intended to do
> this, but since most options in struct replay_opts default to 0, it only
> saved non-zero values.  Unfortunately, this does not always work for
> options.edit.  Roughly speaking, options.edit had a default value of 0
> for cherry-pick but a default value of 1 for revert.  Make save_opts()
> record a value whenever it differs from the default.
>
> options.edit was also overly simplistic; we had more than two cases.
> The behavior that previously existed was as follows:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit (ignore isatty(0))
>     cherry-pick        No edit                 See above
>     Specify --edit     Edit (ignore isatty(0)) See above
>     Specify --no-edit  (*)                     See above
>
>     (*) Before stopping for conflicts, No edit is the behavior.  After
>         stopping for conflicts, the --no-edit flag is not saved so see
>         the first two rows.
>
> However, the expected behavior is:
>
>                        Non-conflict commits    Right after Conflict
>     revert             Edit iff isatty(0)      Edit iff isatty(0)
>     cherry-pick        No edit                 Edit iff isatty(0)
>     Specify --edit     Edit (ignore isatty(0)) Edit (ignore isatty(0))
>     Specify --no-edit  No edit                 No edit
>
> In order to get the expected behavior, we need to change options.edit
> to a tri-state: unspecified, false, or true.  When specified, we follow
> what it says.  When unspecified, we need to check whether the current
> commit being created is resolving a conflict as well as consulting
> options.action and isatty(0).  While at it, add a should_edit() utility
> function that compresses options.edit down to a boolean based on the
> additional information for the non-conflict case.
>
> continue_single_pick() is the function responsible for resuming after
> conflict cases, regardless of whether there is one commit being picked
> or many.  Make this function stop assuming edit behavior in all cases,
> so that it can correctly handle !isatty(0) and specific requests to not
> edit the commit message.
>
> Reported-by: Renato Botelho <garga@freebsd.org>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     sequencer: fix edit handling for cherry-pick and revert messages
>
>     Changes since v2:
>
>      * Changed to use <0 for unspecified (instead of =3D=3D -1), >0 for =
true
>        (instead of =3D=3D 1).
>      * Removed assert() statement.
>      * Removed unnecessary "want_edit" local variable
>
>     Reported-by: Renato Botelho garga@freebsd.org Signed-off-by: Elijah
>     Newren newren@gmail.com

Looks good, thank you!

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thanks,
Dscho
