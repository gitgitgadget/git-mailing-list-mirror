From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] install-webdoc: quell diff output on stdout
Date: Thu, 02 Sep 2010 09:29:43 +0200
Message-ID: <4C7F5267.5030708@drmicha.warpmail.net>
References: <2730e927194a15f708ea4c5ffa72353f793f2ed4.1283353628.git.git@drmicha.warpmail.net> <7vzkw15t50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 09:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or4FD-0005yg-HL
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 09:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab0IBH3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 03:29:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52125 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483Ab0IBH3l (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 03:29:41 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B8D4894;
	Thu,  2 Sep 2010 03:29:40 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 02 Sep 2010 03:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=IghJiTUpvFV1xKi/hYVn4Koa96M=; b=hdDNruf179szvXg+G7n7bcOWd364UBG8fWKT+LpAOy+miuzYjzfyc6BNZyw0IUjnN32c2+RCWQvEd06G1nwJk56SiBcl5UCnpBFCCF2WU6bcu9huFvU3gx0vaSjL8DyVLA9EsIeY26rNO6uRKwSzzetdneuxFomXjCTFvpGQrC4=
X-Sasl-enc: pBiMbxg3r0Q4QBzD4j9uvAd1dQl3QjMTDuAjtfVVvw6I 1283412580
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3C6695E60C3;
	Thu,  2 Sep 2010 03:29:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <7vzkw15t50.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155108>

Junio C Hamano venit, vidit, dixit 01.09.2010 18:24:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> When installing html-doc, install-webdoc.sh compares the installed html
>> with the version to be installed using diff. Currently, the diff output
>> fills up stdout.
> 
> As I've been using this output as the final sanity check on k.org
> environment, I personally do not want to lose the output from that
> particular diff.
> 
> When I push to the public repository, a hook is triggered to build and
> install the documentation, sending its progress to a log file, and I have
> a window open running "tail -f" on it.

Sorry, isn't that a somewhat crazy type of sanity check? You're getting
the complete diff for the generated htmls flying by. Wouldn't the actual
"install..." be sufficient, or maybe, a QUIET_DIFF variant which
displays the command line? And not only sufficient, but actually easier
to check visually as you seem to do?

[A more throrough check would be comparing the name-diff of
Documentation/*.txt with that of the generated html.]

> 
> Actually why don't we do the attached instead as the first step?
> 
> The timestamp that follows "Last updated " is formatted differently
> depending on the version of AsciiDoc.  Looking at 4604fe56 on "html"
> branch, you can see that AsciiDoc 7.0.2 used to give "02-Jul-2008 03:02:14
> UTC" but AsciiDoc 8.2.5 gave "2008-09-19 06:33:25 UTC".  We haven't been
> correctly filtering out phantom changes that result from only the build
> date for some time now, it seems.
> 
>     Side note:
> 
>     How can you find the above easily?  Here is one way, if you run git
>     with f506b8e (git log/diff: add -G<regexp> that greps in the patch
>     text, 2010-08-23) currently parked in 'pu':
> 
> 	git log -p -G"Last updated [0-9][0-9]-[A-Z][a-z][a-z]-" origin/html
> 
>  Documentation/install-webdoc.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
> index 34d02a2..37e67d1 100755
> --- a/Documentation/install-webdoc.sh
> +++ b/Documentation/install-webdoc.sh
> @@ -12,7 +12,7 @@ do
>  	then
>  		: did not match
>  	elif test -f "$T/$h" &&
> -	   $DIFF -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
> +		$DIFF -u -I'^Last updated ' "$T/$h" "$h"
>  	then
>  		:; # up to date
>  	else

I think that is the right fix for the problem you mentioned, which is a
different one ;)

With your fix, the problem I'm after occurs less often, of course, maybe
to the extent of not being a real problem any more.

Michael
