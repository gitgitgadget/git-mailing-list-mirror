Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ABC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 16:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhL3Qwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 11:52:42 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:43336 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235870AbhL3Qwm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 11:52:42 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        (Authenticated sender: jn.avila@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 58A4A19F5A6;
        Thu, 30 Dec 2021 17:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1640883160;
        bh=C8GTyNXk3Wpx4kRbt3JVD1lhqV1qVQv1UqvY5bVtBcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNjruOwsLpEyBWGk9Igin/K+29MtI/UTqiF/7IHq9YJofZwtxiDW24CoG+F4q5OQd
         pCYhp/Z8GfaVTcWRbeqf+Acr+nHEQJWrTLH6OmRuJqcCxk5Q0CBPYeQt0ibOQJescA
         83Md30HlieMNe4hwZEdXQaXgITjgffsYr2BMihx6A7GAUruUu706Wr5/hpMq04lPw6
         B4kFNRvOpUzY4XB+dILPVV92MMM7G6VC1iuNhbo88vvSXhigW2Yh86lgrHz4O+ZjTt
         oGJvCjoQdDWuoRCkl9gqV0zDGgAX/RdQle9Asxjv2vc9JTUdqdFn5ejwhFaGShEssX
         673/Q4xskw6Cw==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 03/11] i18n: turn "options are incompatible" into "cannot be used together"
Date:   Thu, 30 Dec 2021 17:52:30 +0100
Message-ID: <48262743.WQR3eRXon5@cayenne>
In-Reply-To: <233ae6c6-294f-f68c-51ca-ec83d25f05dd@kdbg.org>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com> <486cc6c89e2612761bc8835700c9c85c0b50ab55.1640804108.git.gitgitgadget@gmail.com> <233ae6c6-294f-f68c-51ca-ec83d25f05dd@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, 29 December 2021 20:36:59 CET Johannes Sixt wrote:
> Am 29.12.21 um 19:54 schrieb Jean-No=EBl Avila via GitGitGadget:
> > @@ -2867,24 +2867,24 @@ int setup_revisions(int argc, const char **argv=
, struct rev_info *revs, struct s
> >  	compile_grep_patterns(&revs->grep_filter);
> > =20
> >  	if (revs->reverse && revs->reflog_info)
> > -		die("cannot combine --reverse with --walk-reflogs");
> > +		die(_("options '%s' and '%s' cannot be used together"), "--reverse",=
 "--walk-reflogs");
> >  	if (revs->reflog_info && revs->limited)
> >  		die("cannot combine --walk-reflogs with history-limiting options");
> >  	if (revs->rewrite_parents && revs->children.name)
> > -		die("cannot combine --parents and --children");
> > +		die(_("options '%s' and '%s' cannot be used together"), "--parents",=
 "--children");
> > =20
> >  	/*
> >  	 * Limitations on the graph functionality
> >  	 */
> >  	if (revs->reverse && revs->graph)
> > -		die("cannot combine --reverse with --graph");
> > +		die(_("options '%s' and '%s' cannot be used together"), "--reverse",=
 "--graph");
> > =20
> >  	if (revs->reflog_info && revs->graph)
> > -		die("cannot combine --walk-reflogs with --graph");
> > +		die(_("options '%s' and '%s' cannot be used together"), "--walk-refl=
ogs", "--graph");
> >  	if (revs->no_walk && revs->graph)
> > -		die("cannot combine --no-walk with --graph");
> > +		die(_("options '%s' and '%s' cannot be used together"), "--no-walk",=
 "--graph");
> >  	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
> > -		die("cannot use --grep-reflog without --walk-reflogs");
> > +		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
>=20
> This last transformation does not fit the topic of this patch. It should
> go into patch 6/11, I think.
>=20

True! Will reroll after checking again.

JN



