From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 13:18:34 -0500
Message-ID: <B7VXwxfjnTa8aYUBhy6fPK8N4wDq9i91R-fo4xot3lQCjt87hBafoQ@cipher.nrlssc.navy.mil>
References: <jeske@willow=01l5V7waFEDjChmh>	<willow-jeske-01l5PFjPFEDjCfzf-01l5V7wbFEDjCX7V> <willow-jeske-01l5cKsCFEDjC=91MX> <48612ABE.6000104@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Jeske <jeske@google.com>, git@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 20:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBD7N-0003FX-Gb
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 20:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYFXSSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 14:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYFXSSu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 14:18:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36436 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYFXSSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 14:18:49 -0400
Received: by mail.nrlssc.navy.mil id m5OIIZxP031696; Tue, 24 Jun 2008 13:18:35 -0500
In-Reply-To: <48612ABE.6000104@panasas.com>
X-OriginalArrivalTime: 24 Jun 2008 18:18:35.0073 (UTC) FILETIME=[B732F310:01C8D626]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86099>

Boaz Harrosh wrote:

> I use git reset --hard in to separate and distinct functions.
> One - to move current branch head around from place to place.

Why?

> Two - Throw away work I've edited

This is valid.

> It has happened to me more then once that I wanted the first
> and also got the second as an un-warned bonus, to the dismay 
> of my bosses.

Why are you using 'git reset' to do this? Why not just checkout
the branch? I think you are using 'reset' in ways it is not
intended to be used. Is there something in the documentation that
led you to believe that 'reset --hard' should be used to switch
branches? I do see an example of such a thing in everyday.txt.
It deals with setting 'pu' branch to the tip of the 'next' branch,
but the 'pu' branch has a special meaning in git.

It seems like you are using 'reset' when you should be using 'checkout'.

For example:

$ git branch
* mybranch
  master
  next
  maint
  pu

If I have 'mybranch' checked out and I want to make a change on top of
the 'next' branch, I wouldn't do 'git reset --hard next', I would either
'git checkout next' or 'git checkout -b next-feature next' or something
similar.

If I've already merged the changes from mybranch back into upstream, then
it's safe to delete it.

I recommend adopting a branch naming scheme where the branch name describes
the task that is to be accomplished. i.e. 'foo' is a bad branch name.

btw, you are not saving anything by trying to reuse branch names. All
a branch is, is a file with a 40 byte string and a newline. So creating
a branch entails writing 41 bytes to a file. Deleting a branch entails
deleting a single file that is only 41 bytes small.

I suggest trying to adjust your work flow so that 'reset --hard' is not necessary.

-brandon
