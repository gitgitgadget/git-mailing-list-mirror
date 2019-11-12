Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22CA1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 15:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLPEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 10:04:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:35377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfKLPEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 10:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573571041;
        bh=JhIHqUnpJav0W0G0btJi4/G5jFGd2hAQ4CjoHt2+a1M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d0l1nNbhVWkSTioOLGBfqmoTVh8FlMWvV+Gq5smyH86QemTjMOGJa7sM2Nr0UEFJy
         7qQCOxIeUYSwGQW0tSgaEkM+MV5k3hz9uxx7MiroPOVdRN/2Vuz+NJaf1q0k2K5bys
         6mDK1WyAVvaZxKP9NKEKj6Ovtd0dFUJ2pDQwXD1k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1hueva44ZO-00ZzwK; Tue, 12
 Nov 2019 16:04:01 +0100
Date:   Tue, 12 Nov 2019 16:03:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/9] Start to implement a built-in version of `git
 add --interactive`
In-Reply-To: <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911121459270.46@tvgsbejvaqbjf.bet>
References: <pull.170.v4.git.gitgitgadget@gmail.com> <pull.170.v5.git.1572869729.gitgitgadget@gmail.com> <ff59d2d0b3b8b591a806ef71b4bcfd350000b06e.1572869729.git.gitgitgadget@gmail.com> <xmqqh83fnfah.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1911091154550.46@tvgsbejvaqbjf.bet> <xmqqtv7cjj2n.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1911110949590.46@tvgsbejvaqbjf.bet> <xmqqeeyehawj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t1FGODMpQLiDJDHMC9jTuNYAZsrIEuS1QwQSALXK0qdUXmJfMHJ
 5PDl29McWKlDSSZJAK74QyAll2h/CNx+ZEXDOQz8Tn5v3gWJsaY4/om+gvWeUFK9bj6VqMn
 9+e2xW2Mim1RHdxNWO/v2r2k62gnlNSsWOgxepy0DrFmaBOT6oVo1oOiTyVP4VyOfS8ehPG
 FF25JQLcPXrbL4GeyP7eQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v43ObXuQPlA=:vKdy/j+tfZZ4tF8LVg0WGT
 lErEz2tId6DwhYpwA4w5B3fDvN85eF0BnQFK+DLCIBuWjwRDpFmUdS72fshgA3Amvfl7nsnQN
 SxYAOfJ0tY7W4z8EWwE8nv0YG0VmxDPMsM4OUSKzMZvl0VONRzBZs5wfw/arBdtKDE58Jn+eE
 EiE1UtpE1f9u0Caj7Mdf6YORSy9ksD1AH1GdagHf0I48WQzAnJacrABsst1Ss2Hqm9qUfyKSM
 vCtgS+cLF9TNTkGyCY+GUDPFYqYMKZSgtfqntCjUQSKON5K7xG6gyyPhxjMTGdV872iwVTf5Q
 ZKeO2zoJXpMWpwc9+xLcHdo6VDJMPVFTbyWhvWasICLTe21vGiYciNkcs422GErw/vDb7MrXJ
 hnIXKqyYfnlpqkuKpg8rE9MnhdnsAYLm706HHYWfDGX+IfKz11DvNd8t+pdprvMWQC9c0yCZa
 6JSmbiAoIz85h51Sj9Eo00QGbVE4Kn8fVKznQfQNLSTnP80mMuhFhVPF+fHQZvZq/bg1ZVXcO
 XI75fU4igeK6Ksg4abhPmyQoz/aenHTnenyAiMe+hqLlEldgHPxOqzMOx+wTQikwLPj7pI+Vg
 pvDRcjojZ8Gvtdll7EN1mQcYsf9lBOFDzOKauQld7KvFWudIaTPT1abwwJedbT5Ahuas3sR7q
 ZnpaD1of5gaNqRb0EPS4wNtjwi/HDswMrzGT2i45wA4BplSc0dH6JUUkqhwJut5MjyoLNXWlD
 Cq1uS2QitDeywzDke3/oSCTYWTBjhDe0p0QLJJLy8d1OYJ8yVeA44Md6EF/mB56HnKnsXuJ/5
 bUSv/XThQycX9LSYsMqgcAJO62TFK/iqlAaX7hyooSS4aT1V8pWWzJMULdrMcMIlydxIb0Yjs
 rdn73cz5Dj5LinZEtCmeAq1D4nAOlbuDvFRGjLHK5pb26ErCANA8rwyGR2KiLCQO/Oohp0K9G
 tpuRolj1VdXGaR8JwHM0lbKt9KDYIud5/xH4HQYvtr3U6p75TNBSxVNorCu5gu5tRS1AOYx6o
 NuaydfH6HnekrCyyl3Jig0h67dprY7VrZIAw4NlJOeY1qW+GwjV6JixQ4JCV2cESPtlRSPzKN
 3KwHZ+uyiKXT7hW1Nx7I2HVyu0vB+Agh8D2Id5LqMsYOjR42CsGTppbNsWoaUn1knqowE1apn
 QPYpM/s4vPiBE9pELRAT0o8djYafv85b+ColzK4AwLrcdVQ7Ou4ExYKt8FPXam7s0eLnpnNWF
 IiuYQQ4ZFOy2CHBN9Eo0lhYczAt4o6XWDmSAzYNxIg9bpuxChLmWiyLEyvjw=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 11 Nov 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > And I agree that this sidetrack is totally irrelevant for the patch
