From: Francois Beutin <beutinf@ensimag.grenoble-inp.fr>
Subject: [Opinion gathering] Git remote whitelist/blacklist
Date: Fri, 20 May 2016 16:21:44 +0200 (CEST)
Message-ID: <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: matthieu.moy@grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	wiliam.duclot@ensimag.grenoble-inp.fr,
	antoine.queru@ensimag.grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 16:14:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lCE-0005Za-M0
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbcETOOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 10:14:30 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:59779 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751842AbcETOO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 10:14:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id EF8F1210E;
	Fri, 20 May 2016 16:14:25 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9TngOlQovFP; Fri, 20 May 2016 16:14:25 +0200 (CEST)
Received: from zm-int-mbx7.grenet.fr (zm-int-mbx7.grenet.fr [130.190.242.146])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id D67A82106;
	Fri, 20 May 2016 16:14:25 +0200 (CEST)
In-Reply-To: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: Git remote whitelist/blacklist
Thread-Index: dzch463Bxl16hI5b5t/lNym25nbflw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295166>

Hi everyone,

We (Ensimag students) plan to implement the
"remote whitelist/blacklist" feature described in the SoC 2016 ideas,
but first I would like to be sure we agree on what exactly this
feature would be, and that the community sees an interest in it.

The general idea is to add a way to prevent accidental push to the
wrong repository, we see two ways to do it:
First solution:
 - a whitelist: Git will accept a push to a repository in it
 - a blacklist: Git will refuse a push to a repository in it
 - a default policy

Second solution:
 - a default policy
 - a list of repository not following the default policy

The new options in config if we implement the first solution:

[remote]
	# List of repository that will be allowed/denied with
					# a whitelist/blacklist
	whitelisted = "http://git-hosting.org"
	blacklisted = "http://git-hosting2.org"

	# What is displayed when the user attempts a push on an
		# unauthorised repository? (this option overwrites
		# the default message)
	denymessage = "message"

	# What git should do if the user attempts a push on an
		# unauthorised repository (reject or warn and
		# ask the user)?
	denypolicy = reject(default)/warning

	# How should unknown repositories be treated?
	defaultpolicy = allow(default)/deny


Some concrete usage example:

 - A beginner is working on company code, to prevent him from
	accidentally pushing the code on a public repository, the
	company (or him) can do:
git config --global remote.defaultpolicy "deny"
git config --global remote.denymessage "Not the company's server!"
git config --global remote.denypolicy "reject"
git config --global remote.whitelisted "http://company-server.com"


 - A regular git user fears that he might accidentally push sensible
	code to a public repository he often uses for free-time
	projects, he can do:
git config remote.defaultpolicy "allow"	#not really needed
git config remote.denymessage "Are you sure it is the good server?"
git config remote.denypolicy "warning"
git config remote.blacklisted "http://github/personnalproject"


We would like to gather opinions about this before starting to
	implement it, is there any controversy? Do you prefer the
	first or second solution (or none)? Do you find the option's
	names accurate?
