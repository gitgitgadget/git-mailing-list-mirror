From: Aaron Schrab <aaron@schrab.com>
Subject: Re: Git Bug report
Date: Thu, 6 Oct 2011 18:57:40 -0400
Message-ID: <20111006225740.GG24640@pug.qqx.org>
References: <1317763443.17036.15.camel@skyplex>
 <20111005072235.GA12600@kolya>
 <7vlisz8jur.fsf@alter.siamese.dyndns.org>
 <20111006003318.GA9015@goldbirke>
 <7vobxv3q49.fsf@alter.siamese.dyndns.org>
 <20111006010940.GR2208@goldbirke>
 <CABURp0qCsKG2oOxLw4BfU8UM=9V+pigd69ZK=TZVwetBPqjuiA@mail.gmail.com>
 <7vy5wy145q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Phil Hord <phil.hord@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 01:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBwzZ-0000RU-O3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 01:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758965Ab1JFXEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 19:04:37 -0400
Received: from pug.qqx.org ([209.177.157.228]:51750 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455Ab1JFXEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 19:04:36 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2011 19:04:36 EDT
Received: by pug.qqx.org (Postfix, from userid 1000)
	id F1C3B206F1; Thu,  6 Oct 2011 18:57:40 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Federico Lucifredi <federico@canonical.com>
Content-Disposition: inline
In-Reply-To: <7vy5wy145q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2010-08-04)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183047>

At 09:22 -0700 06 Oct 2011, Junio C Hamano <gitster@pobox.com> wrote:
>Yeah, after thinking about it a bit more, whenever we see ".git" during
>the upward discovery process, we should always warn if we know it is _not_
>a GIT_DIR before looking for another ".git" at higher levels, as anything
>in that directory cannot be added. If we cannot tell if it is or is not
>a GIT_DIR, we should error out---the reason we cannot tell most likely is
>because we cannot read it, and such a file, if it is not a GIT_DIR, cannot
>be tracked in the real GIT_DIR at a higher level, and if it is a GIT_DIR,
>we cannot use it to record updates or inspect existing history.

Yes, I think that sounds like a good idea.  That should also solve a 
related problem that I noticed while checking out the current behaviour.

Currently if the .git directory of a submodule is inaccessible running 
`git status` from anywhere in the parent repository (including within 
the submodule) will cause git to recursively call itself until enough 
resources are used to prevent further forking.  I then tried this with 
the patch from earlier in the thread applied, but with the call to 
error() changed to call die() instead.  With that change it quickly 
failed with a useful error message.
