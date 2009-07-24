From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [ANNOUNCE] GIT 1.6.4-rc2
Date: Fri, 24 Jul 2009 02:38:48 -0700
Message-ID: <20090724093847.GA20338@dcvr.yhbt.net>
References: <7vd47r298e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mattias Nissler <mattias.nissler@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 11:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUHEv-0002Vc-Os
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 11:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZGXJiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 05:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbZGXJiu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 05:38:50 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42356 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbZGXJit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 05:38:49 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id D44E81F78F;
	Fri, 24 Jul 2009 09:38:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vd47r298e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123912>

Junio C Hamano <gitster@pobox.com> wrote:
>  * git-svn updates, including a new --authors-prog option to map author
>    names by invoking an external program, 'git svn reset' to unwind
>    'git svn fetch', support for more than one branches, etc.

I completely forgot the implications of a change made in commit
0b2af457a49e3b00d47d556d5301934d27909db8.  This change probably doesn't
affect a lot of repos out there, but --minimize-url is no longer the
default for new imports.


The good thing is that access-limited repositories are easier to setup
and import.  So if you only had access for a sub_project under the
repository root in svn://example.com/big_project/sub_project,
you won't need read permissions to / or /big_project, just
/big_project/sub_project and everything under it.


Unfortunately, this default breaks the case where a project is moved to
a lower-level within the repository:

svn://example.com/foo => svn://example.com/big_project/sub_project

Without --minimize-url enabled, your clone would register
"/big_project/sub_project" to track and not be able to find the history
of "/foo".  With --minimize-url (the old behavior), you would've
registered "/" to be able to track all subdirectories underneath the
repository root (assuming the SVN repo is world-readable).


While both cases are fairly rare, I've personally encountered the latter
(and now broken-by-default) case more.  This is because I mainly use
git/git svn to work on free software without read restrictions.
However, with more and more free projects switching entirely to git,
maybe leaving the default to be more friendly to people on restrictive
setups will be more helpful than harmful.

This change only affects the creation of new clones, existing repos
are unaffected.


Let me know if the above made sense, it's late and I nodded off
several times while writing this.

-- 
Eric Wong
