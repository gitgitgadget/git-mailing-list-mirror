X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Fri, 24 Nov 2006 13:14:00 +0300
Message-ID: <ek6glc$pn$1@sea.gmane.org>
References: <20061123225835.30071.99265.stgit@machine.or.cz>	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>	<20061123234203.GN7201@pasky.or.cz>	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net> <7vpsbde4fy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 24 Nov 2006 10:14:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 50
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <7vpsbde4fy.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32207>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnY4w-00082t-3C for gcvg-git@gmane.org; Fri, 24 Nov
 2006 11:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934539AbWKXKOd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 05:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934540AbWKXKOd
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 05:14:33 -0500
Received: from main.gmane.org ([80.91.229.2]:19394 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S934539AbWKXKOc (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 05:14:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GnY4b-0007y8-Cn for git@vger.kernel.org; Fri, 24 Nov 2006 11:14:21 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 24 Nov 2006 11:14:21 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 24 Nov 2006
 11:14:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> -- >8 --
> [PATCH] refs outside refs/{heads,tags} match less strongly.
> 
> Pushing 'foo' when both heads/foo and tags/foo exist at the
> remote end is still considered an error and you would need to
> disambiguate between them by being more explicit.
> 
> When neither heads/foo nor tags/foo exists at the remote,
> pushing 'foo' when there is only remotes/origin/foo is not
> ambiguous, while it still is ambiguous when there are more than
> one such weaker match (remotes/origin/foo and remotes/alt/foo,
> for example).

git-push.1 has following description:

    Some short-cut notations are also supported.

              o   tag <tag> means the same as refs/tags/<tag>:refs/tags/<tag>.

              o  A parameter <ref> without a colon is equivalent to
                 <ref>:<ref>, hence updates <ref>  in
                 the destination from <ref> in the source.

Maybe this is only my reading of manual page, but I understood
it like it does not leave the room for ambiguity, because it is using
_the same_ refspec as the local one.

That's why, when I do

   git-push repo x

and it results in

   git-push repo refs/heads/x:refs/remotes/origin/x

instead of expected

   git-push repo refs/heads/x:refs/heads/x

just because the remote repo did not have refs/heads/x, but happened
to have refs/remotes/origin/x, would be highly surprising to me.

The expected behaviour on 'git-push repo x' in my understanding is
1) git finds the exact reference for 'x' (i.e. either refs/heads/x or
refs/tags/x) according to local lookup rules
2) git uses the found reference _unambiguously_ to create or update exactly the
same reference in the remote repo.

Am I the only one to have this understanding?
