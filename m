From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Object Permissions - trying git-init --shared=group parameters
Date: Thu, 21 Feb 2008 14:16:04 -0800
Message-ID: <7vzlturm57.fsf@gitster.siamese.dyndns.org>
References: <47BDF5EF.9030707@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	piet.delaney@gmail.piet.net, Piet Delaney <piet.delaney@gmail.com>
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Thu Feb 21 23:17:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJiy-00056o-Ff
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763712AbYBUWQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbYBUWQ1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:16:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763398AbYBUWQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:16:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B3AD2EC2;
	Thu, 21 Feb 2008 17:16:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 93C3C2EBD; Thu, 21 Feb 2008 17:16:14 -0500 (EST)
In-Reply-To: <47BDF5EF.9030707@bluelane.com> (pete@bluelane.com's message of
 "Thu, 21 Feb 2008 14:06:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74671>

Pete/Piet Delaney <pete@bluelane.com> writes:

> So I looked int the meaning of these config prams and
> thought I tried adding:
>
> 	sharedrepository = 1
>
> 	denyNonFastforwards = true
>
> to the bare repo on the git server. I'm not sure if
> existing repo that have been cloned will have to be
> updated, hopefully not.

You would at least make sure the directories there that was
created while the repository was misconfigured can be writable
by group members (i.e. permissions no stricter than drwxrws---)
and owned by the group.  Something like

	mode=2775 ;# 2770 if closed to non-members
	chgrp -R $group $GIT_DIR
	find $GIT_DIR -type d -print0 | xargs -0 chmod $mode
