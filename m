From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bug: transform a binary file into a symlink in one commit =>
 invalid binary patch
Date: Fri, 23 Jan 2009 14:13:57 +0100
Message-ID: <4979C295.1000803@drmicha.warpmail.net>
References: <lyhc3q9pl1.fsf@leia.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pixel <pixel@mandriva.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:15:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQLsk-0006tn-Eg
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 14:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbZAWNOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 08:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbZAWNOE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 08:14:04 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:40342 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753886AbZAWNOD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jan 2009 08:14:03 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.fastmail.fm (Postfix) with ESMTP id BF56B255977;
	Fri, 23 Jan 2009 08:14:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 23 Jan 2009 08:14:01 -0500
X-Sasl-enc: Oc6wjkAJ8KNOofSqAEncX5HKtF4lJsFurgJWxbv8a9/+ 1232716441
Received: from [139.174.44.165] (wagner.math.tu-clausthal.de [139.174.44.165])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DFAA524D9A;
	Fri, 23 Jan 2009 08:14:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <lyhc3q9pl1.fsf@leia.mandriva.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106880>

Pixel venit, vidit, dixit 23.01.2009 13:25:
> hi, 
> 
> i hit a bug (git 1.6.1): when you transform a binary file into a
> symlink in one commit, the binary patch can't be used in "git apply".
> Is it a known issue?
> 
> 
> reproducer: 
> 
> ----------
> #!/bin/sh -e
> 
> # the bug: if you transform a binary file into a symlink in one commit, 
> # the binary patch can't be used in "git apply"
> #
> # nb: if you uncomment the "##" lines, the problem disappears
> # since the first patch will empty the binary file then the non-binary file
> # will be transformed into a symlink
> 
> rm -rf t t2
> mkdir t
> dd if=/dev/urandom of=t/a count=10
> cp -r t t2
> 
> cd t
> git init
> git add .
> git commit -m initial
> 
> ##echo -n > a
> ##git commit -a -m foo
> ln -sf zzz a
> git commit -a -m foo2
> git format-patch :/initial
> 
> cd ../t2
> git apply ../t/*.patch
> 
> cd ..
> rm -rf t t2
> ----------

You're not even initialising a repo in t2. I assume you want to "cp -a t
t2" after the "initial" commit, don't you? Doing that I get

error: binary patch to 'a' creates incorrect result (expecting
e132db255c0e0e3e9309c3c58a0a9c9eb97dd942, got
e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
error: a: patch does not apply
error: a: already exists in working directory

which is not that magnificient either. If that's the error you're after
your test script needs to be modified.

Michael
