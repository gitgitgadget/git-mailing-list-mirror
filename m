From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix fetch/pull when run without --update-head-ok
Date: Mon, 13 Oct 2008 10:30:31 -0700
Message-ID: <7vod1o9zd4.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111336350.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LNX.1.00.0810121501590.19665@iabervon.org>
 <alpine.DEB.1.00.0810131129110.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vod1obmlh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:32:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRHe-00056k-9S
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbYJMRb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYJMRb3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:31:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367AbYJMRb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:31:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D92ED8AF0A;
	Mon, 13 Oct 2008 13:31:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC6B58AEF9; Mon, 13 Oct 2008 13:30:33 -0400 (EDT)
In-Reply-To: <7vod1obmlh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Oct 2008 07:23:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C39392CE-994C-11DD-BBE0-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98127>

Junio C Hamano <gitster@pobox.com> writes:

> With these verified, I think I should move the "Strangely" comment to the
> commit log message proper (after stripping "Strangely" part -- it is not
> strange anymore after we understand why).

Proposed amendment to the commit log message is:

    Fix fetch/pull when run without --update-head-ok
    
    Some confusing tutorials suggested that it would be a good idea to fetch
    into the current branch with something like this:
    
    	git fetch origin master:master
    
    (or even worse: the same command line with "pull" instead of "fetch").
    While it might make sense to store what you want to pull, it typically is
    plain wrong when the current branch is "master".  This should only be
    allowed when (an incorrect) "git pull origin master:master" tries to work
    around by giving --update-head-ok to underlying "git fetch", and otherwise
    we should refuse it, but somewhere along the lines we lost that behavior.
    
    The check for the current branch is now _only_ performed in non-bare
    repositories, which is an improvement from the original behaviour.
    
    Some newer tests were depending on the broken behaviour of "git fetch"
    this patch fixes, and have been adjusted.
    
    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Acked-by: Shawn O. Pearce <spearce@spearce.org>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks for the fix.
