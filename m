From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 03:25:34 -0800
Message-ID: <7vvei3d5n5.fsf@assigned-by-dhcp.cox.net>
References: <200702140909.28369.andyparkins@gmail.com>
	<slrnet5p5h.s9h.siprbaum@xp.machine.xx>
	<Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfy98o78i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wkshtxg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702151126300.448@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 12:25:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHek9-00075z-GD
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965647AbXBOLZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965890AbXBOLZh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:25:37 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56881 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965647AbXBOLZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:25:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070215112536.ZIJD21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 15 Feb 2007 06:25:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PnRa1W00N1kojtg0000000; Thu, 15 Feb 2007 06:25:36 -0500
In-Reply-To: <Pine.LNX.4.63.0702151126300.448@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 15 Feb 2007 11:43:56 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39818>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay for GIT_LOCAL_CONFIG. I do not remember off-hand who wanted it 
> (Jakub? Pasky?), but it was in the context of gitweb.
>
> However, GIT_CONFIG is meant to parse arbitrary config files.
> ...
> But this "core.*" stuff is insane. Please no.

Ok, Eric's example and yours made it clear that GIT_CONFIG is an
interface meant to reuse (or abuse) git-config to read some file
that is not at all related to git, and should never be used by
other plumbing.  As long as that is clear (could we have that in
the documentation, by the way, please?), I have no problem with
that.

In fact, I am very happy that we do not have to do that insane
"core.*" stuff, which I thought was needed purely because
somebody was trying to use GIT_CONFIG to prevent plumbing and
porcelain from reading core configuration variables that are per
repository in nature.

As I said in my other message, GIT_LOCAL_CONFIG is parallel to
GIT_OBJECT_DIRECTORY and GIT_INDEX_FILE, and I am Ok with the
way it is handled by the current code.

I mildly disagree with you on having an ability to disable
/etc/gitconfig.  This is necessary in the real world (in the
same sense as "adduser" can be told not to copy skeltons by
creating an empty home directory beforehand), even if we do not
consider the fact that it would help gaining repeatable results
from our test scripts (remember, using GIT_CONFIG to make
plumbing and porcelain read from there would set a bad example,
even when it is pointing at .git/config).

I've queued that insane "core.*" stuff in 'pu' and pushed out,
but I'll drop that topic altogether.  But before doing that,
it's past my bedtime ;-).
