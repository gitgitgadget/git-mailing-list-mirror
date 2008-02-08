From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Completion message for git-clone?
Date: Fri, 08 Feb 2008 02:01:21 -0800 (PST)
Message-ID: <m3ejbn4vis.fsf@localhost.localdomain>
References: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ian Dees" <undees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 11:02:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQ3V-0003x5-MC
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760468AbYBHKB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760786AbYBHKB0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:01:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23425 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760446AbYBHKBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 05:01:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so850431ugc.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 02:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=fslqqE1sZs++YIsck67Q8eL8Sfygkc+AsKkKAhVIci0=;
        b=cqny+qJ/ljgG5mUHscdRYTQevsBMBm46fudob45eJqjRDrSJqgwJq+4yk9ZUvYI0FigPiVH0CtuI60ay6+DSBzr9hnl/2ihN/baRePD5a0zCrt8AkT9E24wGCpQoqoZYE1KlDP1wo7Tun8a6yHzIN9a/PxWeKkIU3kvxSNryFp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=nRcIXUkFmOI4JLiMvl43Emfg6ydmY9L4p7PqiUxvRxWVX7Od0zpoqNw2AID6BmljKp5+OsTrWOGrD2cehPPUV1DReqoIchdqlwawdRVDJLfZNe11pnCes74/4fXrE9TNkjuPxwWjnVPOJdpZOuHvsHk0YTNNH7AA6nbn4jkB3yI=
Received: by 10.67.24.11 with SMTP id b11mr5214905ugj.2.1202464882956;
        Fri, 08 Feb 2008 02:01:22 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.186])
        by mx.google.com with ESMTPS id j4sm3684692ugf.49.2008.02.08.02.01.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 02:01:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m18A1Hw2027080;
	Fri, 8 Feb 2008 11:01:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m18A1FvX027076;
	Fri, 8 Feb 2008 11:01:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73062>

"Ian Dees" <undees@gmail.com> writes:

> Hi, all.  Upon cloning a repository, the initial message reads:
> 
>   Initialized empty Git repository in path/to/new-repo/.git
>   0 blocks
> 
> I'd wager "empty" means, "empty because Git is about to populate it."
> Even so, this wording could be a bit surprising to new adopters,
> especially coupled with the "0 blocks" suffix (is it really creating
> hardlinks on NTFS?).  The impression is that the clone didn't work.
> The impression is, of course, eventually dispelled by looking inside
> the new directory.  Is there a way to clarify the overall status of
> the clone operation?

This is caused by the fact that for now git-clone is a shell script,
which creates empty repository using git-init (The "Initialized..."
message is from git-init), then configures it and populates it.
For local clones it uses cpio for hardlinking: the "0 blocks" is
from cpio.

It shouldn't be hard to add message which would confirm successful
completion of the clone if it is local clone; the messages from
git-fetch are I think enough indication that clone succeeded...
but perhaps we would want to add final message anyway.

Nevertheless git-clone waits to be rewritten in C anyway, so
there is no much initiative to improve shell version. The stumbling
blocks are as far as I can remember moving detection of which branch
is currently checked out to git-remote, and optionally adding
symbolic-ref extension to git transfer protocol for git to not have to
guess which branch is HEAD.
 
> One other minor thing I noticed while futzing with clones: if you try
> to clone an empty repository, you get the same "Initialized empty
> repository" message, even though no such second directory is created.
> I'm not suggesting Git should suddenly start allowing empty cloning,
> but perhaps a "Empty repository; skipping clone" message would be
> helpful.

$ git clone a b
Initialized empty Git repository in /tmp/b/.git/
fatal: cannot clone empty repository
$ git --version
git version 1.5.4

Perhaps git should check if there is anything to clone _before_
git-init, or do not remove empty directory after failing to fetch.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
