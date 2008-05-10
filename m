From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 08/22] Added the iterface Rules.
Date: Sat, 10 May 2008 22:46:56 +0200
Message-ID: <200805102246.56436.robin.rosenberg.lists@dewire.com>
References: <1210424440-13886-1-git-send-email-florianskarten@web.de> <1210424440-13886-9-git-send-email-florianskarten@web.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AngJIlVml3dhDa8"
Cc: git@vger.kernel.org
To: Florian Koeberle <florianskarten@web.de>
X-From: git-owner@vger.kernel.org Sat May 10 22:48:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juvzx-0007Pi-Bo
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 22:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525AbYEJUrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 16:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbYEJUrs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 16:47:48 -0400
Received: from [83.140.172.130] ([83.140.172.130]:12890 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755489AbYEJUrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 16:47:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D46E11434CBC;
	Sat, 10 May 2008 22:47:46 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u6riakMdDzy1; Sat, 10 May 2008 22:47:46 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 6273E1434CBB;
	Sat, 10 May 2008 22:47:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1210424440-13886-9-git-send-email-florianskarten@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81697>

--Boundary-00=_AngJIlVml3dhDa8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Typo in commit message

> + * @author Florian K=C3=B6berle
We do not use this javadoc field.

> \ No newline at end of file
Minor comment. Avoid this. Easy to forget so we do often. Weeding out trail=
ing
whitespace is also nice as that tend to make diff smaller.  Attached a scri=
pt
that be used to ammend a commit so any new or changed lines do not have
trailing whitespace. Not fixing this won't be a showstopper as  you do not
have a lot of these things anyway.

=2D- robin


--Boundary-00=_AngJIlVml3dhDa8
Content-Type: application/x-shellscript;
  name="washammend"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="washammend"

#!/bin/bash -e
#
# Rewrite the last commit to remove any trailing whitespace
# in the new version of changed lines.
# Then replace space-based indentation with TAB based indentation
# based on TABS at every eight position
#
[[ -z $TRACE ]] || set -x
trap "rm -f $tmpf" 0
tmpf1=$TMP/$$.1.diff
tmpf2=$TMP/$$.2.diff
git show --binary >$tmpf1
perl -p -e 's/^(\+.*?)[ \t]+$/$1/; while(m/^(\+\t*)( {1,7}\t| {8})(.*)/) { $_=$1."\t".$3."\n"; }' <$tmpf1 >$tmpf2
if ! cmp -s $tmpf1 $tmpf2
then
	git apply --binary --index -R --whitespace=nowarn $tmpf1
	git apply --binary --index $tmpf2
	GIT_EDITOR=true git commit --amend
else
	echo "No changes"
fi

--Boundary-00=_AngJIlVml3dhDa8--
