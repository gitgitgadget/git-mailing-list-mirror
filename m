From: Seth Robertson <in-gitvger@baka.org>
Subject: .gitignore Bug Report on the behavior of *
Date: Sat, 25 Sep 2010 15:23:19 -0400
Message-ID: <201009251923.o8PJNJYE031841@no.baka.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:23:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzaLG-0003x8-AN
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990Ab0IYTXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:23:21 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:36077 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895Ab0IYTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:23:20 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o8PJNJ99014857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 25 Sep 2010 15:23:19 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o8PJNJYE031841
	for <git@vger.kernel.org>; Sat, 25 Sep 2010 15:23:19 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157190>


I'm not sure if this is a documentation bug, an actual bug, or my
mis-interpretation of what is supposed to happen, however, this
behavior was not expected by other people as well.  This was tested
using git 1.7.2.3 and 1.7.3

My sample configuration:
----------------------------------------------------------------------
mkdir foo; cd foo; git init; echo A > A; mkdir B; echo B > B/B
git add .; git commit -a -m "initial"
----------------------------------------------------------------------

# Properly shows X and B/XX as untracked, as I expected
echo X > X; echo XX > B/XX; git status

# I expected B/XX to show up as untracked
rm -f .gitignore B/.gitignore
echo '*' > .gitignore; echo '!*' > B/.gitignore; git status

# I expected B/XX to show up as untracked
rm -f .gitignore B/.gitignore
echo '/*' > .gitignore; git status

# Works as I expected
rm -f .gitignore B/.gitignore
echo '/*X' > .gitignore; git status

# Works as I expected
rm -f .gitignore B/.gitignore
echo '*X' > .gitignore; echo '!*X' > B/.gitignore; git status

# Works as I expected
rm -f .gitignore B/.gitignore
echo -e '/*\n!/B' > .gitignore; git status

					-Seth Robertson
