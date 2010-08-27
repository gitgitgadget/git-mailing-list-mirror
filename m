From: Dave Olszewski <cxreg@pobox.com>
Subject: Re: [PATCH] push: disallow fast-forwarding tags without --force
Date: Fri, 27 Aug 2010 11:01:16 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008271046080.20874@narbuckle.genericorp.net>
References: <1282893284-17829-1-git-send-email-cxreg@pobox.com> <7vfwy0hsn1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 20:04:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op3HY-0003nK-PD
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 20:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab0H0SD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 14:03:57 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:39793 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755175Ab0H0SDy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 14:03:54 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id o7RI1GVY032529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 27 Aug 2010 13:01:17 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <7vfwy0hsn1.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154613>

On Fri, 27 Aug 2010, Junio C Hamano wrote:

> Dave Olszewski <cxreg@pobox.com> writes:
> 
> > Generally, tags are considered a write-once ref (or object), and updates
> > to them are the exception to the rule.  This is evident from the
> > behavior of "git fetch", which will not update a tag it already has
> > unless --tags is specified, and from the --force option to "git tag".
> 
> The title and what you describe later in your proposed log message do not
> match.  This is about "push: disallow updating an existing tag by default"
> isn't it?

I don't see a major difference in meaning, since only fast-forwards are
allowed without --force, but you're right about my intent.  I'm happy to
change the commit message.

> This proposes a big change in the policy, and I do not like it starting
> out as the new default to forbid people from doing something they have
> been allowed to do for a long time.  I recall hearing some people auto
> tagging the latest version their autobuilder/tester tested successfully
> and updating the same tag nightly---your change will break their cron
> script, no?
> 
> If you ship the feature disabled by default first, it will still allow
> people to take advantage of it by simply flipping the feature on, instead
> of having to install their own update hook.  In a later version, if and
> when enough people agree that this should be on by default, we can do so
> at a version bump.

Yes that's true.  I suspected based on the lack of any documentation or
tests promising such behavior, the inclination for git to want to
pretend that changed tags haven't changed, and the social stigma against
it, that this was a bug.

It's trivial for someone to update build software from "git push remote
tag" to "git push remote +tag" or "git push -f remote tag", but I can
understand your objection.  It's the reason I didn't also add
receive.denyMovingTags to the default config for bare repositories.

It seems unlikely that many people are ever going to "flip on" this
feature; either they won't know about it (and for them, it should be
on), or they'll have a reason to move a tag, and want it off.  That, and
my perception that this was unintentional behavior, is the reason I
patched it to be default.

However, If you still feel strongly about this, I can rework it to be
optional.  Thanks for your feedback!

    Dave
