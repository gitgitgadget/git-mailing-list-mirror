From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: git tag --no-merged?
Date: Wed, 4 Feb 2015 16:22:54 -0800
Message-ID: <6A0F0356-2AF1-487D-A20E-FB6051D9E689@gmail.com>
References: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Feb 05 01:23:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJADn-0008PA-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 01:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965444AbbBEAW6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 19:22:58 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33709 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbbBEAW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 19:22:58 -0500
Received: by pdbnh10 with SMTP id nh10so1390762pdb.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=qvjgHI62+hZ4pQMByJToT/4lBHBgKDBevWyLicl5I1M=;
        b=Lnb8N54HANHpYD6QaqSnIRgiXmoa1zXOlRzRSc56OQ/YZRXKj3INdKFMtOLsxi2dyB
         4JCEtOI/fbMrfAjNRzbALWlZGRsFUSiKcUZLObqEYBZEeQZag1tMGC+qMfN8XDT40T1l
         o+rSTn8TaaZW62XOJAK9vgUqSmc6On9dQg1s0uQgD/CjR7AjOK267lE8UN4JZjazYQWa
         DctjKPWzKk1Y986F87OQEF8lpZwKOf3/GUBySqDarXqa6MBUMi4c+vrL6q+OIlXk4aws
         ZJ8w1uQiH0GQDZfUOAq0wZF0hCDA8KvyjJ+NCU7G7FcUT9X/tkNwnGaziAxK0E0jwxwH
         mmfQ==
X-Received: by 10.66.65.195 with SMTP id z3mr1176636pas.104.1423095777340;
        Wed, 04 Feb 2015 16:22:57 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id jx2sm3155914pbc.46.2015.02.04.16.22.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Feb 2015 16:22:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263361>

On Feb 4, 2015, at 07:19, Peter Krefting wrote:
> Using "git branch --no-merged" I can get a list of branches that I  
> have that I haven't merged into my current branch. "git tag" doesn't  
> have such an option, is there a way to achieve something similar  
> listing tags that point to commits that aren't in my history?

I think something like this might do what you want:

git for-each-ref --format='%(refname)' refs/tags | \
while read t; do
   if ! git merge-base --is-ancestor $t HEAD; then
     echo ${t#refs/tags/}
   fi
done

If you run that on the Git repository (assuming you've checked out  
master), after a while (there are a lot of tags to check) it spits out  
v1.4.4.5 (along with some complaints about *-gpg-pub tags that refer  
to blobs).

And sure enough, `git log v1.4.4.5 ^master` shows 5 commits not  
contained in master so I think it does what you want.  You'll want to  
restrict the for-each-ref output further, if possible, to make it  
quicker.

-Kyle