> > under discussion.
> >
> > I do think, however, that the discussion of "we wanted to do it the
> > other way, but when we tried, it did not work" is relevant, even if I
> > shortened it to "we use a different approach than previous conversions=
,
> > because that previous approach would not work".
>
> Regardless of the language the scripted version was written in, I
> think the '--helper' approach is always the poorer choice between
> the two [*1*].  It limits the modular decomposition to what suits the
> original language, the impedance mismatch between the original and
> target language forces us to unnatural style of inter module
> communication, and the unnatural interface layer, which we know has
> to be discarded at the end, must be written [*2*].
>
> So, I'd prefer to see "because this is a better way in the longer
> term" over "because the --helper approach would not work".

Hmm. I feel distinctly unheard.

It may appear compelling, conceptually, to shun the `--helper` approach,
but the more important reality is that it is the only one that makes an
incremental conversion possible at all.

It took an entire month of 60-hour weeks to complete the conversion of
`git add -i`/`git add -p` to C, and only at the very end was I able to
run the test suite with `GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue` and see it
pass.

That is an awfully long time, and you know fully well that this amount
of work equates to three to four Outreachy/GSoC seasons. That would be
an insane amount of time to go without the confidence of a passing test
suite.

In contrast, we were able to complete the conversions of the interactive
rebase as well as of `git stash` within _a single season_. I attribute a
large part of that success to the ability to keep the tests green during
the incremental conversion _because of_ the `--helper` approach.

So no, I do not think that your suggestion to reword the commit message
is something we want to do.  Instead, I think the commit message needs
to be rephrased until I get the point across clearly.

It is indeed _in spite of_ the success of the `--helper` approach that
we cannot use it here.

Ciao,
Dscho

>
> [Footnote]
>
> *1* In only one case I would recommend using "--helper" approach,
>     though.  When you are not expecting the developer to be able to
>     come up with a better split of the program into modules than how
>     the scripted version is, and you want to ensure that the
>     developer have something to show when they faild to complete the
>     project after N weeks.  You are a more experienced developer
>     than an average GSoC student, and there is no pencils-down time,
>     so the exception would not apply.
>
> *2* In "git submodule" for example it was quite natural for the
>     module that gives a list of submodules with its traits the
>     program cares about to be written as a shell function that
>     writes the data to its standard output.  And consuming modules
>     sit at the downstream of a pipe, accepting its output.  When you
>     are writing these modules both in C, you wouldn't connect them
>     with pipe to carry the list of submodules, but a piecemeal
>     conversion using the "--helper" approach meant that there always
>     remained _some_ consumer that wants to read from the pipe, so
>     long after the module lister was rewritten in C, it still needed
>     to support a mode where it sends its output to the pipe, instead
>     of just passing an array of structures.
>
