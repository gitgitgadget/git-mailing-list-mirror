From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I'm a total push-over..
Date: Tue, 22 Jan 2008 18:23:23 -0800
Message-ID: <7vabmxqnz8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVHe-0006X1-Dt
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:24:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYAWCXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYAWCXk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:23:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYAWCXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:23:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D486896;
	Tue, 22 Jan 2008 21:23:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BDFB6893;
	Tue, 22 Jan 2008 21:23:35 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 22 Jan 2008 15:37:30 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71493>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, here's an interesting patch based on the current 'next' (since it very 
> intimately requires the new in-memory index format).

This is nice.  It does not do anything specific with HFS+ issues
but aims for faster look-ups, which would help everybody.

Two things I noticed (only two, not necessarily because you are
good but mostly because I am still mired in day job and could
not get enough uninterrupted minutes to read the patch ;-)):

 - You might want to store the hash table (once computed) in the
   index extension section, and lazily unpack the table the
   first time index_name_exists() or set_index_entry() is called
   on the given istate, instead of unpacking it immediately when
   you read from the disk.  That way, ls-files does not have to
   suffer at all.

 - You would need to get rid of the table in discard_index().
