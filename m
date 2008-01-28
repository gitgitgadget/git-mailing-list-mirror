From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 23:25:58 -0800
Message-ID: <7vabmqwgvt.fsf@gitster.siamese.dyndns.org>
References: <20080127103934.GA2735@spearce.org>
	<7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
	<20080128004722.GZ24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:26:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJOOM-0001pE-6k
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbYA1H0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbYA1H0H
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:26:07 -0500
Received: from rune.pobox.com ([208.210.124.79]:39428 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbYA1H0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:26:06 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 9AF3918E283;
	Mon, 28 Jan 2008 02:26:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3217B18E281;
	Mon, 28 Jan 2008 02:26:22 -0500 (EST)
In-Reply-To: <20080128004722.GZ24004@spearce.org> (Shawn O. Pearce's message
	of "Sun, 27 Jan 2008 19:47:22 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71856>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Hmm.  core.sharedrepository is sometimes a bad solution.
>
> core.sharedrepository means I need to give write access to both the
> refs database and the object database to all members of the project.
> Some of whom may not be able to be trusted with tools like "rm",
> but who need real shell access to that system anyway.  And sometimes
> management won't allow users to have two accounts on the same system
> (one that is fixed to git-shell, and one that has a real shell)
> because the world would implode if a user was given two different
> accounts for two different access purposes.

Ok, that was the motiviation I did not get from your original
message.  It begins to make sense somewhat.

Another approach to do the same I can think of, without having
to add 50 new accounts for 50 users, would be to collect a ssh
key from each of these 50 users, and have 1 line per user in the
authorized_keys file of gitadmin.gitadmin user (who owns the
repository with the paranoia hook that decides the authorization
aspect of the repository).  The authentication would come from
the environment="Name=value" option in the authorized_keys file.
Each of your aunt tillies can push or fetch over ssh using the
key she has in the gitadmin.gitadmin's authorized_keys file.

I suspect the "hackiness" factor from the aesthetics viewpoint
is probably about the same, but this would work with the current
code without patches, no?
