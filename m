Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0141C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A683C60ED6
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 20:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbhH3Uuq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 30 Aug 2021 16:50:46 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:4584 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236459AbhH3Uum (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 16:50:42 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:d787:42d5:3b3a:1b26])
        by smtp5-g21.free.fr (Postfix) with ESMTP id C1A4C5FF67;
        Mon, 30 Aug 2021 22:48:54 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?ISO-8859-1?Q?R=FCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?ISO-8859-1?Q?D=EDaz?= 
        <christopher.diaz.riv@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
Date:   Tue, 24 Aug 2021 23:34:42 +0200
Message-ID: <3020682.V8qLCztWNM@cayenne>
In-Reply-To: <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet>
References: <20210822161325.22038-1-worldhello.net@gmail.com> <xmqqsfyzq1wq.fsf@gitster.g> <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mardi 24 août 2021, 11:27:44 CEST Johannes Schindelin a écrit :
> Hi Junio,
> 
> On Mon, 23 Aug 2021, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> For a push event, it will scan commits one by one. If a commit does not
> > >> look like a l10n commit (no file in "po/" has been changed), it will
> > >> immediately fail without checking for further commits. While for a
> > >> pull_request event, all new introduced commits will be scanned.
> > >>
> > >> "git-po-helper" will generate two kinds of suggestions, errors and
> > >> warnings. A l10n contributor should try to fix all the errors, and
> > >> should pay attention to the warnings. All the errors and warnings will
> > >> be reported in the last step of the l10n workflow as two message groups.
> > >> For a pull_request event, will create additional comments in pull
> > >> request to report the result.
> > >
> > > It is a good idea to automate this.
> > >
> > > I am a bit concerned that the `ci-config` approach, even if we use it in
> > > the Git project itself, is quite cumbersome to use, though. So I hope that
> > > we can find an alternative solution.
> > >
> > > One such solution could be to make the `git-po-helper` job contingent on
> > > part of the repository name. For example:
> > >
> > >   git-po-helper:
> > >     if: endsWith(github.repository, '/git-po')
> > >     [...]
> > >
> > > would skip the job unless the target repository's name is `git-po`.
> >
> > Nice.
> >
> > Can this be made into a matter purely local to git-l10n/git-po
> > repository and not git/git repository? I am wondering if we can ee if
> > the current repository is git-l10n/git-po or its fork and run it only if
> > that is true.
> 
> The biggest problem is that there are forks of `git-l10n/git-po` that
> accept PRs in their own right. That is what I tried to address by using
> just the repository name, without the org/user prefix.
> 
> Ciao,
> Dscho
> 

Well, I'm in this case, plus my repo is a fork of git/git. 

Would it not possible to formally require the presence of a "dumb" secret to run this rule? 

JN


