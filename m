From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] safecrlf: Add flag to convert_to_git() to disable safecrlf check
Date: Tue, 15 Jan 2008 15:23:21 -0800
Message-ID: <7vodbmd66u.fsf@gitster.siamese.dyndns.org>
References: <004D2FB5-2CEA-4DB1-AF8D-D5ADEB0F0508@zib.de>
	<12003528401309-git-send-email-prohaska@zib.de>
	<7vk5mchsct.fsf@gitster.siamese.dyndns.org>
	<F825ADAF-036C-46FE-8E3D-540B9AA092A8@zib.de>
	<FF86F119-5BF4-4ED3-B6AD-BADFDC91301D@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 00:24:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEv8S-0001Pa-7n
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 00:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbYAOXXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 18:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbYAOXXc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 18:23:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbYAOXXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 18:23:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 03B0278B0;
	Tue, 15 Jan 2008 18:23:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 66BF978AD;
	Tue, 15 Jan 2008 18:23:23 -0500 (EST)
In-Reply-To: <FF86F119-5BF4-4ED3-B6AD-BADFDC91301D@zib.de> (Steffen Prohaska's
	message of "Tue, 15 Jan 2008 22:41:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70577>

Steffen Prohaska <prohaska@zib.de> writes:

> What is the right way to iterate over the changed files?

I think something like

	read_cache();
        for (i = 0; i < active_nr; i++) {
		struct cache_entry *ce = active_cache[i];
		struct stat st;
		if (!lstat(ce->name, &st) &&
			ce_match_stat(ce, &st, 0)) {
			/* do your thing */
		}
	}

would do.
