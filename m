From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Wed, 01 Jun 2011 12:11:13 -0400
Message-ID: <4DE664A1.5060206@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de> <4DE55857.3090706@xiplink.com> <4DE55D0F.1020905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:11:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRo10-0007wV-04
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab1FAQLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:11:21 -0400
Received: from smtp122.iad.emailsrvr.com ([207.97.245.122]:36653 "EHLO
	smtp122.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696Ab1FAQLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:11:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp52.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 604CD2405E5;
	Wed,  1 Jun 2011 12:11:19 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp52.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 36D262405E4;
	Wed,  1 Jun 2011 12:11:19 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <4DE55D0F.1020905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174875>

On 11-05-31 05:26 PM, Jens Lehmann wrote:
> Am 31.05.2011 23:06, schrieb Marc Branchaud:
>> On 11-05-31 03:30 PM, Jens Lehmann wrote:
>>> Am 30.05.2011 23:51, schrieb Marc Branchaud:
>>>> Patch 2 exposes an anomaly in "submodule status", which reports that a
>>>> submodule is OK even though it has deleted files.  "git status" inside
>>>> the submodule (and in the super-repo) both identify any deleted files, but
>>>> "submodule status" doesn't prefix the submodule's HEAD SHA-ID with a "+".
>>>
>>> That is documented behavior. "git submodule status" only cares about the
>>> commit recorded in the superproject vs the HEAD in the submodule, work
>>> tree modifications are never shown by it.
>>>
>>> But try a "git status" in the superproject, that will give you the following
>>> output:
>>> #	modified:   init (modified content)
>>
>> I understand.  My apologies for not reading the man page closely enough.
> 
> No problem, maybe that's just an indication that a reference to "git status"
> being more capable of telling what is going on inside a submodule is missing
> to the man page for "git submodule status".

Yes, that'd possibly help.

>> I know there's been a lot of recent work on making "git status"
>> submodule-friendly, but would there be any interest in having another prefix
>> for submodule status to cover this case?  Maybe ! could indicate that the
>> submodule's HEAD is correct, but the working directory doesn't match it exactly.
> 
> I'd rather leave "git submodule status" as it is and incorporate this kind
> of functionality into core git (for "submodule status" it already arrived there
> in 1.7.0/1.7.1, so that part is finished ;-). I hope making the "git submodule"
> script mostly obsolete in the long run and would want to avoid teaching it new
> stuff already covered by core git.

A noble goal, certainly.

So here's my basic question: How can my build system be sure that a submodule
contains the correct working directory?  Do I need to do both "git submodule
status" to check the submodule's HEAD, then also use "git status" to see if
that HEAD is correctly checked out?

Note that my automated builds don't really care about possibly-modified files
or anything like that.  They just want the exact tree that corresponds to the
commit ID recorded in the superproject.  (Previous builds might've left some
cruft lying around, and the automated build wants to be sure that's eliminated.)

Maybe I should just forego the status-checking altogether, and do "git
submodule update path/to/sub && (cd path/to/sub; git reset --hard HEAD; git
clean -dx)".

		M.
