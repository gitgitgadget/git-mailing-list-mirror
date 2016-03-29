From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/4] config --show-origin: report paths with forward
 slashes
Date: Tue, 29 Mar 2016 21:18:30 +0200
Message-ID: <56FAD506.4050701@kdbg.org>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <8beb1c208e33e1de8f272caa22fb7a0b662ca4cc.1458668543.git.johannes.schindelin@gmx.de>
 <56F8E435.3020304@kdbg.org> <alpine.DEB.2.20.1603281712470.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:18:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akz9y-0007HI-Nn
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbcC2TSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:18:34 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44441 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbcC2TSd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:18:33 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3qZLCq30mwz5tlC;
	Tue, 29 Mar 2016 21:18:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 7DCE051D4;
	Tue, 29 Mar 2016 21:18:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <alpine.DEB.2.20.1603281712470.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290165>

Am 28.03.2016 um 17:14 schrieb Johannes Schindelin:
> Hi Hannes,
> 
> On Mon, 28 Mar 2016, Johannes Sixt wrote:
> 
>> A change like this whould have been preferable:
>> [...]
> 
> The problem with your patch is that it does not account for backslashes in
> paths resulting in quoting. I am afraid that your patch will most likely
> *not* let the tests pass in Git for Windows SDK, while my patch does.

It does pass. The reason is that pwd -W generates forward slashes.

This part of your 45bf3297 (t1300: fix the new --show-origin tests on
Windows)

@@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing per
          "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
 '
 
+! test_have_prereq MINGW ||
+HOME="$(pwd)" # convert to Windows path
+
 test_expect_success 'set up --show-origin tests' '
        INCLUDE_DIR="$HOME/include" &&
        mkdir -p "$INCLUDE_DIR" &&

is actually a much more concise version of my proposed patch,
although the result still misuses $HOME where it does not have
to. In fact, if I revert 5ca6b7bb (config --show-origin: report
paths with forward slashes), the tests still pass. But since it
does not make a difference save for a few microseconds more or
less during startup, it is not worth the churn at this point.

-- Hannes
