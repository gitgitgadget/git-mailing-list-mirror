From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] t0060: basename("//") is implementation defined
Date: Thu, 14 Jan 2016 08:00:24 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601140758420.2964@virtualbox>
References: <1452718561-32226-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Thu Jan 14 08:00:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJbtY-0006S0-AV
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 08:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbcANHA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 02:00:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:49765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750701AbcANHA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 02:00:28 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M6AbC-1ZzLzH3rbe-00yA4N; Thu, 14 Jan 2016 08:00:26
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1452718561-32226-1-git-send-email-tboegi@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:C8afnbmUuoc4wh0DogirvFDqCDctXs1rBslpf8FluIAJWRuJ3Ab
 bFs3MGZvPFln6L+Oqu4GJoWo+E4cCGwgT4kKahcgrjXVsgirCXH/C7hmtTqzbI7tHYzNL84
 UqqxF2+sX0c3D9oD40hVDmnGgilo8Uxlvl962DSOgfefOv7Agz/+QNBY6HH3wsC3ubFxrH8
 6VMwqu+SM0Jr3ySGytHgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MqssWQAF9HA=:ewLi9vR27+wqyhSffQRBU9
 /5+UWM53fNvbn6ZbbnUK74Py9Qh1f7eQXN6yyLiiQi28Dp9gZNnDj2AldKxvNB8UMg95lf+dp
 b0cN76FiP5dcurm3pVBmgh3PYwb4q7C1F9z1d0bH+Hk7U8d/ILzeJsxM1W+TOqsMGpR+MoB1Q
 sRgCPjNuBCxN0hQ1reh8LvASTzW/ZlM0Zia3sTDGaADj+euUcslxc7HhqJPBHDjfVE/Himbgo
 i4wmgSXIjDmTZbT44Vg4rOx8JKGsyAxawQ0W1ubIeJ4zfJI7kkzNipyc4Wh9v+DYZyF3g2Pjn
 4Ep6/IA3yp7b90pXpb5P5iKeJC1th6EsdcfLhZ0vLmt4iFQ4ntbvXJp2uyHIsR9H+5iNcBQx4
 oJXjVXWldN4OqidMHvKbTiqhDBbKlBqHK6LbvqpnCu9avcVLHKoZREQ9fjheX4MXpVoT9li5j
 HIDfA9VDPmS2QwbZbBXxY0aqzglfslCbkroZvM7C1CjWh9on3Oqql6Re5I42lXWV3dBI4FTdG
 Bp5ziYe1PqnoA2kDSAhv1RwSX4C4xDng6SN3whWl3vXCdRWZp1jZasgZU+Ch2ZQLPUCM7lt2R
 Ro0zxAB4owPMBYtwPZiXSQdbvCyhPAgW9UH02lSDQGMQV2V7FEe/LksztowKmh9o2yhanslpU
 SVh5nK5zzMlG1WXFjFlhvTtrKSv8D1QvZ5mfXYsLAi+ioUkSv/+mVKe4reN7lva8btMj8TDkl
 wZVe9wtgzn6/04JE5yuEi2kT+5MquQZtS2B6igajHC7tcxKBXXNVkmo1xpSbZGHuRhGLoYwd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284021>

Hi Torsten,

On Wed, 13 Jan 2016, tboegi@web.de wrote:

> diff --git a/test-path-utils.c b/test-path-utils.c
> index 4ab68ac..db0bb39 100644
> --- a/test-path-utils.c
> +++ b/test-path-utils.c
> @@ -142,7 +142,9 @@ static struct test_data dirname_data[] = {
>  	{ ".",               "."      },
>  	{ "..",              "."      },
>  	{ "/",               "/"      },
> +#if defined(NO_LIBGEN_H)
>  	{ "//",              "//"     },
> +#endif

This would miss faulty implementations that return completely bogus
outputs for the "//" input. Not very likely, I agree, but the entire
intention of this regression test is to verify that Git's expectations are
met (and to document those expectations).

I hope you like the alternative patch I just sent out.

Ciao,
Dscho
