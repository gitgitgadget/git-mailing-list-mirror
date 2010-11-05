From: Kevin Ballard <kevin@sb.org>
Subject: [RFC] Using gitrevisions :/search style with other operators
Date: Fri, 5 Nov 2010 15:38:23 -0700
Message-ID: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 05 23:38:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEUvZ-0004LK-MB
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 23:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978Ab0KEWi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 18:38:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37247 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab0KEWi0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Nov 2010 18:38:26 -0400
Received: by pzk28 with SMTP id 28so552090pzk.19
        for <git@vger.kernel.org>; Fri, 05 Nov 2010 15:38:26 -0700 (PDT)
Received: by 10.143.18.20 with SMTP id v20mr2394276wfi.113.1288996706460;
        Fri, 05 Nov 2010 15:38:26 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm2448751wfc.17.2010.11.05.15.38.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Nov 2010 15:38:25 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160825>

Most of the ways to refer to a git revision can be combined, e.g. I can type
something silly like

  HEAD~2^^2^2~4^{tree}

and this will work as expected.

There is one operator that doesn't allow this at all, and that's the commit
message search (e.g. :/foo). Every character after the :/ is taken to be
part of the regular expression. This is rather unfortunate as it prevents me
from doing something like :/foo^ to refer to the parent of the matching commit.

Does anybody have any opinions on changing this operator? My suggestion would
be to treat a second / as a termination of the pattern and allow operators
(such as ^ or ~<n>) to occur at that point. This would look like

  :/Merge branch 'foo'/^

If you need a / in your message then you can just escape it with a backslash.

A second change to consider is a syntax to specify that you want the 2nd
(or nth) match rather than the first. This could be done like

  :/foo/2

unless someone has a better idea.

And finally, I'd love to be able to specify the ref to search from. The current
behavior is to find the earliest matching commit on any ref, but it seems
I should be able to type something like

  git merge 'origin/pu:/jh\/notes-merge/^2'

in order to grab the jh/notes-merge topic branch from origin/pu and merge
it into HEAD. Currently trying to type something like master:/test will
treat /test as a file path on master, which is something that will never
resolve to a real file due to the leading slash.

Comments/suggestions/critiques are welcome.

-Kevin Ballard