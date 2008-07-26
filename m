From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] git-svn: teach dcommit about svn auto-props
Date: Sat, 26 Jul 2008 10:08:05 -0400
Message-ID: <488B2FC5.4080801@kitware.com>
References: <20080725060037.GB14756@untitled> <4889F215.9020804@kitware.com> <20080726054547.GA20494@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 26 16:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMkSE-0007K7-QZ
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 16:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYGZOH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 10:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYGZOH6
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 10:07:58 -0400
Received: from public.kitware.com ([66.194.253.19]:37312 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYGZOH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 10:07:57 -0400
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 1F57E1F67;
	Sat, 26 Jul 2008 10:09:00 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 6BA199A10;
	Sat, 26 Jul 2008 10:07:56 -0400 (EDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <20080726054547.GA20494@untitled>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90224>

Eric Wong wrote:
> Brad King <brad.king@kitware.com> wrote:
>> Signed-off-by: Brad King <brad.king@kitware.com>
> 
> Acked-by: Eric Wong <normalperson@yhbt.net>

Great, thanks!

>> ---
>> Eric Wong wrote:
>>> I haven't had the chance to look at this.   Can anybody else shed more
>>> light on that bug?  It's really strange that the tests won't run because
>>> of it.  Are you unable to run some git-svn tests or all of them?
>> Just that one fails.  All others (including the one in the patch below) pass.
> 
> Exactly which test fails for you?  Perhaps it's some setting in your
> ~/.subversion/config that's causing it to fail.  Maybe we should set
> $HOME and use a clean ~/.subversion/config for git-svn tests regardless
> if that turns out to be the case...

$ cd $gitsrc/t
$ export SVNSERVE_PORT=5432
$ ./t9113-git-svn-dcommit-new-file.sh
*   ok 1: start tracking an empty repo
* FAIL 2: create files in new directory with dcommit

                mkdir git-new-dir &&
                echo hello > git-new-dir/world &&
                git update-index --add git-new-dir/world &&
                git commit -m hello &&
                start_svnserve &&
                git svn dcommit

* failed 1 among 2 test(s)

I hacked the test script to log the dcommit output to a file, and I see
this:

Committing to svn://127.0.0.1:5432 ...
Use of uninitialized value in concatenation (.) or string at
/usr/lib/perl5/SVN/Core.pm line 584.
Authorization failed:  at $gitsrc/t/../git-svn line 3329

(I replaced my git source dir full path with $gitsrc).

The version of libsvn-perl is:  1.5.0dfsg1-4

Please let me know if you need more info.

I tried moving my ~/.subversion/config out of the way but it makes no
difference.  However, I agree we should block the user's home svn config
when running other dcommit tests now that we have auto-props.  Perhaps
just using the --config-dir option with an empty directory would be enough.

-Brad
