From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 09:29:39 -0800
Message-ID: <20090119172939.GA14053@spearce.org>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 18:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOxxn-0002fP-C0
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 18:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759195AbZASR3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 12:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758983AbZASR3m
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 12:29:42 -0500
Received: from george.spearce.org ([209.20.77.23]:59405 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759144AbZASR3k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 12:29:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3C71738210; Mon, 19 Jan 2009 17:29:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vwsct2xd1.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106368>

Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > +		if test ! -z "$GIT_PS1_EXPENSIVE"; then
> > +			git update-index --refresh >/dev/null 2>&1 || w="*"
> 
> This makes the feature unavailable for people who care about the stat
> dirtiness and explicitly set diff.autorefreshindex to false, doesn't it?

Yup, and I'm one of those people who sets autorefresindex to false
in my ~/.gitconfig, usually before I even have user.{name,email} set.

I do like the idea of what Thomas is trying to do here, but its
so bloody expensive to compute dirty state on every prompt in
some repositories that I'd shoot myself.  E.g. WebKit is huge,
computing the dirty state inside of the WebKit repository on each
prompt would absolutely kill CLI performance to a point of it not
being usuable.  But git.git is small enough its OK on pretty much
everything except Cygwin.

So as much as I'd like to use this without the update-index --refresh
bit, I'm not sure its viable in every project out there.  If we had
an inotify sort of daemon to keep the data current so the prompt
doesn't have to stat every source file on every display it would
be reasonable, but we don't have such a thing yet for Git.

-- 
Shawn.
