From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: Git GSoC 2014
Date: Thu, 13 Feb 2014 22:45:01 +0100
Message-ID: <87bnya8z6q.fsf@thomasrast.ch>
References: <20140213091037.GA28927@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 22:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE45z-0003T7-HD
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 22:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbaBMVpQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 16:45:16 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:44822 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbaBMVpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 16:45:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B59544D6579;
	Thu, 13 Feb 2014 22:45:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ucrxYEaTSVq3; Thu, 13 Feb 2014 22:45:02 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9E7E44D64BD;
	Thu, 13 Feb 2014 22:45:02 +0100 (CET)
In-Reply-To: <20140213091037.GA28927@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 13 Feb 2014 04:10:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242080>

Jeff King <peff@peff.net> writes:

>   - somebody to be the backup admin (I am assuming I'll be the primary
>     admin, but as always, if somebody else wants to...)

I can be backup, if Shawn doesn't want it.

>   - ideas ideas ideas

Here's my moonshot:

--- 8< ---
Replace object loading/writing layer by libgit2

Git reads objects from storage (loose and packed) through functions in
sha1_file.c.  Most commands only require very simple, opaque read and
write access to the object storage.  As a weatherballoon, show that it
is feasible to use libgit2 git_odb_* routines for these simple callers.

Aim for passing the git test suite using git_odb_* object storage
access, except for tests that verify behavior in the face of storage
corruption, replacement objects, alternate storage locations, and
similar quirks.  Of course it is even better if you pass the test suite
without exception.

Language: C
Difficulty: hard
Possible mentors: Thomas Rast and <fill in libgit2 expert>
--- >8 ---

That absolutely requires a co-mentor from the libgit2 side to do,
however.  Perhaps you could talk someone into it? ;-)

Motivation: I believe that migrating to libgit2 is the better approach,
medium term, than rewriting everything ourselves to be nice, clean and
thread-safe.  I took a shot a while ago at making the pack reading code
thread-safe, but it's adding mess when we could simply replace it all by
the already thread-safe libgit2 calls.  It also helps shake out
incompatibilities in libgit2.

Downside: not listing "code merged" as a goal may not make the project
as shiny, neither for Git nor for the student.

-- 
Thomas Rast
tr@thomasrast.ch
