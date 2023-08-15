Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694C4C001B0
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 15:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjHOPZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 11:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbjHOPZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 11:25:47 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A4E74
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 08:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1692113134; x=1692717934; i=tboegi@web.de;
 bh=pHmS9ff+soygQD9TVI1BCAlAay/Ba3D/nJUylivDuIE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=p7OyVJutOFBaV9Mi0CBj7e7GmAxjZJOR/nV4k+7W4MO76CSVYSUqbGIi4vlpcJ/onZGlKi8
 V9QPv1hvGr8du93nlr06NIq5NJmzWuQUIo4oiy7eEzODhqC+b5Iawfs/r3e0iiXW9XAryspgz
 tJU6HiBAqMuDOhG+sKq2KwpgfgLJ3jV5guvwx2zmad4F+c2zteHfyfSUUK7k9CmVjK7VPH6Tx
 md0/KKkUgzRTZRFTkL0/lZ0+2SzckRoS/YVmuMP4WhjPJE5umI8dDlQwZ8qBuOFUaY/VzC+9F
 G0/FXPYc8vvRU7jo+5iRv5sMNSZSLdk2FHpRmLsJq40jOHsEMz4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWz8l-1qGKyV1L4r-00XKds; Tue, 15
 Aug 2023 17:25:34 +0200
Date:   Tue, 15 Aug 2023 17:25:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, friebetill@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Message-ID: <20230815152511.suipgnzr2wgolmsx@tb-raspi4>
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
 <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com>
 <20230809184751.ffwolkvjwoptnmen@tb-raspi4>
 <9f76de24-d337-ed41-fb81-888dba0b1656@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9f76de24-d337-ed41-fb81-888dba0b1656@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:SJ4ACOgyANcOxUXKhsZy9YSFxxaaE+UoaR+yDc/bH1hu9rqdJWz
 3E53//ZQjeZfYGxG/EVMguSaNxWQCZDvBW87gtcPhAR+hCepNHS34GOK7xqGLOpINyOOmvU
 odeqMEZmZy5pDBh6MknhblP7SY86bcKRIWV5/+bwBYNM112ysE0t80GSYUB3TkHkC9uYLZv
 jzP5LfYYIErG7xwsiJWyQ==
UI-OutboundReport: notjunk:1;M01:P0:T7GL/0NiF8A=;7RIlyAUb5p9UTHY/fsZyGGmppLk
 m250HvJRCQtT6OOGw2/ol14E7cl0MJtCFFcoJAcSjzlIk9Tha0zQOV2OLOIL1GYGHvk2xSamh
 bNw+/yN3zKr7PmmmDh3YEkXlDjIYYM9QF19s9UZo4AxoIfRFI2tXrcj8gQtuhnyYH8l8aJG2L
 qCkX7vV3BbyrsNtJm1og60ghlAHgLqbph5zOlyw/ohHF0g7fj29iOmNAAEcHjK+hViejN42kR
 sbHkviU/kO9DfPhzcouF2Hq7AQsh1EO2gvVRDzhzeOV4xvDam3HfeT3j55WS4mni94UU9cAdE
 n6PGMIsrHG+z+pRHyZHJ/FUDRDeuNoSO6MZswpHNdl/OxrosPmrWO/0OkEiShIvxBBU1C/txP
 +YtmGDIXtJ9NGTWq6nZ8rubLusMLH1TClH4gdSpWJxybCgvHCbiZUiBkicAKnz1W/kXOPnldo
 8V7fWNgFWbiNHVTPT5/x3++tcgyrEAUxXEYaC0TjoMfAgBy5ED/j9geXIr6VQeAk/yyZrDN60
 FQgACEeDzq5ccNfNhbisUYWoR9R2itcl9MuGuwZ6T0TpSpYhBP+8a7VltM20MwQXZEc7enxIg
 NnhJSATkcSoGhOyx8SaxQlcb6plrcRahd/rfjJ96PT81cQPA5dHExO11pYF2TZtJck6Sh50MK
 fsYdu0fYLO0lGgSmLL7Um4EFuAKwpb23gtXqlB5GZz+3qZMTNT5r9UNp/C6ymeoDHrLpL3CzQ
 fPodbUligILLaHUa4tjofpjx+1O132xgnsTjGtcP6et9uMcd4gEvIL7dR8YzqaXe73UCsGalE
 tHW0wZdpj+5OkvZIWc9efvtY5SL3RNrOPssGiUgmsibeL10e8fy3aBoplp8F0AVZDwjoBSMPe
 zfE14cA0oqP42foq5P0CXhKkUp0EbpFnC/G7VNNz3oR4yBomnx6joyBzonIbcZzNHdq7r5iy0
 YxV5hzcpT9tTllGd//sye/qYhBM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 10:15:37AM +0100, Phillip Wood wrote:
> Hi Torsten
>
> Sorry for the slow reply

No problem.
Thanks for the response, I think that we have an
agreement not to overwrite an untracked file, when a directory
with the same name needs to be created.

I try to come up with a patch series -
starting with the stash operation.

>
> On 09/08/2023 19:47, Torsten B=F6gershausen wrote:
> > On Wed, Aug 09, 2023 at 02:15:28PM +0100, Phillip Wood wrote:
> > > Hi Torsten
> > >
> > > Thanks for working on this. I've cc'd Junio for his unpack_trees()
> > > knowledge.
> >
> > Thanks Eric for the review.
> >
> > Hej Phillip,
> > I have been playing around with the whole thing some time.
> > At the end I had a version, which did fiddle the information
> > that we are doing a `git stash` (and not any other operation)
> > into entry.c, and all test cases passed.
> > So in principle I can dig out all changes, polish them
> > and send them out, after doing cleanups of course.
>
> I don't think we should be treating "git stash" as a special case here -
> commands like "git checkout" should not be removing untracked files
> unprompted either.
>
> > (And that could take a couple of days, or weeks ;-)
> >
> > My main question is still open:
> > Is it a good idea, to create a "helper file" ?
> > The naming can be discussed, we may stick the date/time
> > into the filename to make it really unique, or so.
>
> I think stopping and telling the user that the file would be overwritten=
 as
> we do in other cases would be better.
>
> > Reading the different reports and including own experience,
> > I still think that a directory called ".deleted-by-user"
> > or ".wastebin" or something in that style is a good idea.
>
> I can see an argument for being able to opt-in to that for "git restore"=
 and
> "git reset --hard" but that is a different problem to the one here.
>
> Best Wishes
>
> Phillip
>
