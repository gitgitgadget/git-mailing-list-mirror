From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 6 May 2014 09:07:49 +0100
Message-ID: <20140506080749.GD23935@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:46:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiLS-0008Bg-M0
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934295AbaEFIN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 04:13:27 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:49179 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934230AbaEFINY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 04:13:24 -0400
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 May 2014 04:13:24 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 9327822B61;
	Tue,  6 May 2014 09:07:55 +0100 (BST)
X-Quarantine-ID: <aAQBg+krJALr>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aAQBg+krJALr; Tue,  6 May 2014 09:07:54 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 6C9A722B91;
	Tue,  6 May 2014 09:07:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248190>

On Mon, May 05, 2014 at 04:50:58PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> Having said all that, there is one caveat.
> 
> > Since the remote helper interface is stable and the remote helpers do
> > not use any of the Git internals, I consider the risks of including them
> > in core Git to outweigh the benefits of wider distribution.
> 
> You are correct to say that a remote helper has to talk with a
> foreign system and it would not help to dictate the update schedule
> of helpers to match the release cycle of Git itself.  At the same
> time, however, the interface the remote helpers use to talk to Git
> has not been as stable as you seem to think, I am afraid.  For
> example, a recent remote-hg/bzr series needed some enhancements to
> fast-import to achieve the feature parity with native transports by
> adding a missing feature or two on the Git side.

This doesn't qualify as an unstable interface for me.  In this case, the
remote helpers could not support a feature without Git supporting it
first, which is quite natural and the remote helper can then guard that
feature with a capability check.  I do not think it likely that the
remote helper interface will ever change in such a way that all remote
helpers must be updated, at least not without a long deprecation period.

The Mercurial API makes no such guarantee; it is considered a private
implementation detail and most releases seem to contain some changes
that require all consumers to be updated.

There is a different level of urgency between "you cannot use this new
feature until you update Git" and "if you update Mercurial then the
remote helper will stop working", and that's why I think the remote
helpers may benefit from a separate release schedule.
