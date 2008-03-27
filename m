From: Junio C Hamano <gitster@pobox.com>
Subject: Re: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 12:05:25 -0700
Message-ID: <7vd4pg9edm.fsf@gitster.siamese.dyndns.org>
References: <loom.20080327T112740-539@post.gmane.org>
 <7v3aqcb02s.fsf@gitster.siamese.dyndns.org>
 <loom.20080327T175844-199@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 20:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JexQp-0001yw-SR
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 20:06:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbYC0TFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 15:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756465AbYC0TFn
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 15:05:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548AbYC0TFm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 15:05:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 50350168E;
	Thu, 27 Mar 2008 15:05:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 101EA168B; Thu, 27 Mar 2008 15:05:32 -0400 (EDT)
In-Reply-To: <loom.20080327T175844-199@post.gmane.org> (Sergio Callegari's
 message of "Thu, 27 Mar 2008 18:34:30 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78360>

Sergio Callegari <sergio.callegari@gmail.com> writes:

> Unless Y is also in the tracked project...
> ...
> Note that if Y is outside of the tracked project and I make an archive,
> and then I give the archive to my friend X, Mr. X will see the same
> symbolic link, but still a completely and randomly different content
> than I do, depending on where he is unpacking the archive.

If you _do_ keep track of Y in a separate repository, I think two archives
(the one that has a pointer to Y, and the other that is taken from the
repository Y _at the revision you are using_), would solve that more
naturally.  Then the version markers recorded in the archives would still
be valid.

	Side note.  If we ever teach git-archive to create a recursive
	tarball that contains a submodule, we should be doing something
	like that, not necessarily as two separate tarballs but possibly
	with a single tarball that has two comments that describe the
	revision of the toplevel and the submodule.

> ...  In the end git archive is a nice shorthand for a checkout and a
> successive run of zip or tar and both zip and tar have a switch to
> control this dereferencing behaviour (BTW, zip on my distro dereferences
> by default, the switch is to store symbolic links).

Under such an option, at least the comment in the archive (both for zip
and tar) that notes which revision the tarball was taken from should be
omitted.  As long as that is done, I think it is Ok to have such an
optional behaviour.
