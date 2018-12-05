Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 520A8211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 05:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeLEFyS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 00:54:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:59406 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726092AbeLEFyS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 00:54:18 -0500
Received: (qmail 833 invoked by uid 109); 5 Dec 2018 05:54:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 05:54:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28210 invoked by uid 111); 5 Dec 2018 05:53:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Dec 2018 00:53:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Dec 2018 00:54:16 -0500
Date:   Wed, 5 Dec 2018 00:54:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 3/3] sha1-file: change alternate "error:" message to
 "warning:"
Message-ID: <20181205055415.GA12980@sigill.intra.peff.net>
References: <87tvjtvah0.fsf@evledraar.gmail.com>
 <20181204132716.19208-4-avarab@gmail.com>
 <xmqqva48d4o9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqva48d4o9.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 05, 2018 at 12:37:58PM +0900, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Change the "error" message emitted by alt_odb_usable() to be a
> > "warning" instead. As noted in commits leading up to this one this has
> > never impacted the exit code ever since the check was initially added
> > in 26125f6b9b ("detect broken alternates.", 2006-02-22).
> >
> > It's confusing to emit an "error" when e.g. "git fsck" will exit with
> > 0, so let's emit a "warning:" instead.
> 
> OK, that sounds sensible.  An alternative that may be more sensible
> is to actually diagnose this as an error, but the purpose of this
> message is to help users diagnose a possible misconfiguration and
> keeping the repository "working" with the remaining set of object
> stores by leaving it as a mere warning, like this patch does, is
> probably a better approach.

Yeah, I think it's better to keep it as a warning. It's actually
reasonably likely to be benign (e.g., you did a "git repack -ad && rm
/path/to/alternate" to remove the dependency, but forgot to clean up the
alternates). And when it _is_ a problem, the object-reading code paths
will definitely let you know.

-Peff
