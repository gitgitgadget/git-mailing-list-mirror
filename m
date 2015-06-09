From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: format-patch and submodules
Date: Tue, 09 Jun 2015 20:52:22 +0200
Message-ID: <557735E6.8040906@web.de>
References: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Christopher Dunn <cdunn2001@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:52:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Odd-0002zq-HD
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269AbbFISwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:52:32 -0400
Received: from mout.web.de ([212.227.15.3]:52293 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933292AbbFISw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:52:27 -0400
Received: from [192.168.178.41] ([79.211.107.75]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MbQLE-1YjlHn0vYa-00IhYT; Tue, 09 Jun 2015 20:52:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAD2z=MAu1qrr9=wwBnOJZZ3JCJOsmFWi=gDgKMQKU3_P-01e3g@mail.gmail.com>
X-Provags-ID: V03:K0:Y/UyIxG5cJ9R0ACHNgvmrw0A+EwpMY4TWfMHf+nlL3hz8xp62LW
 b0IcMkx25Q6DlJD/inlc0zeT+GqPL2oLbtlBVM3OVZWBxPayOQG0jp0oIdzgnTPOTdgK49Z
 xWVinJ3sOVww2Mef7/ZtIyvk+kAoAIA6ASdu4xTQgaODcv1FHiUn9HJAga0TRSXh/mSZCeI
 GEfsi9qgt73x6fswNwYZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271229>

Am 05.06.2015 um 01:20 schrieb Christopher Dunn:
> (Seen in git versions: 2.1.0 and 1.9.3 et al.)
>
> $ git format-patch --stdout X^..X | git apply check -
> fatal: unrecognized input
>
> This fails when the commit consists of nothing but a submodule change
> (as in 'git add submodule foo'), but it passes when a file change is
> added to the same commit.
>
> There used to be a similar problem for empty commits, but that was
> fixed around git-1.8:
>
>      http://stackoverflow.com/questions/20775132/cannot-apply-git-patch-replacing-a-file-with-a-link
>
> Now, 'git format-patch' outputs nothing for an empty commit. I suppose
> that needs to be the behavior also when only submodules are changed,
> since in that case there is no 'diff' section from 'format-patch'.
>
> Use-case: git-p4
>
> Of course, we do not plan to add the submodule into Perforce, but we
> would like this particular command to behave the same whether there
> are other diffs or not.

Hmm, I'm not sure that this is a bug. It looks to me like doing a

$ git format-patch --stdout X^..X | git apply check -

when nothing is changed except submodules and expecting it to work
is the cause of the problem.

I get the same error when I do:

$git format-patch --stdout master..master | git apply --check -
fatal: unrecognized input

No submodules involved, just an empty patch.

I assume you want to ignore all submodule changes, so you should
check if e.g. "git diff --ignore-submodules X^..X" returns anything
before applying that? (From the command you ran I assume you might
be able to drop the --ignore-submodules because you already did set
"diff.ignoreSubmodules" to "all"?)
