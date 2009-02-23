From: Heiko Voigt <git-list@hvoigt.net>
Subject: Re: [RFC PATCH] hooks: add some defaults to support sane workflow
 to pre-commit
Date: Mon, 23 Feb 2009 19:41:23 +0100
Message-ID: <49A2EDD3.5080307@hvoigt.net>
References: <499EF2B6.7060103@hvoigt.net> <C95EAEB9-D520-497F-BA42-0CDCC1348340@wincent.com> <499FDDC2.90502@hvoigt.net> <200902211216.43964.trast@student.ethz.ch> <49A00215.9070106@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 23 19:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbfla-0003bO-6f
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbZBWSl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753996AbZBWSl3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:41:29 -0500
Received: from darksea.de ([83.133.111.250]:39677 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753901AbZBWSl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 13:41:28 -0500
Received: (qmail 9689 invoked from network); 23 Feb 2009 19:41:13 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2009 19:41:13 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49A00215.9070106@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt schrieb:
> How about combining my first approach with the second idea? Teach git
> different default sets of hooks. So something like:
> 
>    git init --workflow="topic-branches"
> 
> would initialize and install a certain set of hooks.
> 
> Implement the possibility to propagate this setting to the server, by
> using a config variable or similar. This way only secure hooks will
> automatically be inherited and the user has the benefit of a more
> specific workflow support.

So I have been thinking about an actual implementation lately and here are
some more specifics of a possible implementation:

Add a new configuration file .gitconfig tracked in the working copy next to
.gitignore and such. The order would then be: 

/etc/gitconfig
~/.gitconfig
$project/.gitconfig
$project/.git/config 

Do not allow all options in such a file but use a specific namespace for
whitelisting them e.g.: project.workflow

Add hooks that are activated by default and use these configuration
variables to tune their behaviour. Example: 

[ "$(git config project.workflow)" = "topic-branches" ] && topic_branches=1

# if we are in topic mode work should always be done on a feature branch
if topic_branches && git branch | grep "^* master" > /dev/null; then
    echo "No commits on master, please !"
    exit 1
fi

Such distributable options could also transport other values like the
description for gitweb.

What do you think?

cheers Heiko
