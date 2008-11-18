From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-bisect not working correctly in the kvm.git repository?
Date: Tue, 18 Nov 2008 08:13:42 +0100
Message-ID: <49226B26.4000807@viscovery.net>
References: <gfs9hn$hq9$1@ger.gmane.org> <alpine.LFD.2.00.0811171131330.18283@nehalem.linux-foundation.org> <gfsjjp$o42$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 08:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Knc-0003MB-Qp
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 08:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbYKRHNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 02:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbYKRHNp
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 02:13:45 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:62473 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbYKRHNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 02:13:44 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L2KmM-0004et-CN; Tue, 18 Nov 2008 08:13:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 217CB4E4; Tue, 18 Nov 2008 08:13:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <gfsjjp$o42$1@ger.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101262>

walt schrieb:
> Linus Torvalds wrote:
>>
>> On Mon, 17 Nov 2008, walt wrote:
>>> I'm trying to find a bug introduced somewhere between kvm-69
>>> and kvm-70, so of course I want to git-bisect down to it.
>>>
>>> The weirdness is that when I give git-bisect the good and
>>> bad tags, almost everything in my working directory just
>>> disappears, leaving only the qemu subdirectory behind.
> 
>> ...
>> If you merge stuff from another project that isn't a full repository,
>> then
>> you are merging commits that simply don't _have_ the full tree of your
>> repo...
> 
> Okay, that's clearly what's happening to me.  The kvm.git repo
> contains hundred of commits just like that.  How would you deal
> with the same situation?  Is git-bisect skip the easiest way?

If you are pretty sure that the bug you are looking for was *not*
introduced in the branch that was subtree-merged, you can mark it as
"good" like so:

  $ git bisect start kvm-69 kvm-70 $BRANCH

where $BRANCH is the most recent commit on the subtree-merged branch.
Watch out that you do *not* accidentally pick the *merge* commit that
merged the branch in, but the (second) parent[*], the one that was merged
in.  Then your bisect sequence won't ever end up in that branch.

[*] If you happen to have the branch lying around as a remote ref, you can
use that instead, even if it is ahead of what was merged in.

-- Hannes
