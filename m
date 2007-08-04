From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: gitbox status (for those who want to hack on it)
Date: Sat, 4 Aug 2007 13:40:14 -0400
Message-ID: <fcaeb9bf0708041040w6d2b3f2cu1680e1e7dc542ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Mike Pape" <dotzenlabs@gmail.com>,
	"Paul Hampson" <PaulH@microforte.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHNbx-00035h-IK
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 19:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764855AbXHDRkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 13:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764832AbXHDRkR
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 13:40:17 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:42722 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764829AbXHDRkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 13:40:15 -0400
Received: by an-out-0708.google.com with SMTP id d31so208255and
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 10:40:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BmO8wP0f++bsR8ccOiGi6gcwSrgmsOn55+A6jRhTVmQ6YbLgTu6EhBxYM/fx69MzraWdzB/yYO4OCfCYjBV/s18DnMJmhYAYVcjxAhaEwiCSMmzhY84GkpxY2vvVwpE1312rRZo90fdoU2gwHoQ46zK7r8wAAXSLWg+dE6ZTnw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MPuIVEmmUcyFOVUScwg3i38MC+GngE+Jp53+3n3nYUmGQlZxgjp44taH/QdUIBnXnuV8Z/4iF3cPPalgZQcIz4O9dV6fi64VTXrxO6++eH0MIu4JU0E22MhNrCY3MOWTB20EF/5wC/aG/JwPLprxhk0qmeyB+WIFpvIN1UT1Fus=
Received: by 10.100.165.9 with SMTP id n9mr2348727ane.1186249214496;
        Sat, 04 Aug 2007 10:40:14 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Sat, 4 Aug 2007 10:40:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54886>

I would say it's in pretty good state now because it can run through
test cases. Running tests on Windows can take about an hour so I'll
put test results here so you don't have to rerun the whole thing if
you want to know what part needs work. Known failed tests:

t1301-shared-repo.sh: no umask on gitbox
t3200-branch.sh: "unable to move logfile" and "Not a valid object name"
t3405-rebase-malformed.sh: no idea
t3900-i18n-commit.sh: failed due to diff not ignore \r. I don't really
care about this.
t3902-quoted.sh: both gitbox and the official branch fail on this,
haven't looked at it
t4020-diff-external.sh: "unable to fork", diff external programs
should be run under sh
t4110-apply-scan.sh: bad busybox patch, no cure
t4114-apply-typechange.sh: ln
t5000-tar-tree.sh: needs /bin/sh. Even if /bin/sh existed, still
failed for some reasons. This test passed under Wine
t5300-pack-object.sh: busybox ash does not understand "read -d", any workaround?
t5302-pack-index.sh: dd
t5502-quickfetch.sh: git-remote is a perl script. this test itself
also requires perl
t6002-rev-list-bisect.sh: worked under wine but failed under xp, dunno why
t7003-filter-branch.sh: git-filter-branch does not understand Windows
absolute path, among others
t7005-editor.sh: vi is needed
t7300-clean.sh: no idea, ran fine under wine
t7500-commit.sh: probably because busybox diff can't diff on
non-seekable input like stdin
t7501-commit.sh: failed on interactive add, no idea
t8001-annotate.sh: needs perl
t8002-blame.sh: needs perl
t9001-send-email.sh: well git-send-email is written in perl so...

Tests were run on commit f04fbf244970358a5c9d621c99b2353aecb34a12 with
arguments --no-symlinks --verbose

gitbox also grows its toolkit a bit. The complete list is:

        [, [[, ash, awk, basename, bunzip2, bzcat, cat, chmod,
        cmp, cp, cut, date, diff, dirname, echo, egrep, env, expr,
        false, fgrep, find, grep, gunzip, gzip, head, ls, md5sum,
        mkdir, mv, od, patch, printenv, printf, pwd, realpath,
        rm, rmdir, sed, seq, sh, sleep, sort, sum, tail, tar,
        test, touch, tr, true, uniq, unzip, wc, which, yes, zcat

patch is not really good. ls is a hacked version, made for tests only.
tar does not support verbose mode. diff does not support non-seekable
input. The rest should work fine.
-- 
Duy
