From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-daemon is insecure? (was: [RFC] Secure central repositories)
Date: Sun, 27 Jan 2008 19:16:55 -0500
Message-ID: <20080128001655.GY24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJHh7-0004Mb-Pj
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 01:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYA1ARB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 19:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbYA1ARB
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 19:17:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41871 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211AbYA1ARA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 19:17:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJHg8-0002SK-2o; Sun, 27 Jan 2008 19:16:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9F3E920FBAE; Sun, 27 Jan 2008 19:16:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71839>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > This change allows any repository owner to setup a git-daemon
> > that other users on the same host can connect through to perform
> > upload-pack or receive-pack.
> 
> My reading of this is that it creates a backdoor for people who
[...]
> In addition to having to worry about
> the in-repo data properly being protected from people outside
> the group, you now need to worry about the access through that
> backdoor does not extend outside of the repository.  E.g. the
> repository owner's $HOME that is outside the repository would be
> writable that owner, but is not meant to be accessible by
> project participants.  If you allow others to "run as" you, the
> only thing that forbids that process running as you from
> accessing $HOME is an additional audit of git-daemon and the
> programs it spawns.

So you are partially suggesting that git-daemon isn't thought to
be secure, and that anything readable by the user that git-daemon
is running as is fully exposed to the public Internet.  So the
access control attempts relating to --base-path or the check for
git-daemon-export-ok shouldn't really be trusted or relied upon.

If that really is the case, perhaps git-daemon should be audited
and hardened further.  Last I checked, we encouraged people to run
it to offer anonymous access to repositories, and the documentation
suggests there are publishing access controls that actually work.
If those controls cannot be trusted then we shouldn't encourage
running git-daemon on untrusted networks.


With regards to this patch, yes, you can export your entire $HOME
and maybe expose things you shouldn't or didn't want to.  But even
without git installed you could do this:

	cp /bin/bash /tmp/be-like-mike
	chown $USER /tmp/be-like-mike
	chmod 777 /tmp/be-like-mike
	chmod u+s /tmp/be-like-mike
	wall "try out /tmp/be-like-mike today"

but why would anyone do something that foolish?  UNIX provides the
tools to do this, because there are cases where it can be useful,
but really, you have to be nuts to export all of $HOME.

-- 
Shawn.
