Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EC4C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6735F20738
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 13:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TZAUhMqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgFXN01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:26:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:55883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgFXN0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 09:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593005179;
        bh=uXOqlYq5X1/IWkfN4qd6RhfQv4wt56g6bFUdOuzmfmo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TZAUhMqnO8Nf/ruNr0KoTXd+mYSSqXG5XixQP5Yq2WA8hBk6lN8Sd4izvIKzGM1IR
         2qBbuAxtJttLol1AQVRxZwVv469IZyrdUeqcatzMBZwoE62nHxYrbCYR1cSjUHXQCh
         z3IrxMHHCepaXeTLWV6dnNd1AIuR6knWEK7wFYzk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBm1e-1jicpL1Maa-00CBVk; Wed, 24
 Jun 2020 15:26:19 +0200
Date:   Wed, 24 Jun 2020 15:26:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: Re: [PATCH v2 1/3] diff-files --raw: handle intent-to-add files
 correctly
In-Reply-To: <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006241517320.54@tvgsbejvaqbjf.bet>
References: <pull.654.git.1591879139.gitgitgadget@gmail.com> <pull.654.v2.git.1592916485.gitgitgadget@gmail.com> <640e225550886727594ca9dfaee6c9e6ea4b1014.1592916485.git.gitgitgadget@gmail.com> <xmqqzh8t9vf5.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:07hSmy6ktodXOJUTWa3cij5IwR0NJkIj+5K70fDIUKIEx3OaKOw
 MuhqVQzDe3fSP5oppZFV/2JBzlScsk6qjaQyHa8N1qQY/PHk9ArNfmo9QuN+bGok5k8Q3oS
 IBe29clBPSC4N2VryQxoJX/s3JT/lxO9J2NjQ+dPSIMw5lTkea4MlHfSiIhiOLIptGlbSGI
 c/6VqgWitTowi8V8VvCYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Ys3pta6MCI=:n/xWYVhWSbclDGJNCCFf8F
 KDPKqmNMGlYB8ha/wM4kxKXrDeNJEEKmN0gmcy214Rhcyjbc5UtfRuA8dQp+WAHCRiEg7MtTP
 ZcBScxuSsfTa8yqm5rM+lqrrfGQqD1Y1rMGeeezodI8+B3b1yIy7518ZlGGs0ID8NS8DChNnN
 CZJD7u8EVUc0qGf5ZPLrLTAavzMAo0fEfLqcc0QMGiWs1YxvufSvMbSu2X/6FVoAbOfpgYEn0
 +TC03nhWZAROzaskdUP0JcNiY1zomVfESqm/lM7rCPA6Ap4C6T1RDHg1LZsq2/TPvJZcfQHjG
 msqPy5WmWw70k+9x7iIISAin1/TuGTFh5535RC9SnT5D7tkuNvU0HoDBRWW+TgEIwD3UVDtcU
 xZrPUrWFgwmBKDXi6fqkZ59PlmcOiizMiqv+owWAsuGqiO1F47kpF6U78C0DQmX8aRl25MsYt
 aoUAIK6yWtbrcZ7fJcs3zjRiC0VDBtJJaa3IVIrPxECFElflUncER4K/7gLUf6JW7/kg5YTYd
 Zk1FkKqNI1lMWxyDEYj85m/YFlfgsENTaH2Ls2SuxR9hBjTJFyUD+RVsCXGqlqo5G7JJztJhY
 FCRpuiPoF46y4nE0+8+Rnb+jibBrEzHDowsctRZEZZ4qa1bBu7p/CbZyHtJgrdqHPHZHguIvr
 dcDzedIY6pL/fjaUG4nwkAJ/blkY26dCIGMTMUG9uwGVn4FpCp+XjKKWOulu4fILJCscmH0cq
 XdcNpccudz4XBecYCxg1NWgyT92maa4erkQBPv9NyywJuQyHhY/SzgXPEHCSVAXmWG0jBi+mb
 QI8H2hkOVTUckmkd5uIGT3m8z3ooLwkxogTPO8x49BDDcT/wZ8GrSnbVERc8HSN3/rl52RnhJ
 dMi/CKUxiFDaHufFjQU0T9oeAJtuYVRTu2Yg0oWA/tNbh7Dgkg1jtV1iYlaUtp9wZXSKPkwaM
 QeMbUIBezyAzUmDNUDVGl9x6k7YF3P8CmWVpARcUCzc/o4dySkGjo9bqR0iv7fcg6gwZj+xRw
 BLudECHOhNIC2MNtngm5myBQWk9prGnwQ9opw7O2ARcOlIYIcqXpQAHBQ4vugSPel+SvrJVx4
 ySxosTa2nnLDlJnIsnS+cB18eRtiqt9/JNfp9PFrtosrPAs0sQuKaIJPMqCJOgVzi6YwptgfY
 xAun1bKaURAHkaUfj1VPr3E2XYFc1ePU7tBGzsnd0P1PY0dIZ8RLT6whgGRNmt8yklJjchngs
 NXdU7IlqVkr5koZT5
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Jun 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > In `run_diff_files()`, files that have been staged with the intention =
to
> > add are queued without a valid OID in the `diff_filepair`.
> >
> > When the output mode is, say, `DIFF_FORMAT_PATCH`, the
> > `diff_fill_oid_info()` function, called from `run_diff()`, will remedy
> > that situation by reading the file contents from disk.
>
> The above is true.  What do we do for a path that is actually added
> to the index but is stat-dirty or actually modified in the working
> tree when we are giving the raw output?  Don't we give 0{40} to mean
> "we dunno---you go look at the working tree"?  I think we should do
> the same for i-t-a file wrt the object name.  In both cases, the
> index does not know what the actual object name is, and we do not
> want to run the index_path() and write out a new object in the
> object database.

Sure, but my intention was to synchronize the `--raw` vs the `--patch`
output: the latter _already_ shows the correct hash. This here patch makes
the hash in the former's output match the latter's.

Besides, we're talking about the post-image of `diff-files`, i.e. the
worktree version, here. I seem to remember that the pre-image already uses
the all-zero hash to indicate precisely what you mentioned above.

Ciao,
Dscho

> Using the status letter 'A' would also be appropriate, as we would
> show "new file ..." in the --patch output in this case, which would
> be consistent.
>
>
