Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C125DC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4026D20658
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="YzRdZq6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIHUAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:00:05 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:55704 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730463AbgIHPfg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1599575262; bh=jQEbQGdcUCy3syuJXgj6lsOe5ks+BzJnDSUMr8CjsjQ=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=YzRdZq6yW8rLq3ZGejic9a5Cl3eZ6PqnyPTr20+S7cBdYsxu/HIBB2Hip+dC6bePF
         RqAb3GVbT1YsWiIkV5F2A014o+LGqzS8vm91yDCvdD/bCE//Za3LCv8Co7R/Fns2fB
         b7i4Sa0Pm8ASzLTmg22QqMO3pgcfq6A0StvtI/0c=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: Proposal: server-advertised config options
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Date:   Tue, 08 Sep 2020 10:14:47 -0400
Message-Id: <C5I1TZ1OCN40.2BHKV9GD572FL@homura>
In-Reply-To: <20200907205242.GF241078@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Sep 7, 2020 at 4:52 PM EDT, brian m. carlson wrote:
> The Git security model doesn't permit untrusted config options, so I
> think it's risky to add support for config options from the server
> side. We need to consider not only advanced users who are going to be
> able to make a good decision here, but novice users who are struggling
> to understand how Git works and are prone to social engineering. Just
> because your server is not malicious does not mean that others aren't.

Hm. If we view some of these use-cases as legitimate, maybe it would
make sense to only permit a hard-coded list of config options to be
advertised, removing all other configurability to avoid letting users
configure themselves into a compromised system (potentially via social
engineering). For example, project policies like sendmail.to and config
options in the server's domain like push options would be in-scope, but
something like core.editor would be out of scope.

> In addition, if I'm cloning a repository just to build it, I don't want
> to be prompted to set those configuration options at all. My experience
> in Git hosting is that clones and fetches far, far outnumber pushes, so
> adding a prompting feature adds a bunch of impediment with little gain
> for the vast majority of users.

That alternative approach would also eliminate the need for prompting.

> That doesn't mean you can't provide a downloadable shell script that
> people could check into their repositories to configure this for the
> user.

Yeah, but that also eliminates most of the convenience factor and is
even more of a risk.

> It doesn't automatically "just work", but it also lets projects decide
> for themselves what their settings should be. Just because a site
> offers, say, mailing lists, doesn't mean that folks will want to use
> those mailing lists. For example, the Go language repository is hosted
> on GitHub, but uses Gerrit for code review, not GitHub pull requests.

Note that in the case of sourcehut, mailing lists are optional. It's not
like GitHub where you can't turn off pull requests and have to deal with
rejecting them manually or set up a bot to auto-close them or something.
