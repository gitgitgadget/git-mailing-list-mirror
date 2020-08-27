Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F768C433E2
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D047207F7
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 23:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpwn.com header.i=@cmpwn.com header.b="Pid7WaQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgH0XEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 19:04:20 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:48022 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbgH0XEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 19:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1598569459; bh=eXIjNaY9VRpSzd41pAx0LyeKDpdJGEXxBA9vpoA7dkI=;
        h=Cc:Subject:From:To:Date:In-Reply-To;
        b=Pid7WaQ8AzQQTHCyJ6gfrFTZ7bC2G1pgr64230DW3vBS2pHDUZtcf22RFSrmfpt6j
         bAw23lqErEQpmPDV5vriS5YNceFZLBi5iv4fjgXP47ilFh+1LyBfnEMS29q2tIuZ8Z
         Ws4VedzTZOpuefTsGtDZzuKkCYf1QobXZgWmNiFw=
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Drew DeVault" <sir@cmpwn.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: do not prompt for In-Reply-To
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Junio C Hamano" <gitster@pobox.com>,
        =?utf-8?q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Date:   Thu, 27 Aug 2020 18:59:01 -0400
Message-Id: <C585GT9K2V93.4O470Q21FXFD@homura>
In-Reply-To: <xmqqd03bpuh7.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 27, 2020 at 6:57 PM EDT, Junio C Hamano wrote:
> To help those who do not want to add this header, it would probably
> be more helpful to tell what to do when prompted (like "you can give
> an empty answer to tell the command that you are not responding to
> any message").

I don't like this solution. We should make it harder to do the wrong
thing, and easier to do the right thing.

It would be helpful for git to take an opinionated stance on the right
way to send emails with it, since no one else is really in the position
to. This behavior has confused many people that I've spoken with and
makes for a rough introduction to a tool which people are already loathe
to learn. git send-email is really the best way to send emails with git,
and will save the user a lot of trouble in the future if they figure it
out, so I want it to be as easy to figure out as possible.

Even so, I understand the concerns raised so far. I haven't started on
v2 yet, but my rough plan is to add a config option along the lines of
sendemail.verbosePrompts, defaulted to on for now, which enables the
present-day behavior, along with a message stating the intention to
change the behavior in a future release, and an invitation to comment on
the mailing list.

The behavior of this flag if set to false would be equivalent to
removing the $prompting condition in the if statement which controls
whether or not this prompt is shown.
