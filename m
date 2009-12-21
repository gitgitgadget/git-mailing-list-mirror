From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: possible code error at run_command.c
Date: Mon, 21 Dec 2009 09:52:02 +0100
Message-ID: <4B2F3732.6030903@viscovery.net>
References: <1976ea660912202246k45732bf2p111bbeb78047693e@mail.gmail.com>	 <4B2F214D.2020905@viscovery.net>	 <1976ea660912202329x42f6add3j9175867e8723a4bd@mail.gmail.com>	 <4B2F2727.4060405@viscovery.net>	 <1976ea660912210018y15acfe32o78841d5e0968f793@mail.gmail.com>	 <4B2F320A.6010908@viscovery.net> <40aa078e0912210041g1fd94c77g6cf9f1b236b6ecd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 21 09:52:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMdzz-00029f-Q2
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 09:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZLUIwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 03:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZLUIwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 03:52:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51851 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752665AbZLUIwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 03:52:08 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NMdzn-0003mj-5n; Mon, 21 Dec 2009 09:52:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DE0771660F;
	Mon, 21 Dec 2009 09:52:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <40aa078e0912210041g1fd94c77g6cf9f1b236b6ecd7@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135550>

Erik Faye-Lund schrieb:
> On Mon, Dec 21, 2009 at 9:30 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Frank Li schrieb:
>>> Maybe some excute path miss initialized it. Otherwise compiler will
>>> not report warning.
>> LOOK AT THE CODE. There is no such code path.
>>
> 
> That's odd.

Only if Frank did the homework and removed the initialization from

	int failed_errno = failed_errno;

> I agree, there isn't such a code path. But this is the
> first time I've ever seen this MSVC-feature turn up false positives,
> which puzzles me.

This line will trigger the check. It initializes failed_errno with itself,
which is still uninitialized at this time.

Note that we have more definitions of this kind:

$ git grep -E ' ([a-zA-Z_][a-zA-Z_0-9]*) = \1[;,]' *.c
builtin-rev-list.c:             int reaches = reaches, all = all;
match-trees.c:          unsigned mode1 = mode1;
match-trees.c:          unsigned mode2 = mode2;
run-command.c:  int failed_errno = failed_errno;
transport.c:            int cmp = cmp, len;
wt-status.c:    int status = status;

-- Hannes
