From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Mon, 19 Nov 2007 17:47:05 +0000
Message-ID: <tnxbq9qyvom.fsf@pc1117.cambridge.arm.com>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com>
	<7v7ikfwhkj.fsf@gitster.siamese.dyndns.org>
	<9e4733910711181042x123e99efjad38486654db17e2@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 18:51:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuAl3-0006Uy-1d
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 18:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbXKSRtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 12:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753896AbXKSRtr
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 12:49:47 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:35573 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753819AbXKSRtq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 12:49:46 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id lAJHl7bG002983;
	Mon, 19 Nov 2007 17:47:07 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 Nov 2007 17:47:07 +0000
In-Reply-To: <9e4733910711181042x123e99efjad38486654db17e2@mail.gmail.com> (Jon Smirl's message of "Sun\, 18 Nov 2007 13\:42\:19 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-OriginalArrivalTime: 19 Nov 2007 17:47:07.0272 (UTC) FILETIME=[33EDE080:01C82AD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65476>

"Jon Smirl" <jonsmirl@gmail.com> wrote:
> On 11/18/07, Junio C Hamano <gitster@pobox.com> wrote:
>> "Jon Smirl" <jonsmirl@gmail.com> writes:
>>
>> > What's causing this? I'm using stgit on the master branch.
[...]
>> pushed "A" to the remote's 'master', then built this history:
>>
>>          o---o---A
>>         /
>>     ---o---o---o---o---A'
>>
>> by rewinding and rebuilding, and the tip of the branch now
>> points at A', which you tried to push to the remote.
>
> stgit must be doing this when I rebase. It pops all of it's patches,
> moves to head of linus/master and then rebases them.
[...]
> What is the right way to share repositories using stgit? I have a set
> of patches which I am working on for kernel inclusion. I have them
> applied as a stgit stack on top of linus/master. I need to share this
> patch stack with other developers. These developers may want to change
> one of my patches. Right now they are emailing me deltas and I apply
> them to the appropriate stgit patch. I have seventeen patches in my
> stack currently.

StGIT is meant for keeping a clean history but with the big
disadvantage that this history is volatile.

A solution is for the other developers to use StGIT or just git-rebase
so that they always have the same base (volatile) history and keep
their patches on top of yours.

A 2nd approach is to use topic branches rather than StGIT patches but
you might lose some flexibility.

Yet another approach (which I used) is to keep a public branch (can be
maintained by StGIT) where the history doesn't change and a devel
volatile branch. When I modify some patches and they are ready for
publishing, switch to the public branch and cherry-pick them (stg
pick) from the devel branch. Because this is done with a three-way
merge in StGIT, you will only get the new changes rather than the full
patch. You need to change the patch message (as it is that of the
original patch) to describe the specific changes and run 'stg refresh
&& stg commit' to store it into the immutable history (well, there is
an 'uncommit' command as well if something goes wrong).

-- 
Catalin
