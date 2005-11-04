From: Paul Collins <paul@briny.ondioline.org>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 22:04:10 +0000
Message-ID: <87hdas9ijp.fsf@briny.internal.ondioline.org>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
	<7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net>
	<7v7jbow8ae.fsf@assigned-by-dhcp.cox.net>
	<87ll049l8a.fsf@briny.internal.ondioline.org>
	<7v3bmct7i3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 23:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY9hY-0005te-KB
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 23:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVKDWGW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 17:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVKDWGW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 17:06:22 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:41226 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1751003AbVKDWGV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 17:06:21 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id BD3B18CD5B; Fri,  4 Nov 2005 22:06:20 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id BF9B5F95F; Fri,  4 Nov 2005 22:04:10 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v3bmct7i3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Nov 2005 13:42:28 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11164>

Junio C Hamano <junkio@cox.net> writes:

> Paul Collins <paul@briny.ondioline.org> writes:
>
>> But perhaps I do not really understand your objection.
>
> No, I think you are getting it right.
>
> I just wanted to avoid using the proxy script for some hosts,
> depending on where you are going.  Obviously you can teach the
> proxy script to do passthru for some hosts like you did in your
> message.  The only difference is where the configuration is
> specified.  I wanted it to be in the git configuration file
> (i.e. using different proxy script or no script, depending on
> the host).  Your example has that configuration wired in the
> single script that is always called regardless of the
> destination, and the script itself switches how it proxies,
> depending on where it is going, perhaps using its own
> configuration file or hardcoding.

I had some ideas along those lines, but I didn't like any of them.

 * Extend the proxy-command "protocol" with a third argument, an
   action.  For example if 'query $host $port' returns successfully,
   then git should run it with arguments 'connect $host $port',
   otherwise use git_tcp_connect().

 * Add a Proxy-Command field to the files in .git/remotes, e.g.:

     URL: git://git.kernel.org/pub/scm/git/git.git/
     Pull: master:origin
     Proxy-command: my-git-proxy-command

 * If the git config syntax is extended to allow dots in section or
   key names:

     [proxy]
     git.kernel.org = "ssh-to-bastion-proxy-command"
     git.blargco.com = "blargco-proxy-command"

   or perhaps

     [git.kernel.org]
     proxycommand = "ssh-to-bastion-proxy-command"
     [git.blargco.com]
     proxycommand = "blargco-proxy-command"

-- 
Dag vijandelijk luchtschip de huismeester is dood
