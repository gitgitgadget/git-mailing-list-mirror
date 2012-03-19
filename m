From: Andreas Ericsson <ae@op5.se>
Subject: Re: Feature request: don't require both bad and good when bisecting
Date: Mon, 19 Mar 2012 15:45:31 +0100
Message-ID: <4F67468B.4070502@op5.se>
References: <20120318212957.GS1219@chaosreigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: darxus@chaosreigns.com
X-From: git-owner@vger.kernel.org Mon Mar 19 15:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9dq9-0005vd-UJ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 15:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030850Ab2CSOph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 10:45:37 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48186 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030834Ab2CSOpg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 10:45:36 -0400
Received: by lbbgm6 with SMTP id gm6so3384619lbb.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 07:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=rLRc/QWrFykwtI2Qfm3oS2OX8R5398yAHhBUthhyztI=;
        b=cnBRn1gYTawwVzFgcyV9f+jpMG7MZFfsNHGs/3BrgmPIvpLad79QNG/qRR3buDRlse
         59SprMrH7PFlubSKeJa3nOv3ny26IFgmecFbxI40pGC71+vwQHyrkW1vuM+gkhmTUO4U
         j868ibpRm1xcoqZEDBAzcdL5aHv5G2wuTa8POZD4Ws5yPTOXLE1STcGa7W5voLod/tax
         O+wYI5jFsjCremkaSLDdGGuTvNveD92EMLvHI1C/yoXKXDJUBhHNWpHrP9PGENEUyf+B
         yfW45V1VHc02Jlq4atMTxQPAbe/zQnnFREBg/XZZ/OppDXhocjZmynhvcziAviJwTrp/
         MqDw==
Received: by 10.152.114.35 with SMTP id jd3mr9417747lab.18.1332168334482;
        Mon, 19 Mar 2012 07:45:34 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id s6sm18527188lbl.12.2012.03.19.07.45.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 07:45:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16 ThunderGit/0.1a
In-Reply-To: <20120318212957.GS1219@chaosreigns.com>
X-Gm-Message-State: ALoCoQl8329mxLzna5MjgLqyuv8H5LNUThvaVZMx7OttEYDGOytmHQjLyYxOm23QO686c8gCfiQv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193430>

On 03/18/2012 10:29 PM, darxus@chaosreigns.com wrote:
> I'd like to be able to tell get only that I know the latest commit is bad,
> and have it go find a good commit, then do the bisecting.  Maybe something
> like the opposite of a binary search, start with the last commit, then
> second to last, then 4th to last, 8th to last, etc., till it finds a good
> commit.
> 

Assuming the good commit is the 13'th from HEAD, you'd get the same nr
of attempts by just specifying a commit 100 revisions in the past and
doing the already implemented binary search as you would from trying 4
commits at a time to get at the good one.

Binary search is a "divide and conquer" algorithm (running in O(log n)
time), so it handles extremely large datasets very efficiently. As such,
it's (almost) always easier to just specify a revision really far back
in history and let it get to work. If you specify a range of 1000000
commits, it will take 20 attempts to find the right one ("git bisect"
has to exclude all possible candidates for both sides, so it always
runs in worst-case time, even when it hits the correct commit on the
first check).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
