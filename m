From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn and the post-receive hook
Date: Sat, 02 Aug 2008 11:43:14 -0700
Message-ID: <7vwsizl0l9.fsf@gitster.siamese.dyndns.org>
References: <489485BC.1020607@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Sat Aug 02 20:44:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPM5b-0006Nb-0S
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbYHBSnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbYHBSnZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:43:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYHBSnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:43:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 906694539E;
	Sat,  2 Aug 2008 14:43:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E5C084539C; Sat,  2 Aug 2008 14:43:20 -0400 (EDT)
In-Reply-To: <489485BC.1020607@obry.net> (Pascal Obry's message of "Sat, 02
 Aug 2008 18:05:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2C9D45E-60C2-11DD-9F66-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91167>

Pascal Obry <pascal@obry.net> writes:

> I'd like to check for example that if a file has been added to the
> remote Subversion repository then it is properly added into a MANIFEST
> file. I'd also like to check some style rules. This would help to
> detect some problems when one has no way to add hooks on the
> Subversion repository.

Are you saying that there may be breakages that is made at the Subversion
side, and you would want to catch it?

What would you do _after_ finding out that somebody screwed up and you
have a borked history on the Subversion side already?

I do not think this belongs to "git svn rebase" (let alone "git rebase",
no way --- you won't rewrite nor reject the upstream even if you find
problems with it).

I understand that you would at least want to notice the damange to the
history that happened at the remote end, and I agree it would make sense
to do something like:

	$ git command-that-updates-the-remote-tracking-branch git-svn
        $ check-history git-svn@{1}..git-svn

The "command-that-updates" could be "svn fetch" or just a simple "fetch".

But the "check-history" script will be very specific to your project, and
I do not think it makes sense to make it a hook to the "command-that-updates".
