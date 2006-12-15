X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enable reflogs by default in any repository with a working directory.
Date: Fri, 15 Dec 2006 13:55:15 -0800
Message-ID: <7vodq4n7ss.fsf@assigned-by-dhcp.cox.net>
References: <20061214224117.GA26374@spearce.org>
	<Pine.LNX.4.63.0612150112010.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061215002015.GI26202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:56:20 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34562>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL2O-0006er-Va for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965212AbWLOVz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWLOVzY
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:36808 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965206AbWLOVzQ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215515.QGI22053.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vT1V00H1kojtg0000000; Fri, 15 Dec 2006
 16:55:27 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>> 
>> On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
>> 
>> > +int is_bare_git_dir (const char *dir)
>> > +{
>> > +	if (!strcmp(dir, DEFAULT_GIT_DIR_ENVIRONMENT))
>> > +		return 0;
>> > +	const char *s = strrchr(dir, '/');
>> > +	return !s || strcmp(s + 1, DEFAULT_GIT_DIR_ENVIRONMENT);
>> >  }
>> 
>> This function does not really determine if the repo is bare. I have no 
>> better name for it, though.
>
> guess_if_bare_git_dir ?
>
> I struggled to name that thing because it can't really tell, its just
> guessing... but it is going to be right most of the time.  Of course
> I'm sure there's some Git user somewhere who will confuse it.

I think the name is fine, but probably a comment in front would
help unconfuse people.

	/* Does it look like a repository without a working tree? */

Unfortunately there currently are public bare repositories that
have index under them because they were primed by rsync from
developers' working repositories.  I do not think it is
unreasonable to persuade owners of them to drop index -- then we
could use absence of $GIT_DIR/index as a strong clue that the
repository is bare.
