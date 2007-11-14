From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-diff: complain about >=8 consecutive spaces in initial indent
Date: Tue, 13 Nov 2007 16:46:19 -0800
Message-ID: <7vabphr6w4.fsf@gitster.siamese.dyndns.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org>
	<7vr6j95c84.fsf@gitster.siamese.dyndns.org>
	<473A3552.3060907@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>,
	dsymonds@gmail.com
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 01:46:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is6PB-0006B7-MS
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 01:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760735AbXKNAqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 19:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759993AbXKNAqm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 19:46:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43780 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760075AbXKNAql (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 19:46:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2EB68322;
	Tue, 13 Nov 2007 19:47:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BAE39580E;
	Tue, 13 Nov 2007 19:46:57 -0500 (EST)
In-Reply-To: <473A3552.3060907@freedesktop.org> (Josh Triplett's message of
	"Tue, 13 Nov 2007 15:37:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64932>

Josh Triplett <josh@freedesktop.org> writes:

> My standard test case for this:
>
> fprintf("some very long string",
>         arguments);
>
> Type the first line, and press enter.  A good editor should indent to
> the open parenthesis.  However, it should not use a tab, because it
> needs to match up with the length of "fprintf(".

Sorry, I do not want to go into ideology or be anal, but I have
to disagree.  Tab width is 8 spaces (in the kernel and git), so
"fprintf(" from the beginning of the line and an HT at the
beginning of the line have the same width.

Your project may have different conventions.  Then you do not
have to use that option to check for 8 or more leading spaces.

And honestly, I think responding to that by saying "but somebody
can have tab width that is not 8" is irrelevant.  Somebody else
can even use a non-proportional font to print it, so your 8
spaces and "fprintf(" won't line up ANYWAY.

If you REALLY want to be anal, then the rules to follow would
be:

 - Do not assume you know the width of a HT, other than that the
   same number of HT at the beginning of two lines indent to the
   same distance from the left margin, and more of them indent
   deeper;

 - Do not assume the text will be printed in monospace;

which leads to:

 - Indent with the same number of HT from the beginning of
   lines.  Go deeper with one more HT, go shallower with one
   less HT.

 - Start the continuation line with the same number of HT to
   indent but DO NOT BOTHER aligning.  There is no alignment,
   period.

I happen to choose to be less anal, and accept 8 space HT _and_
monospace font.  So "complaining at >=8 SP at the beginning"
makes perfect sense, so does a corresponding patch to convert
such runs of SPs to HTs with "git-apply --whitespace=fix" (which
should require an option to be enabled, and the is not here
yet) when applying a patch.
