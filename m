From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: git-fetch in 1.5.4 fails versus 1.5.3.8
Date: Thu, 7 Feb 2008 10:15:02 +0000 (UTC)
Message-ID: <pan.2008.02.07.10.15.05@progsoc.org>
References: <pan.2008.02.04.18.25.26@progsoc.org>
	<20080205050741.GA4624@coredump.intra.peff.net>
	<pan.2008.02.06.21.56.35@progsoc.org>
	<20080207042332.GA7632@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 11:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN3nS-0005Zs-Qi
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYBGKPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 05:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754118AbYBGKPV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 05:15:21 -0500
Received: from main.gmane.org ([80.91.229.2]:38039 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064AbYBGKPU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 05:15:20 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JN3mj-0001cE-Kw
	for git@vger.kernel.org; Thu, 07 Feb 2008 10:15:13 +0000
Received: from 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk ([82.35.82.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 10:15:13 +0000
Received: from wildfire by 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 07 Feb 2008 10:15:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 82-35-82-57.cable.ubr03.dals.blueyonder.co.uk
User-Agent: Pan/0.132 (Waxed in Black)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72921>

On Wed, 06 Feb 2008 23:23:33 -0500, Jeff King wrote:

> On Wed, Feb 06, 2008 at 09:56:35PM +0000, Anand Kumria wrote:
> 
>> With GIT_SSL_NO_VERIFY defined, it fails with:
>> 
>> $ GIT_SSL_NO_VERIFY=1 ../git/git-fetch richard error:
>> gnutls_handshake() failed: ASN1 parser: Element was not found.
>> (curl_result = 35, http_code = 0, sha1 =
>> 510567ca41e201253445528ca6eb89ed43e71fce) Getting pack list for
>> https://server.example.com/~richard/newfoo.git error:
>> gnutls_handshake() failed: ASN1 parser: Element was not found. Getting
>> alternates list for https://server.example.com/~richard/newfoo.git
>> error: Unable to find 510567ca41e201253445528ca6eb89ed43e71fce under
>> https://server.example.com/~richard/newfoo.git Cannot obtain needed
>> object 510567ca41e201253445528ca6eb89ed43e71fce fatal: Fetch failed.
> 
> OK, I was finally able to reproduce your bug. It seems that it _only_
> happens when using curl built against gnutls. I built against the
> libcurl4-openssl-dev in Debian unstable, and the problem goes away.
> 
> Can you confirm that building using the openssl version of curl fixes
> the problem?

Confirmed.

Thanks for figuring out how to reproduce it ... how did you btw?

> Googling for your error message turns up only one other instance: a bug
> in pidgin where the result was "this seems like a bug in gnutls." I hate
> to say "it's not our bug" without knowing exactly what is causing it,
> though. And it does seem odd that it works with 1.5.3.8. I wonder if
> there is some difference in the way we are calling curl that matters.

It appears that git 1.5.3.8 on Debian links to libcurl3-gnutls whereas, 
at least for me, git 1.5.4 on Debian links to libcurl4-gnutls 
(or libcurl4-openssl).

I agree with you, it is a bit problematic when the library (curl) relies
on another library (gnutls) and the bottom one is having a problem.

Gerrit - since I seem to be able to reproduce this fairly easily - would
it be useful to you to have me do anything to track this down. Or will you
switch the Debian build to openssl?

Thanks for looking into this Jeff.

Regards,
Anand
