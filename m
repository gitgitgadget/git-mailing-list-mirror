X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 13:50:26 -0500
Message-ID: <20061103185026.GA28566@coredump.intra.peff.net>
References: <376237.14965.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 18:50:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <376237.14965.qm@web31805.mail.mud.yahoo.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30874>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg47d-0007E6-RJ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 19:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753435AbWKCSub (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbWKCSub
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 13:50:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:50400
 "HELO peff.net") by vger.kernel.org with SMTP id S1753435AbWKCSua (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 13:50:30 -0500
Received: (qmail 22154 invoked from network); 3 Nov 2006 13:49:30 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 3 Nov 2006 13:49:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov
 2006 13:50:26 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

On Fri, Nov 03, 2006 at 01:07:20AM -0800, Luben Tuikov wrote:

> So I still make the mistake of:
> # git-rev-list --no-merges --pretty=one-line HEAD -- <somepath>
>     I select a commit
> # git-format-patch -o /tmp/ <commit>
> ...
>     Oh, f@#$!  <CTRL-C>
> # git-format-patch -o /tmp/ <commit>^..<commit>

For my own workflow, I don't want to have to pick the commit out of
rev-list (or log) output. I want to find it and hit a button to say "OK,
now mail this patch." So I put _all_ of my patches into an mbox, and
then browse them with mutt. Sort of a poor man's patch browser, but then
I'm ready to jump into mailing them immediately.

I use the following script:

#!/bin/sh
root=${1:-origin}
git-format-patch -s --stdout $root >.mbox
mutt -f .mbox
rm -f .mbox

And then in mutt, I use this macro to bind 'b' to editing the full
message w/ headers:

macro index b ":set edit_headers=yes<enter><resend-message>:set edit_headers=no<enter>"

I know that may be useless if you're not using mutt, but I just wanted
to stimulate some discussion among patch submitters about how they
actually do it. I'm not sure how configurable tig is, but it shouldn't
be too hard to add something like this to it.

