From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [Opinion gathering] Git remote whitelist/blacklist
Date: Fri, 20 May 2016 10:22:17 -0400
Message-ID: <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: <matthieu.moy@grenoble-inp.fr>,
	<simon.rabourg@ensimag.grenoble-inp.fr>,
	<wiliam.duclot@ensimag.grenoble-inp.fr>,
	<antoine.queru@ensimag.grenoble-inp.fr>
To: "'Francois Beutin'" <beutinf@ensimag.grenoble-inp.fr>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 20 16:23:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3lKH-00035a-0o
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 16:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcETOWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 10:22:44 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20062 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbcETOWn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 10:22:43 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u4KEMVZZ069661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 May 2016 10:22:32 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLJLMcy5aI0sQo5p+pO4Y/K+qYQcZ3S6uzw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295169>

On May 20, 2016 10:22 AM, Francois Beutin wrote:
> We (Ensimag students) plan to implement the "remote whitelist/blacklist"
> feature described in the SoC 2016 ideas, but first I would like to be sure we
> agree on what exactly this feature would be, and that the community sees an
> interest in it.
> 
> The general idea is to add a way to prevent accidental push to the wrong
> repository, we see two ways to do it:
> First solution:
>  - a whitelist: Git will accept a push to a repository in it
>  - a blacklist: Git will refuse a push to a repository in it
>  - a default policy
> 
> Second solution:
>  - a default policy
>  - a list of repository not following the default policy
> 
> The new options in config if we implement the first solution:
> 
> [remote]
> 	# List of repository that will be allowed/denied with
> 					# a whitelist/blacklist
> 	whitelisted = "http://git-hosting.org"
> 	blacklisted = "http://git-hosting2.org"
> 
> 	# What is displayed when the user attempts a push on an
> 		# unauthorised repository? (this option overwrites
> 		# the default message)
> 	denymessage = "message"
> 
> 	# What git should do if the user attempts a push on an
> 		# unauthorised repository (reject or warn and
> 		# ask the user)?
> 	denypolicy = reject(default)/warning
> 
> 	# How should unknown repositories be treated?
> 	defaultpolicy = allow(default)/deny
> 
> 
> Some concrete usage example:
> 
>  - A beginner is working on company code, to prevent him from
> 	accidentally pushing the code on a public repository, the
> 	company (or him) can do:
> git config --global remote.defaultpolicy "deny"
> git config --global remote.denymessage "Not the company's server!"
> git config --global remote.denypolicy "reject"
> git config --global remote.whitelisted "http://company-server.com"
> 
> 
>  - A regular git user fears that he might accidentally push sensible
> 	code to a public repository he often uses for free-time
> 	projects, he can do:
> git config remote.defaultpolicy "allow"	#not really needed
> git config remote.denymessage "Are you sure it is the good server?"
> git config remote.denypolicy "warning"
> git config remote.blacklisted "http://github/personnalproject"
> 
> 
> We would like to gather opinions about this before starting to
> 	implement it, is there any controversy? Do you prefer the
> 	first or second solution (or none)? Do you find the option's
> 	names accurate?

How would this feature be secure and made reliably consistent in managing the policies (I do like storing the lists separate from the repository, btw)? My concern is that by using git config, a legitimate clone can be made of a repository with these attributes, then the attributes overridden by local config on the clone turning the policy off, changing the remote, and thereby allowing a push to an unauthorized destination (example: one on the originally intended blacklist). It is unclear to me how a policy manager would keep track of this or even know this happened and prevent policies from being bypassed - could you clarify this for the requirements?

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
