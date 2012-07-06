From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/6] Teach clone to set remote.default.
Date: Fri, 06 Jul 2012 16:43:00 -0400
Message-ID: <4FF74DD4.1060800@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-4-git-send-email-marcnarc@xiplink.com> <7vzk7dq0qk.fsf@alter.siamese.dyndns.org> <4FF6F811.7000808@xiplink.com> <7vd348of0z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 22:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnFMg-0002Ac-Bi
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 22:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab2GFUmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 16:42:53 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:56213 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2GFUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 16:42:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 71F101C809D;
	Fri,  6 Jul 2012 16:42:51 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C6E081C807E;
	Fri,  6 Jul 2012 16:42:50 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vd348of0z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201150>

On 12-07-06 03:39 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> If remote.default isn't set, then if someone does
>> 		git remote rename origin foo
>> the default remote will still be "origin" (modulo the currently-checked-out
>> branch stuff).
> 
> Why?

Erm, actually, my statement is incorrect.  Doh!

> I thought the proposed semantics was "if remote.default is
> unset, the default value of 'origin' is used where remote.default
> would have been used _everywhere_".

Yes, true.

> If "remote rename" wants to
> update the value of remote.default from 'origin' to 'foo' (which may
> or may not be the right thing to do, for which a separate discussion
> seems to exist already),

Are you talking about the sub-thread Phil Hord & I spawned about patch #4?  I
think Phil & I are in agreement there that it is the right thing to do.  If
anyone disagrees please speak up!

> and if it sees that the repository does not
> have remote.default, shouldn't it still set it to 'foo', just like
> the case where remote.default exists and set to 'origin'?

The proposed code actually already does that.  I'll add a unit test for this
case.

So why change "git clone" to always set remote.default if the functionality
remains the same either way?

To me it makes a more consistent implementation.  Since "git remote add" sets
remote.default if it's adding the first remote to the repository, when clone
itself adds the first remote it should do the same.

Plus this approach makes "clone -o" also work without any special-casing, so
the code is cleaner, IMHO.

If this justification is adequate, I'll add it to the commit message.  It may
then make more sense to have this commit come after the "git remote" changes
in the series.

> Your updated "remote rename" must work correctly in a repository
> that was created long ago, where remote.default was not set to
> anything (and default 'origin' was used) after all.
> 
> Or am I missing some subtle issues?

I agree with that requirement, and believe the proposed code fulfils it.

		M.
