From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 0/2] Tests for some submodule corner cases.
Date: Tue, 31 May 2011 17:06:31 -0400
Message-ID: <4DE55857.3090706@xiplink.com>
References: <1306792280-12768-1-git-send-email-marcnarc@xiplink.com> <4DE541EC.7010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 31 23:06:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRW9D-00038h-AK
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 23:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527Ab1EaVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 17:06:38 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:38063 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282Ab1EaVGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 17:06:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 21E6CE014F;
	Tue, 31 May 2011 17:06:37 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp28.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EA307E01C9;
	Tue, 31 May 2011 17:06:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <4DE541EC.7010202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174828>

On 11-05-31 03:30 PM, Jens Lehmann wrote:
> Am 30.05.2011 23:51, schrieb Marc Branchaud:
>> Ran across some submodule behavior that seems wrong to me.  I don't have the
>> chops to fix the issues, so I thought I'd just point them out with some unit
>> tests.
> 
> Thanks for bringing these issues to our attention this way, having a way
> to easily reproduce them is very much appreciated.
> 
>> Patch 1 tests the case where "submodule add" fails if the path to the
>> submodule repo is relative (i.e. starts with "../").  This currently fails
>> with "remote (origin) does not have a url defined in .git/config".  Maybe
>> there's a reason to fail?  If so, a better error message would be appreciated.
> 
> I stumbled across this behavior now and then too, but according to the
> commit it added (f31a522a2d) it is intended that adding a relative path
> behaves differently than using an absolute path (it resolves relative to
> the superproject's origin, not the filesystem, and to be able to do that
> the superproject's .git/config has to have an url defined for it). But
> you are right about the error message, it really isn't that helpful ...
> 
>> Patch 2 exposes an anomaly in "submodule status", which reports that a
>> submodule is OK even though it has deleted files.  "git status" inside
>> the submodule (and in the super-repo) both identify any deleted files, but
>> "submodule status" doesn't prefix the submodule's HEAD SHA-ID with a "+".
> 
> That is documented behavior. "git submodule status" only cares about the
> commit recorded in the superproject vs the HEAD in the submodule, work
> tree modifications are never shown by it.
> 
> But try a "git status" in the superproject, that will give you the following
> output:
> #	modified:   init (modified content)

I understand.  My apologies for not reading the man page closely enough.

I know there's been a lot of recent work on making "git status"
submodule-friendly, but would there be any interest in having another prefix
for submodule status to cover this case?  Maybe ! could indicate that the
submodule's HEAD is correct, but the working directory doesn't match it exactly.

		M.
