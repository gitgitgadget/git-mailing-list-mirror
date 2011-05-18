From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Wed, 18 May 2011 11:14:22 +0200
Message-ID: <4DD38DEE.4080604@drmicha.warpmail.net>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu> <4DD373CD.6010607@alum.mit.edu> <20110518083314.GA22204@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ray Chen <rchen@cs.umd.edu>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed May 18 11:14:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcpq-0004CP-VE
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 11:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab1ERJOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 05:14:25 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33228 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755545Ab1ERJOZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 05:14:25 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A727B20751;
	Wed, 18 May 2011 05:14:24 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 18 May 2011 05:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0x0LtCBpnVc25hOnGfaJ9brdVNc=; b=bvDNFGOSGX+knd0yrdZpmQoottGBAoLhLeuATOhdI2I+ZLmDdjHAkOhDN4t9N+2Rv+OXkFFQ7AmVWB/9zcRZSzeEYR3+EHYnn6e8Y9eYSXd08kly83Vo0JqO0OcgtlO84GcyoOmhjWafuyfrsGbmiADp+cVebNELeTTxzS1soNc=
X-Sasl-enc: Fw6DKVbqy61QHPAG9BOd5s6pqw7Q8N4tVMU7J1dkEnZ/ 1305710064
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E805E4065E2;
	Wed, 18 May 2011 05:14:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110518083314.GA22204@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173867>

Eric Wong venit, vidit, dixit 18.05.2011 10:33:
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
> <snip> 1..3 are all very good points
> 
>> 4. If it is a goal to support long-term tracking of a Subversion
>> repository, then it would be good to add a config option to turn on this
>> feature permanently for a git-svn repository, so that the user doesn't
>> have to enter the extra options with each command invocation.
> 
> Command-line options should be automatically converted into config file
> options inside git svn.  We should however discourage this from getting
> mixed...
> 
>> 5. It might be useful to allow the placeholder files to be committed to
>> Subversion, so that other git-svn users based off the same Subversion
>> repository don't have to worry about empty directories.  This would
>> typically be something that people would want to do semi-manually in
>> specific Subversion commits.  To support this user case, one could add a
>> similar option to "git svn mkdirs" that causes the placeholder files to
>> be created in the working copy but not committed.  Then the user could
>> review the suggested changes, perhaps add lines to the .gitignore files,
>> commit to git, then dcommit to Subversion.
> 
> No, too hard and error-prone, I think.
> 
> This would require tracking which .gitignore files are git-only and
> which are not (some SVN repos have .gitignore files explicitly checked
> in, but that should /always/ be done explicitly by the user every time).
> 
> I would go as far as to have a flag to disable dcommit (and set-tree) on
> any repo that uses this placeholder feature.  SVN-only folks could be
> very unhappy to see placeholder files, especially in some cases
> where placeholders may break builds or cause information leaks.
> 
> 
> I strongly believe git-svn should leave no trace.  Nobody but the user
> using git-svn should know they're using git-svn to interact with an SVN
> repo.  This allows users to stay under the radar of any idiotic rules
> (or knee-jerk reactions of FUD) their organization may have against
> using non-standard SVN clients.  So far, it's worked out pretty well,
> git-svn users slowly and quietly develop clout and influence to migrate
> their repos from SVN to git.

git-svn's maintenance of these files would be simpler if we used a
special file for that, say .git-svn-empty-dir, and teach dcommit to
ignore it. That way git clones can share it and git svn dcommit is
unimpaired. The only problem occurs when a new git-svn commits these,
and old git clones that and an old git-svn dcommits from that clone.

>> 6. Documentation patches would also be required.
> 
> Agreed, along with automated test cases.
> 

Michael
