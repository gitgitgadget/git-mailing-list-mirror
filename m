From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: make install fails with $bindir = $execdir
Date: Fri, 10 Jul 2009 12:11:59 +0200
Message-ID: <adf1fd3d0907100311k3b70c9f4va077e96a499ce093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 12:13:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPD5O-00059m-3x
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 12:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbZGJKMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 06:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbZGJKMC
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 06:12:02 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:47244 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZGJKMB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 06:12:01 -0400
Received: by bwz25 with SMTP id 25so755657bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 03:11:59 -0700 (PDT)
Received: by 10.204.120.19 with SMTP id b19mr1791337bkr.36.1247220719666; Fri, 
	10 Jul 2009 03:11:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123045>

Hi *,

  since commit 4ecbc17 (Makefile: install 'git' in execdir,
2009-07-09), included in v1.6.4-rc0, the install fails when $bindir is
equal to $execdir with:

bindir=$(cd '/home/pcl305/sbejar/usr/stow/git/bin' && pwd) && \
        execdir=$(cd '/home/pcl305/sbejar/usr/stow/git/bin' && pwd) && \
        { rm -f "$execdir/git" && \
                test -z "" && \
                ln "$bindir/git" "$execdir/git" 2>/dev/null || \
                cp "$bindir/git" "$execdir/git"; } && \
        { for p in  ..list..of..builtins; do \
                rm -f "$execdir/$p" && \
                ln "$execdir/git" "$execdir/$p" 2>/dev/null || \
                ln -s "git" "$execdir/$p" 2>/dev/null || \
                cp "$execdir/git" "$execdir/$p" || exit; \
          done; } && \
        ./check_bindir "z$bindir" "z$execdir" "$bindir/git-add"
cp: cannot stat `/home/pcl305/sbejar/usr/stow/git/bin/git': No such
file or directory
make: *** [install] Error 1

I understant what happens, but all this is very delicate, so I'll try
to fix it but I don't know when.
Maybe we need also tests for this.

Santi
