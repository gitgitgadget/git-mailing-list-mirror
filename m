Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30677C433B4
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E6A61057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbhCaTAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:00:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:38932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235282AbhCaTAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:00:09 -0400
Received: (qmail 30774 invoked by uid 109); 31 Mar 2021 19:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 19:00:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6623 invoked by uid 111); 31 Mar 2021 19:00:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 15:00:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 15:00:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
Message-ID: <YGTGt+xGM9FN/ewm@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g>
 <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
 <xmqqv9976u9d.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv9976u9d.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 11:41:18AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
> > +				error(_("object %s is a %s, but was referred to as a %s"),
> > +				      oid_to_hex(&obj->oid), type_name(obj->type),
> > +				      type_name(type));
> > +			else
> > +				error(_("object %s referred to as both a %s and a %s"),
> > +				      oid_to_hex(&obj->oid),
> > +				      type_name(obj->type), type_name(type));
> > +		}
> 
> Am I correct to understand that the latter is after we read a tree
> that refers to an object with 100644 (blob) and then another tree
> that refers to the same object with 40000 (tree), before we have a
> need/chance to actually find out what that object is?  The error
> would trigger while reading the second tree and find the second
> mention of the object that conflicts with the earlier one?

Yes, exactly (or two tags, or a tag and a tree, or a commit and a tree,
etc).

-Peff
