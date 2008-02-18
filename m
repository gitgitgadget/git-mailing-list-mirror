From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Mon, 18 Feb 2008 10:10:26 +0100
Message-ID: <20080218101026.6098667f@pc09.procura.nl>
References: <20080208174654.2e9e679c@pc09.procura.nl>
	<e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
	<20080208210447.289022b6@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:11:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR225-0006yb-UD
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 10:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYBRJKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 04:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbYBRJKd
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 04:10:33 -0500
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:1384 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYBRJKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 04:10:30 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1I9ARZj054193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Feb 2008 10:10:27 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080208210447.289022b6@pc09.procura.nl>
X-Mailer: Claws Mail 3.3.0cvs11 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74251>

On Fri, 8 Feb 2008 21:04:47 +0100, "H.Merijn Brand" <h.m.brand@xs4all.nl>
wrote:

> $ cat do-tests
> #!/bin/sh
> 
> export TAR=ntar
> rm -f *.err
> for t in t[0-9]*.sh ; do
>     echo $t
>     sh $t > test.err 2>&1 || mv test.err $t.err
>     rm -f test.err
>     done
> $
> 
> 197509 -rw-rw-rw- 1 merijn softwr 1633 Feb  8 18:03 t5302-pack-index.sh.err
> 196846 -rw-rw-rw- 1 merijn softwr  943 Feb  8 18:04 t5500-fetch-pack.sh.err
> 203431 -rw-rw-rw- 1 merijn softwr  344 Feb  8 18:05 t5600-clone-fail-cleanup.sh.err
> 202602 -rw-rw-rw- 1 merijn softwr  458 Feb  8 18:05 t5701-clone-local.sh.err
> 202761 -rw-rw-rw- 1 merijn softwr 3039 Feb  8 18:06 t6002-rev-list-bisect.sh.err
> 202641 -rw-rw-rw- 1 merijn softwr 3980 Feb  8 18:06 t6003-rev-list-topo-order.sh.err
> 202731 -rw-rw-rw- 1 merijn softwr  899 Feb  8 18:06 t6022-merge-rename.sh.err
> 197510 -rw-rw-rw- 1 merijn softwr 1340 Feb  8 18:08 t7201-co.sh.err
> 202705 -rw-rw-rw- 1 merijn softwr  149 Feb  8 18:09 t9300-fast-import.sh.err
> 197051 -rw-rw-rw- 1 merijn softwr 1651 Feb  8 18:09 t9301-fast-export.sh.err
> 
> http://www.xs4all.nl/~procura/git-1.5.3-1123ipf.tar
> 
> Tips welcome :)

Most bizarre workaround found for clone (the first 4 failures):
--8<---
diff -pur /a5/pro/3gl/LINUX/git-1.5.4/git-clone.sh git-clone.sh
--- a/git-1.5.4/git-clone.sh  2008-02-02 05:09:01 +0100
+++ b/git-1.5.4/git-clone.sh  2008-02-18 10:03:26 +0100
@@ -368,7 +368,8 @@ yes)
                '') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
                *) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
                esac >"$GIT_DIR/CLONE_HEAD" ||
-                       die "fetch-pack from '$repo' failed."
+                       exit 1
+                       # die "fetch-pack from '$repo' failed."
                ;;
        esac
        ;;
-->8---

4 down, 6 to go
197225 -rw-rw-rw- 1 merijn softwr  7246 Feb 18 09:58 t6002-rev-list-bisect.sh.err
197111 -rw-rw-rw- 1 merijn softwr 10763 Feb 18 09:58 t6003-rev-list-topo-order.sh.err
197190 -rw-rw-rw- 1 merijn softwr 17903 Feb 18 09:58 t6022-merge-rename.sh.err
196841 -rw-rw-rw- 1 merijn softwr  9299 Feb 18 10:00 t7201-co.sh.err
196928 -rw-rw-rw- 1 merijn softwr   484 Feb 18 10:01 t9300-fast-import.sh.err
196683 -rw-rw-rw- 1 merijn softwr  5035 Feb 18 10:01 t9301-fast-export.sh.err

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
