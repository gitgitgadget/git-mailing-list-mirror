From: Christofer Jennings <boz.lists@gmail.com>
Subject: Re: Sanity Check: scrum teams, shared 'story branches', rebasing shared branches
Date: Thu, 14 Jun 2012 07:32:22 -0700
Message-ID: <4E5D3B5D-DFAA-4FA7-ABA7-872584951221@gmail.com>
References: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 14 16:32:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfB68-0000Kj-Je
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 16:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2FNOc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 10:32:27 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:48722 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972Ab2FNOc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jun 2012 10:32:26 -0400
Received: by ghrr11 with SMTP id r11so1393263ghr.19
        for <git@vger.kernel.org>; Thu, 14 Jun 2012 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=3GgC4uHf02qi4O1H9ZnkzEStXj8t8K/e4wIRAHhZBfk=;
        b=Mb5n48qF8dCDubYeCktFwa+2ecSlysn22rEPhXizggHbH9jBLJWrcfe9crDw++qKty
         6vaC4hqF4g6lvw2uGMjt7shlchztPt3zioKhK+xN1V6zLy4Ro+M1w+xx834qwwZSTN2r
         ZYzQWZuIhCdzPTgh8+SFJSGEiBBGIZ7jmZlVHfuKtslX7ZyONF4FwhQeWX8BdXglyAq5
         z1isgofFN+gMKO4QE6O5lTcRrEEYpAJu7MVCbFQ9saPPb5MqbRxQBxk0N4tNP4a+D/XS
         8rIZvi7blxeN2Sf8TRfNDMTf35ID6NWefMdpUOSIyICfvQYjlCcSliRiJ1iE6L5rxtme
         OENg==
Received: by 10.60.6.163 with SMTP id c3mr2019074oea.27.1339684346146;
        Thu, 14 Jun 2012 07:32:26 -0700 (PDT)
Received: from [10.0.1.2] (ip72-197-63-152.sd.sd.cox.net. [72.197.63.152])
        by mx.google.com with ESMTPS id s10sm4471219obo.16.2012.06.14.07.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jun 2012 07:32:25 -0700 (PDT)
In-Reply-To: <3EA7D039-9D6E-4945-A982-43DB53AAE43A@gmail.com>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200008>

Thanks Heiko and Michael! Your emails were very helpful.

We did some experiments similar to yours, Michael, and came to the conclusion that we'll use merge to synchronize between branches that have been shared remotely (e.g., origin/master and origin/s1). Rebase fits our needs for synchronizing local working branches their corresponding origin branches though (e.g., s1 and origin/s1). In those cases, merge causes too many splits in the log.

This is all working out pretty well to support our "Story branch" approach.

Thanks again,
,chris

On Jun 9, 2012, at 4:51 PM, Christofer Jennings wrote:

> Hi All,
> 
> (New to this list. Please tell me if this is the wrong forum for this thread.) 
> 
> I've been using Git and GitHub for ~6 months. Working on a SCM plan for a Scrum project with 50+ developers in ~8 dev. teams. Each team will be working on one or two stories simultaneously, so expect ~16 'story branches' (and master) at any given time. We've got GitHub Enterprise and are working out how to manage story development on shared branches that get merged to master only after going through acceptance & peer review. We hope stories will only be 3 - 5 days to complete, but may take 2 weeks. We're promoting frequent pushes to story branches.
> 
> After a number of experiments and doing online research, we're thinking to use rebase to keep the story branches up-to-date with master while the story branches are in development. This seems to be the best approach because it will allow us to use bisect to isolate issues, and it will give us the most linear history graph. 
> 
> So, here's my question: Can we use "rebase -s recursive -Xtheirs" as shown below?
> 
> In this experiment, we're on 'story' branch 's1'. It's behind master because another story has been merged to master. We need to rebase to master and then rebase to origin/s1to be up-to-date. So we...
> git fetch -v
> git rebase origin/master
> ... resolve stuff ...
> git rebase -s recursive -Xtheirs origin/s1
> The "-s recursive -Xtheirs" part seems to result in all the right code at the end. We only had to "git add && git rebase --continue" for deleted files.
> 
> Would this approach always work? Or do we actually need to step through each conflict while rebasing to origin/s1 too?
> 
> (I don't want to step through each conflict while rebasing to origin/s1 because it brings up conflicts that the s1 developer may know nothing about.)
> 
> Thanks!
> chris
