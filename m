From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 03 Feb 2008 23:31:15 -0800
Message-ID: <7vsl09kwjg.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
	<402c10cd0802032313la7d3a8cqa4ec34e100385fb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 08:32:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvo8-0008W0-19
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbYBDHb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbYBDHb1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:31:27 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170AbYBDHb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:31:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CB55A1885;
	Mon,  4 Feb 2008 02:31:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 624D71882;
	Mon,  4 Feb 2008 02:31:22 -0500 (EST)
In-Reply-To: <402c10cd0802032313la7d3a8cqa4ec34e100385fb4@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Sun, 3 Feb 2008 23:13:50
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72470>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> git-pull only accepts one repository.  With this patch it makes sense
> to accept more than one repository.  I would like to rewrite git-pull
> to accept more than one repository.  This might break compatibility
> with existing git-pull.  One solution could be to introduce a new
> command that does the same as git-pull and more.  What about naming
> such a command git-update and deprecate git-pull.

Just add contrib/multi-pull/ directory and put your shell script
there, something like:

	#!/bin/sh
	append=
	for repo
        do
        	git fetch $append $repo
                append=--append
	done
	merge_name=$(git fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
        git merge -m "$merge_name" $(sed -e '/	not-for-merge	/d'
        		-e 's/	.*//' "$GIT_DIR/FETCH_HEAD")

If it turns out to be useful for many people, it may become part
of the main Porcelain.  It's too early to talk about touching
git-pull at all.
