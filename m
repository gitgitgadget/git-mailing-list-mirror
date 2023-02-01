Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE4C636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBAMV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBAMV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:21:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064F37B4E
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:21:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 19A9133CD7;
        Wed,  1 Feb 2023 12:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675254114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aa0UORKVWhmFdCU2sA3CAfWdj4VlwTRRnhDI/yuo8TU=;
        b=10DSPRQ/n8+R9GW9PgVY6PM39XMM6rS9YPbYzUZEhyJ95OhGdD9AbPlNpT6K59qjT+GuOo
        MJOXxpzr2gL8A9r3xl3cY2lsAmaD6IvXKcFmZi1iDbFBzWN2xLL1vQuDW+E0SWIkjFgwai
        iKk0Wi/Hesttnas1n9D5u4kuZEO2jH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675254114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aa0UORKVWhmFdCU2sA3CAfWdj4VlwTRRnhDI/yuo8TU=;
        b=AacS4AiMPWNdga9Z3MAP90DJvdpSoBGaMhbGh7SOIsNch83jOk7ZK1P/0YVCIpiKjBYYsE
        o6BedyTz6ff63zAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA4512C141;
        Wed,  1 Feb 2023 12:21:53 +0000 (UTC)
Date:   Wed, 1 Feb 2023 13:21:52 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     demerphq <demerphq@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eli Schwartz <eschwartz93@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and
 a possible solution
Message-ID: <20230201122152.GJ19419@kitsune.suse.cz>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
 <20230131150555.ewiwsbczwep6ltbi@meerkat.local>
 <Y9mXB1LaYSUJBlwF@tapette.crustytoothpaste.net>
 <230201.86pmatr9mj.gmgdl@evledraar.gmail.com>
 <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANgJU+V0QRFwmTh8ZzY=28kmbUw=DvSLE24LioOXp6_ozq+RdA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 12:34:06PM +0100, demerphq wrote:
> On Wed, 1 Feb 2023 at 11:26, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > That would be going above & beyond what's needed IMO, but still a lot
> > easier than the daunting task of writing a specification that exactly
> > described GNU gzip's current behavior, to the point where you could
> > clean-room implement it and be guaranteed byte-for-byte compatibility.
> 
> Why does it have to be gzip? It is not that hard to come up with a
historical reasons?
