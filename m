Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55971FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbcHZNk6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:40:58 -0400
Received: from mout.gmx.net ([212.227.17.22]:49221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751085AbcHZNk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:40:57 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0La3c1-1bGdHK286f-00loMG; Fri, 26 Aug 2016 15:40:35
 +0200
Date:   Fri, 26 Aug 2016 15:40:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/15] sequencer: lib'ify prepare_revs()
In-Reply-To: <xmqqinuojwc4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608261534110.4924@virtualbox>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <ce6a7cac9f0bd53e44129c8f72818adc4bb4a934.1471968378.git.johannes.schindelin@gmx.de> <xmqqinuojwc4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BHr/2sXChsRK9HanNceiewZyF2HBleGCoaSm8uy0yjpbPJT7zDm
 ujny325OZXK0BKFxu4LxnkcjSsV2+IyxTWAIbgFXup4ZqKnfL0TxI6gRnMaaIV+Dw/D8KZv
 DlKlyYyqDxRVUnxowrsXvhQdRMd+NETmVJXbVcNE4Sz2gQlrz0Kwt8iJnhhMWEB+5j5lFox
 YRa2dJy4mUfo8OQXsn2Sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yfyhkgn3vrY=:T50n10380Yy4JEyRl4Kpc1
 AHz88UjrLTVX0/iVV+sj+Qmo+Quz2mLMq16MaVmjqYCFOrs3SaeowE8rDaNNoL9GajubFJHrr
 vJ2tASnbeZOm3ZmpTYaYiDNLRIBeGOVhTU4izLNUZMVnUQ/w835oBwKUwAay8Ixltd8UHdxj6
 uJkngCrlQdCLzXNDb4wBjBV9VrunkIu5k6zLvcih72RbeBBttrrMDBzGf+DEZ2ICCdAOrTXYj
 XfmenZ//e3DvgS0KNjthHr9RRi7obPB6C95tKI5zC49N4ufZN0lehWZXInrP76nw2W7MOEIFg
 Rmn5MsePpN0oki0EXgpig8fkNZv3vZ5EZbyAx1fJqXw6s3dovOjJyBuquZXxMLP6eNW8Juoqf
 2NxyxPN2WuEgli8E+XuuJed8CEdPHs8dzgMKxgS3JnmjVWE6zCZ95DWJy3wC78mwzIUedWnO0
 K1iEjdmJt1jBmtmq6On8n8x1mL9jrhgZYdXB0DGQhvbWnMIT54C71aPAnOLs/Ja9Lwbk1oP1Y
 csuxMweGa6GE30YUl5FCq1RRXHXw0kQImmENb7fe+WcVZGb2Mr7z/DB4BzpfK6E34HQdfQH8b
 ihJ1AluDrbh4ri8xB5aPbSYPMHP+l6Mf8glbptkJ9vXJUYsXQPdnT8fpdHQTOf2W4/mqrXS7/
 z0hhKOXkf30heL27m96qSOvJ2h2G9QX2KjV20ZLXpm0Z11dEKjDztDyGKquSCu/3CqDdRnzUt
 lcgmtyA5CGsfJbMD3Jl7ayMn01DImdr2UPZuk49JnTDlO12olnKAOfeHTYcNpHPxShycVcSaN
 fW37VDg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 25 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > To be truly useful, the sequencer should never die() but always return
> > an error.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> I am still looking at sequencer.c in 'master', but I do not think
> that the sole caller of this function, walk_revs_populate_todo(),
> is prepared to act on an error return from this function and instead
> it expects this to die() when in trouble.  And I do not think I saw
> the function touched in the steps so far.
> 
> So this step smells like a fishy conversion to me.

The fishy part is, of course, that I managed not to realize that the patch
libifiying walk_revs_populate_todo() came *after* this patch that libified
one of its callees, prepare_revs().

FWIW the same is true for sequencer_pick_revisions(), which was libified
way too late in the game.

This is once again a demonstration that a final patch series does *not*
reflect the process of developing it: in this case, the order of the
patches is the *opposite* of their development, as I libified functions
from the lowest, deepest call depth up to the top-level functions.

Fixed in v2,
Dscho
