From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: git and github query about maintaining project
Date: Tue, 03 Jan 2012 15:21:37 -0500
Message-ID: <201201032021.q03KLblT024296@no.baka.org>
References: <CA+KSefVajgEBCH+31a0DLXPGUgb2yshxPeXV+SdmGvPFVBOBtg@mail.gmail.com>
        <CA+KSefW+K1hMiFkrFCP1LAVjfV9hECwFWAHz940fwGJawHuoFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: manoj soni <manoj6891@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:21:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiArl-0008Pp-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab2ACUVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:21:44 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:57211 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161Ab2ACUVl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:21:41 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q03KLbrB017263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Jan 2012 15:21:39 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q03KLblT024296;
	Tue, 3 Jan 2012 15:21:37 -0500
In-reply-to: <CA+KSefW+K1hMiFkrFCP1LAVjfV9hECwFWAHz940fwGJawHuoFQ@mail.gmail.com>
Comments: In reply to a message from "manoj soni <manoj6891@gmail.com>" dated "Tue, 03 Jan 2012 14:42:38 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187893>


In message <CA+KSefW+K1hMiFkrFCP1LAVjfV9hECwFWAHz940fwGJawHuoFQ@mail.gmail.com>, manoj soni writes:

    Forwarding you below email, which I have sent to wrong email address by mistake.

You might want to ask on the IRC #git channel for tactical support
questions, like this. irc://irc.freenode.net/git

    we forked P (on github),  I got project forked copy C1

    What I want to do that in my project C1, OLD branch should have
    all of my commits and master branch should be same as P.

Tactically, the answer to your question is as follows:
----------------------------------------------------------------------
# Create a new branch OLD from where master is (presumably containing your commits)
git checkout -b OLD master

# Share OLD with your forked C1 (if you want to)
git push origin OLD
git branch --set-upstream OLD origin/OLD

# Get access to the repository you forked from
git remote add P URL-TO-P
git fetch P

# Reset the master branch to the contents of P/master
#  Please note that any uncommitted changes WILL BE LOST
git checkout master
git reset --hard P/master

# Share your rewritten history with origin (C1)
#  Please note, rewriting publicly visible history is a BAD IDEA.
#  Anyone else who might have pulled the old history will have to do
#  special things and may hate you forever.
git push -f origin
----------------------------------------------------------------------

However, interpreting what you are really trying to do (get your
changes and C2's changes put together and uploaded to P), this is what
*I* would do:
----------------------------------------------------------------------
# Get access to the repository you forked from git remote add P
URL-TO-P git fetch P

# Merge your development with the other development that has been happening
git merge origin/P

# Share your rewritten history with origin (C1)
git push

# When you have finished testing (unless you are using the github pull request method)
git push P master
----------------------------------------------------------------------

					-Seth Robertson
