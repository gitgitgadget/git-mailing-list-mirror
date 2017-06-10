Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C4B720282
	for <e@80x24.org>; Sat, 10 Jun 2017 03:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbdFJDVp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 23:21:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50968 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdFJDVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 23:21:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0C04720282;
        Sat, 10 Jun 2017 03:21:44 +0000 (UTC)
Date:   Sat, 10 Jun 2017 03:21:43 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 1/2] git-compat-util: add a FREEZ() wrapper around
 free(ptr); ptr = NULL
Message-ID: <20170610032143.GA7880@starla>
References: <20170609085346.19974-1-avarab@gmail.com>
 <20170609220420.4910-2-avarab@gmail.com>
 <20170609222738.GF21733@aiede.mtv.corp.google.com>
 <20170609233701.GA7195@whir>
 <xmqq60g462nd.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60g462nd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > I don't see the point of a macro wrapper, forcing the user to
> > type out the '&' should drive home the point that the pointer
> > gets set to NULL.  I also find capitalization tiring-to-read
> > because all characters are the same height.
> 
> Sounds sensible.
> 
> So make Jonathan's freez_impl a public API and rename it to
> free_and_null(), perhaps?

Perhaps...  I think it needs to take "void *" to avoid warnings:

	static inline void free_and_null(void *ptrptr)
	{
		void **tmp = ptrptr;

		free(*tmp);
		*tmp = NULL;
	}

...At least I needed to do that for "mog_free_and_null" in
cmogstored:

	https://bogomips.org/cmogstored.git/plain/alloc.c?h=v1.6.0

But heck, maybe that's covering up for something else I got
wrong in cmogstored *shrug*    I don't know all of C.
