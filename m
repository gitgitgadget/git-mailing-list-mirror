X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: Idea for rebase strategy
Date: Mon, 27 Nov 2006 09:02:42 +0000
Message-ID: <456AA9B2.8050409@shadowen.org>
References: <Pine.LNX.4.63.0611270108160.30004@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 09:02:55 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <7vfyc5l24t.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32404>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GocO1-0003TR-0r for gcvg-git@gmane.org; Mon, 27 Nov
 2006 10:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757488AbWK0JCp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 04:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbWK0JCp
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 04:02:45 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:9224 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1757488AbWK0JCo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 04:02:44 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1GocNC-0000kP-Hn; Mon, 27 Nov 2006 09:01:58 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> an idea hit me today: maybe we can make rebase work nicely with merges 
>> after all. We could record the original branch point and the new branch 
>> point for rebases.
> 
> One case that that would be simple enough, appear often enough
> in real life, and would be useful in practice is this:
> 
>        A---B---C---D---E topic
>       /       /
>   ---X---o---Y---Z master
> 
> After forking 'topic' at 'X' and built two commits A and B, the
> master has a related change in the area 'topic' works on, and a
> merge to adjust is made at C.  Then it builds two other commits
> D and E.  We should be able to rebase it on top of the master.
> 
> If we have a reliable ref-log for 'topic' that should be trivial
> to do.  It will be just the matter of replaying the log on top
> of master.  The ref-log says we committed two after we forked,
> so we replay them:
> 
>        A---B---C---D---E topic
>       /       /
>   ---X---o---Y---Z master
>                   \
>                    A'--B'
> 
> Then the log says we merged 'Y'.  We faithfully replay that,
> which wuold result in "fast-forward -- nothing special is
> needed" situation.  The remaining log entries would say we have
> two further commits, so replaying them would result in:
> 
>        A---B---C---D---E topic
>       /       /
>   ---X---o---Y---Z master
>                   \
>                    A'--B'--C'--D' topic'

Interestingly this trivial situation seems to works pretty much as is.
A "git rebase --onto master X topic" (at least in my trivial test case)
replayed A and B, squashed C as a noop, and copied D and E.  I did not
need any information from the reflog.  Of course the reflog is a good
way to find X as its first transaction but I did not need it to drive
replay.

