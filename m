From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git-svn: handling merge-base failures
Date: Sun, 3 Jan 2010 20:43:52 -0800
Message-ID: <7B6F15D3-FCF3-4569-9617-62BA38C92B35@apple.com>
References: <931B0483-7628-488E-BB9F-C40346353149@apple.com> <7878A426-9D87-43B5-A10A-38F3C9369165@apple.com> <20100104034540.GA4548@dcvr.yhbt.net>
Mime-Version: 1.0 (Apple Message framework v1130)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 05:44:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRenV-0003Uf-6z
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 05:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab0ADEn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 23:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878Ab0ADEn4
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 23:43:56 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:62522 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0ADEnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jan 2010 23:43:55 -0500
Received: from relay15.apple.com (relay15.apple.com [17.128.113.54])
	by mail-out4.apple.com (Postfix) with ESMTP id 6D9BB84E474F;
	Sun,  3 Jan 2010 20:43:53 -0800 (PST)
X-AuditID: 11807136-b7bafae000000e8d-b4-4b4172086f91
Received: from [17.151.111.20] (Unknown_Domain [17.151.111.20])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay15.apple.com (Apple SCV relay) with SMTP id 75.26.03725.902714B4; Sun,  3 Jan 2010 20:43:53 -0800 (PST)
In-Reply-To: <20100104034540.GA4548@dcvr.yhbt.net>
X-Mailer: Apple Mail (2.1130)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136090>


On Jan 3, 2010, at 7:45 PM, Eric Wong wrote:

> Andrew Myrick <amyrick@apple.com> wrote:
>> On Dec 23, 2009, at 11:54 AM, Andrew Myrick wrote:
>>> One of my projects is failing to clone because merge-base is failing
>>> on one of the revisions; the branch is a partial branch, so
>>> merge-base can't find a common ancestor with trunk.  I'd like to
>>> catch the exception that command_oneline should throw when
>>> merge-base fails,
>> 
>> Instead of using the Error.pm module, I was able to handle the
>> exception with the more basic eval block.  However, there are some
>> details here I would like to discuss with the community.
>> 
>> When git-svn fetches a partial branch, it appears to refetch all of
>> the history of the subdirectory from which the branch was created.
>> This creates new commits for the old revisions, and these new commits
>> exist as a separate history for the partial branch.   When git-svn
>> fetches the revision at which this partial branch is merged back to
>> trunk, git-svn attempts to run merge-base to find a common ancestor.
>> However, because the partial branch has its own history, the
>> merge-base fails, and git-svn dies.
>> 
>> Naively handling the exception with an eval block and skipping the
>> merge ticket works fine in that it brings us back to parity with git
>> 1.6.5.7, but it means that the merge parent relationship between trunk
>> and the partial branch is lost.  Is there any way to preserve this
>> information, or does the separate commit history of the partial branch
>> make it fundamentally impossible?
> 
> Hi Andrew,
> 
> A method of preserving the $SVN_PATH <=> $PARENT@$REV mapping for
> reusing follow_parent-created branches is definitely desired.
> 
> I've just been lacking time and motivation these days with other
> projects taking priority.  Help (even if it's just to refactor/cleanup
> existing code) would definitely be appreciated here.

Thanks for the explanation, Eric.  Unfortunately, I also don't have the time to commit to taking this on for the foreseeable future.  I'll try to get my existing patches out in the next couple of days that at least fix the regressions from 1.6.5.7.

Regards,
Andrew
