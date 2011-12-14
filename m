From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue,
 13))
Date: Wed, 14 Dec 2011 17:31:19 -0600
Message-ID: <20111214233119.GA2354@elie>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
 <20111214070916.GA14954@elie.hsd1.il.comcast.net>
 <201112141717.15021.trast@student.ethz.ch>
 <20111214230713.GA13128@sigill.intra.peff.net>
 <20111214232151.GB13128@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:31:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RayIS-0002lZ-DG
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 00:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758191Ab1LNXb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 18:31:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40519 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758111Ab1LNXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 18:31:26 -0500
Received: by ghbz12 with SMTP id z12so1075617ghb.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JiU4YClbAqJlBDllQcjeMpQS2XHms4aEOIrSOI9zeL0=;
        b=gZGgFUH3C/dXZHQBgpQD9nuyASgNfldSVJGTan3bggzxIuy0Qfatxqj8USHz1kMO0U
         EvfU5PmC7vy+YKGRAno4kBavPRWLorIjHT+cIONmvNx3zjBd3LaBTbK9yHg0V0QyDy/j
         pfpsY45wr8j8yGtyo5eK+MEyaa7PW3iCnUu6I=
Received: by 10.236.148.235 with SMTP id v71mr2369980yhj.6.1323905485778;
        Wed, 14 Dec 2011 15:31:25 -0800 (PST)
Received: from elie (c-67-173-1-13.hsd1.il.comcast.net. [67.173.1.13])
        by mx.google.com with ESMTPS id q52sm5962800yhh.3.2011.12.14.15.31.24
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 15:31:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111214232151.GB13128@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187176>

Jeff King wrote:

[...]
> A test which accidentally reads stdin would soak up all of
> the rest of the input intended for the outer shell loop.
> 
> Let's redirect stdin from a known source to eliminate
> variation. We could just connect it to /dev/null. However,
> tests which accidentally read stdin would then see immediate
> EOF, which may or may not cause them to notice the errror.
[...]
> +++ b/t/test-lib.sh
[...]
> @@ -469,7 +471,7 @@ test_debug () {
>  test_eval_ () {
>  	# This is a separate function because some tests use
>  	# "return" to end a test_expect_success block early.
> -	eval >&3 2>&4 "$*"
> +	eval <"$TEST_DIRECTORY/stdin-garbage" >&3 2>&4 "$*"

How about /dev/urandom on platforms that support it?  It wouldn't be
as pleasant to debug as "This is a magic stdin garbage stream", but it
would be more likely to (despite the name :)) predictably trip errors,
or at least hangs, in problematic tests.

With or without something along those lines on top, your patch looks
like a good change.

Thanks for a thoughtful analysis.
Jonathan
