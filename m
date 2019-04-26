Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA911F453
	for <e@80x24.org>; Fri, 26 Apr 2019 14:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDZO3z (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 10:29:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:40957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbfDZO3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556288988;
        bh=cUfjJoLYlA1KQoaZwR6P91IUuTcrCSRj/Tj/T61/itQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KpPy18zVAjOeYflcLUuyglz7+kjSiCemZKwWZ8Dd+FaNkxub0QyDB2/OtoNdHjiyt
         I8fiLavDsGP9fzyxF+4bhOzfABXSNxwq0/iaFUamAUrzJyW2jv7HKFPrd8QZ7WD7u7
         urh3cRJfuRF2FN5iKhls0+sXvr3uATf2R3Fz8TKU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.8] ([167.220.152.8]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8e5P-1gWzq30iPL-00wBDV; Fri, 26
 Apr 2019 16:29:48 +0200
Date:   Fri, 26 Apr 2019 10:29:45 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 1/2] archive: replace write_or_die() calls with
 write_block_or_die()
In-Reply-To: <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904261028220.45@tvgsbejvaqbjf.bet>
References: <pull.145.git.gitgitgadget@gmail.com> <7a9525a78a7b7b237150b9264cf675a4a0b37267.1555110278.git.gitgitgadget@gmail.com> <20190413013451.GB2040@sigill.intra.peff.net> <xmqqzhouwizg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wfA3Hw+JFaFdYwX1r44HTAfCayXGqVmNhpupvVtpEyV9ns+s5Vj
 I5gvtuAWs36yojq3SgDPgPcVeUae5SXkONgIQzegOiwOmNX1Zt47lYhJ6Ut40ZDXdEXCHHY
 WSR8drsCpGYbmtlAqN+E1es3fY3YUib9O0jZWYLp2MfaqmL2VokQn25xpojJhMMQmq1yxKK
 0aYkHehA/JylJp9QWTMEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jvdE4V27BZs=:iSzxHzxg6p5y0o6c//o7Oh
 ipIf/yQLROGTBoVs2572IqmwQHrwYm8WtyGOh97THmoUeAMAWb0iSmIn0auN3bLAOZGDF5I6g
 zT0bTgvpER7hwMvahpmuSDQRDDpTFz7niqDIt4OR+Yfgvi41qJokc++Mwf3OmUHaLIH16ZwvY
 leN0lRED1CsKG/z1ufS9PTqi1zlpsnhmv94fUPSf8qiyHXG0I8Zs3bgKwPX8fKHbqVRnwbIo9
 amQe+tMinWgck2Px52XlWyvyKdRL/4yZYl+AnbZPuDbJkZf1Z5d02PimTYyNTc48W4DRK88zZ
 tF2atkjlktHTluxIahSIDGl/TR27+2tJwC7WE2L6V3Vms5fqsCs0wCcWlkenqFAtKGHwQW9mN
 WdTyegyljeFOknRpu/N58QY4CP/JEsbFibQnNaDRczcrgpU5cliFw/x+kLImNYEztUx0+XSfN
 lLTvDhgSzJPgQiZFJ9c2sum7auwrIjApFiJ13d6OenXLRd0BZObplOgbPSw2hYFieWm/XG5SF
 wBHkg9PMTPw20o2UU5DqteM7B3QmHorXcVdRimJ9snfvcl5KOGrK+qVAFaXrNTYEcJSiM//TP
 Ir7Vwf8nrd8n2GXyxiA6SgnZ68Wew6dfnrzkTc5dernl4jPQ9Chu3LfaSxAK8CCl5fGEt8J0V
 GE63DazBt+lem5Zgt8v95X5bYAuN242IHTwj2ymfoEjwREswzS3W35FgPr3VVBo9BZ5FMF8zr
 TkgBFDCLfPRgEiRMR/Xt+buz5jAujaNfkis2TI7fFucE2xaaOticc+2zquznzru3a6E3PRbwG
 0kWCXYIw8dxP/AKueCLD4TddwGl2NLfYi5R9W1zSXufsi5DKkLE+lNa+jKScFugvXfXCRl9IR
 towDfkVR4yX332/O9OC7r7qrKKRC6gL0c10aNifNSf7UjWmy3a6wopkA6O9WkwkqC230DiwHY
 02lHnLTN0nA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 13 Apr 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> >> +/* writes out the whole block, or dies if fails */
> >> +static void write_block_or_die(const char *block) {
> >> +	if (gzip) {
> >> +		if (gzwrite(gzip, block, (unsigned) BLOCKSIZE) !=3D BLOCKSIZE)
> >> +			die(_("gzwrite failed"));
> >> +	} else {
> >> +		write_or_die(1, block, BLOCKSIZE);
> >> +	}
> >> +}
>
> I agree everything you said you your two review messages.
>
> One thing you did not mention but I found disturbing was that this
> does not take size argument but hardcodes BLOCKSIZE.

That is very much on purpose, as this code really is specific to the `tar`
file format, which has a fixed, well-defined block size. It would make it
easier to introduce a bug if that was a parameter.

Ciao,
Dscho
