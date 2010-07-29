From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Using filter-branch to move repo contents in subdirectory
Date: Thu, 29 Jul 2010 15:08:05 +0200
Message-ID: <201007291508.05242.trast@student.ethz.ch>
References: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 15:08:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeSqN-0006Lf-Uk
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 15:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757413Ab0G2NIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 09:08:09 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:43191 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753819Ab0G2NIH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 09:08:07 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 29 Jul
 2010 15:08:06 +0200
Received: from thomas.site (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Thu, 29 Jul
 2010 15:08:05 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTik2dL5jrEjZe0LB6Y4_PEwRt-7t_5CG7gup3pnV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152173>

Adam Mercer wrote:
> $ git filter-branch --index-filter \
>     'git ls-files -s | sed "s-\t\"*-&sftlib/-" |
>         GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
>             git update-index --index-info &&
>     mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
> Rewrite 223651f2ebd5d5d9341bcfc9e7cb6caaa3f4d171 (56/65)Ignoring path
> 00bootsftlib/

What OS is this?  You seem to have a 'sed' version where \t does not
match the horizontal tab character, or a shell that replaces the '\t'
inside a double-quoted string with simply 't'.

As a short-term fix, you can try to replace it with $(printf '\t')
which should always give a tab character.  You need to quote the '
though, so that's

  $ git filter-branch --index-filter \
      'git ls-files -s | sed "s-$(printf '\''\t'\'')\"*-&sftlib/-" |
          GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
              git update-index --index-info &&
      mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD


As for the actual issue: 'man 1p sed' on my system claims

        * The escape sequence '\n' shall match a <newline> embedded in the  pat-
          tern space. A literal <newline> shall not be used in the BRE of a con-
          text address or in the substitute function.

but does not mention \t at all, so I guess either that manpage is
wrong or GNU sed is not POSIX compliant even with --posix (where it
still treats \t as a tab).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
