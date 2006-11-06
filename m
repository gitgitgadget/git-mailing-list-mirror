X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Mon, 6 Nov 2006 07:48:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net>
 <454F31D7.1030202@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 6 Nov 2006 15:53:10 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454F31D7.1030202@gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31015>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh6iM-0005eW-Sf for gcvg-git@gmane.org; Mon, 06 Nov
 2006 16:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753255AbWKFPs2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 10:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbWKFPs2
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 10:48:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57809 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1753255AbWKFPs1 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 10:48:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kA6Fm6oZ020565
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 6
 Nov 2006 07:48:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kA6Fm55V022754; Mon, 6 Nov
 2006 07:48:06 -0800
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 6 Nov 2006, Liu Yubao wrote:
> 
> Then, what bad *logical* problem will happen if a merging that is really a
> fast forwarding creates a new commit?

You MUST NOT do that.

If a fast-forward were to do a "merge commit", you'd never get into the 
situation where two people merging each other would really ever get a 
stable result. They'd just keep doing merge commits on top of each other.

Git tracks history, not "your view of history". Trying to track "your 
view" is fundamentally wrong, because "your wiew" automatically means that 
the project history would not be distributed any more - it would be 
centralized around what _you_ think happened. That is not a sensible thing 
to have in a distributed system.

For example, the way to break the "infinite merges" problem above is to 
say that _you_ would be special, and you would do a "fast-forward commit", 
and the other side would always just fast-forward without a commit. But 
that is very fundamentally against the whole point of being distributed. 
Now you're special.

In fact, even for "you", it would be horrible - because you personally 
might have 5 different repositories on five different machines. You'd have 
to select _which_ machine you want to track. That's simply insane. It's a 
totally broken model. (You can even get the same situation with just _one_ 
repository, by just having five different branches - you have to decide 
which one is the "main" branch).

Besides, doing an empty commit like that ("I fast forwarded") literally 
doesn't add any true history information. It literally views history not 
as history of the _project_, but as the history of just one of the 
repositories. And that's wrong.

So just get used to it. You MUST NOT do what you want to do. It's stupid.

If you want to track the history of one particular local branch, use the 
"reflog" thing. It allows you to see what one of your local branches 
contained at any particular time.

See

	[core]
		logAllRefUpdates = true

documentation in "man git-update-refs" (and maybe somebody can write more 
about it?)

