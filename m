From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add pretty format configuration to git
 log/show/whatchanged
Date: Sat, 01 Mar 2008 22:20:17 -0800
Message-ID: <7vve45tzoe.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803011821420.22527@racer.site>
 <1204401056-8763-1-git-send-email-crquan@gmail.com>
 <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 07:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhaL-0007Tv-KJ
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 07:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYCBGUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 01:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbYCBGUz
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 01:20:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43887 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbYCBGUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 01:20:32 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E97C92D88;
	Sun,  2 Mar 2008 01:20:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 13BAB2D87; Sun,  2 Mar 2008 01:20:24 -0500 (EST)
In-Reply-To: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 01 Mar 2008 19:44:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75729>

Junio C Hamano <gitster@pobox.com> writes:

> In-tree, there are only two callers that do not use --pretty on the
> command line when calling these three commands:
>
>  * "bisect visualize" calls "git log" when gitk is not available, with the
>    user supplied formatting options.  This is very much Ok --- we actively
>    want your configuration feature for this caller.
>
>  * "git merge --squash" calls "git log" to prepare the commit message
>    template.  This is _not_ Ok, and will be broken if we accept your
>    patch.
>
> So you will need a preliminary patch to "git-merge" _before_ submitting
> this patch to make the latter codepath use "git log --pretty" instead.
> Doing so would have raised _my_ confidence level of the patch that you
> made your best effort not to introduce regression.

I should point out that I did not look at things outside shell scripts,
i.e. stuff I do not consider really the core part of the system.  I did
not look at contrib/ area either.

I suspect the following have calls to show/log/whatchanged and do expect
to read the default format out of them, and can be broken by your patch:

 * contrib/emacs/git.el (git-setup-commit-buffer)
 * git-cvsserver.perl (sub update)

There also is a call to git log, but I think it is Ok.

 * contrib/hooks/post-receive (generate_general_email)

You should not blindly trust nor take the above as an exhaustive list; it
is just from my quick survey.
