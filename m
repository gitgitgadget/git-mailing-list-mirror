Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E9FA1F461
	for <e@80x24.org>; Mon, 13 May 2019 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbfEMME1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 08:04:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:49345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfEMME1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 08:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557749057;
        bh=MIGzknGa9zqGVDcJ32LLnfjHo1wSIbMzztosXdS8yo8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MRond7eO+u0dIp/yQ86a2lyWLt3KSL/esPRPHt/FX5h7P+opQRTKAEQAmpA3EM8Z9
         CP8N05OvKim2CcQtLyWbwo17RS3ntSdC174BpRbt0qPGmHMxLBplZx8M/wbu62NFLe
         pn86kGLmuAr6Y/Yw8vakQCxaBSbX9g6J67xkVji4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ml6mE-1gyohR0dKu-00lWWF; Mon, 13
 May 2019 14:04:17 +0200
Date:   Mon, 13 May 2019 14:04:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/11] built-in add -i: implement the main loop
In-Reply-To: <27ebbb44-1208-563c-2419-edfc6570fefb@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.1905131401510.44@tvgsbejvaqbjf.bet>
References: <pull.170.git.gitgitgadget@gmail.com> <93b3151b6c8abeeab0674919badae72e39eea68d.1554917868.git.gitgitgadget@gmail.com> <27ebbb44-1208-563c-2419-edfc6570fefb@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RBm/Kv27M2fTFZ152hJl0iPwVgEBL9ONmplBM/7ugdYB8SqUhZT
 1NJQvxo/ySRUNPYBz9E79JNN132G3eqxmvflZgMa04bnAJ808U8GNDRy2+KHsNG51qZ0Rbk
 GkXoaZHJqP1k3oXver6BQMl3wJORhW+KFm58QVFUBe13vzmzMpVxAsdmkeUZujivBpXPVG5
 6GMCXzlYvOur5av+BLiPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QUq6cdeXeiQ=:nIM28p+Xht9h7BM1yX0gTk
 P7FHjUbSj9h4cnvHSgR6oMql/Mhl7JKhRI2gpUOjMBt0Eg+kUjKVNRnkI8lBaRoexde96dJ/N
 EjbKP+sTCe2SXtAEuYnhW65kNqWuFj9mSJVi09SxIACve0zHONSpZn+zQovbtMaFwDBJCcfwP
 QhAVbLsDJs+/LqEDoWPZEXfwItg2ToSd6VRYCmlP3N2znd3saKJwVw3L/4jc0p0JwaspRHaGd
 O+cbxUs0gHhcHI+BTr0cEs6h3qcSA9gh7iSnQE57OXYYTTgXULCdiJVKIgYJUq03zhpxXiXV3
 Bt2WEVIY9VriFTDKeC7/3AwD4+LryLdBbyAw5ZPOiTYj/NQ74DNFR8KNipea20IjVe0F5FLY1
 UCG4O4f6VLzeVxPTGgCOg+yNXO86f6IoXBU3JNqslJT4AJH3QoIbozf2gWgyIUVACOpmxbbKa
 rlo2/lMnr6aAZjgOdrI+yfYBE4tOhgWTRZ28KEaFpqxr1y9NFvDcZT4vKdW/uex9gGGyQRWJ/
 LpIJu1CY4v5qJONF0kb5iJjXf98/CZKBFowg3SRQd04LOtoE98m3hmLTPrT3zx16o5GrcEmHt
 ib8EJC/ITCP2bADaWAWfMlQA2H2u7VyqNNIkuHBXn/zEJPmcZ2TEdIl4GPV9Zu/ETghSzuL4g
 osEOgbXbKlVcH43YFnBMbyY/MC5ZOILm6IJ/acv6HauAc4KmAHB7RS8sER85HqURmM+3seSJD
 Gx0g+iOENs/jPaFVpnnT/VmaqOwzYvsSMzS9+sj0uwN2z57+KyHuqrhdnmAzfEJeHrH6KaIAr
 ObD9RjYe8AgCjuaXsNdClMYI8LrTperUCNsMqXrxEkBpwirbfZUh0wQFyJQzXcCAWzoT3VBU3
 j7YVp524g1hlaLwwU7Acevr+JTbj0OdElDFATKq1uly+TvV0m/6pUXge0y20dx8spT3TWOX6h
 vR8jllT0E3g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Thu, 18 Apr 2019, Jeff Hostetler wrote:

> On 4/10/2019 1:37 PM, Johannes Schindelin via GitGitGadget wrote:
>
> > [...]
> > +
> > +/*
> > + * Returns the selected index.
> > + */
> > +static ssize_t list_and_choose(struct item **items, size_t nr,
> > +			       struct list_and_choose_options *opts)
> > +{
> > +	struct strbuf input =3D STRBUF_INIT;
> > +	ssize_t res =3D -1;
> > +
> > +	for (;;) {
> > +		char *p, *endp;
> > +
> > +		strbuf_reset(&input);
> > +
> > +		list(items, nr, &opts->list_opts);
> > +
> > +		printf("%s%s", opts->prompt, "> ");
> > +		fflush(stdout);
> > +
> > +		if (strbuf_getline(&input, stdin) =3D=3D EOF) {
> > +			putchar('\n');
> > +			res =3D -2;
>
> It would be nice to know what -1 and -2 mean if
> they get returned to our caller.  Maybe a #define
> for these??

Makes a total lot of sense. I changed that.

Thanks!
Dscho
