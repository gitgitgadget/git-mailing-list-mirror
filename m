From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Mon, 26 Jan 2009 13:28:02 -0800
Message-ID: <7v7i4h4v19.fsf@gitster.siamese.dyndns.org>
References: <20090121210348.GD9088@mit.edu>
 <1232578668-2203-1-git-send-email-charles@hashpling.org>
 <7v1vuuvt11.fsf@gitster.siamese.dyndns.org> <83skn6doxm.fsf@kalahari.s2.org>
 <20090126163114.GD32604@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 22:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRZ1d-0004NX-4G
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbZAZV2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753352AbZAZV2S
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:28:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbZAZV2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:28:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DF7F9484F;
	Mon, 26 Jan 2009 16:28:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3AAED94846; Mon,
 26 Jan 2009 16:28:04 -0500 (EST)
In-Reply-To: <20090126163114.GD32604@hashpling.org> (Charles Bailey's message
 of "Mon, 26 Jan 2009 16:31:14 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D28DEBE-EBF0-11DD-8F50-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107287>

Charles Bailey <charles@hashpling.org> writes:

> I suspect that the LF endings in the file is due to the fact that in
> builtin-merge-file.c, the file is opened (fopen) in binary mode
> ("wb"), but xdl_merge terminates all lines with a raw '\n'.
>
> The obvious fix would be to change fopen in builtin-file-merge.c to
> use "w" instead, but this doesn't work in a number of scenarios. In
> particular, it is wrong for repositories on windows with core.autocrlf
> set to false, and would not fix non-windows repositories with
> core.autocrlf set to true.
>
> Currently, I've no idea as to what the solution should be.

"git file-merge" is designed to be a replacement for stock RCS merge, and
unfortunately it does not call convert_to_working_tree(), nor has any way
to know for which path it should take the attributes to apply to affect
what convert_to_working_tree() should do even if it were to call it.

I think we would need a new option to the command that says "pretend this
is about merging this path, and use the gitattributes specified for it
when writing out the result."
