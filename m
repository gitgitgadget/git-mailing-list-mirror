From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: Making a patch:  "git format-patch" does not produce the
 documented format
Date: Fri, 2 Aug 2013 18:11:29 -0400
Message-ID: <201308022211.r72MBT9G020153@freeze.ariadne.com>
References: <201307312131.r6VLVliK028321@hobgoblin.ariadne.com> <20130731214818.GP2337@serenity.lan>
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Aug 03 00:12:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5NZm-0004RO-Gq
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 00:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab3HBWLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 18:11:42 -0400
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:45308
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754122Ab3HBWLc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Aug 2013 18:11:32 -0400
Received: from omta14.westchester.pa.mail.comcast.net ([76.96.62.60])
	by qmta15.westchester.pa.mail.comcast.net with comcast
	id 7t8l1m0031HzFnQ5FyBY3v; Fri, 02 Aug 2013 22:11:32 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta14.westchester.pa.mail.comcast.net with comcast
	id 7yBX1m00R1KKtkw3ayBXth; Fri, 02 Aug 2013 22:11:31 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r72MBUfU020154;
	Fri, 2 Aug 2013 18:11:30 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r72MBT9G020153;
	Fri, 2 Aug 2013 18:11:29 -0400
In-reply-to: <20130731214818.GP2337@serenity.lan> (john@keeping.me.uk)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1375481492;
	bh=JpqTf2mTVYwiRYRXG19w5qqyLrRPNGp2udIQIdbItSY=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=HyaXR9+WoX9UTtry4ZiSzaZjXte9IBIqKkYbBOeIdHhbKwANmZPzciYTM3Ek0OUV9
	 9JaylnB31Ek+twlsBingvzGB18/cD2YsnuQfqL17L8qY44v/OuIaW2YChwFPRBfe6/
	 yAGdj2khrHGTxnyOU9f07a7TYKVWhGwo5Vd0fP02nBYVszwa9s5DBKwGpXTAu9SvLj
	 C9WNWOftB+7cTKQinmIFGz4jRQAQV4AtzwDMKNmwrMqDTGcmy0F2WNvRiPPM3sSBmP
	 HuUupqnGlUKoJJg2MV0YqhH/6AmRVKz4keXGIC8pwDyTgmHD7WgsJESS2DJz2davA0
	 b90a9Rjk55x6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231539>

> From: John Keeping <john@keeping.me.uk>
> 
> git-format-patch(1) says:
> 
>         By default, the subject of a single patch is "[PATCH] " followed
>         by the concatenation of lines from the commit message up to the
>         first blank line (see the DISCUSSION section of git-commit(1)).
> 
> I think that accurately describes what you're seeing.  The referenced
> DISCUSSION section describes how to write a commit message that is
> formatted in a suitable way, with a short first subject line and then a
> blank line before the body of the message.

Thanks for the confirmation.  I've figured out what is going wrong:
Documentation/SubmittingPatches says:

    The first line of the commit message should be a short description (50
    characters is the soft limit, see DISCUSSION in git-commit(1)), and
    should skip the full stop.

What it *doesn't* say is that the second line of the commit message
should be empty -- precisely so that git format-patch turns the first
line into the Subject: but does not merge the remainder of the commit
message (the "body") into the Subject: line.  Now that I know to look
for this, I can see that the commit messages in the Git repository
show this pattern.

I'm preparing some clarifications of SubmittingPatches to explain
things that a new person (e.g., me) would not know.  To fix this
issue, I am inserting:

    This first line should be a separate paragraph, that is, it should be
    followed by an empty line, which is then followed by the body of the
    commit message.

Dale
