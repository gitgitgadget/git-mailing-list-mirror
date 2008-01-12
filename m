From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-relink.perl: warn() instead of die() on directory open failure
Date: Fri, 11 Jan 2008 18:14:18 -0800
Message-ID: <7vabnbzt6t.fsf@gitster.siamese.dyndns.org>
References: <4787B15D.3070105@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:14:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVth-0001Y2-NG
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757650AbYALCOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759979AbYALCOa
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:14:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625AbYALCO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:14:29 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 13F443F0F;
	Fri, 11 Jan 2008 21:14:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B023F0C;
	Fri, 11 Jan 2008 21:14:25 -0500 (EST)
In-Reply-To: <4787B15D.3070105@nrlssc.navy.mil> (Brandon Casey's message of
	"Fri, 11 Jan 2008 12:11:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70251>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> Sometimes the repository to link to is not under your control.
> If it contains files or unreadable directories, git-relink will
> die without this patch.

I am not so sure if dying is a bad behaviour, if it is because
you are trying to link against an object store that you may not
be able to read.  I actually think we should actively refuse to,
in order to prevent future problems.  After seeing the command
die, you will talk to the owner of that "master" object store
and ask him to fix permissions (or he may choose to say "please
do not share with me").

However, if the "master" object store has pruned its loose
objects since you read @hashdirs out of it, that opendir() can
fail, and we should silently ignore the whole $subdir.
