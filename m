From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sun, 18 Nov 2007 02:16:58 -0800
Message-ID: <7v3av3yi1x.fsf@gitster.siamese.dyndns.org>
References: <200711172309.28364.johannes.sixt@telecom.at>
	<7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
	<200711181036.14565.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 18 11:17:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthDT-0006ly-8P
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 11:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758706AbXKRKRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 05:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755645AbXKRKRF
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 05:17:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42360 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbXKRKRD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 05:17:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A340C2EF;
	Sun, 18 Nov 2007 05:17:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 348EC960AF;
	Sun, 18 Nov 2007 05:17:22 -0500 (EST)
In-Reply-To: <200711181036.14565.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 18 Nov 2007 10:36:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65356>

Johannes Sixt <johannes.sixt@telecom.at> writes:

>> If the rationale was "running in a thread is more natural on the
>> platform", I would understand it.
>
> Please take it as such.
>
>> But "_must_ run because there is no fork(2)" solicits a "Huh?
>> How does Cygwin does it then?" from me.
>
> Alex has answered this. We are not going to copy Cygwin's fork() into git.

Wholeheartedly agree, and I feel dirty after looking at that
thing.  Nothing against Cygwin folks, of course.

The reason I wanted to close pipes as early as possible was
because I did not want to get bitten by "read() waiting forever
for EOF due to an extra unclosed fd on the writer end of the
pipe() without the writer not writing anything to it" problem,
which is an often-seen mistake.

As long as you did not introduce that problem the change is fine
by me.
