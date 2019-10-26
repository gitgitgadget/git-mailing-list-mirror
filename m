Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 403C51F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfJZV5C (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 17:57:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:45217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbfJZV5C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 17:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572127010;
        bh=ZxXWYou5DLvImIztn7SOiWrVdDbC7izvApCboV5EuW0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EXo0MmC6hH7gHl1SbWqc+CIM46+cjf71gqvHdhB2YSbZOiMg8/nbWDTR85Lu/d5NR
         uMr9bQiV3PJRlxM1xLxXNPpjR3TDAbcRRSSUaboSqHYC2vXHU8Kr4j51mazN3v6uMA
         isTeac8QVvkARxPzcnqbQ1R44SC/QhtEkvVNW/cQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1iCisR0VW1-00GsJ3; Sat, 26
 Oct 2019 23:56:50 +0200
Date:   Sat, 26 Oct 2019 23:56:21 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
In-Reply-To: <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1910262351340.46@tvgsbejvaqbjf.bet>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com> <pull.407.v2.git.1571755538.gitgitgadget@gmail.com> <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com> <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet> <20191025221118.GA29213@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1910262040360.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j9yfAxdMmOzI+j+GIiaNktOC5NnvvUJiamQTzLUSAlUUUzo1GiS
 7wOVVWVbZEFKxEIkiR51JXoWyT9sP8shysFXS0ST6oRueTVRNWZJP6iQXPFm0YQDOqkiMa0
 r+tHkZC1c7psqzakje4maLtX0SIWT9AnrwkKNlfvYabz2d7PuHkAjiuS0S04mxlfwqt3EJX
 1PwwSvl7k7TDoXg85FrJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZwK+TgSPfkA=:MzjjvI3xAN0979K4KRmzbL
 gjn86LTuCWQnAN3wXhy3JhCvQj3tjzzQzi7WtlHrH61bFXI7cUNUfHSsXXnuTw6uVaL+BSdsJ
 ECll9OW3drnRWDDpfGWuLBTqcDYzSfbY6oR8kgAiIwl9MOFdRYIYjKM1IRnazaU5gSc2CkErW
 RTVkTndm1rD9LA3R2mBlBpXdk9RzvNclFArjIhdjrbZ+M2vppuLAwyk/xkPr8DRSH23hcy8Fg
 RF9vJyfYvxbQWLVpxt2picRzzefEU4JYu0633+S6XmjKBwEnR5yVNmuhVlI5qpz1Iqp2TOhPV
 eUw5Ohe/K4t21WdpcF1o/KXaTghq/9nVuXuFNraqarQtlk8oWkTZsEKrgYyoDBTHtWseJk0rE
 X0xNda+IVlDaO4Y9YLiMsMbBku+lUvWBbzDBumESqZyCRY53TTh/ZMIk5eAMOqfwE8aPyTePh
 pzgIGsOC3cE7vVjIYfgP4XOmsKuwNqUTtmkOL0q34l0Z4IEb+PXXXB07NVdHIjUrMtbLycHue
 P3l5LR+mebaDHT078+/9GbCJ75eXkMiR4e9iFvIVyrWF7wNqdpkzzuslV4ndwh+qzbkKm7Wi/
 S/coXJeBkzYcl0o7lE0YVSPLKbSr+kruTaOgkpraYg2QFt2wM5ruGGpieS5TBy+H0L/2GZ/5O
 KC4f7dKRnAtbg3ynar39v6Al5Mr/S7lYkXSo54N2mXozw1YRBBtSEqN1io9Da0GQmNpMbfvRE
 F8Bi0AOkchIxn77hmRfCpfdOVljthIyNPL3Al9V25iGCX5/nyc4sswwbXeBsdsXOrByC4IuF/
 GpomDCNvIls5GXnH1c8mbpFtboLO3xPYB02ZPbnShhqaZNhZUbfhKMBxdyobHEibFqKKlx9K4
 LAB4BP30v82uhuCNGpavTYNY7Y/AODOs2tKRXNzLNq3dYRLShModlOtq9vLzJ053npKhmvFPG
 NIIY8TQUnFaDWBIY5LB0RbEQBgCFWzlDDBsGZsBXP4NqCxOIKa023yVykjmG3CQTeKppyc9to
 Cj9YPGOx4zfVljdIinFrMW/m4XJLVEUNUF9A5F7/PdiEHjyhVsmI+wLVKygi4NrJJBa7S066Q
 D7eNK0lk7x7ZbRDvkK6qbZ2JE6PYF8xiSkRnT+QxCd85NoeccEKd76byAekafMiYiqe1mFJ3U
 Q4WvHn9tXqxbDdV9mfOcQN+CckHc2hiIY1iuBJN44UZaE3TitcEtyV7G+PV6EcLT/4G8J86il
 4P7uJJmcsmZwOE73NwIbGTl1I9K6DMKx7Yni/IHtVMroBdPiE64GuhpXQhow=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sat, 26 Oct 2019, Johannes Schindelin wrote:

> [...] I did open a GitGitGadget PR with my proposed change,

I should have mentioned the URL:

	https://github.com/gitgitgadget/git/pull/428

FWIW, in the meantime I managed to address below-mentioned breakages
(apart from the broken pipe problem that is discussed over here:
https://public-inbox.org/git/20190828161552.GE8571@szeder.dev/) and the
build is green.

Alex asked to be given time to brush his patch up on Monday, so I am
holding off sending my version (for now...).

Ciao,
Dscho

> in the hopes that I could somehow fast-track this fix into the
> CI/PR builds over at https://github.com/gitgitgadget/git, but there are
> problems: it seems that now there is an at least occasional broken pipe
> in the same test when run on macOS.
>
> There _also_ seems to be something spooky going on in t3510.12 and .13,
> where the expected output differs from the actual output only by a
> re-ordering of the lines:
>
> -- snip --
> [...]
> +++ diff -u expect advice
> --- expect	2019-10-25 22:17:44.982884700 +0000
> +++ advice	2019-10-25 22:17:45.278884500 +0000
> @@ -1,3 +1,3 @@
>  error: cherry-pick is already in progress
> -hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
>  fatal: cherry-pick failed
> +hint: try "git cherry-pick (--continue | --skip | --abort | --quit)"
> -- snap --
>
> For details, see:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D19336&vi=
ew=3Dms.vss-test-web.build-test-results-tab
> and
> https://dev.azure.com/Git-for-Windows/git/_build/results?buildId=3D44549=
&view=3Dms.vss-test-web.build-test-results-tab
> (You need to click on a test case title to open the logs, then inspect
> the Attachments to get to the full trace)
>
> So much as I would love to see the flakiness of t5516 be fixed as soon
> as possible, I fear we will have to look at the underlying issue a bit
> closer: there are two processes writing to `stderr` concurrently. I
> don't know whether there would be a good way for the `stderr` of the
> `upload-pack` process to be consumed by the `fetch` process, and to be
> printed by the latter.
>
> Ciao,
> Dscho
>
