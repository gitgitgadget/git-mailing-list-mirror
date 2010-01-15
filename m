From: Jeff King <peff@peff.net>
Subject: Re: Removal of post-upload-hook
Date: Fri, 15 Jan 2010 09:47:36 -0500
Message-ID: <20100115144736.GC621@coredump.intra.peff.net>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
 <20100114193607.GB25863@coredump.intra.peff.net>
 <20100114194107.GA20033@spearce.org>
 <20100114204305.GC26883@coredump.intra.peff.net>
 <20100114210645.GE16921@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 15:47:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVnSk-0003ca-3q
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 15:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757831Ab0AOOrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 09:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757827Ab0AOOrm
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 09:47:42 -0500
Received: from peff.net ([208.65.91.99]:58440 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757824Ab0AOOrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 09:47:40 -0500
Received: (qmail 26774 invoked by uid 107); 15 Jan 2010 14:52:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 09:52:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 09:47:36 -0500
Content-Disposition: inline
In-Reply-To: <20100114210645.GE16921@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137073>

On Thu, Jan 14, 2010 at 09:06:45PM +0000, Robin H. Johnson wrote:

> As a reasonable middle ground between the functionality and complete
> removal, can we find a way just to only execute the potentially
> dangerous hooks under known safe conditions or when explicitly requested
> by the user.

An alternative to ripping it out that was discussed is to check that
getuid() matches the owner of the hook.

That might be a nice improvement in security for the push hooks, as
well. But it does come at the cost of some inconvenience. How do you set
up hooks in a shared central repo that every user should trigger? You
need some way to say "these hooks really _are_ trusted, run them
anyway", but that mechanism cannot be in the configuration of the repo
itself for obvious reasons. I suppose if the owner is root? But that
leaves no way for non-root users to set up shared access.

Also, there is a similar issue with config. Right now, if I can convince
you to run "git log" in a repo whose config I own, I can make you run
arbitrary commands via textconv (and ditto for "git diff" and external
diff).

> Places where the hooks are safe:
> - the hooks are known trusted AND not writable by the user/group.
>   (e.g. "chown -R root:root hooks/").

This can work, but has drawbacks. See above.

> - Systems where the users/groups do not have full shell access, just
>   access to run Git itself. Eg gitosis, regular git+ssh:// w/ a
>   restricted shell.

Yes, this would work, too, but how do you configure the "it's OK to run
random hooks" flag? Environment?

-Peff
