From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Possible bug in 1.6.6 with reset --hard and $GIT_WORK_TREE
Date: Tue, 29 Dec 2009 20:04:26 +0900
Message-ID: <20091229200426.6117@nanako3.lavabit.com>
References: <1a04eebf0912282247p6975a96el8076cb39378bd104@mail.gmail.com> <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Fyn Fynn <fynfynn@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPZtJ-0001O2-CQ
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:05:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbZL2LFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbZL2LFN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:05:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:38992 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751192AbZL2LFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:05:12 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 205E111B8BB;
	Tue, 29 Dec 2009 05:05:12 -0600 (CST)
Received: from 4391.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id TL11R2D2ILM6; Tue, 29 Dec 2009 05:05:12 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=VCg3maioDQ1zvQxLXWM2EQS+JbIdoC8T4BWQAqAeLj/m/kB+T7D9JjVM7wpfKv1hgYFS3ckg8Ozt7sVJGNp3PzoSqhSTQdK8JfJ+e+nPYJS2XN4C5QurZ/lJLDYfs7reH4okjM1IpoydmPQfkDrLeST/KwxkpBWJ1PLcL9P95Vs=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <fcaeb9bf0912290038u77a5e83cqe2f3cbfab05af263@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135788>

Quoting Nguyen Thai Ngoc Duy <pclouds@gmail.com>:

> On 12/29/09, Fyn Fynn <fynfynn@gmail.com> wrote:
>> The exact same git reset command that works in 1.6.4, fails to work
>>  under 1.6.6:
>>
>>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>>  /usr/local/git-1.6.6/bin/git reset --hard
>>  fatal: hard reset requires a work tree
>>  $ GIT_WORK_TREE=$HOME/rawdata/ GIT_DIR=$HOME/rawdata/.git
>>  /usr/local/git-1.6.4/bin/git reset --hard
>>  HEAD is now at 77ec73f...
>>
>>  What gives?
>
> A recent patch by Jeff (952dfc6 (reset: improve worktree safety valves
> - 2009-12-04)) makes sure that "git reset --hard" will not work
> outside worktree (which is right).

Sorry, but I don't understand why it is *right*. Isn't 'git reset --hard' supposed to make all the files in the working tree match the HEAD, no matter where you start from?

Jeff's commit message says:

        make sure we are in a worktree. Otherwise, we can end up
	munging files inside of '.git'

But if you have ~/myproject/.git project, whose working tree is ~/myproject, and if you run

        % cd ~/myproject/.git
	% git reset --hard

the code mistakenly overwrote files in ~/myproject/.git directory before Jeff's patch, and I agree it was a bug.

But shouldn't the correct fix be to go to ~/myproject, the obvious root level of the working tree, and check out the files in that directory?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
