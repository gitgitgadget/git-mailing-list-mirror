From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Highlight keyboard shortcuts in git-add--interactive
Date: Fri, 30 Nov 2007 18:36:48 -0800
Message-ID: <7vy7cf87jz.fsf@gitster.siamese.dyndns.org>
References: <7vmysx2ac8.fsf@gitster.siamese.dyndns.org>
	<1196337638-45972-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dzwell@gmail.com, peff@peff.net,
	Matthieu.Moy@imag.fr
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Dec 01 03:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyIEJ-0003kJ-IZ
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 03:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633AbXLACg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 21:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758616AbXLACg5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 21:36:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40313 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758570AbXLACg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 21:36:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BCC9A2EF;
	Fri, 30 Nov 2007 21:37:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 33B409B9F0;
	Fri, 30 Nov 2007 21:37:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66683>

Wincent Colaiuta <win@wincent.com> writes:

> A "hidden" feature is that any string can be entered, and an anchored
> regex search is used to find the first matching option.

I'd run s/the first/the uniquely/ here.

When list_and_choose() function is letting you choose more than one
items, its prompt becomes ">> ", instead of "> " that is used for a
singleton choice.  To that prompt, you can say "3-7" (Add these 5 items
to the choice), "*" (I want all of them), "-2-4" (exclude 2 and 3 and 4
from the set I have chosen so far).  These are also "hidden", and need
to be documented, but that would be a separate patch.

> +# given a prefix/remainder tuple return a string with the prefix highlighted
> +# for now use square brackets; later might use ANSI colors (underline, bold)
> +sub highlight_prefix {
> +	my $prefix = shift;
> +	my $remainder = shift;
> +	$prefix ? "[$prefix]$remainder" : $remainder;
> +}

I'd rewrite the last line to:

	return (defined $prefix) ? "[$prefix]$remainder" : $remainder;

just in case the unique prefix is "0".  Otherwise you would lose the
first letter from "00ReadMe" and show remainder "0ReadMe" alone.
