From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] Ensure __BYTE_ORDER is always set
Date: Thu, 30 Jan 2014 18:24:01 -0500
Message-ID: <1E24F82E-3543-459E-9C55-350AE8C4E455@gernhardtsoftware.com>
References: <1391111741-28994-1-git-send-email-brian@gernhardtsoftware.com> <20140130204538.GA1130@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 31 00:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W90xu-0006zm-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 00:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbaA3XYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 18:24:05 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:58696 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbaA3XYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jan 2014 18:24:04 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 8ADD82736189; Thu, 30 Jan 2014 23:24:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.5 tests=ALL_TRUSTED,BAYES_00,
	MIME_QP_LONG_LINE autolearn=no version=3.2.5
Received: from [192.168.69.135] (static-173-87-73-207.sdsl01.roch.ny.frontiernet.net [173.87.73.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 7CA9A2736189;
	Thu, 30 Jan 2014 23:24:01 +0000 (UTC)
X-Universally-Unique-Identifier: 5C69B0D8-C07D-458F-8BA2-FD09E32BC0E0
In-Reply-To: <20140130204538.GA1130@sigill.intra.peff.net>
X-Smtp-Server: silverinsanity.com:benabik
X-Mailer: iPad Mail (11B554a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241287>

[Re-send to include the list. Meant to hit reply all, not just reply.]

> On Jan 30, 2014, at 3:45 PM, Jeff King <peff@peff.net> wrote:
> 
> I do find the failure mode interesting. The endian-swapping code kicked
> in when it did not, meaning your are on a big-endian system. Is this on
> an ancient PPC Mac? Or is the problem that the code did not kick in when
> it should?

Erm.  I was perhaps writing my analysis too quickly.  I was running on a x86_64 Mac, so it wasn't included when it was supposed to be.  Or whichever you said that I didn't.  ;-)

> Either way, we should perhaps be more careful in the bitmap code, too,
> that the values we get are sensible. It's better to die("your bitmap is
> broken") than to read off the end of the array. I can't seem to trigger
> the same failure mode, though. On my x86 system, turning off the
> endian-swap (i.e., the opposite of what should happen) makes t5310 fail,
> but it is because we end up trying to set the bit very far into a
> dynamic bitfield, and die allocating memory.

To be more specific, I hit an assertion failure at in ewah_iterator_next() (ewah/ewah_bitmap.c:355) when running `git rev-list --test-bitmap HEAD` (and others if I don't have it die immediately).  That seems to me that there is a check to ensure it doesn't run off the end.  Perhaps you have assertions disabled so hit an error somewhere else?

~~ Brian Gernhardt
