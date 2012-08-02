From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: git gui chokes on multiple remotes without "fetch = "
Date: Thu, 2 Aug 2012 10:26:07 +0200
Message-ID: <CAB7pA0_M_UtXZ_Rtg-zqvQmMvgUu9QH2VGNOMwnv8Yk11EYJHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 10:26:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swqjc-0005HI-5H
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 10:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab2HBI0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 04:26:12 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:42972 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab2HBI0I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 04:26:08 -0400
Received: by ghrr11 with SMTP id r11so1929251ghr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=1D1qq+P6YDXDHy1IsT1u1XP6kEYen+rLy5x/li8E7XI=;
        b=jw0d2Bg6orRJDfMwwJElVfl56c6rfQD49hHrlcZL0F5ugsS5LvJivZDXoPXhQTI7To
         pCEz82lLrninre2xPnEkPFHs8lTT4s2yKduBxFQE+vdz0UqmVlnRlNSqq2oi24FnG5dy
         gcNT2pYu2keB4pv9M7+FmtI7NKCG1Ot2iWjNjJrb9Depw60mt/lvv06y3eMUdgGHHsZr
         jsb0Rkb/gnxE/FU/xDRDHPAthkos6wdpUyDbUWanOx/cIc0sTP1EOygrgI5py4fpDTwc
         V1DQDK/5xhOF+2/lj4IXkxbjcSChUWTBHyGrFyt7UpcNTIoqbwnHv8SPiY6US5EkcctI
         PhuQ==
Received: by 10.60.20.233 with SMTP id q9mr31966193oee.57.1343895967419; Thu,
 02 Aug 2012 01:26:07 -0700 (PDT)
Received: by 10.76.124.232 with HTTP; Thu, 2 Aug 2012 01:26:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202744>

Hi,

It seems that git gui doesn't like multiple remotes without a "fetch =
" line. Having just one remote with no "fetch =" line is OK. Having
more than one bombs, though adding "fetch =" to just one of them seems
to work. It's easy to reproduce:

lasse@plystrofyf:/tmp$ mkdir test.git
lasse@plystrofyf:/tmp$ cd test.git/
$ git init
Initialized empty Git repository in /tmp/test.git/.git/
$ echo '[remote "a"]' >>.git/config
$ echo 'url = ssh://a/b/c.git' >>.git/config
$ git gui
$ # happy git gui :-)
$ echo '[remote "b"]' >>.git/config
$ echo 'url = ssh://d/e/f.git' >>.git/config
$ git gui
Error in startup script: unknown option "-label"
    while executing
"$fetch_m entrycget end -label"
    (procedure "update_all_remotes_menu_entry" line 16)
    invoked from within
"update_all_remotes_menu_entry"
    (procedure "populate_remotes_menu" line 9)
    invoked from within
"populate_remotes_menu"
    invoked from within
"if {[is_enabled transport]} {
	load_all_remotes

	set n [.mbar.remote index end]
	populate_remotes_menu
	set n [expr {[.mbar.remote index end] - $n}]
..."
    (file "/usr/lib/git-core/git-gui" line 3824)
$ # sad git gui :-(
$ echo 'fetch =' >>.git/config
$ git gui
$ # happy git gui :-)

This is with v1.7.12-rc1-16-g05a20c8 (current master as if this writing)

/Lasse
