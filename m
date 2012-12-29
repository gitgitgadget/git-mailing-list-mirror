From: Martin Fick <mfick@codeaurora.org>
Subject: Re: Lockless Refs?
Date: Sat, 29 Dec 2012 14:15:50 -0700
Message-ID: <30efc2de-237f-4f46-9748-fa9c12e3e1be@email.android.com>
References: <20121221080449.GA21741@sigill.intra.peff.net> <50DAB447.8000101@alum.mit.edu> <201212271611.52203.mfick@codeaurora.org> <201212280750.14695.mfick@codeaurora.org> <7vhan6jdx3.fsf@alter.siamese.dyndns.org> <20121229081657.GE15408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Shawn Pearce <sop@google.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 22:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp3qV-0007U0-4b
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 22:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276Ab2L2VVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 16:21:13 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:10632 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149Ab2L2VVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 16:21:12 -0500
X-IronPort-AV: E=Sophos;i="4.84,378,1355126400"; 
   d="scan'208";a="16932016"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Dec 2012 13:21:11 -0800
Received: from [192.168.1.181] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E003010004B1;
	Sat, 29 Dec 2012 13:21:10 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20121229081657.GE15408@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212318>



Jeff King <peff@peff.net> wrote:

>On Fri, Dec 28, 2012 at 09:15:52AM -0800, Junio C Hamano wrote:
>
>> Martin Fick <mfick@codeaurora.org> writes:
>> 
>> > Hmm, actually I believe that with a small modification to the 
>> > semantics described here it would be possible to make multi 
>> > repo/branch commits work....
>> >
>> > Shawn talked about adding multi repo/branch transaction 
>> > semantics to jgit, this might be something that git wants to 
>> > support also at some point?
>> 
>> Shawn may have talked about it and you may have listened to it, but
>> others wouldn't have any idea what kind of "multi repo/branch
>> transaction" you are talking about.  Is it about "I want to push
>> this ref to that repo and push this other ref to that other repo",
>> in what situation will it be used/useful, what are the failure
>> modes, what are failure tolerances by the expected use cases, ...?
>> 
>> Care to explain?
>
>I cannot speak for Martin, but I am assuming the point is to atomically
>update 2 (or more) refs on the same repo. That is, if I have a branch
>"refs/heads/foo" and a ref pointing to meta-information (say, notes
>about commits in foo, in "refs/notes/meta/foo"), I would want to "git
>push" them, and only update them if _both_ will succeed, and otherwise
>fail and update nothing.

My use case was cross repo/branch dependencies in Gerrit (which do not yet exist). Users want to be able to define several changes (destined for different project/branches) which can only be merged together.  If one change cannot be merged, the others should fail too.  The solutions we can think of generally need to hold ref locks while acquiring more ref locks, this drastically increases the opportunities for stale locks over the simple "lock, check, update, unlock" mode which git locks are currently used for.

I was perhaps making too big of a leap to assume that there would be other non Gerrit uses cases for this?  I assumed that other git projects which are spread across several git repos would need this? But maybe this simply wouldn't be practical with other git server solutions?

-Martin

Employee of Qualcomm Innovation Center,Inc. which is a member of Code Aurora Forum
