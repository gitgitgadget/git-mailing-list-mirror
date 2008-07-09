From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: /usr/local/bin/git-daemon starts /usr/sbin/git-upload-pack?
Date: Wed, 09 Jul 2008 14:14:06 -0700
Message-ID: <7vlk0a7obl.fsf@gitster.siamese.dyndns.org>
References: <200807092220.10655.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:15:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGh0U-0005zh-Ka
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757603AbYGIVO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757594AbYGIVOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:14:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756642AbYGIVOY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:14:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B76DE1A8D3;
	Wed,  9 Jul 2008 17:14:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0AA4D1A8D2; Wed,  9 Jul 2008 17:14:15 -0400 (EDT)
In-Reply-To: <200807092220.10655.J.Wielemaker@uva.nl> (Jan Wielemaker's
 message of "Wed, 9 Jul 2008 22:20:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF5CECCA-4DFB-11DD-99BA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87913>

Jan Wielemaker <J.Wielemaker@uva.nl> writes:

> After upgrade to SuSE 11.0 I was forced to update GIT (changed libcurl).
> I did (with some trickery) a pull of the latest git and built it using
> make prefix=/usr/local ..., to find out that /usr/local/bin/git-daemon
> starts /usr/sbin/git-upload-pack.
>
> After creating a symlink to /usr/local/bin/git-upload-pack all works fine
> again, but I guess this is a mistake?

I think this is a distro issue.

Pre-1.6.0 git installs git-everything in $(bindir) and knows things are
there.  Current 'master' we are preparing for 1.6.0 instead installs
git-mostofthem in $(prefix)/libexec/git-core and git-someofthem in
$(bindir); our executables know which binaries are installed in $(bindir)
and which ones are installed in $(prefix)/libexec/git-core.

The point is we never install $anywhere/sbin unless the person who is
building explicitly does so (either by futzing the Makefile or giving
bindir=$somewhere from the command line of "make").  The reason your
/usr/local/bin/git-daemon (we do not know who compiled it and how) spawns
something in /usr/sbin is not our doing.  Find out who configured it and
why, and more importantly, what _other_ changes are made in the build and
installation procedure to support that change in location.
