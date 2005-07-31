From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: send-pack question.
Date: Sat, 30 Jul 2005 23:02:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507302257000.29650@g5.osdl.org>
References: <7v1x5fwmpk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 08:03:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz6v0-0007hy-Tu
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 08:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVGaGDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 02:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGaGDP
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 02:03:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbVGaGDD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 02:03:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6V62wjA009104
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 23:02:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6V62vLB001245;
	Sat, 30 Jul 2005 23:02:58 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x5fwmpk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Junio C Hamano wrote:
> 
>  * Right now, "send-pack --all" into an empty repository does
>    not do anything, but "send-pack --all master" into an empty
>    repository pushes all local heads.  This is because we do not
>    check "send_all" when deciding if we want to call try_match
>    on local references.  I am assuming this is an oversight; am
>    I correct?  If so, does the attached patch look OK?

Yeah, that sounds like me just not having taken my 'meds. The patch looks 
fine.

>  * It appears to me that you can say "send-pack net", and
>    depending on how the remote lists its refs, you can end up
>    updating their refs/heads/net or refs/tags/net.

Yeh. I was wanting to sort the refs to make everything be totally 
repeatable, but that was more of an urge than a real plan.

>						  More
>    confusingly, you could say "send-pack net net" to update
>    both.  More realistically, you could get confused with a
>    remote that has refs/heads/jgarzik/net and
>    refs/heads/dsmiller/net in this way.  I think it should
>    detect, stop and warn about the ambiguity and require the
>    user to be more explicit.  Am I reading the current code
>    correctly?

Yes, warning on ambiguity sounds like a sound plan, and then you don't 
need to sort.

You also probably to come up with a syntax for saying "xyz is the local
name, abc is the remote name". That's needed for both the pulling and the 
pushing side, but I didn't ever do it. 

>    I've always _hated_ the interface to path_match() which
>    pretends to be just a boolean function but actually has a
>    grave side effect, by the way.

It's "interesting" but useful. But I agree, we've had one bug already due
to the interesting part.

If you do the ambiguity thing, you might mark them used some separate way, 
and maybe avoid that side effect (or rather - the side effect would still 
exist, but instead of removing the entry, it would just mark it as 
"seen", ie make it less drastic).

		Linus
