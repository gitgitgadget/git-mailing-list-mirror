Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D66ECAAD2
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 12:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiH2MbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiH2Mae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 08:30:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BA3CE03
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661775230;
        bh=f9hvsZrw38dQOkDR2k6Zldttkzm3/82sqBvH7nQ++BI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gc3x2p7e6TXKu8GPZiL9TrcrO7c0anX2lF1MGRDIftQ4J7kaTY75P8aqN54wjw5Ci
         5CTb73A1xTIOEYcztq7S61iguFFjJW6Svq8mNGhvqlsISYhwNdhDZMAm7P6pF09NQ5
         N6Ibj9DFNdDr+pn4SWYv700euQIpxOXbXtnABzMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCbB-1oxlHA37tR-00VCnG; Mon, 29
 Aug 2022 14:13:49 +0200
Date:   Mon, 29 Aug 2022 14:13:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v5 05/16] bisect--helper: make `terms` an explicit
 singleton
In-Reply-To: <xmqqk06svoxp.fsf@gitster.g>
Message-ID: <662758rn-942n-1n3s-25r9-o7qn071s0567@tzk.qr>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>        <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com> <xmqqk06svoxp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yScYt1sNwz15GKRbMeIN1i5evxJ0J75Vz5mnzu0PuOTXRppwT5V
 cyFxUwZ78tHLefrNwzmwtxHwMTUhsxtbRZjEF/3gSutcGbTbm6h+DJJ7jRjS9FKZ6jHbkRq
 syIeeUFsOdgqmoIZiJxIt8tnLYn2NqTA8EfDeNP4aiS+1Dmeat274HfzBDUznPO0aot+gKX
 IrhBGUq+Ak2pW7WTMzSDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4qLFsqGwHSw=:msnRvc9RYqE1lhsXUNuBYk
 t7pJUQD3YfvQ5bGsHhs+sh/F3mFZ637N7BlSQUbjZhB286ZyzRJgb4z2K1sHzqE7MdVYHhJYQ
 g6cSSXmYzXMDs3AhZhRpN6sZB4csjNmK6M97Z+hthM26KuYivE79h/paf4ki4FRgwH7JAk3/r
 uiD86Te5EN5yvH1vQE3SxSPIodKVj3RkMjBJgKQT1hSMovAebHuhGobqUgLOfVcxbXkXyY3yo
 XbVBShvHx3GjSr46aGR4jcimUhJs0tJqmgK785Zvi5J23yLK7QEwEvPbkYHNp3mr2px+UGyAJ
 3g0/LqnMxZGTAYH/63YxoQAA/dR6OV9Z2Dn8F4MUvokqJJBl9ufbfxsCVhiTz1Ce4UwLm8wjo
 QkNxPKqDDzb4RahQLTAMVNzVbhmSDaGBri5DwPhdkGYKCuBBMCB56UeavSXTOJWJj5ByiRcvH
 Rw73OSt4woE3JR/X+hF4NZ0vMk058d8woLXuku6iVUlD1Bk4H6myI57o1O5Tr6F3hdRCz4Kjc
 IliUq8u5wj+3SBGHfCcpIS4oXE+eolZW1toYSupA7hsXVGJ1r/ZwHtZ6Z/CbzkLd8GnZns729
 r/dGD5QljOo7d5RuwC11DhWNbuG0IaZ3Sh2RQ5W5qf1DJu0ARc+lqRGU/aO7ykgFxx70yr0FD
 ZvuUlekBnS0JDvMUlvQVaQI5ap0O0b3mLWRAvLgEDrjRZbsvmXKbZrnPiWUE2ZiYxgIbeE7OK
 AfiqXA71SCerCDeHXkUh5+sIaJg3Nmj7VzTxQkQzapbZCPTbmfdrc2NDqRo679QS8sZnDUVrw
 v9bRzby/65aHddkpZLncZ0wZnqeSLXg7S6LO+vrk7cC7aeQuJfX6qpoeb0vmXtlVUiRi15xmR
 XofzStPcia25eJfhHtn6VV/uTEy2PlXvtagKKZNBwOkn7iBvqwzVTa7Q4FWw3HH2/ONFE9jR/
 19GflCNcFUosAQUADFZSeA9KCuVejkDeoDfVgA1HPOVCdHbeYdNrvzzQs6wWdIe2ZClaIp8k4
 HlVJ22bwNlB44X9Tn+PZO77y8NxYbws7CB9qCkAESabUT3C2yBMPjYzqIWWIWtvWYa5U8OEcu
 QLYDKe32z1FtlVuonbhnz7oBPX+3Mh2qJbjxkyHJp5sh1La+4dYuM70VA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 27 Aug 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > -struct bisect_terms {
> > +static struct bisect_terms {
> >  	char *term_good;
> >  	char *term_bad;
> > -};
> > +} terms;
>
> On the surface, more global state may feel sad, but I do not think
> we want to run multiple bisection in one session anyway.  Overall
> this may result in a simplicity win, hopefully.
>
> The patch is noisy, but mostly from rewriting "terms->member" to
> "terms.member".  I am not sure if that was worth the effort, though.
> You had a code that plumbed a parameter through the call graph, and
> instead of destroying that arrangement, you could have just replaced
> the reference at the beginning of the call chain to use the global
> state instead of an on-stack variable that the caller used to have.
>
> I have no strong preference, but I do not think that it particularly
> contributes to "clarifying that we are using global state" to make
> direct accesses to the variable everywhere.  I dunno.

I do have a strong preference to avoid mixing and matching global
variables with functions that pretend not to use said global variables, as
it is too easy to forget to pass through the corresponding parameter to a
function at a lower layer when that function accesses the global variable
anyway.

Ciao,
Dscho
