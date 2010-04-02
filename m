From: Chris Webb <chris@arachsys.com>
Subject: Re: [RFC 1/1] Add new indent-with-tab whitespace check
Date: Fri, 2 Apr 2010 11:55:04 +0100
Message-ID: <20100402105504.GO19047@arachsys.com>
References: <7vsk7fovjx.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 12:55:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxeWw-00036C-8R
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 12:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636Ab0DBKzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 06:55:09 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:50195 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0DBKzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 06:55:07 -0400
Received: from [83.104.159.199] (helo=miranda.arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.52)
	id 1NxeWn-00035Y-P9; Fri, 02 Apr 2010 11:55:06 +0100
Content-Disposition: inline
In-Reply-To: <7vsk7fovjx.fsf_-_@alter.siamese.dyndns.org>
 <7vwrwstq8r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143805>

Hi. Thanks for the detailed feedback.

Junio C Hamano <gitster@pobox.com> writes:

> This sounds more like "tab-in-indent".  Naming the option that way would
> give it an added benefit of allowing it to be abbreviated to "tab" by the
> parser.

Yes that's nice: much harder to confuse with indent-with-non-tab that way.

> I think WS_TAB_IN_INDENT are incompatible with either WS_SPACE_BEFORE_TAB
> or WS_INDENT_WITH_TAB.  Don't we want to notice such a combination as an
> error?

Oh yes, that has to be the right behaviour for the finished feature here. (I
guess strictly they could coexist with the meaning 'no indented lines
allowed at all' but I don't think that's useful or sensible.)

> I'll queue this with s/indent-with-tab/tab-in-indent/ tweak to 'pu' but
> the topic would need:
> 
>  - detecting incompatible settings;
>  - tests;
>  - docs;
>  - matching change to apply --whitespace=fix;
> 
> before moving to 'next', I think.

Are you happy with my suggestion in [0/1] to replumb ws_fix_copy() to take a
strbuf as dst rather than a char *, to deal with the fact that whitespace
can grow with --whitespace=fix and WS_TAB_IN_INDENT?

If so, I'll polish up the existing patch as you suggest in your first three
points above, and then make this change to the way ws_fix_copy() works so I
can do the right thing in whitespace=fix.

> There is another issue with this change.  Because "whitespace" without any
> string in .gitattributes are defined to cause all the whitespace breakages
> known to git to be caught, and tab-in-indent is inherently incompatible
> with indent-with-non-tab, this cannot be supported without changing the
> definition of "default set of whitespace breakage classes".

Ah, this was a behaviour I didn't know about. I should probably put your
patch (without the WS_TAB_IN_INDENT line) as the first one in the series,
before I introduce WS_TAB_IN_INDENT, so we don't break this wildcard
whitespace behaviour at any point in the series.

Cheers,

Chris.
