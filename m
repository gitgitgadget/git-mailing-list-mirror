From: David Kastrup <dak@gnu.org>
Subject: Re: Git very slow ?
Date: Sun, 08 Mar 2015 20:37:43 +0100
Message-ID: <87sidfmgag.fsf@fencepost.gnu.org>
References: <20150307013007.GA13250@milliways>
	<20150308155136.GA6273@vps892.directvps.nl>
	<87zj7nmpdp.fsf@fencepost.gnu.org> <20150308192045.GB32504@milliways>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin D <me@ikke.info>, git@vger.kernel.org
To: Ken Moffat <zarniwhoop@ntlworld.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUh2u-00013x-Vp
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 20:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbCHTjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 15:39:24 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:54896 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbCHTjY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 15:39:24 -0400
Received: from localhost ([127.0.0.1]:53937 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1YUh2o-0006tK-Lm; Sun, 08 Mar 2015 15:39:22 -0400
Received: by lola (Postfix, from userid 1000)
	id 02A05E04F4; Sun,  8 Mar 2015 20:37:43 +0100 (CET)
In-Reply-To: <20150308192045.GB32504@milliways> (Ken Moffat's message of "Sun,
	8 Mar 2015 19:20:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265106>

Ken Moffat <zarniwhoop@ntlworld.com> writes:

> On Sun, Mar 08, 2015 at 05:21:22PM +0100, David Kastrup wrote:
>
>> Particularly not git-blame in 2.1.  I should be quite surprised to see
>> any git-blame call running noticeably slower in 2.1 than in any
>> preceding version.
>> 
>> What may have happened is that the repository recently got repacked
>> aggressively and thus any access to older revisions got slower.
>> However, that change would be mostly tied to the repository rather than
>> the version of Git you access it with.
>> 
> That is possible - well, not recently-recently, but I might have
> repacked my repo of buildscripts some time last year.  Running
>  ls -al .git
> in that repository gives me:
> drwxr-xr-x   8 ken 100   4096 Mar  8 16:08 .
> drwxr-xr-x  48 ken 100   4096 Mar  8 03:05 ..
> -rw-r--r--   1 ken 100    220 May 12  2014 BRANCH_DESCRIPTION
> drwxr-xr-x   2 ken 100   4096 Apr 13  2010 branches
> -rw-r--r--   1 ken 100    470 Mar  8 16:08 COMMIT_EDITMSG
> -rw-r--r--   1 ken 100    566 May 17  2014 config
> -rw-r--r--   1 ken 100     73 May  1  2010 description
> -rw-r--r--   1 ken 100 196439 Sep 17 21:56 gitk.cache
> -rw-rw-rw-   1 ken 100     29 Feb  8 22:19 HEAD
> drwxr-xr-x   2 ken 100   4096 May  1  2010 hooks
> -rw-r--r--   1 ken 100 218255 Mar  8 16:07 index
> drwxr-xr-x   2 ken 100   4096 Sep 16  2013 info
> drwxr-xr-x   3 ken 100   4096 Sep 16  2013 logs
> drwxr-xr-x 260 ken 100   4096 Nov 12  2013 objects
> -rw-r--r--   1 ken 100     41 Nov 11 06:05 ORIG_HEAD
> -rw-r--r--   1 ken 100   1879 Sep 16  2013 packed-refs
> drwxr-xr-x   5 ken 100   4096 May 20  2014 refs
> -rw-r--r--   1 ken 100     41 Dec  7  2010 RENAMED-REF
>
> Running git blame on a script which dates back to when the repo was
> created takes between 5 and 6 seconds to show the first screen,

Since git blame outputs everything once it is finished ("the first
screen" is purely the pager's business), it needs to unpack the entire
history of the file (unless no blameable lines remain at all) and look
at it.  6 seconds tends not to be all that excessive for extracting more
than 5 years of a file's history.

-- 
David Kastrup
