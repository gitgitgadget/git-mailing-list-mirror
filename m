From: Junio C Hamano <junkio@cox.net>
Subject: Re: HTTP repo referencing stale heads (can't clone)
Date: Tue, 04 Apr 2006 00:03:22 -0700
Message-ID: <7vzmj1aklh.fsf@assigned-by-dhcp.cox.net>
References: <443146EC.7060704@gentoo.org>
	<7virpqefp1.fsf@assigned-by-dhcp.cox.net>
	<20060403180929.GA14967@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 09:03:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQfZn-0006qp-R3
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 09:03:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWDDHD2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 03:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWDDHD1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 03:03:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56790 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751827AbWDDHD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 03:03:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060404070326.YHVQ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Apr 2006 03:03:26 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060403180929.GA14967@reactrix.com> (Nick Hengeveld's message
	of "Mon, 3 Apr 2006 11:09:30 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18376>

Nick Hengeveld <nickh@reactrix.com> writes:

> Is there any interest in making the HTTP transport slighly less dumb by
> using DAV?

I personally feel PROPFIND is the right way to do "wget -r", and
very much welcome a patch to replace objects/info/packs with it
when able.

> I have a working patch to http-fetch that tries to use PROPFIND to get a
> remote pack list and falls back to using objects/info/packs.  It's
> feasible to do something similar to get a remote ref list when cloning,
> although that's a bit more work as all refs would have to be fetched
> into a local repo and parsed to determine the object type.

Faking info/refs with PROPFIND, if we do not have to peel the
onion ^{}, should be relatively cheap operation, and could be
done as an enhancement to git-ls-remote.sh.  If your faked
info/refs file lacks ^{} entries, git-fetch cannot auto-follow
tags, but git-clone should work as before.

A clever sysadmins could mod_rewrite requests to info/refs and
objects/info/packs with a custom CGI, but then probably they
would be running git-daemon ;-).
