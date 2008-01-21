From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast importer for SCCS files
Date: Sun, 20 Jan 2008 16:50:23 -0800
Message-ID: <7vsl0s57e8.fsf@gitster.siamese.dyndns.org>
References: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James Youngman" <jay@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 01:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGksZ-0001GQ-Jm
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 01:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbYAUAum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 19:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbYAUAum
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 19:50:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbYAUAul (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 19:50:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D22018C2;
	Sun, 20 Jan 2008 19:50:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 620B418C1;
	Sun, 20 Jan 2008 19:50:35 -0500 (EST)
In-Reply-To: <c5df85930801200312o7cd5d307v1a39fb35179249a9@mail.gmail.com>
	(James Youngman's message of "Sun, 20 Jan 2008 11:12:47 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71207>

"James Youngman" <jay@gnu.org> writes:

> The attached patch implements an importer for SCCS files using
> git-fastimport.  It's unidirectional SCCS->git.  This is my first git
> patch, so apologies if I have done something the wrong way with regard
> to how one shoudl submit a patch.    I've attached the patch because
> my mail client would probably screw the formatting up if I just pasted
> it :(

Welcome.

> From 64c49a2ee864d50280df06b0f04d17d718f187c2 Mon Sep 17 00:00:00 2001
> From: James Youngman <jay@gnu.org>
> Date: Sun, 20 Jan 2008 11:02:10 +0000
> Subject: [PATCH] Add a fast importer for SCCS.
>
> ---

Lacks sign-off (please see Documentation/SubmittingPatches).

A description?  For example, "It's unidirectional" should be in
the commit message.  If it allows incremental or just one shot
should also be said.  There perhaps are other things, including
future directions.

As to future directions, I think unidirectional importers should
allow incremental updates, and try to be usable as a drop-in
replacement of "git fetch".  Among the existing ones, cvsimport
is almost there (instead of doing "git fetch $url && git rebase
FETCH_HEAD", you can do "git cvsimport $args $cvs_repository &&
git rebase $cvs_tracking_branch"), and I think it is a good
model.

> +# Author: James Youngman <jay@gnu.org>
> +# Copyright: 2008 James Youngman <jay@gnu.org>
> +# License: GNU GPL version 2 or later <http://www.gnu.org/licenses/old-licenses/gpl-2.0.html>
> +#

This is quite a long line isn't it?  Besides, we ship the copy
of GPLv2 in git.git already.

> +"""
> +A fast git importer for SCCS files.
> +
> +How to use this program:
> +
> +Let's assume you have some SCCS files in $PROJECTDIR and want to
> +convert them to a git repository in the directory $NEWGIT.
> +
> +First, make sure the SCCS (or CSSC) binaries are on your $PATH.  Then
> +do this:
> +
> +  cd "$PROJECTDIR"
> +  python git-sccsimport.py --init --git-dir="$NEWGIT" --dirs .

So, from the point of view to imitate git-fetch, this is a
suboptimal interface.  Rather:

	mkdir my-project-converted-to-git
        cd my-project-converted-to-git
        git init
        git-sccsimport $PROJECTDIR

and later incremental option would allow the user to say:

        cd my-project-converted-to-git
        git-sccsimport $some_incremental_options $PROJECTDIR

> +TIMEZONE = None
> +MAIL_DOMAIN = None
> +UNIX_EPOCH = time.mktime(datetime.datetime(1970, 1, 1,
> +											0, 0, 0, 0,
> +											None).timetuple())

You seem to be using a tab-width that is not 8, and it shows
everywhere.  Please don't.
