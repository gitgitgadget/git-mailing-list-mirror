From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Tue, 22 Apr 2014 14:38:18 -0400
Message-ID: <5356B71A.6070500@bbn.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>	<20140421202454.GA6062@sigill.intra.peff.net>	<53562A96.6000002@alum.mit.edu> <xmqqy4yx5knw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, sitaramc@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 22 20:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcfaQ-00022P-EY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 20:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbaDVSiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 14:38:25 -0400
Received: from smtp.bbn.com ([128.33.1.81]:58957 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbaDVSiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 14:38:24 -0400
Received: from socket.bbn.com ([192.1.120.102]:42595)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WcfaP-000C1j-3X; Tue, 22 Apr 2014 14:38:29 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 570434029C
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqy4yx5knw.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246762>

On 2014-04-22 13:38, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> While we're at it, I think it would be prudent to ban '-' at the
>> beginning of reference name segments.  For example, reference names like
>>
>>     refs/heads/--cmd=/sbin/halt
>>     refs/tags/--exec=forkbomb(){forkbomb|forkbomb&};forkbomb
>>
>> are currently both legal, but I think they shouldn't be.
> 
> I think we forbid these at the Porcelain level ("git branch", "git
> checkout -b" and "git tag" should not let you create "-aBranch"),
> while leaving the plumbing lax to allow people experimenting with
> their repositories.
> 
> It may be sensible to discuss and agree on what exactly should be
> forbidden (we saw "leading dash", "semicolon and dollar anywhere"
> so far in the discussion)

Also backquote anywhere.

> and plan for transition to forbid them
> everywhere in a next big version bump (it is too late for 2.0).

Would it be acceptable to have a config option to forbid these in a
non-major version bump?  Does parsing config files add too much overhead
for this to be feasible?

If it's OK to have a config option, then here's one possible transition
path (probably flawed, but my intent is to bootstrap discussion):

  1. Add an option to forbid dangerous characters.  The option defaults
     to disabled for compatibility.  If the option is unset, print a
     warning upon encountering a ref name that would be forbidden.
  2. Later, flip the default to enabled.
  3. Later, in the weeks/months leading up to the next major version
     release, print the warning even if the config option is set to
     disabled.

Thanks,
Richard
