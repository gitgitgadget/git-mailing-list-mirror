From: Henning Moll <newsScott@gmx.de>
Subject: Re: squash commits deep down in history
Date: Fri, 24 Oct 2014 00:20:10 +0200
Message-ID: <54497F1A.8050606@gmx.de>
References: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48> <54496036.8080109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 00:20:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhQk1-0007Du-A6
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbaJWWUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 18:20:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:50058 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbaJWWUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 18:20:15 -0400
Received: from [192.168.178.33] ([88.217.115.1]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LcBvB-1YQLoU2J1h-00jZy2; Fri, 24 Oct 2014 00:20:11
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54496036.8080109@kdbg.org>
X-Provags-ID: V03:K0:5B0Urj7dN/q8wvTM6Qb5gq5foCraAn0RCgc/ou3cEMsWPSQLmBw
 q3H7HrSJZzBwrlxAS6Ihq1wIQz9fhOeMCoQZ32ans7pT4lVdi4T/1iRa3G8vrBn65j1pxpF
 6zoKR1HEcnrkB1RavK+zzq1fQ3/2/VIXioaG0chJVoJl66lK0gwWYsHYT/ChJkruoVDPPjF
 gmoj7AKf5i5JHBuA2Je2Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.10.2014 um 22:08 schrieb Johannes Sixt:
> Use git-replace do construct a squashed commit that replaces the last 
> child in each run such that its parent points to the parent of the 
> first in the run. Then use a git-filterbranch without filters to burn 
> the parenthood into the history. -- Hannes 
Wow, cool. Thanks a lot for the hint.

I managed to do the following: Suppose i have the following history


A - B - C - D   <-master

and i want to squash B and C together. First i create a temporary branch 
on A and switch to it. Then i cherry-pick B and C without commit. So all 
the changes are merged into the index. Then i commit a single commit 
"M". The history now looks like

   M             <-temp
  /
A - B - C - D   <-master

Using

$ git replace C M

leads to

    temp
         |
         v

A -     M - D   <-master

As far as i understand, such a repalce is something like a "symbolic 
link". Is that right?

This is interesting: Before filter-branch, the deletion of the replace 
would lead to the initial situation (ABCD). After filter-branch, the 
history is (AM'D'). The replace still exists but is now something like a 
"dead link". I may come to life again after "git resetting" to somewhere 
before filter-branch. Even "before" creating the replace (the replace 
ref itself is not part of the history). Even if you gor before creation 
of M: The link still works as long as M is not garbage collected. I was 
very irritated after resetting to where i commited D, and still seeing 
A-M-D.

Somehow logical, somehow crazy! I am still a git learner ;-)

Two questions remain for me:

1. Is there a more elegant way to build M?
2. Having a replace "in place" before filter-branch: Is there a way to 
find out what the replace is hiding? A simple "git log C" produces 
"M-A". How to get "C-B-A"?

Best regards
Henning
