From: Mircea Bardac <dev@mircea.bardac.net>
Subject: Re: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 11:13:17 +0100
Message-ID: <485B82BD.2000404@mircea.bardac.net>
References: <485AF10B.7060202@mircea.bardac.net> <20080620085618.GA27940@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Skolmli <fredrik@frsk.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:28:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9drA-0004NA-F3
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYFTK1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYFTK1k
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:27:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:36475 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYFTK1j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:27:39 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1134553ugf.16
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 03:27:37 -0700 (PDT)
Received: by 10.67.87.18 with SMTP id p18mr11352312ugl.43.1213957657652;
        Fri, 20 Jun 2008 03:27:37 -0700 (PDT)
Received: from ?192.168.126.97? ( [212.13.49.167])
        by mx.google.com with ESMTPS id u6sm20922181uge.70.2008.06.20.03.27.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 03:27:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080620085618.GA27940@frsk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85616>

Fredrik Skolmli wrote:
> On Fri, Jun 20, 2008 at 12:51:39AM +0100, Mircea Bardac wrote:
>> Hi,
>>
>> According to the documentation, this parameter (--use-log-author) should 
>>  use the author from the From/Signed-off-by line. Unfortunately, I 
>> found this to be working only on the first git svn clone. Later rebasing 
>> made the commits use the old username@uuid format.
>>
>> I am assuming the option is not being preserved in the Git repository 
>> metadata and it is only used on cloning/init. Is this the intended 
>> behavior?
> 
> Doesn't look like it. When you're using --add-author-from on dcommit, git-svn
> doesn't seem to know that it should look after "From:" in the commit, thus
> not setting the author correctly. The following oneliner should solve the
> case. Please let me know if it works as well for you as it did for me.

I haven't tested this yet but I have a feeling this is not my case, or I 
might not be fully understanding the implications of "--add-author-from" 
on the functionality of "--use-log-author". Technically, they should be 
independent and the options should not depend on each other:
* --use-log-author only applies to getting info from the commits
* --add-author-from only applies to putting info in the commits

 From the documentation, these 2 options can only be used with git svn 
init/clone so they should somehow be saved for future use. Maybe this 
doesn't happen.

My Git commits (not dcommits) already have "Signed-off-by:" at the end, 
added with "git commit -s". When I do a "git svn dcommit" they get 
pushed to SVN and the entire commit is rewritten. I have 
--add-author-from added on git clone, but nothing else is being added to 
the commit except the git-svn-id - from my point of view, according to 
the documentation, this is the correct behavior (since there already is 
a Signed-off-by line)

The problem is that, after the dcommit, when *viewing* the latest 
commits in the git-svn repository, even though they have 
"Signed-off-by:" in them, I see them not respecting the --use-log-author 
option, showing up as username@uuid. What I assume is that, after a 
dcommit (and everything being done on dcommit) the --use-log-author 
option is ignored.

Looking over the code, I see that make_log_entry (which is responsible 
for getting the correct format for the user/e-mail out of the commit 
message) is only being called in do_fetch and find_parent_branch. I am 
not sure if these are somehow called by cmd_dcommit.

Many thanks.

--
Mircea
http://mircea.bardac.net
