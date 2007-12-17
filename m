From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 5/6] whitespace: more accurate initial-indent highlighting
Date: Mon, 17 Dec 2007 09:00:13 +0100
Message-ID: <ACA0791E-189F-4E19-AE87-C7D1163C0366@wincent.com>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com> <1197822702-5262-1-git-send-email-bfields@citi.umich.edu> <1197822702-5262-2-git-send-email-bfields@citi.umich.edu> <1197822702-5262-3-git-send-email-bfields@citi.umich.edu> <1197822702-5262-4-git-send-email-bfields@citi.umich.edu> <1197822702-5262-5-git-send-email-bfields@citi.umich.edu> <1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:00:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Au5-0006mr-As
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXLQIAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 03:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbXLQIAU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:00:20 -0500
Received: from wincent.com ([72.3.236.74]:57507 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443AbXLQIAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 03:00:19 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBH80Eem014335;
	Mon, 17 Dec 2007 02:00:15 -0600
In-Reply-To: <1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68515>

El 16/12/2007, a las 17:31, J. Bruce Fields escribi=F3:

> Instead of highlighting the entire initial indent, highlight only the
> problematic spaces.
>
> In the case of an indent like ' \t \t' there may be multiple =20
> problematic
> ranges, so it's easiest to emit the highlighting as we go instead of
> trying rember disjoint ranges and do it all at the end.

I'm relatively opposed to mixing the "check" and the "emit" phases =20
here because it will make further refactoring harder.

In the initial version of your series you forgot that there was =20
another place in the codebase ("git apply --whitespace=3Dfix") where =20
whitespace errors are detected, and so you introduced an inconsistency =
=20
which you later fixed up. To me this is indicative of the fact that we =
=20
need to refactor further so that there really is only *one* place =20
where the whitespace checking logic is implemented.

Basically I would have proposed extracting out each type of whitespace =
=20
error into an inline function in ws.c, where it could be used by both =20
check_and_emit_line() in ws.c and apply_one_fragment() in builtin-=20
apply.c.

Unfortunately, mixing checking and emission phases makes this proposed =
=20
refactoring a little bit ugly.

But I see it's already gone into master as ffe56885.

Wincent
