From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/2] attribute "coding": specify blob encoding
Date: Fri, 04 Jan 2008 12:53:33 -0800
Message-ID: <7vwsqpia7m.fsf@gitster.siamese.dyndns.org>
References: <7vsl1gy2si.fsf@gitster.siamese.dyndns.org>
	<200801032128.m03LSIn2022902@mi0.bluebottle.com>
	<7vejcyo9ql.fsf@gitster.siamese.dyndns.org>
	<20080105.011649.26949633.tshibata@ab.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: nanako3@bluebottle.com, git@vger.kernel.org
To: Tsugikazu Shibata <tshibata@ab.jp.nec.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 21:54:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAtYQ-0000Fn-M2
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 21:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYADUxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 15:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753297AbYADUxn
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 15:53:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYADUxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 15:53:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B24AE57FC;
	Fri,  4 Jan 2008 15:53:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E5EE57F9;
	Fri,  4 Jan 2008 15:53:36 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69604>

Tsugikazu Shibata <tshibata@ab.jp.nec.com> writes:

> So, question is why we should think of this field in case of non
> programming language files ? 
> In case of text file using any coding, Should we need to add something
> after "@@"?

See gitattributes(5), "Defining a custom hunk-header".  The
associated configuration variable for this feature is somewhat
misnamed [*1*], but if you do not want to see anything, I think
you should be able to define a custom pattern that match
emptyness.

For .txt files, I always hoped that someday, somebody clever
would come up with a custom pattern to grok AsciiDoc mark-up to
pick a label-looking line so that the hunks in patches to our
documentation would be easier to find.  A simpler and more
generally applicable possibility is to find the previous line
that starts a paragraph (e.g. you would pick "For .txt files..."
for this part because it is the non-blank line that immediately
follows the first blank line before this part).  But I think the
code to find an appropriate string for hunk header is not
capable of looking at more than one line, so neither of these
would be easy to implement without changing the underlying logic
and semantics of "diff.*.funcname" configuration.

[Footnote]

*1* It may be misnamed but it is in line with GNU diff, though.
They call -p "show-c-function" and -F "show-function-line" --
both assume function names are what people are interested in
having on hunk headers.
