Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A024820193
	for <e@80x24.org>; Wed,  2 Nov 2016 21:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755744AbcKBViI (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 17:38:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbcKBViI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 17:38:08 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 86E06C04B30E;
        Wed,  2 Nov 2016 21:38:07 +0000 (UTC)
Received: from mail.random (ovpn-116-31.ams2.redhat.com [10.36.116.31])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id uA2Lc68w015184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 2 Nov 2016 17:38:07 -0400
Date:   Wed, 2 Nov 2016 22:38:05 +0100
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: send-email garbled header with trailing doublequote in email
Message-ID: <20161102213805.GJ4611@redhat.com>
References: <20161102202709.GI4611@redhat.com>
 <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161102211118.sc4j3fezfqxg23i3@sigill.intra.peff.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 02 Nov 2016 21:38:07 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Nov 02, 2016 at 05:11:18PM -0400, Jeff King wrote:
> In fact, it is not even git that does this, but rather what
> Mail::Address happens to output (though git has fallback routines if
> that module isn't available that do the same thing).

If it's something in perl it should be fixed there indeed. I didn't
debug what exactly was wrong, so I sent it here first.

> But in either case, in my test, the actual email address is still
> extracted correctly and fed to the MTA, so the mail is delivered.

The email is delivered to the right email for me too, but to see the
problem you need to check the email itself, and look how the To: field
looks in the actual email in your mail client or web interface.

Don't you see whatever@yourhostname without spaces and @yourhostname
instead of the email domain?

If you still can't reproduce, maybe it's a different perl
Mail::Address, I'm using dev-perl/MailTools-2.140.0

From who receives the email it just looks garbled, but --dry-run
showed a correct To/Cc list so it was undetectable that it would end
up garbled during the real email delivery.

> So I'm not sure what you wanted to happen that didn't. Did you want
> --dry-run to complain about the bogus address? Did the message not get
> delivered for you? Something else?

If --dry-run complained and failed instead of passing and then sending
an email with garbled To/Cc list, it'd be more than enough. Either
that or it should generate a mail header that matches the output of
--dry-run so the review of --dry-run becomes meaningful again.

Thanks,
Andrea
