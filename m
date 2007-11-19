From: Junio C Hamano <gitster@pobox.com>
Subject: Re: StGIT 0.13 recognizes but not list packed StGIT controlled branches
Date: Sun, 18 Nov 2007 16:00:15 -0800
Message-ID: <7vpry7t88g.fsf@gitster.siamese.dyndns.org>
References: <200711190005.49990.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 01:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itu49-0005fQ-EF
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 01:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753466AbXKSAAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 19:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbXKSAAW
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 19:00:22 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57764 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbXKSAAV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 19:00:21 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4EEC02EF;
	Sun, 18 Nov 2007 19:00:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CE14097444;
	Sun, 18 Nov 2007 19:00:38 -0500 (EST)
In-Reply-To: <200711190005.49990.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 19 Nov 2007 00:05:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65395>

Jakub Narebski <jnareb@gmail.com> writes:

> So the question is: how to unpack branches, and how to prevent
> branches from being packed by "git-gc"?

I am afraid that is a wrong question.  How long have we had the
packed-refs anyway?

The question is "How to get the list of refs from a Porcelain if
it wants to be compatible with GIT v1.4.4-rc1 (Nov 7, 2006) and
later?", and the answer is for-each-ref.

Having said that, you could explode it by hand like this:

	git for-each-ref --format='%(objectname) %(refname)' refs/heads |
	while read sha1 refname
        do
        	test -f "$GIT_DIR/$refname" || 
               	git update-ref "$refname" "$sha1"
	done                
