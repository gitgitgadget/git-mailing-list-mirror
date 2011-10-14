From: Jonathan Nieder <jrnieder@gmail.com>
Subject: interrupting "git rebase" (Re: git rebase +)
Date: Fri, 14 Oct 2011 00:26:53 -0500
Message-ID: <20111014052653.GA5052@elie.hsd1.il.comcast.net>
References: <loom.20111013T134405-495@post.gmane.org>
 <4E96E5E1.7010103@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Piatyszek <ediap@wp.pl>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:29:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REaKJ-00017g-5m
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 07:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab1JNF1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 01:27:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34309 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab1JNF1I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 01:27:08 -0400
Received: by yws29 with SMTP id 29so260065yws.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xb/sSz0NtSa/FqGiKjhM3XtcHc/prlsQGp1Ahkc+BrE=;
        b=HxHBqZ/VhTrVXbFSoT+yWkcZkVzhx4SbXTrw8VHE5mHhFUJ7qymPoUYopNzS5Pf2V1
         iJEYCffs+G/M/ptJV+gTqMtHACdhJxQBsF3I758NWv1QV4tbdYy12zC1Qa5Bn3oZVKrO
         KCoYMbHfscozSMgXiRa1CD+gySZM933BAiNSk=
Received: by 10.236.124.97 with SMTP id w61mr9099790yhh.106.1318570027418;
        Thu, 13 Oct 2011 22:27:07 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s42sm3226150yhs.0.2011.10.13.22.27.04
        (version=SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 22:27:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E96E5E1.7010103@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183538>

Johannes Sixt wrote:

> Hitting Ctrl-C during git-rebase results undefined behavior. git-rebase is
> a shell script and was never designed to operate in any form of atomicity.
>
> You should have let it run until it stopped.

Wait, really?  That's bad, and unlike most git commands.

> Then you could have said 'git
> rebase --abort' (if it didn't complete) or 'git reset --hard ORIG_HEAD'
> (if it completed).

If interrupting the rebase leaves the repository in a state that

	rm -fr .git/rebase-apply
	git reset --hard <appropriate commit name>

cannot recover from, I'd consider it a serious problem.

By the way, what happened to the "git rebase --abort-softly" synonym
for "rm -fr .git/rebase-apply" discussed a while ago?
