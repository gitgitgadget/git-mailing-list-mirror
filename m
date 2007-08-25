From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't segfault if we failed to inflate a packed delta
Date: Sat, 25 Aug 2007 10:56:09 -0700
Message-ID: <7v8x7z5why.fsf@gitster.siamese.dyndns.org>
References: <20070825072604.GA20155@spearce.org>
	<alpine.LFD.0.999.0708250815150.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 19:56:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOzsQ-0006eL-OV
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 19:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbXHYR4U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 13:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbXHYR4U
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 13:56:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755358AbXHYR4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 13:56:19 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0C21A128136;
	Sat, 25 Aug 2007 13:56:37 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708250815150.25853@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 25 Aug 2007 08:19:17 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56646>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Hmm. We should actually make "unpack_entry()" return print an error and 
> return NULL for these cases, rather than die, I think.
>
> Most of the callers seem to already check for NULL (not "load_tree()" in 
> fast-import.c), but for something like fsck, while "die()" is obviously 
> better than a SIGSEGV, we should probably continue and try to see what 
> else we find.
>
> (Although, to be honest, it might not matter. If your pack-file is corrupt 
> enough for this to trigger, there's seldom anything interesting fsck will 
> tell, so in practical terms this probably isn't a big deal).

But if the delta does not apply we already die().  Last night I
and Shawn actually were wondering if it makes sense to have
unpack_entry() die -- quite the opposite of being nicer to fsck.
