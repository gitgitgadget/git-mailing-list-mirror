From: Corey Thompson <cmtptr@gmail.com>
Subject: Re: git-p4 out of memory for very large repository
Date: Wed, 28 Aug 2013 11:41:35 -0400
Message-ID: <20130828154135.GA16921@jerec>
References: <20130823011245.GA7693@jerec>
 <52170C6A.4080708@diamand.org>
 <20130823114856.GA8182@jerec>
 <20130825155001.GA875@padd.com>
 <20130826134756.GA1335@jerec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 17:41:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEhsU-0004XJ-Ed
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 17:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab3H1Plq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 11:41:46 -0400
Received: from mail-gh0-f182.google.com ([209.85.160.182]:64449 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab3H1Plp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 11:41:45 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so1581592ghb.13
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 08:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=salMPKMMphVbm9AhidnzFNqA7dYMwFfHqIMUTuXTBKs=;
        b=dwntVOeuRwPlKOBR21ZEg4i9gCIqApxah9X5K+QALVLoGx6429RqRNY9gJbdLUZJRs
         mN7bRrpjRCs8MDvOfqm51xvSPWmIGtgNutocTNZ+TFfixON3d4BXJdf5dKzFX14yN7gz
         wqm1O3DeA/hkdkcu+OZDPkMH15C9dnCQHqioq2WTIMLOmnQ2NYyNn0z6NbrmPunE/e3+
         4d/zZlMd1IU35mK8JEF2hjKBOe36yowjHLk3buRG4vUx1rE9dYskMj7KdN/IkKSkbqVt
         lMsu1nF9KKa8X6ysvGrvKH38uvXFw+SY6hTrw5qifpB3vQSy7zJua9hqu+k+gKApcC2E
         r20w==
X-Received: by 10.236.6.199 with SMTP id 47mr651065yhn.127.1377704504866;
        Wed, 28 Aug 2013 08:41:44 -0700 (PDT)
Received: from jerec (c-71-59-19-88.hsd1.ga.comcast.net. [71.59.19.88])
        by mx.google.com with ESMTPSA id w43sm7537204yhl.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 08:41:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130826134756.GA1335@jerec>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233190>

On Mon, Aug 26, 2013 at 09:47:56AM -0400, Corey Thompson wrote:
> You are correct that git-fast-import is killed by the OOM killer, but I
> was unclear about which process was malloc()ing so much memory that the
> OOM killer got invoked (as other completely unrelated processes usually
> also get killed when this happens).
> 
> Unless there's one gigantic file in one change that gets removed by
> another change, I don't think that's the problem; as I mentioned in
> another email, the machine has 32GB physical memory and the largest
> single file in the current head is only 118MB.  Even if there is a very
> large transient file somewhere in the history, I seriously doubt it's
> tens of gigabytes in size.
> 
> I have tried watching it with top before, but it takes several hours
> before it dies.  I haven't been able to see any explosion of memory
> usage, even within the final hour, but I've never caught it just before
> it dies, either.  I suspect that whatever the issue is here, it happens
> very quickly.
> 
> If I'm unable to get through this today using the incremental p4 sync
> method you described, I'll try running a full-blown clone overnight with
> top in batch mode writing to a log file to see whether it catches
> anything.
> 
> Thanks again,
> Corey

Unforunately I have not made much progress.  The incremental sync method
fails with the output pasted below.  The change I specified is only one
change number above where that repo was cloned...

So I tried a 'git p4 rebase' overnight with top running, and as I feared
I did not see anything out of the ordinary.  git, git-fast-import, and
git-p4 all hovered under 1.5% MEM the entire time, right up until
death.  The last entry in my log shows git-fast-import at 0.8%, with git
and git-p4 at 0.0% and 0.1%, respectively.  I could try again with a
more granular period, but I feel like this method is ultimately a goose
chase.

Corey


$ git p4 sync //path/to/some/branch@505859
Doing initial import of //path/to/some/branch/ from revision @505859 into refs/remotes/p4/master
fast-import failed: warning: Not updating refs/remotes/p4/master (new tip 29ef6ff25f1448fa2f907d22fd704594dc8769bd does not contain d477672be5ac6a00cc9175ba2713d5395660e840)
git-fast-import statistics:
---------------------------------------------------------------------
Alloc'd objects:     165000
Total objects:           69 (    232434 duplicates                  )
      blobs  :           45 (    209904 duplicates         40 deltas of         42 attempts) 
      trees  :           23 (     22530 duplicates          0 deltas of         23 attempts) 
      commits:            1 (         0 duplicates          0 deltas of          0 attempts) 
      tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
Total branches:           1 (         1 loads     )
      marks:           1024 (         0 unique    )
      atoms:         105170
Memory total:         24421 KiB
       pools:         17976 KiB
     objects:          6445 KiB
---------------------------------------------------------------------
pack_report: getpagesize()            =       4096
pack_report: core.packedGitWindowSize =   33554432
pack_report: core.packedGitLimit      =  268435456
pack_report: pack_used_ctr            =       4371
pack_report: pack_mmap_calls          =        124
pack_report: pack_open_windows        =          8 /          9
pack_report: pack_mapped              =  268435456 /  268435456
---------------------------------------------------------------------
