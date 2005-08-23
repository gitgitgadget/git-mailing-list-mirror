From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 14:54:30 -0700
Message-ID: <7vvf1wnwtl.fsf@assigned-by-dhcp.cox.net>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508231533570.23242@iabervon.org>
	<20050823205052.GA13311@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508231713450.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 23:57:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gk6-000280-3m
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 23:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbVHWVyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 17:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVHWVys
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 17:54:48 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62184 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932470AbVHWVyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 17:54:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823215430.BUYU8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 17:54:30 -0400
To: Carl Baldwin <cnb@fc.hp.com>
cc: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508231713450.23242@iabervon.org> (Daniel
	Barkalow's message of "Tue, 23 Aug 2005 17:27:12 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7676>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> > If you don't use -f, git-checkout-script removes deleted files. Using -f
>> > tells it to ignore the old index, which means that it can't tell the
>> > difference between removed files and files that weren't tracked at all.

Yes and no.  "git checkout" assumes that the index file and the
working tree somewhat resembles what is in .git/HEAD commit.
Since push operation updates .git/HEAD commit without touching
the index file, that assumption does not hold.

The update hook gets old commit name and new commit name, so you
should be able to do (untested):

    git-read-tree -m -u $old_commit $new_commit

there, of course after making sure that you had old_commit (the
first time push happens to a new ref you would not have that one).
