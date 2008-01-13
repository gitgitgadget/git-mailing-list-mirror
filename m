From: Junio C Hamano <gitster@pobox.com>
Subject: Re: performance problem: "git commit filename"
Date: Sun, 13 Jan 2008 03:09:19 -0800
Message-ID: <7vy7auoucg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801121949180.2806@woody.linux-foundation.org>
	<7vtzliqh3u.fsf@gitster.siamese.dyndns.org>
	<7vd4s6qal0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Kristian H?gsberg <krh@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 13 12:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE0j4-0003MD-Aj
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 12:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYAMLJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 06:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbYAMLJd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 06:09:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYAMLJc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 06:09:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D3A003629;
	Sun, 13 Jan 2008 06:09:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51F783628;
	Sun, 13 Jan 2008 06:09:26 -0500 (EST)
In-Reply-To: <7vd4s6qal0.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 13 Jan 2008 02:33:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70379>

Junio C Hamano <gitster@pobox.com> writes:

> The fact that we write out a temporary index and then rebuild
> the real index means CE_UPTODATE flag we populate in the
> temporary index is lost and we still need to lstat(2) while
> building the real index, which is a bit unfortunate.  I suspect
> that we can use the one-way merge to reset the index when
> building the real index after we are done building the temporary
> index, instead of discarding the in-core temporary index and
> re-reading the real index.

This comment is completely bogus.  With your earlier one-way
merge fix, as the way CE_UPTODATE patch was written we preserve
in-core CE_UPTODATE bit across write_index(), the code already
should be taking advantage of an earlier lstat(2).
