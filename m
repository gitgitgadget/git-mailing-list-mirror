Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5816C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 15:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8A522B37
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 15:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406248AbhAZPWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:22:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:55647 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406333AbhAZPWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 10:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611674375;
        bh=Y4KmVyCj0lhb4b+ma7rGduX60xDKiuwCeKBwvvGlk+Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dMO8ojd2Z88Q2ghpsiX0OygR55IsD0zIAc5LEZ4qTvkIn+pcLbMhWhQQOs7ukFS2j
         +i5Lxdd/GV8ZcZdLfGEPwJwwkecBNhlFCp1UnFOIEYJdhytkJLxGZYzsLTNQCX/RZ0
         Gu0ahqPnWBI0+7e1xji9hwm/5W9bnYa1TD0mCFso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MY68T-1lU1VK1WKj-00YSRN; Tue, 26
 Jan 2021 16:19:35 +0100
Date:   Tue, 26 Jan 2021 16:19:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] range-diff: refactor check for commit range
In-Reply-To: <a0b100e7-57b8-df46-de2b-d54fdbe6a255@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101261618520.57@tvgsbejvaqbjf.bet>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com> <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com> <0ce0953a-92b2-2ce6-1e13-6f6240933ce1@gmail.com> <xmqqbldg7hvb.fsf@gitster.c.googlers.com>
 <a0b100e7-57b8-df46-de2b-d54fdbe6a255@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:R6DbWIOiQRhZzRlhEXh7pArOLdNJ71J50Z8+F6ckP3o/K2KvORx
 DWP8bM6e5mi+NWCLWo3yAZC0iEpz1Z0+HejoIkag0e59XT04/6Dqm+yvaXVcUWUaeNPhex6
 3iZXkRU5gcDSc2M0WEbsxWEbs+EzudWSvQ34WOUEQhnq+mPa4FVnZt1rFJgCMXuItGP4rok
 h1UcGpvfqDGhb4ZTOs5YQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jPGFpoCkhIA=:EeN5H+dZtL921HQLHTV+MK
 yqP6l8ngfy5iF5tXRcOWe8znK7oGzXGN+OO2hiQNdb2qw1aUcOGuQks2RzpwretdN2kgCrpB8
 LU1RvRt3VTRk/Hbh52iIiKoUBPlapvxW4CcIeKAtvFEv+EMeyuVMN6shhzixLNKuYp6WXt+AI
 5vudx/7/tbIzIJQhJ80kRImL9mtbe45eorOc9iO7vSQYDk4HQhDeWXQcucO9RS8PEhNvq1v7r
 SuKYDFGIZ+XXO8ThI8264MMWTF214390JgbHHTjJks5XqOnh+bN5xVfT+Bq5b5QQF2R6mpfXN
 lYO36YsT97xVhX9/qWqtu6UAtynGW5qhTjAe2JFAV2tmCg7rjrQJo7u4QaxOCc2U9TsNdHgco
 SXEIrzFxahXozFYDvLUeoG9qs//v1Fv/a88LfgrfWgBFvVHf43bc0+AphX/EORJk2rY5eegsn
 YvE8nrLhMz41sbKK0uMFdjwGzQJIeiFZv9mlcpwR6xt1ehPOMg+22TgFCkXmLI3VqPg5iYcMt
 M/1ZnoSdE91cc0gvGhs6nka6/IClfZYGwwwzv+LbPygXlqtdNt9cRPFRloy1yLeE1OehJJmjh
 GQY5Q18GvewMietLpj3cUD50shc9twdJXUOljC8yEDQ14VXL3RCWgZrEfRum44MJ1PR+/72TJ
 E4tl7nF0JfySvOuDDsaEgvOHoo+FgsfM5BCUsYta9wUCDZmdj3uGwwuzvBGJ2yHHuBlvSqbrf
 OLz4TYgSUxhDm6Bu/wxP2KNzkXr/HiQiDa5vtW6QKXEDPl3F2yKfhqt52n/5uHbB8ubpsbthq
 fKSJYBdqUPtmYUxpfOYFbqDHnWPgn/IHJOuz4zZQVIUmIWNal8dJmjmid95mQBeanmDOURuup
 QywE8s16Ng78OmVgEXAOelHeBPqp4YLEL9IENMoPQ=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sat, 23 Jan 2021, Phillip Wood wrote:

> On 22/01/2021 21:59, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood123@gmail.com> writes:
> >
> > > >    +static int is_range(const char *range)
> > > > +{
> > > > +	return !!strstr(range, "..");
> > > > +}
> > >
> > > If the user wrongly passes two arguments referring to single commits
> > > with `:/<text>` or `@{/<text>}` where text contains ".." this will
> > > give a false positive.
> >
> > True.  I do not think this aims to be complete revision parser in
> > the first place, though.
>
> Yes but it affects the error message given to the user.

True. But my patch series does not try to fix that (it is not an issue
_introduced_ by this patch series, it was there all along).

Ciao,
Dscho
