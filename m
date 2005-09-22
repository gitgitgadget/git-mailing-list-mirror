From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT cannot import properly from stdin
Date: Thu, 22 Sep 2005 13:11:40 +0100
Message-ID: <tnxhdcd2tfn.fsf@arm.com>
References: <433107C7.60901@drzeus.cx>
	<b0943d9e05092101033dd5d366@mail.gmail.com>
	<433290A5.5070008@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 14:14:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIPwB-0003Tl-Tn
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 14:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVIVMMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 08:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVIVMMP
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 08:12:15 -0400
Received: from [63.80.46.197] ([63.80.46.197]:38579 "EHLO
	incsun1.losgatos.arm.com") by vger.kernel.org with ESMTP
	id S1030275AbVIVMMN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 08:12:13 -0400
Received: from ASHWA.Asiapac.Arm.com (localhost [127.0.0.1])
	by incsun1.losgatos.arm.com (8.12.6/8.12.6) with ESMTP id j8MCBdd1004006;
	Thu, 22 Sep 2005 05:12:01 -0700 (PDT)
Received: from ZIPPY.Emea.Arm.com ([10.1.255.57]) by ASHWA.Asiapac.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Thu, 22 Sep 2005 17:41:58 +0530
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 22 Sep 2005 13:11:41 +0100
To: Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <433290A5.5070008@drzeus.cx> (Pierre Ossman's message of "Thu,
 22 Sep 2005 13:08:21 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 22 Sep 2005 12:11:41.0431 (UTC) FILETIME=[CA7B4070:01C5BF6E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9112>

Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>>It works for me with the latest snapshot. What might happen in your
>>case is a missing "---" line after the patch description. The import
>>command reads the sys.stdin file descriptor until the first "---"
>>line. After that, the git.apply() function will read the rest of the
>>lines and pass them to git-apply. You can put some prints in the
>>git.apply() function to check where it starts reading from.
>
> Hmm... it seems you're kind of right. It doesn't need the patch twice.
> But it needs EOF more than once. The for-loop in __parse_patch() doesn't
> start until the EOF is recieved. And the second for-loop in _input()
> requires a new EOF.

The line below in __parse_patch() ensures that the 'for' loop does not
consume all the input lines:

        if re.match('---\s*$', line) or re.match('diff -', line):
            break

Unfortunately, if the '---' line is missing, it consumes all the input
lines. Is this the case with your patch?

> If you would cache the input to a file (or memory) you would remove both
> of these problems.

True, but it requires more work than simply writing the patch to a
file and reading it twice.

-- 
Catalin
