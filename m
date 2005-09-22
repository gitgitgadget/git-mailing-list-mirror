From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 15:34:45 +0100
Message-ID: <tnxr7bh188q.fsf@arm.com>
References: <433107C7.60901@drzeus.cx>
	<b0943d9e05092101033dd5d366@mail.gmail.com>
	<433290A5.5070008@drzeus.cx> <tnxhdcd2tfn.fsf@arm.com>
	<4332BA3E.2080607@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 16:39:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EISBE-0004oc-5x
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 16:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030378AbVIVOgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 10:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbVIVOgF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 10:36:05 -0400
Received: from incsun1.losgatos.arm.com ([63.80.46.197]:29154 "EHLO
	incsun1.losgatos.arm.com") by vger.kernel.org with ESMTP
	id S1030378AbVIVOgD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 10:36:03 -0400
Received: from ASHWA.Asiapac.Arm.com (localhost [127.0.0.1])
	by incsun1.losgatos.arm.com (8.12.6/8.12.6) with ESMTP id j8MEYrcx007175;
	Thu, 22 Sep 2005 07:35:53 -0700 (PDT)
Received: from ZIPPY.Emea.Arm.com ([10.1.255.57]) by ASHWA.Asiapac.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 22 Sep 2005 20:05:28 +0530
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 22 Sep 2005 15:34:50 +0100
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <4332BA3E.2080607@drzeus.cx> (Pierre Ossman's message of "Thu,
 22 Sep 2005 16:05:50 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Sep 2005 14:34:50.0267 (UTC) FILETIME=[C9D39EB0:01C5BF82]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9122>

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>>Unfortunately, if the '---' line is missing, it consumes all the input
>>lines. Is this the case with your patch?
>
> Nope. It consumes the correct ammount of lines. The problem is that I
> have to give it a kick (^D) to start things twice. The first for
> __parse_patch() and the second for _input(). I put some debug-prints in
> there and the for-loops will not start executing on the first complete
> line, only EOF.

I tried it with reading from the terminal directly and you are right.

Using 'stg import -n patch < patch-file' is fine since the stdin is
not re-opened and the _input() loop starts automatically.

'cat | stg import -n patch' also works fine since cat exits when stdin
receives EOF.

It looks like a problem with Python since it re-opens sys.stdin once
it receives EOF.

>>>If you would cache the input to a file (or memory) you would remove both
>>>of these problems.
>>
>>True, but it requires more work than simply writing the patch to a
>>file and reading it twice.
>
> If it supports everything when given a filename then shouldn't adding a
> preprocessing step to dump stdin to disk give the same code path?

I was referring to the 'cache the input to memory' variant, which is a
bit more complicated. Caching to a file is simple but do you need to
read patches from the terminal directly?

-- 
Catalin
