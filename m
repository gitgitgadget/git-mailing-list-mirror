From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: RE: [BUG] git clean does not remove certain directories
Date: Wed, 21 Nov 2012 05:02:11 +0000
Message-ID: <1c18081c-baa9-4e1a-b463-ae7abf787f1c@CO1EHSMHS004.ehs.local>
References: <933d806a-abce-4baf-8c3b-9b6742cb8ac7@VA3EHSMHS004.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 06:04:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb2Tg-0003JK-9q
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 06:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab2KUFDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 00:03:44 -0500
Received: from [216.32.180.187] ([216.32.180.187]:38319 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750900Ab2KUFDV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 00:03:21 -0500
Received: from mail135-co1-R.bigfish.com (10.243.78.238) by
 CO1EHSOBE011.bigfish.com (10.243.66.74) with Microsoft SMTP Server id
 14.1.225.23; Wed, 21 Nov 2012 05:02:15 +0000
Received: from mail135-co1 (localhost [127.0.0.1])	by
 mail135-co1-R.bigfish.com (Postfix) with ESMTP id ADB58720252	for
 <git@vger.kernel.org>; Wed, 21 Nov 2012 05:02:15 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: 0
X-BigFish: VPS0(zz1432Izz1de0h1202h1d1ah1d2ahzzz2fh95h668h839h944hd24hf0ah119dh1220h1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h906i1155h)
Received-SPF: pass (mail135-co1: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail135-co1 (localhost.localdomain [127.0.0.1]) by mail135-co1
 (MessageSwitch) id 1353474133239285_6942; Wed, 21 Nov 2012 05:02:13 +0000
 (UTC)
Received: from CO1EHSMHS004.bigfish.com (unknown [10.243.78.249])	by
 mail135-co1.bigfish.com (Postfix) with ESMTP id 36B13940049	for
 <git@vger.kernel.org>; Wed, 21 Nov 2012 05:02:13 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by CO1EHSMHS004.bigfish.com
 (10.243.66.14) with Microsoft SMTP Server id 14.1.225.23; Wed, 21 Nov 2012
 05:02:13 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1Tb2Rw-0007Ok-Sw	for git@vger.kernel.org;
 Tue, 20 Nov 2012 21:02:12 -0800
Thread-Topic: [BUG] git clean does not remove certain directories
Thread-Index: AQHNx3wI2W6xnPfbG0uanSxH0SNwgZfzuuhG
In-Reply-To: <933d806a-abce-4baf-8c3b-9b6742cb8ac7@VA3EHSMHS004.ehs.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [149.199.60.81]
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210135>

> Hi,
>
> this use case may be a little awkward but this is the behavior I see:
>
> I have a repository which has a couple of untracked directories which can also
> include git repositories. No submodules, though.
> I used 'git clean -xdf' on the top level of this repo to remove everything
> untracked in it - including the git repositories in sub-directories.
>
> Since using git 1.8.0 the clean operation seems to be 'broken', as output
> indicates all those questionable sub directories are removed - just as in prior
> git versions - but in fact they remain untouched and are _not_ removed.
>
> I attached a shell script creating a hierarchy to reproduce the issue.
> Executing the script creates the git repo 'repo.git' with a couple of tracked
> and untracked dirs/files and two more git repositories within the first one.
>
> If you cd into repo.git and execute 'git clean -xdf' I see the following output:
>       Removing repo2.git/
>       Removing untracked_dir/
>
> But the directories remain intact when using git 1.8.0.
> With git 1.6.3.2 it works as I expected and removes the
> directories. I'm pretty
> sure the 1.7.x versions did the same, but it's no longer
> installed here.

As additional data point: With git 1.7.9.5 the 'untracked_dir' is deleted, while
'repo2.git' is kept. Output is the same as always, indicating both were deleted.

So, three different git versions gain three different results...

        Soren


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
