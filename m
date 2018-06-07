Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5DE31F403
	for <e@80x24.org>; Thu,  7 Jun 2018 02:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeFGCX5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 22:23:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752991AbeFGCX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 22:23:56 -0400
Received: (qmail 13598 invoked by uid 109); 7 Jun 2018 02:23:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Jun 2018 02:23:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11720 invoked by uid 111); 7 Jun 2018 02:24:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 22:24:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 22:23:54 -0400
Date:   Wed, 6 Jun 2018 22:23:54 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180607022353.GA3898@sigill.intra.peff.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
 <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 07, 2018 at 01:16:14AM +0100, Ramsay Jones wrote:

> > Probably. We may want to go the same route as we did for perl in 
> > a0e0ec9f7d (t: provide a perl() function which uses $PERL_PATH,
> > 2013-10-28) so that test writers don't have to remember this.
> > 
> > That said, I wonder if it would be hard to simply do the python bits
> > here in perl. This is the first use of python in our test scripts (and
> 
> Hmm, not quite the _first_ use:
> 
> $ git grep PYTHON_PATH -- t
> t/lib-git-p4.sh:        (cd / && "$PYTHON_PATH" -c 'import time; print(int(time.time()))')
> t/lib-git-p4.sh:        "$PYTHON_PATH" "$TRASH_DIRECTORY/marshal-dump.py"
> t/t9020-remote-svn.sh:export PATH PYTHON_PATH GIT_BUILD_DIR
> t/t9020-remote-svn.sh:exec "$PYTHON_PATH" "$GIT_BUILD_DIR/contrib/svn-fe/svnrdump_sim.py" "$@"
> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
> t/t9802-git-p4-filetype.sh:             "$PYTHON_PATH" "$TRASH_DIRECTORY/gendouble.py" >%double.png &&
> t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_k.py" <"$git/$file" >"$scrub" &&
> t/t9810-git-p4-rcs.sh:  "$PYTHON_PATH" "$TRASH_DIRECTORY/scrub_ko.py" <"$git/$file" >"$scrub" &&
> $ 

OK, the first for a feature that is not already written in python
(leading into my second claim that python is used only for fringe
commands ;) ).

Though maybe I am wrong that the remote-svn stuff requires python. I
thought it did, but poking around, it looks like it's all C, and just
the "svnrdump_sim" helper is python.

At any rate, I think the point still stands that perl is our main
scripting language. I'd rather keep us to that unless there's a good
reason not to.

-Peff
