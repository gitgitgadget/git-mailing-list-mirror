X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add support to git-branch to show local and remote branches
Date: Fri, 03 Nov 2006 04:08:53 -0800
Message-ID: <7vhcxg91gq.fsf@assigned-by-dhcp.cox.net>
References: <7v64dxl0bf.fsf@assigned-by-dhcp.cox.net>
	<200611031052.16095.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 12:09:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611031052.16095.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 3 Nov 2006 10:52:15 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30837>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfxr0-00007V-Dt for gcvg-git@gmane.org; Fri, 03 Nov
 2006 13:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751151AbWKCMIz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 07:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWKCMIy
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 07:08:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:61075 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751151AbWKCMIy
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 07:08:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103120853.ECHE13632.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 3
 Nov 2006 07:08:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id iC8y1V00Q1kojtg0000000 Fri, 03 Nov 2006
 07:08:58 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> Instead of storing a list of refnames in append_ref, a list of
> structures is created.  Each of these stores the refname and a
> symbolic constant representing its type.
>
> The creation of the list is filtered based on a command line
> switch; no switch means "local branches only", "-r" means
> "remote branches only" (as they always did); but now "-a"
> means "local branches or remote branches".
>
> As a side effect, the list is now not global, but allocated in
> print_ref_list() where it used.
>
> Also a memory leak is plugged, the memory allocated during the
> list creation was never freed.  This is now done in the new
> function, tidy_ref_list()

I would not call that a "leak" given that print_ref_list() is
the last thing to be called before the command exits.  I'd
rather not to spend cycles calling free().

> +static int tidy_ref_list( struct ref_list *ref_list )

Style.  No spaces before or after parameter list.

I see you already parse "refs/tags" prefix. "git branch" would
not print tags, but that part might be useful when we want to
redo git-tag in C.

Other than that, I think it is equivalent to what I have in "pu"
right now.

