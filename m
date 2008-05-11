From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git branches - confusing behavior
Date: Sun, 11 May 2008 15:40:04 +0200
Message-ID: <200805111540.05195.jnareb@gmail.com>
References: <4826D8FA.30305@gmail.com> <m31w495apd.fsf@localhost.localdomain> <4826DF6A.2070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dima Kagan <dima.kagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 11 15:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvBnr-0007dl-4M
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 15:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbYEKNki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYEKNki
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 09:40:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:47114 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYEKNkR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 09:40:17 -0400
Received: by nf-out-0910.google.com with SMTP id d3so973881nfc.21
        for <git@vger.kernel.org>; Sun, 11 May 2008 06:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=iWkXknCP52ZMj02CkgqxAydftW0JXRMfVVhxtnZQCuA=;
        b=k3JryJojNK9euZRPvsKQURG/IEvvAPSQPzCxNc+6roG+LV1IosxGvlvK3qvWL9yR1Kq+NSvUO3XU1DzaqP3288pQNN+ZdPPdNhwgKWwlOsJRA2lFShFGTeiO2yIpyL9cL1XGSBVEVAwyBo3/B0DBkkAeifdKFl4aSuLc3v4IapE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QulRXRsuPuZQbaIX179SxGvZVm7Ezq0Ojw6FJbTmlq30JSzLgYSdYtCckWJkvHoEWcLXgVVJsGFRwDHpCtA5YKahR8RV6HmOEWFx0iVTJNclRh067v9KkNZLtDDcRgm/GgOGIR4kQL+/RuR4UfUVcLud3+ooRYSSqHoYU4fqwcA=
Received: by 10.210.136.10 with SMTP id j10mr6256610ebd.43.1210513215108;
        Sun, 11 May 2008 06:40:15 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.242.178])
        by mx.google.com with ESMTPS id k10sm9747856nfh.25.2008.05.11.06.40.12
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 06:40:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4826DF6A.2070306@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81774>

Dima Kagan wrote:
> Jakub Narebski wrote:
>> Dima Kagan <dima.kagan@gmail.com> writes:

[...]
> So if I am working on more than one branch at a time I need to commit
> my changes every time before I do 'git checkout <branch>'?
[...]
Not necessary, see below (and it is not necessary bad).

>>> Basically I see that the same file I edited on the 'test_branch'
>>> branch appears to be modified on the 'master' branch as well. This
>>> behavior is unwanted, of course.
>>>
>>> Can someone please tell me, what am doing wrong? Or is this git's
>>> normal behavior?
>> 
>> This is normal, and wanted, behavior.
 
> That's a subjective point of view :) I'm coming from the SVN world and
> uncommitted changes on one branch don't affect other branches. Is
> there a way I can achieve this behavior with git?  

How would you want git to behave, with "git checkout <branch>" changing 
branches _in place_, in single working area?  Besides, current 
behavior, together with "git checkout -m" option, allows to change 
branches when you have realized (after making some changes) that you 
are on wrong branch...


There are few possible solutions:

1. Save state before switching branches

1.1. You can simply commit changes before switching branch, perhaps with
"(WIP)" (work in progress) in the commit message.  Then, when you go 
back to the branch, you can continue your work, and simply --amend (as 
in "git commit --amend" a commit.

1.2. You can use git-stash to save state of your working area (working 
directory) _and_ index, change branches, and when going back to branch 
restore state using "git stash apply". I think you can save state even 
during not resolved merge.

1.3. If you use patch management interface on top of Git, like StGit
(or Guilt), you can simply "stg refresh" a patch, then change branches.  
When returning to branch, use refresh and/or edit, then create new 
patch if you think current is finished (you can always go back...).


2. Use separate working for differen branches: this is what Bazaar does, 
what Mercurial does by default without 'localbranch' extension, and I 
think also what Subversion does.   Take a look at contrib/workdir
on how to manage multiple working areas with single repository; the 
core.workdir and --working-dir could also be of help.

Note that in this case you have to take care to not have the same branch 
checked out to two (or more) different working areas, to not stomp on 
your changes, and to avoid confusion.


Final note: you would work better learning SCM "the git way", and not to 
rely on Subversion bad habits (yes, I know that bad CVS habits are 
worse...) ;-)

-- 
Jakub Narebski
Poland
