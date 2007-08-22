From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix break in git-rev-list.txt
Date: Wed, 22 Aug 2007 03:01:44 -0700
Message-ID: <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
References: <11877706831306-git-send-email-qtonthat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Quy Tonthat <qtonthat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 12:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INn29-0001j4-0h
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXHVKBu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 06:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbXHVKBt
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:01:49 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbXHVKBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 06:01:48 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 85F2D12453C;
	Wed, 22 Aug 2007 06:02:08 -0400 (EDT)
In-Reply-To: <11877706831306-git-send-email-qtonthat@gmail.com> (Quy Tonthat's
	message of "Wed, 22 Aug 2007 18:18:03 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56363>

Quy Tonthat <qtonthat@gmail.com> writes:

> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index cbbc234..a0c611e 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -298,8 +298,8 @@ used in the output.  When the starting commit is specified as
>  'commit@{now}', output also uses 'commit@\{timestamp}' notation
>  instead.  Under '\--pretty=oneline', the commit message is
>  prefixed with this information on the same line.
> -+
> -Cannot be combined with --reverse.
> +
> +Cannot be combined with '\--reverse'.

Hmph.  Interesting.  The text around this is:

	-g, --wark-reflogs::

        	Indented first paragraph...
	+
        With '\--pretty' fromat ... second paragraph ...
	prefixed with this information on the same line.
	+
        Cannot be combined with --reverse.

And its formatted form looks like either (without your patch):

	<listitem>
        <simpara>
        	Indented first paragraph...
	With <emphasis>--pretty</emphasis> format ...
	</simpara>
        <simpara>Cannot be combined with --reverse.</simpara>

        </listitem>	

or (with):

	<listitem>
        <simpara>
        	Indented first paragraph...
	With <emphasis>--pretty</emphasis> format ...
	Cannot be combined with --reverse.
	</simpara>

        </listitem>	

So it looks as if the only place that needs the ugly '+'
continuation marker is between the first and the second
paragraph.  And it also appears that the manpage backend does
not pay attention to the paragraph break there (HTML backend
places a <br /> before "With <em>--pretty</em>").

Is it just me, or the more we look at it, everybody doubts if
AsciiDoc was such a good choice?

It was a major plus that the input format is mostly readable as
straight text, but this was one of the sore points in our
formatting.  In the description part of a definition list, we
indent the first paragraph but append the second paragraph and
later with '+' without indenting (we would rather keep the
second and subsequent paragraphs aligned with the first one).
However, it appears that the definition has to be a single
paragraph and not any longer in such a list anyway.

Hmmmm.

In any case, I'd appreciate feedbacks from people who recently
reported formatting breakages on this patch.
