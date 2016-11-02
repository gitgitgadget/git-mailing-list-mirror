Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB1320193
	for <e@80x24.org>; Wed,  2 Nov 2016 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756891AbcKBW3E (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 18:29:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32293 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755851AbcKBW3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 18:29:03 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B1F061B93;
        Wed,  2 Nov 2016 22:29:03 +0000 (UTC)
Received: from mail.random (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA2MT1M0017106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Nov 2016 18:29:02 -0400
Date:   Wed, 2 Nov 2016 23:29:01 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161102222901.GK4611@redhat.com>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
 <20161102213805.GJ4611@redhat.com>
 <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102220437.5ewzezxs2nasyouv@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 02 Nov 2016 22:29:03 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 06:04:37PM -0400, Jeff King wrote:
> Nope, it looks exactly as --dry-run reports it.

My sendmail is postfix 3.1.0.

> To see exactly what is being sent out, try:
> 
> -- >8 --
> 
> cat >/tmp/foo <<\EOF
> #!/bin/sh
> echo "args: $*"
> sed 's/^/stdin: /'
> EOF
> 
> chmod +x /tmp/foo
> 
> git send-email --smtp-server=/tmp/foo --to=whatever
> 
> -- 8< --

Right it's the same as --dry-run:

stdin: To: "what ever" " <.....>

There's not my hostname and not removed space. If I add more addresses
they also go in the second line with a leading space and they're not cut.

So this must be postfix then that out of the blue decided to garble it
in a strange way while parsing the input... The removal of all
whitespaces s/what ever/whatever/ especially I've no idea how it
decided to do so.

Can you reproduce with postfix as sendmail at least? If you can
reproduce also see what happens if you add another --to.
