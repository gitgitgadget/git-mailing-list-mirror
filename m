From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] opening files in remote.c should ensure it is opening a
 file
Date: Mon, 18 Feb 2008 12:31:57 +0100
Message-ID: <20080218123157.17c91f20@pc09.procura.nl>
References: <20080208174654.2e9e679c@pc09.procura.nl>
 <e2b179460802080925s61270036q81896010c76236ae@mail.gmail.com>
 <20080208210447.289022b6@pc09.procura.nl>
 <20080218101026.6098667f@pc09.procura.nl>
 <7v3arqr4qo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Mike Ralphson" <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 12:32:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4Er-00015R-Pz
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:32:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbYBRLcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757625AbYBRLcP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:32:15 -0500
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:1792 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482AbYBRLcN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:32:13 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1IBVvkR085862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 Feb 2008 12:31:58 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7v3arqr4qo.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74265>

On Mon, 18 Feb 2008 01:30:39 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > Most bizarre workaround found for clone (the first 4 failures):
> > --8<---
> > diff -pur /a5/pro/3gl/LINUX/git-1.5.4/git-clone.sh git-clone.sh
> > --- a/git-1.5.4/git-clone.sh  2008-02-02 05:09:01 +0100
> > +++ b/git-1.5.4/git-clone.sh  2008-02-18 10:03:26 +0100
> > @@ -368,7 +368,8 @@ yes)
> >                 '') git-fetch-pack --all -k $quiet $depth $no_progress "$repo";;
> >                 *) git-fetch-pack --all -k $quiet "$upload_pack" $depth $no_progress "$repo" ;;
> >                 esac >"$GIT_DIR/CLONE_HEAD" ||
> > -                       die "fetch-pack from '$repo' failed."
> > +                       exit 1
> > +                       # die "fetch-pack from '$repo' failed."
> >                 ;;
> >         esac
> >         ;;
> 
> That sounds *very* broken.

Indeed, and trying to see if eval or exiting from with a sub caused
this weird behaviour, I failed to come up with a simple test script
to prove this.

> Is your /bin/sh really a variant of Bourne?

Yes

 NAME
      sh - overview of various system shells

 SYNOPSIS
    POSIX Shell:
      sh [+-aefhikmnoprstuvx] [+-o option] ...  [-c string] [arg ...]

      rsh [+-aefhikmnoprstuvx] [+-o option] ...  [-c string] [arg ...]

    Korn Shell:
      ksh [+-aefhikmnoprstuvx] [+-o option] ...  [-c string] [arg ...]

      rksh [+-aefhikmnoprstuvx] [+-o option] ...  [-c string] [arg ...]

    C Shell:
      csh [-cefinstvxTVX] [command_file] [argument_list ...]

    Key Shell:
      keysh

> If HP-UX is broken in a similar way as Solaris is, in that it
> installs a non-POSIX shell under /bin/sh and offers a Korn in
> /bin/ksh, "make SHELL_PATH=/bin/ksh" may help.

$ path -al sh ksh
  27231 100555 -r-x    2      bin    586136  27 Aug 2004 03:36 /usr/bin/sh
   1744 100555 -r-x    1      bin   1219780  27 Aug 2004 03:36 /sbin/sh
   3206 100555 -r-x    2      bin    446904  27 Aug 2004 03:20 /usr/bin/ksh

And running all with ksh only makes things worse!

$ cat t0000-basic.sh.err
t0000-basic.sh[31]: !:  not found
test_expect_success[31]: !:  not found
test_expect_success[31]: !:  not found
test_expect_failure[31]: !:  not found
test_expect_success[31]: !:  not found
test_expect_success[31]: !:  not found
test_expect_success[31]: !:  not found
test_expect_failure[31]: !:  not found
:
:



-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
