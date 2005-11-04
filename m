From: Paul Collins <paul@briny.ondioline.org>
Subject: Re: [PATCH] v2: proxy-command support for git://
Date: Fri, 04 Nov 2005 21:06:13 +0000
Message-ID: <87ll049l8a.fsf@briny.internal.ondioline.org>
References: <87fyqdbuab.fsf@briny.internal.ondioline.org>
	<7v8xw5h898.fsf@assigned-by-dhcp.cox.net>
	<871x1wbgvn.fsf_-_@briny.internal.ondioline.org>
	<7v1x1wz7ae.fsf@assigned-by-dhcp.cox.net>
	<7v7jbow8ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 04 22:15:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY8rL-0001rh-0w
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 22:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750890AbVKDVMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbVKDVMY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 16:12:24 -0500
Received: from jenny.ondioline.org ([66.220.1.122]:5383 "EHLO
	jenny.ondioline.org") by vger.kernel.org with ESMTP
	id S1750890AbVKDVMX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 16:12:23 -0500
Received: by jenny.ondioline.org (Postfix, from userid 10)
	id 44E278CD5B; Fri,  4 Nov 2005 21:12:22 +0000 (GMT)
Received: by briny.internal.ondioline.org (Postfix, from userid 1000)
	id 351ADF95F; Fri,  4 Nov 2005 21:06:13 +0000 (GMT)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7v7jbow8ae.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Nov 2005 10:57:13 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11158>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> Paul Collins <paul@briny.ondioline.org> writes:
>>
>>> Regarding internal vs. external hosts, the proxy command can simply
>>> run netcat locally to internal hosts, so perhaps that is sufficient.
>>
>> I was hoping this to become a bit more generalized mechanism
>> than that; for example using outgoing plug over HTTP Connect or
>> telnet proxy using tn-gw-nav.

"Run a program and talk to it via stdin/stdout" is as general as it
gets, isn't it?  ssh+netcat is just what I happen to use.

> I realize the above does not really convey my real objection.
>
> Your "ssh to the proxy/firewall host and run netcat to the
> destination" would not work for me to reach the internal hosts
> at all (while it would work for external ones), because my
> firewall does not know names of our internal hosts (the same for
> using tn-gw-nav to cross http or telnet proxy).

It doesn't have to be unconditional.  For example, one could have:

    if on_blargco_network; then
        # internal
        case "$1" in
            *.blargco.com)
                exec nc "$1" "$2"
                ;;
            *)
                exec ssh bastion.blargco.com nc "$1" "$2"
                ;;
        esac
    else
        # external
        case "$1" in
            *.blargco.com)
                exec ssh bastion.blargco.com nc "$1" "$2"
                ;;
            *)
                exec ssh bastion nc "$1" "$2"
                ;;
        esac
    fi

But perhaps I do not really understand your objection.

-- 
Dag vijandelijk luchtschip de huismeester is dood
