Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9511520189
	for <e@80x24.org>; Sun, 19 Jun 2016 04:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbcFSEcp (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 00:32:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39714 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbcFSEcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 00:32:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEA52018B;
	Sun, 19 Jun 2016 04:32:43 +0000 (UTC)
Date:	Sun, 19 Jun 2016 04:32:43 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] prune: keep files created after process start
Message-ID: <20160619043243.GA26443@dcvr.yhbt.net>
References: <20160619031338.GA5161@dcvr.yhbt.net>
 <xmqqa8ihygms.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8ihygms.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >  I'm somewhat surprised this check didn't already exist;
> >  but maybe nobody else runs prune manually, anymore.
> 
> The only time an end user would run "git prune" in their
> repositories with working trees these days is "git repack" followed
> by "git prune", I would guess.

Right, I wanted to drop some sensitive data with that.

> You generally cannot compare a timestamp you read from the
> filesystem and the timestamp you obtain from time(2) when network
> filesystems are involved, so I am not sure the implementation is
> quite right, though.

Yes, but I'm not aware of a good way to deal with this;
I would expect machines on the same network would have
synchronized times.

Perhaps having a small slack time (one second?) could mitigate
some problems with machines being slightly off:

       start = time(NULL) - 1;

And then warning if it encountered files within the slack
period and asking the user to rerun "prune" if needed.
But I'm not sure it's worth it.

Any other suggestions?

Thanks.

Having prune prevent object creation entirely while running
seems unacceptable.
