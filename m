From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Question about PERL_PATH
Date: Fri, 06 May 2011 17:56:45 +0200
Message-ID: <4DC41A3D.10104@drmicha.warpmail.net>
References: <4DC3F804.3080205@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ian Abbott <abbotti@mev.co.uk>
X-From: git-owner@vger.kernel.org Fri May 06 17:56:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QINOf-0004X7-O3
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 17:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756579Ab1EFP4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 11:56:48 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42002 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754367Ab1EFP4r (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 11:56:47 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5BE122056D;
	Fri,  6 May 2011 11:56:47 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 06 May 2011 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=f5Q05pZJ91ewjyImYDrOKKQj4yE=; b=IlH72OQlqdrpgtNd6LmVjejhvPr7uIuhoQsZH4S+7r+uI9qOj/HUMxmpa96ltyYBQ3O2QTxbXq7tqHOHGh/GneRTleDyuAXiAxBN2aIBJt3ym119Qk9OpOpj9A9eKDNM8fyJwzXE0SyVymQ8FoiNZP85njUB1bYfdEtNqazNAxM=
X-Sasl-enc: HKFgUOiQQs+vwWJ1XiwjCuPasrZup74iYOSNM06kZfJ2 1304697407
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D48EB440FBD;
	Fri,  6 May 2011 11:56:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <4DC3F804.3080205@mev.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172982>

Ian Abbott venit, vidit, dixit 06.05.2011 15:30:
> The Gentoo ebuilds for git have started invoking 'make' with the option
> 'PERL_PATH=/usr/bin/env perl'.  This doesn't seem to cause any problems
> except when running git instaweb, which outputs an error similar to the
> following:

Well, it means that all our perl scripts are run with the perl which is
the first in PATH at run time (for the user running it), which may or
may not be the one which is first in PATH at build or test time (for the
user running that).

Of course there's no problem when they are the same.

> /usr/libexec/git-core/git-instaweb: line 135: /usr/bin/env perl: No such
> file or directory
> 
> There is an easy workaround, which is to modify the invocation of perl
> in the httpd_is_ready() function in the git-instaweb shell script.  It
> currently invokes perl as "$PERL" (with the quotes).  Removing the
> quotes makes it work.
> 
> My question is, should git support Gentoo's unusual setting of PERL_PATH
> as a multi-word command, or should Gentoo patch around the problem they
> have created with git-instaweb themselves?
> 
> There is one other place where $PERL is used in git-instaweb and that is
> in the mongoose_conf() function.  It has a heredoc that puts the
> following line in the httpd.conf file (subject to shell variable expansion):
> 
> cgi_interp	$PERL
> 
> For Gentoo, that would get expanded to the following:
> 
> cgi_interp	/usr/bin/env perl
> 
> I don't know if Mongoose would choke on this or not.

For a system wide installed package, it just seems like a crazy idea to
package it in a way which makes it depend on the contents of users'
$HOME/bin and such. What kind of packaging is that? I mean, package git
depends on package perl, but then leave the meaning of "perl" at the
users' discretion and mercy...

Michael
