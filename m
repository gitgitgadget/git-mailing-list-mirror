From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Wed, 11 Nov 2015 11:41:45 +0100
Message-ID: <56431B69.9010007@drmicha.warpmail.net>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net,
	dturner@twopensource.com, pclouds@gmail.com,
	sunshine@sunshineco.com
To: Michael Rappazzo <rappazzo@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 11 11:42:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwSqm-0007LL-5X
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 11:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbbKKKlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 05:41:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59501 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766AbbKKKlt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2015 05:41:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id F410520A7E
	for <git@vger.kernel.org>; Wed, 11 Nov 2015 05:41:47 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 11 Nov 2015 05:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Ps2azJdOTfrpk8r+rroEJXOdlRw=; b=CRJewe
	beF9yoDIu2J3ubFfoCHYB/3sE/PseTAkEeqbgmFaB3dkYc9JRQann83TZSrjuDOP
	4mfh8S+nUZp2RxXxzgAStDCZm68Rr7yIukHZJ7cHI//Fuy7V/ECTywVW4/GYHEBW
	8Zx94LbZN2auFoROS/eEGKA/J7SjDuwC7zs6Q=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Ps2azJdOTfrpk8r
	+rroEJXOdlRw=; b=AtWFPRxmjI7OPGXEX+ytdObywap4juCVCkrKOviYumUe775
	5w35DJ5DUZLERqhwZiDuP5B4aiiNQStfisZ6T+MC2PkwpmjavncSVpyv8g8HFbkK
	S00ST77P1XAQjtDNlNGX/MgbAwDQfLoRKWuImgxE1YpcKaDYKWYfMcVfr2hU=
X-Sasl-enc: 7I5zGXUi28K50VDwDai+PCqix7bYOw5PCuMS660xFR0M 1447238507
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8D978C016DB;
	Wed, 11 Nov 2015 05:41:46 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281158>

Michael Rappazzo venit, vidit, dixit 11.11.2015 03:11:
> This patch series is built on (based on) 'next' because it relies on
> worktree.c
> 
> `ff-refs` will update local branches which can be fast-forwarded to their
> upstream tracking branch.  Any branch which has diverged from the upstream
> will be left untouched by this command.  Additionally, there are options
> for '--dry-run' and to '--skip-worktrees'.
> 
> There are two primary update mechanisms for fast-forwarding a branch.
>   - For a checked out branch, emulate `git-merge --ff-only`
>   - For a non-checked out branch, emulate `git update-ref`
> 
> When run on a repo with multiple worktrees (created with git-worktree add),
> git-ff-refs will take that into account when fast-forwarding.  That is, it
> will run in 'merge --ff-only' emulation mode when a branch is checked out
> in a worktree, rather than in 'update-ref' mode.
> 
> The primary benefit of ff-refs will come for those who maintain several
> local branches which track upstream remote branches that update often.  The
> intended usage pattern is to run `git-fetch` followed by `git-ff-refs`.

I'm sorry, but I don't see why this deserves a new command. If refspec
with and without "+" are not enough then maybe "git fetch --all" or "git
remote update" should learn a new "--ff-only" option (ignoring all "+")
like merge has.

As for updating worktrees: This shouldn't be taken too lightly anyways.
But the worktree interface still has some rough edges, and I would hope
that it learns a "foreach" subcommand very much like the submodule
version. That would allow you to

git worktree foreach git merge --ff-only

with a systematic aproach that opens many other opportunities.

Michael
