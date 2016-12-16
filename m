Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31691FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758119AbcLPVFm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:05:42 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:55661 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758051AbcLPVFj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 16:05:39 -0500
Received: from homiemail-a18.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 7D919FF21C
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 13:05:35 -0800 (PST)
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id CC0E2258069;
        Fri, 16 Dec 2016 13:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:content-type:mime-version:
        content-transfer-encoding; s=novalis.org; bh=Q7vMBVfRxIjGAmZ7uh6
        vt7dGr04=; b=qnEkvhuKkYKqKBUYET0SayH5sTMTRVL+S7UQM6AVIBZGELxHhPN
        9t38HMCEFvEl7gjCLzZ9dAt14gQmiNWdgTyF96Wi6rghQfAG40BlT2lKi9wyv1A0
        wPirKWYpJIwGRtjp3D38ueAuvdAWBFsGvvhUjEzciJwmMtkNdC3Ypj0s=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 7F8AD258066;
        Fri, 16 Dec 2016 13:05:32 -0800 (PST)
Message-ID: <1481922331.28176.11.camel@frank>
Subject: "disabling bitmap writing, as some objects are not being packed"?
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Date:   Fri, 16 Dec 2016 16:05:31 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm a bit confused by the message "disabling bitmap writing, as some
objects are not being packed".  I see it the my gc.log file on my git
server.

1. Its presence in the gc.log file prevents future automatic garbage
collection.  This seems bad.  I understand the desire to avoid making
things worse if a past gc has run into issues.  But this warning is
non-fatal; the only consequence is that many operations get slower.  But
a lack of gc when there are too many packs causes that consequence too
(often a much worse slowdown than would be caused by the missing
bitmap).

So I wonder if it would be better for auto gc to grep gc.log for fatal
errors (as opposed to warnings) and only skip running if any are found.
Alternately, we could simply put warnings into gc.log.warning and
reserve gc.log for fatal errors. I'm not sure which would be simpler.  

2. I don't understand what would cause that message.  That is, what bad
thing am I doing that I should stop doing?  I've briefly skimmed the
code and commit message, but the answer isn't leaping out at me.


