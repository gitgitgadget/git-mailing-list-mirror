From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] commit: More generous accepting of RFC-2822 footer
	lines.
Date: Tue, 27 Oct 2009 17:05:11 -0700
Message-ID: <20091028000511.GK10505@spearce.org>
References: <20091027234520.GA11433@quaoar.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2w2S-0004GP-BD
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756890AbZJ1AFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756884AbZJ1AFI
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:05:08 -0400
Received: from george.spearce.org ([209.20.77.23]:43489 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbZJ1AFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:05:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CA98C381D3; Wed, 28 Oct 2009 00:05:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091027234520.GA11433@quaoar.codeaurora.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131392>

David Brown <davidb@codeaurora.org> wrote:
> From: David Brown <davidb@quicinc.com>
> 
> 'git commit -s' will insert a blank line before the Signed-off-by
> line at the end of the message, unless this last line is a
> Signed-off-by line itself.  Common use has other trailing lines
> at the ends of commit text, in the style of RFC2822 headers.
> 
> Be more generous in considering lines to be part of this footer.
> This may occasionally leave out the blank line for cases where
> the commit text happens to start with a word ending in a colon,
> but this results in less fixups than the extra blank lines with
> Acked-by, or other custom footers.

The nasty perl I use in Gerrit's commit-msg hook is a bit more
expressive.  Basically the rule is we insert a blank line before
the new footer unless all lines in the last paragraph (so all text
after the last "\n\n" sequence) match the regex "^[a-zA-Z0-9-]+:".
 
> +test_expect_success 'signoff gap' '
> +
> +	echo 3 >positive &&
> +	git add positive &&
> +	alt="Alt-RFC-822-Header: Value" &&
> +	git commit -s -m "welcome
> +
> +$alt" &&

I wonder if we shouldn't also have a test case for the message:

	msg="test

this is a test that
fixes: 42.
"

as the result would be expected to be:

	exp="test

this is a test that
fixes: 42.

Signed-off-by A. U. Thor <...>
"

But:

	msg="test

this is a test

fixes: 42
"

would produce:

	exp="test

this is a test

fixes: 42
Signed-off-by A. U. Thor <...>
"

-- 
Shawn.
