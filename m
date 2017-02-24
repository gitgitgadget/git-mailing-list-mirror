Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 645F3201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 16:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdBXQ1i (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 11:27:38 -0500
Received: from chiark.greenend.org.uk ([212.13.197.229]:46422 "EHLO
        chiark.greenend.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdBXQ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 11:27:37 -0500
X-Greylist: delayed 1515 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Feb 2017 11:27:37 EST
Received: by chiark.greenend.org.uk (Debian Exim 4.84_2 #1) with local
        (return-path ijackson@chiark.greenend.org.uk)
        id 1chHYv-0005lz-UX; Fri, 24 Feb 2017 15:13:38 +0000
From:   Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <22704.19873.860148.22472@chiark.greenend.org.uk>
Date:   Fri, 24 Feb 2017 15:13:37 +0000
To:     Joey Hess <id@joeyh.name>
Cc:     git@vger.kernel.org
Subject: Re: SHA1 collisions found
Newsgroups: chiark.mail.linux-rutgers.git
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
X-Mailer: VM 8.2.0b under 24.4.1 (i586-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Hess writes ("SHA1 collisions found"):
> https://shattered.io/static/shattered.pdf
> https://freedom-to-tinker.com/2017/02/23/rip-sha-1/
> 
> IIRC someone has been working on parameterizing git's SHA1 assumptions
> so a repository could eventually use a more secure hash. How far has
> that gotten? There are still many "40" constants in git.git HEAD.

I have been thinking about how to do a transition from SHA1 to another
hash function.

I have concluded that:

 * We can should avoid expecting everyone to rewrite all their
   history.

 * Unfortunately, because the data formats (particularly, the commit
   header) are not in practice extensible (because of the way existing
   code parses them), it is not useful to try generate new data (new
   commits etc.) containing both new hashes and old hashes: old
   clients will mishandle the new data.

 * Therefore the transition needs to be done by giving every object
   two names (old and new hash function).  Objects may refer to each
   other by either name, but must pick one.  The usual shape of
   project histories will be a pile of old commits referring to each
   other by old names, surmounted by new commits referrring to each
   other by new names.

 * It is not possible to solve this problem without extending the
   object name format.  Therefore all software which calls git and
   expects to handle object names will need to be updated.

I have been writing a more detailed transition plan.  I hope to post
this within a few days.

Ian.
