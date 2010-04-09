From: Eric Raymond <esr@snark.thyrsus.com>
Subject: More git status --porcelain lossage
Date: Fri,  9 Apr 2010 15:06:01 -0400 (EDT)
Message-ID: <20100409190601.47B37475FEF@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 09 21:06:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JWu-0006VL-A1
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab0DITGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:06:05 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:58421
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760Ab0DITGC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:06:02 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 47B37475FEF; Fri,  9 Apr 2010 15:06:01 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144457>

After I posted my last, I noticed another crash landing...

A format properly designed for script parseability should use even use
whitespace as a field separator.

Why?

Because if you do that, front ends *will* do field analysis using a
naive split-on-whitespace operation.  And then...someday...someone
will try to run one of these of these on a volume from a system where
filenames contain embedded whitespace.  Like Mac OS X or Windows.

Hilarity will ensue.

Conclusion: As it is presently, git status --porcelain format is
irretrievably botched.  You need a field separator that's musch less
likely to land in a filename, like '|' - and to warn in the documentation
that careful front ends must check for and ignore '\|'. 
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The right of the citizens to keep and bear arms has justly been considered as
the palladium of the liberties of a republic; since it offers a strong moral
check against usurpation and arbitrary power of rulers; and will generally,
even if these are successful in the first instance, enable the people to resist
and triumph over them."
        -- Supreme Court Justice Joseph Story of the John Marshall Court
