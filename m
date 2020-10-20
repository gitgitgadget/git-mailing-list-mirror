Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79638C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFF9222C8
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Zl84ZIRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409619AbgJTUs0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:48:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:33183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405301AbgJTUsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603226891;
        bh=y4W/1jYop3P7PknD9lZi9Iu5gYfjCc1eJwQzBLFVE3I=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Zl84ZIRv7eg9LVywsB8Myib2TxOdPnYRMITT4jT0+kJfvR7yY5BHo7Y1CA1kdl4JM
         7c47iowkMNZxS63sr4073EfrQ8GIMQMyFPA+e1+CZ9f+k14F1M3FYEO+OjQQlAOpWP
         +tw76iAWDTDk3O8KMFacIy6zRXdLW2HLWcsQrdZ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.221]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1k6gMc2YY5-00p3cv; Tue, 20
 Oct 2020 22:48:11 +0200
Date:   Tue, 20 Oct 2020 22:48:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] sideband: avoid reporting incomplete sideband
 messages
In-Reply-To: <xmqqwnzkab85.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2010202246240.56@tvgsbejvaqbjf.bet>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>        <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>        <e4ba96358b7c5d2b4148c5529a3c253dc0d1f358.1603136143.git.gitgitgadget@gmail.com> <xmqqwnzkab85.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gRTNMkrcTKN5xMnXzyp9ifcinsAH075fzbRfvk+L3s/fj5HRZSj
 OnGbZ5sLa2zgaFVXvcTzwHhhRH8FomjXEF7s24NdQoO3D8C8qzWU+ydBU2C1FYqjDF+lFHc
 GmemSu4+0Ll1Y5vJ/vnWst5dgQOw1fsom7GrWrW0CIu/ew0X+gy+Zr6wogaDLrtH4aGSJre
 7zN1XLcS6mHuP80drsE8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:61QmU7E7GRg=:Js0s7OagNtuLsq40k24uZi
 swNfJGvca4tzz8ERYLICin6oy3egm0cWG6n6fsBmyOFxUIb2zr3akAIU73vs2ZOffRtSe7QrH
 /zxr79r0HJSucr2nsDjLWyKoQ2fxLscqRZIY0zjpHz9tIWGhm9qMAGCYAbpcOhMcOCawCPZ5D
 nl2S9o9uRyThA88Gadri2IDnE7OIRI7Hj/yFpLaOdAVPfvCTKPZdsoNLjrveFmhiQjKL4EOLa
 W4f3sk+paWdOPTJkIr+sWvCBOftiBno3xHoI9INvoYm+N2qJiMIW8HDQcQi3Jo4WUnjr4GemS
 XO0SBVG+MxHZBtqazhhpnvmKBJaYOI+8HJWqzMci3affPTOktW479jcnTstTbQQxeSpx5uNyE
 WsLHqOSO/pDwFQQV2/8bxn1YSVPPnkqyGrzYjF8Fqu9gvhdtv0VwvGQji/CBvMrW88D9rnZ6+
 pEB4yDpScV9pH0nbi8hgqNf56+PdR895Yi0GGj+FoWKTEWnwDwqzE6UaYlrJuZZ1NZX3oZPv5
 w6mfxjoM1A5715Uz5aM+bFFn5dkrhf31YiyV0OdgfAvHrDLbEDEkvz5jLC++bbhJnO4TqzVt3
 kPnlByVh1zhtuoDnViRJf15L9xXyWAhWgOnoKZxb/HEr2QN162bpVIVGwUfZerBJL5ZOUn+K9
 KjG99EX1QElYf7c8lscBVyCJa5vQlL6ZXgeHhDGL58tic9TuA0+qC+lqkWx3xulYyn8UUjHWq
 KzU+l3xqL3Hpt9eDZIiIGm/8HwndMcBudCBwnrCYWV8A1IpgW2Kfc3CyHlUnDp2yiVAYwuzcI
 hF74VUgfg9ZV5nWQ91lEBp82hpZCaplnS3S+lFBOChBV6rrM2Y8OKOi4d64pQAHd2aymLY9bd
 G4fUP/GNy/EtboM4Bd6XHZ0KoAdbyI7iHTs+eMnHQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 20 Oct 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In 2b695ecd74d (t5500: count objects through stderr, not trace,
> > 2020-05-06) we tried to ensure that the "Total 3" message could be
> > grepped in Git's output, even if it sometimes got chopped up into
> > multiple lines in the trace machinery.
> > ...
> > The correct way to fix this is to return from `demultiplex_sideband()`
> > early. The caller will then write out the contents of the primary pack=
et
> > and continue looping. The `scratch` buffer for incomplete sideband
> > messages is owned by that caller, and will continue to accumulate the
> > remainder(s) of those messages. The loop will only end once
> > `demultiplex_sideband()` returned non-zero _and_ did not indicate a
> > primary packet, which is the case only when we hit the `cleanup:` path=
,
> > in which we take care of flushing any unfinished sideband messages and
> > release the `scratch` buffer.
> >
> > To ensure that this does not get broken again, we introduce a pair of
> > subcommands of the `pkt-line` test helper that specifically chop up th=
e
> > sideband message and squeeze a primary packet into the middle.
> >
> > Final note: The other test case touched by 2b695ecd74d (t5500: count
> > objects through stderr, not trace, 2020-05-06) is not affected by this
> > issue because the sideband machinery is not involved there.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> Nicely explained.  Do we want to also give credit to Peff for the
> single-liner fix here, perhaps with a suggested/helped-by trailer?

Sure.

I had not added that because I had actually come up with the fix
independently in my analysis before I read Peff's reply thoroughly.

But credit where credit is due: without Peff's reply, I would not have
worked on the full fix and stayed with the work-around.

Ciao,
Dscho
