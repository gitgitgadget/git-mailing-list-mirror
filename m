From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Sun, 06 Jul 2008 23:28:36 -0700
Message-ID: <7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 08:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFkEJ-0001SR-6K
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 08:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYGGG2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbYGGG2p
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:28:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYGGG2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:28:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 13B0110BCF;
	Mon,  7 Jul 2008 02:28:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6B4F610BCE; Mon,  7 Jul 2008 02:28:38 -0400 (EDT)
In-Reply-To: <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com> (Brian
 Gernhardt's message of "Mon, 7 Jul 2008 01:16:06 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F29CEB12-4BED-11DD-B776-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87584>

Brian Gernhardt <benji@silverinsanity.com> writes:

> My final thought is that the rational ORIG_HEAD and when we set it is
> not clearly documented anywhere.  But I am currently out of time to
> work on git, so that patch won't be coming from me soon.

The idea behind ORIG_HEAD is to have an anchoring point before an
operation that moves your HEAD in a drastic way.  Think if it as a
poor-man's reflog -- in fact it predates reflog.

That is why reset saves away the HEAD before it does its thing, so that
you can easily say "Oops, I did not mean it -- reset ORIG_HEAD" to flip
back to the previous state.  Both a fast-forward merge and a real merge
can be undone by resetting back to ORIG_HEAD.

So in that sense:

 (1) ORIG_HEAD is not strictly necessary these days, because we have
     reflogs;

 (2) Even then, it is handy and useful, and we could add ORIG_HEAD to more
     commands such as "git am" and "git rebase".
