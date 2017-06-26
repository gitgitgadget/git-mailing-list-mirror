Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E61F620401
	for <e@80x24.org>; Mon, 26 Jun 2017 08:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdFZICj (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 04:02:39 -0400
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:60386 "EHLO
        zm-mta-out-1.u-ga.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdFZICh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 04:02:37 -0400
X-Greylist: delayed 541 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jun 2017 04:02:36 EDT
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
        by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id A1035A0296;
        Mon, 26 Jun 2017 09:53:33 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps1.u-ga.fr [152.77.1.30])
        by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 9CDDEE009B;
        Mon, 26 Jun 2017 09:53:33 +0200 (CEST)
Received: from anie (anie.imag.fr [129.88.42.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: moym@univ-grenoble-alpes.fr)
        by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 8B37A125EBA;
        Mon, 26 Jun 2017 09:53:33 +0200 (CEST)
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 5/5] stash: implement builtin stash
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-6-joel@teichroeb.net>
        <20170611212739.GA7737@hank>
        <CA+CzEk9i8H2BAUrL854WJELCTa-O1ONMWa0uOcTsW=WxnB_22Q@mail.gmail.com>
        <20170625210909.GB7737@hank>
Date:   Mon, 26 Jun 2017 09:53:33 +0200
In-Reply-To: <20170625210909.GB7737@hank> (Thomas Gummerer's message of "Sun,
        25 Jun 2017 22:09:09 +0100")
Message-ID: <vpqshini3r6.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Whitelist-UJF SMTP Authentifie (moym@univ-grenoble-alpes.fr) via submission-587 ACL (111)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> After the line
>
> test -n "$seen_non_option" || set "push" "$@"
>
> it's not possible that $# is 0 anymore, so this will never be
> printed.  From a quick look at the history it seems like it wasn't
> possible to trigger that codepath for a while.  If I'm reading things
> correctly 3c2eb80fe3 ("stash: simplify defaulting to "save" and reject
> unknown options", 2009-08-18) seems to have introduced the small
> change in behaviour.

Indeed. That wasn't on purpose, but I seem to have turned this

	case $# in
	0)
		push_stash &&
		say "$(gettext "(To restore them type \"git stash apply\")")"
		;;

into dead code.

> As I don't think anyone has complained since then, I'd just leave it
> as is, which makes git stash with no options a little less verbose.

I agree it's OK to keep is as-is, but the original logic (give a bit
more advice when "stash push" was DWIM-ed) made sense too, so it can
make sense to re-activate it while porting to C.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
