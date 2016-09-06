Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632D51F859
	for <e@80x24.org>; Tue,  6 Sep 2016 11:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933001AbcIFLlM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 07:41:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:49958 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932538AbcIFLlL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 07:41:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lbi2Z-1bEBGP0sBf-00lHsw; Tue, 06 Sep 2016 13:41:02
 +0200
Date:   Tue, 6 Sep 2016 13:41:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not
 inherited by child processes
In-Reply-To: <20160905211111.72956-3-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1609061339230.129229@virtualbox>
References: <20160905211111.72956-1-larsxschneider@gmail.com> <20160905211111.72956-3-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wYrLRhpCojDEYzlrTzxoiddj4qsqjWuc75//EsQJ5Bhm86TiJFe
 ktXEJCKLkSUNhkjinclrHcuMa6XvOlYp0AHxyX2ojoPMx5LSu1Db9jxQ8NWlS8//kwEhSic
 NdhOBOpevyyOh/Q4kaMJzlFP3I/K+v4pJj9zmkeYt0NaxTepS1n5odZAluVhaqYoM99tVkp
 GWBO3hG+dywQLeZqzFb6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:04zgSchJCKA=:DrLSJamfgTrL7yniQdMG7D
 hoCd6CAho3xWS8bnfasBQ9HPTBNGZBDszJN19yVZqZ3O+zaoqbajVhaGniy0scUi8YsLDL5Uy
 8yE7bYkIDimoCBGWNLsagAVvsiQIs1rAHfrITlXW/DbQtKSgX8zJx3haSHoRHudMXju/8u3OB
 iXaGO8El5cWpixY7UdSpelLN1c0mwXskvC1L1okCPtIimUTmGWrKTgfrhr67yT/bzaGuPcX2x
 aTEr5d13vKoA5nyHa0ecxRbs0q6vwrDEXNDFf7ZTJk7rT0ApMVVDPYcxk4RSiPwQS9nT5IqRf
 S2TR/PS/jX73kpuobaoL0h5KzbYa4sihCjgRlPg1mKpUT1JAUWJTFn0/39tmgatw7zeTdbIJE
 mtZk22UIxsDF2vCi6zbKO6J4Fklc/O5s1E6HEu2b0kxiuVQrLTcVPuFMITw9xa5VEfs9v/me4
 tI9t0SwQnXD98zCXRQHSL9WOJAYxq4t+os75b5Vsc3OaRbAXgDKUJQqg0nMNTqdy8fean4NZu
 x1JndzwPOLRLReF1gXE7KH3GtpdZ0m2mOKdF9ucV7coMwUpMFhnGktd5Y0lcXagA/zzv2H3J+
 ASZpLKNMye+IqwscNrUxaJjBzqBxHTV0cqDdMmocljd8nvYZRpxTnVLBw7upNHPJKXMBuPwAk
 bxhGkLHRsGNqCzgVCtZuD91Tx/R2cSxE7eHQunT3Cy0fh6zkLCi9NsTo5NWnu4xut3IPAMYbV
 S5penJpofJ6fdwLjRcpygND2k0SHJe1Wakxmu9xVcvNkJzzVj9CrsTEPmYJImDQ9kkyghF6qw
 VClU54k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Mon, 5 Sep 2016, larsxschneider@gmail.com wrote:

> [... commit message ...]

Makes sense.

> diff --git a/read-cache.c b/read-cache.c
> index 491e52d..02f74d3 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -156,7 +156,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
>  static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
>  {
>  	int match = -1;
> -	int fd = open(ce->name, O_RDONLY);
> +	int fd = open(ce->name, O_RDONLY | O_CLOEXEC);

Eric's comment on 1/2 applies here, too, of course: should this cause any
problems on non-Windows platforms, we always have that FD_CLOEXEC thing
that we could probably use to fix it.

But let's cross that bridge when (or better: if) we get there.

Ciao,
Dscho
