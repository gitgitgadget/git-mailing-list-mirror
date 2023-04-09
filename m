Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC0C77B6F
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDIRBP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDIRBO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 13:01:14 -0400
Received: from pulsar.hadrons.org (2.152.192.238.dyn.user.ono.com [2.152.192.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6422D5D
        for <git@vger.kernel.org>; Sun,  9 Apr 2023 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hadrons.org
        ; s=201908; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:From:Reply-To:Subject:
        Content-ID:Content-Description:X-Debbugs-Cc;
        bh=+rkrMLm0gpYdK2a/bO9BUnFXdy77+aoTlAdA+EO2Q4Q=; b=dC9PPsHCnR5/I1tP6iWY5He1av
        yQOKmNZuxIhOk8pvan6+PHxHql8BqCXyqe5uLSCeNaUxJj2Mc7Dd8Mde9RTVXYQo0B5Twrop2YgoR
        rVxlqQSpYpCIM4GWO55VJ7g//vKCO5hodq+KPaQvzhKx/ppPuJh2DgIQ3S+spOzndciILvxJde05s
        astzCZRV+GiOzb+x5BhSbrrOCsjLqVe+FnKv9i+6Hwm48EX1MT99OfPU7Ypo9MR/P2MET+4KAVMIE
        LrePBtcHQo5y2cVqnKbYjK6uCwHhXDjsCq6zWUB7iDESccDXuwzdVVGYTPuMzmM0+DdHW7e0+qfgD
        umy2tEkQ==;
Received: from guillem by pulsar.hadrons.org with local (Exim 4.96)
        (envelope-from <guillem@hadrons.org>)
        id 1plYPb-00005h-0t;
        Sun, 09 Apr 2023 19:01:07 +0200
Date:   Sun, 9 Apr 2023 19:01:07 +0200
From:   Guillem Jover <guillem@hadrons.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Add a way to disable =?utf-8?B?wqtn?= =?utf-8?Q?it_clean=C2=BB?=
 per repo
Message-ID: <ZDLvUxp0d33VgFQY@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@hadrons.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <ZCiZCM+AAUnjp4Ml@thunder.hadrons.org>
 <xmqq355g6f6u.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq355g6f6u.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On Mon, 2023-04-03 at 10:36:25 -0700, Junio C Hamano wrote:
> Guillem Jover <guillem@hadrons.org> writes:
> > Accidentally running «git clean -xdf» or «git clean -Xdf» might be
> > catastrophic there.
> 
> So would accidentally running "rm -fr" there be catastrophic, too.

Sure.

> I doubt it would make much sense to file a feature request to Debian
> or GNU/FSF to disable "rm -r" in certain directories.  I am not sure
> why "git clean" should be any different.

Right, but I see a substantial difference though, «git clean» is
part of the git toolset to manage among other things specific work
trees, where that behavior is controlled through configuration, and
is as such confined within those specific realms, where also the
properties of what is being tracked might be different.
(With GNU coreutils rm you can confine it within one filesystem with
--one-file-system, but TBH I've never had the need to use it AFAIR,
and it's not enabled by default.)

> Commands like "git clean" require "-f" before they become overly
> destructuve for a reason.  clean.requireForce defaults to true for
> the same reason.

Right, I guess that's another reason for me why I see these («rm» vs
«git clean») as not being entirely comparable. Using «rm» requires in
most cases no force options, even when removing recursively (with -r),
while «git clean» by default will fail fatally (for all invocations
AFAICS?), so perhaps I'm holding it wrong, but when you end up invoking
a command very often (f.ex. to make sure your project is building from
a clean state), which requires using a force option (because passing -i
would become very cumbersome very quick), that becomes a habit or part
of your muscle-memory (perhaps a bad one), that means I tend to not pay
as much attention as I'd do when running «rm -rf» (also because of the
confinement I mentioned above).

For now it occurred to me that I could create dummy git repos in
parent directories to act as «git clean» barriers, so that it does not
propagate further up in the directory tree, but that still seems like
a hack, and I'd really like to protect specific work trees where I know
I never want to be able to run «git clean».

Thanks,
Guillem
