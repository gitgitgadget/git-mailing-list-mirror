From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdiff: Show function names in hunk headers.
Date: Tue, 28 Mar 2006 16:21:03 -0800
Message-ID: <7v4q1ihzio.fsf@assigned-by-dhcp.cox.net>
References: <11435126113456-git-send-email-mdw@distorted.org.uk>
	<7vfyl3m7vy.fsf@assigned-by-dhcp.cox.net>
	<slrne2ik1i.s3g.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 02:21:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOOQx-0004IJ-90
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 02:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWC2AVI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Mar 2006 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964877AbWC2AVI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 19:21:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:17026 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964871AbWC2AVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 19:21:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329002104.IAME15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 28 Mar 2006 19:21:04 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne2ik1i.s3g.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Tue, 28 Mar 2006 15:03:14 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18147>

Mark Wooding <mdw@distorted.org.uk> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> GNU diff -p does "^[[:alpha:]$_]"; personally I think any line
>> that does not begin with a whitespace is good enough.
>...
> The second suggestion is slightly refined, but a little more
> complicated.  We ask for a line which starts /either/ with two
> non-whitespace characters, or with an alphanumeric.  Why?  Because text
> documents have a tendency to have headings of the form `7 Heading!' and
> I want to catch them.

Asciidoc?

        . enumerated one
          this is one item

        . enumerated two
          this is another item

> I think I like option 2 best, as a nice compromise between stupidity and
> actually working.  Opinions, anyone?

It's just a heuristic, so there are only two things we could
sensibly do.  Either we keep it absolutely stupid to save our
code and sanity, or we give full configurability via -F regexp
to the end users.

I suspect feeping creaturism would eventually push us to go the
latter route, but for now I'd vote for doing exactly the same as
what default GNU does, by looking at the first letter without
using regexps.  When we add regexps later, the users can
customize the pattern to match the languages they use, and we
might end up having to have a set of (file-suffix -> default
regexp) mappings, with full end user configurability via
.git/config -- gaaah but true X-<.

	[diff]
        	functionline = "^\w" for .c
                functionline = "^(?i)\s*(?:function|procedure)" for .f77
                functionline = "^\(defun " for .el
                ...
