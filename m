From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 13:19:15 -0500
Message-ID: <87abmtvkd8.fsf@jbms.ath.cx>
References: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org>
	<87fxwmv5tf.fsf@jbms.ath.cx>
	<alpine.LSU.1.00.0801251250120.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:19:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIT9d-0004yy-WC
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 19:19:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbYAYSTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 13:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755581AbYAYSTW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 13:19:22 -0500
Received: from deleuze.hcoop.net ([69.90.123.67]:50497 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbYAYSTU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 13:19:20 -0500
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JIT92-0006lp-EA; Fri, 25 Jan 2008 13:19:16 -0500
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <alpine.LSU.1.00.0801251250120.5731@racer.site> (Johannes
	Schindelin's message of "Fri, 25 Jan 2008 12:51:43 +0000 (GMT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71722>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 25 Jan 2008, Jeremy Maitin-Shepard wrote:

>> But since multiple hash functions will be needed anyway to support 
>> different notions of case-insensitivity, if the warning is not enabled, 
>> there is no reason to use a case-insensitive hash function with a 
>> byte-exact comparison.

> No, only multiple compare functions will be needed.  The hash function can 
> be built in such a manner that it guarantees that file names being equal 
> with _any_ of the compare functions fall into the same bucket.

In theory, I agree that this is possible, but in practice it may not be
reasonable at all.  Consider two possible comparison functions:

1. compare file names as strings case-insensitively assuming a latin 1
encoding

2. compare file names as strings case-insensitively assuming a UTF-8
encoding

Actually writing a hash function such that two strings hash to the same
value if either of these comparison functions says that the strings are
equal would appear to be rather difficult.

> The upside of such a hash function: less code to maintain.

A simple hash function that doesn't try to do anything regarding
case-insensitivity is extremely short and simple and therefore is hardly
a maintenance burden.

Although in some cases it is possible to "share" a hash function, except
for the "warning" purpose, actually doing so doesn't make much sense.
Using the "case-insensitive" hash function when you intend to use an
"exact" comparison function just amounts to using a hash function that
is unequivocally worse: it is slower, more complicated, and has a higher
collision rate.

-- 
Jeremy Maitin-Shepard
