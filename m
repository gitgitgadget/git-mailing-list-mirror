Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE241F6C1
	for <e@80x24.org>; Wed, 17 Aug 2016 08:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbcHQIW0 convert rfc822-to-8bit (ORCPT
	<rfc822;e@80x24.org>); Wed, 17 Aug 2016 04:22:26 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:45446 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620AbcHQIWY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2016 04:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7BD942054;
	Wed, 17 Aug 2016 10:22:20 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XogA4oldGbaB; Wed, 17 Aug 2016 10:22:20 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6B1F1202B;
	Wed, 17 Aug 2016 10:22:20 +0200 (CEST)
Date:	Wed, 17 Aug 2016 10:43:29 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, ryenus <ryenus@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>
Message-ID: <594839500.1229861.1471423409171.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <xmqq4m6kcvc6.fsf@gitster.mtv.corp.google.com>
References: <520a941f7472ac1cb4fa41e6bba33a0afc2f5999.1471264971.git.johannes.schindelin@gmx.de> <ce8891377cec31cada49208f2d192dda86658e40.1471353054.git.johannes.schindelin@gmx.de> <1134106438.1228353.1471361364992.JavaMail.zimbra@ensimag.grenoble-inp.fr> <alpine.DEB.2.20.1608161739280.4924@virtualbox> <1654103856.1228422.1471365329111.JavaMail.zimbra@ensimag.grenoble-inp.fr> <xmqq4m6kcvc6.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v2] rev-parse: respect core.hooksPath in --git-path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: rev-parse: respect core.hooksPath in --git-path
Thread-Index: QdyK22HVNo6ESHwfAlcD/DNJoDZtfw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
> writes:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> Hi Rémi,
>>>
>>> On Tue, 16 Aug 2016, Remi Galan Alfonso wrote:
>>>
>>> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>> > > diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
>>> > > index 5e3fb3a..f1f9aee 100755
>>> > > --- a/t/t1350-config-hooks-path.sh
>>> > > +++ b/t/t1350-config-hooks-path.sh
>>> > > @@ -34,4 +34,10 @@ test_expect_success 'Check that various forms of specifying core.hooksPath work'
>>> > >          test_cmp expect actual
>>> > >  '
>>> > >  
>>> > > +test_expect_success 'git rev-parse --git-path hooks' '
>>> > > +        git config core.hooksPath .git/custom-hooks &&
>>> >
>>> > Any reason to not use 'test_config' here?
>>>
>>> Yes: consistency. The rest of the script uses `git config`, not
>>> `test_config`.
>>
>> Fine by me, then. Sorry for the noise.
>
> No, thanks for reviewing.  I'll take Dscho's patch as-is but once it
> hits 'next', it probably is a good idea to do a separate clean-up
> patch on top to use test_config where necessary.
>
> Having said that, this entire script is about constantly changing
> the value of that single configuration variable and see how the code
> performs, so any new test added after existing ones is expected to
> ignore left-over values in the variable and set it to a value of its
> own liking.  So I suspect there is no existing "git config" call in
> this script, with or without Dscho's patch, that would benefit from
> getting converted to test_config.

Thanks for checking the ones in this file, considering the lack
of benefits it might not be worth it to change it for now.

I tried to see if the `git config` in other tests were in the
same case or not but the sheer amount made me reconsider. However
taking a look at a couple of random ones, there are some scripts
that would benefit from the conversion.
For example in t3200-branch there is:

    test_expect_success 'git branch with column.*' '
    	git config column.ui column &&
    	git config column.branch "dense" &&
    	COLUMNS=80 git branch >actual &&
    	git config --unset column.branch &&
    	git config --unset column.ui &&
    	cat >expected <<\EOF &&
      a/b/c   bam   foo   l   * master    n     o/p   r
      abc     bar   j/k   m/m   master2   o/o   q
    EOF
    	test_cmp expected actual
    '

The conversion would drop 2 lines in this particular case and
would avoid bleeding the config should `git branch` fail (not
sure how possible that is...).

(I can make a patch for t3200 but that won't be before
days/weeks, so if someone else wants to take care of it I won't
mind)

If I have some time to kill, I'll try looking at a few others but
I won't expect that any time soon.

Thanks,
Rémi
