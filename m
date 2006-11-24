X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Use git-show-ref instead of git-peek-remote
Date: Fri, 24 Nov 2006 14:20:06 -0800
Message-ID: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
References: <11644056823095-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 22:20:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11644056823095-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Fri, 24 Nov 2006 23:01:22 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32242>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnjP5-0003AX-0x for gcvg-git@gmane.org; Fri, 24 Nov
 2006 23:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755447AbWKXWUK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 17:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756249AbWKXWUK
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 17:20:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:52378 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1755447AbWKXWUH
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 17:20:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124222007.JDOC5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 17:20:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qmLE1V00g1kojtg0000000; Fri, 24 Nov 2006
 17:20:15 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Use "git show-ref --dereference" instead of "git peek-remote ." in
> git_get_references. git-show-ref is faster than git-peek-remote; even
> faster is reading info/refs file (if it exists), but the information
> in info/refs can be stale.

More importantly, it is for dumb protocol transports, not for gitweb.

You forgot to mention that you fixed the last place that
directly used "$GIT" to invoke the command, bypassing sub
git_cmd.  That is a consistency clean-up worth mentioning.

> git-show-ref is available since v1.4.4; the output format is slightly
> different than git-peek-remote output format.

> -		if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
> +		if ($line =~ m/^([0-9a-fA-F]{40}) refs\/($type\/?[^\^]+)/) {

I would rather do:

	m|^([0-9a-f]{40})\srefs/($type/?[^^]+)|

which would catch both space and tab.
