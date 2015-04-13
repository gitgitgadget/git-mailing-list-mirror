From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [WIP/RFH/PATCH 3/3] t/lib-git-svn: adjust config to apache 2.4
Date: Mon, 13 Apr 2015 12:14:13 +0200
Message-ID: <552B96F5.8060607@drmicha.warpmail.net>
References: <cover.1428505184.git.git@drmicha.warpmail.net> <0631c09d394dedb803a100e81ce4052a57b4e73e.1428505184.git.git@drmicha.warpmail.net> <20150410032317.GB11280@peff.net> <20150410033953.GC11280@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 13 12:14:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhbNq-0002Xm-31
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 12:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbbDMKOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 06:14:17 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41569 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752094AbbDMKOP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 06:14:15 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9A4B82081E
	for <git@vger.kernel.org>; Mon, 13 Apr 2015 06:14:14 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 13 Apr 2015 06:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=j+XQXAiX68DIiBfLRfvB4dItI4o=; b=NosItP
	IP+dbLgHblyspf6+YeEUXBnFW98z+4YfKGq/wIuwYNdBBESQqJNjUxePjjY0HrTD
	pwtWdc2LcD6RQ2Gglp3hBAHLiBxE5Mm3ReR9mEokLZqrNEXEfc5czvxbf9v0SI7t
	Xb5rvpA7NJn5mw/qU+cwwVWom3RtnWTND1Ys4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=j+XQXAiX68DIiBf
	LRfvB4dItI4o=; b=Xq6FuCxUkb9AvZbWLN+3fikXxrKdY9KHolaeDZZXBNh/e+m
	R78WsE46RIcoBG9FrbFCctsB/1KvGpR9ZtNjt8hvZvTdOIV7NhjV5fel1jmORJQ/
	bzEtM8gjV7fVZXpaC9SzMO5lCqxvzgzNbzh0wrUPcI05oAzulbybD7txMI80=
X-Sasl-enc: 7rmx59GE1o3EnaJ2IHrWLilGtetmvTQe/klpkHIPh3ST 1428920054
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 10EBDC00015;
	Mon, 13 Apr 2015 06:14:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150410033953.GC11280@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267073>

Jeff King venit, vidit, dixit 10.04.2015 05:39:
> On Fri, Apr 10, 2015 at 05:23:17AM +0200, Jeff King wrote:
> 
>> Curiously, though, the git-svn tests seem to run fine for me on Apache
>> 2.4 without your patch. I wonder if the fixes I mentioned above (which I
>> definitely needed to get the regular http tests running on Debian back
>> then) are not necessary on my system anymore (e.g., because the apache2
>> package now ships with better-compatible config).
> 
> Ah, I see. I am not in fact running apache.
> 
> If you do not set SVN_HTTPD_PORT (which I don't), then lib-git-svn.sh's
> start_httpd silently returns success without bothering to setup the
> apache server at all. And yet the rest of the tests run to completion
> just fine.

Yep.

> It looks like setting this variable is a way to say "run the same set of
> tests, but do it over svn-over-httpd instead of svn's direct filesystem
> access". Setting SVN_HTTPD_PORT does cause the tests to fail for me.

Oh, I didn't even notice that. That's a bit weird.

> I don't know how important it is to run these tests over httpd. If so,
> it would be nice to do something like lib-httpd does: try the apache
> setup by default, and if it fails, gracefully skip the tests (or
> fallback to the non-httpd version).
> 
> I'm also not sure if there's value in running both the httpd and
> local-filesystem forms of the test. IOW, should we be factoring out the
> tests and having two separate scripts that set $svnrepo as appropriate,
> and then runs the tests?
> 
> -Peff

Hmm, if those tests are run (with file://) I'm inclined to leave things
as they are (scratch 3/3)... Though the fact that on my system,
lib-git-svn starts the server but fails to connect isn't overly
comforting. But git-svn is being used less and less. World domination is
almost complete.

Michael
