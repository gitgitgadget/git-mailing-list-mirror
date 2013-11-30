From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Git merge: conflict is expected, but not detected
Date: Fri, 29 Nov 2013 16:42:26 -0800
Message-ID: <288B55D2-B91B-4123-8D0A-84BE5960E14D@gmail.com>
References: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 01:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmYdq-0007BR-D6
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 01:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191Ab3K3Ama (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Nov 2013 19:42:30 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33300 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab3K3Am3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Nov 2013 19:42:29 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so14379992pde.7
        for <git@vger.kernel.org>; Fri, 29 Nov 2013 16:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=ycIlzkOp0MMgUllv+MBdyctM/sNt1OB4/5RozYtJDw4=;
        b=hJMFwky0++M94M6rZpT6BWVvysRVVHmIsBCqUCm6ZxAI/dRUWgPsfXbNRRcSQme4VW
         5f3kRDwvc+1HFcPbBgTu6cU9aDR5QU8HVZN0YM9yaKCIbF0AnAX3AGB/Z9qXeZmrotU/
         WR7oppMFOEWFWh8CA15q2e44KaDdHI0BGDwP5gwbDtRcuQ7iK4G5RVMAUJ+3PenU6I76
         BlxQGukugmVOuaq5f2ePhCHRFT/afkphm8gq7AHJCNOjFhq50kbpKJg95kBfqcq32erP
         KWy9zrbjat6bANJtVrvvGdY2mPfTbwqioT1E1XQxKGvWFL+ZEOEr+Pgb78i7EuepHb64
         ZPMg==
X-Received: by 10.66.220.198 with SMTP id py6mr32292677pac.21.1385772149307;
        Fri, 29 Nov 2013 16:42:29 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id rx4sm118950420pab.13.2013.11.29.16.42.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 29 Nov 2013 16:42:28 -0800 (PST)
In-Reply-To: <CAO6Ho0d=JHk4ydd1PdcWP1XHxvXpjfYVK+B_QLgd0vpyFTh_xQ@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238545>

On Nov 29, 2013, at 06:26, Evgeniy Ivanov wrote:
> Let's say I have two identical branches: master and topic. In master I
> remove some code, i.e. function bar(). In topic I do the same (commit)
> and after some time I realize I need bar() and revert previous commit
> with removal.
> So I end with master with no bar() and topic with bar() in its
> original state. When I merge I get code without bar() and no merge
> conflict (recursive or resolve strategies). Is it possible to detect
> such situations as conflicts? When bar() is C++ virtual there is no
> possibility to catch this with compiler.

You can do something like:

git checkout master
git merge -s ours --no-commit topic
# conflicts, if any, will happen during cherry-pick
git cherry-pick --no-commit ..topic
git commit -m "Merge branch 'topic'"

Which will give you a merge commit as though using "git merge" but it  
will have restored the bar() function.  However, depending on what's  
happened on the topic branch, you might have to wade through some  
conflicts that would not happen with a real "git merge" since cherry- 
pick will replay all the commits from the topic branch that aren't in  
master.  Maybe some day "git merge" will grow a "--cherry-pick" option.
