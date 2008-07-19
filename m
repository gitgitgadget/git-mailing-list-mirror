From: Torsten Paul <Torsten.Paul@gmx.de>
Subject: Re: gitk: Author/Committer name with special characters
Date: Sat, 19 Jul 2008 17:16:04 +0200
Message-ID: <48820534.7080806@gmx.de>
References: <487E7525.7000708@gmx.de> <18558.35423.933860.915622@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKEBb-0005Kr-El
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 17:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbYGSPQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 11:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYGSPQ1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 11:16:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:50959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754739AbYGSPQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 11:16:26 -0400
Received: (qmail invoked by alias); 19 Jul 2008 15:16:23 -0000
Received: from unknown (EHLO [192.168.46.15]) [92.116.228.142]
  by mail.gmx.net (mp067) with SMTP; 19 Jul 2008 17:16:23 +0200
X-Authenticated: #1774914
X-Provags-ID: V01U2FsdGVkX199KiUOEgd9ehrAqNWeoBGFmlq4hTrM7eGDz60PXw
	UAtxOAaOsx11UU
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <18558.35423.933860.915622@cargo.ozlabs.ibm.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89110>

Paul Mackerras wrote:
> Something like that, I think, but to be sure I'd like to see the
> actual author and committer lines that are causing the problem.  Could
> you send me the output of "git cat-file commit" on one of the
> problematic commits?
> 
I've created a small script that creates a minimal repo that shows
the problem...

ciao,
   Torsten.


#!/bin/bash

#
# Script to generate git commit messages that
# contain windows style user names. This kind of
# names are generated when using git-svn with a
# svn-repo that uses NTLM authentification.
#

EXT="@23e39a30-19ad-a625-8bac-5c9ab2323746"

do_commit () {
         F=test.txt
         echo "test$1" > "$F"
         git add "$F"

         M="<$2$EXT>"

         GIT_AUTHOR_NAME="$2" \
         GIT_AUTHOR_EMAIL="$M" \
         GIT_COMMITTER_NAME="$2" \
         GIT_COMMITTER_EMAIL="$M" \
         git commit -m "commit $1"
}

DIR=`mktemp -d /tmp/gitk-test.XXXXXXXXXX` || exit 1
trap "rm -rf \"$DIR\"" EXIT
cd $DIR || exit 2

git init
do_commit 1 "paul"
do_commit 2 "WIN\paul"
do_commit 3 "WIN\test"
do_commit 4 "WIN\nobody"
do_commit 5 "WIN\paul"
do_commit 6 "paul"
gitk
